db_name = 'postgresql'
database_yml = File.expand_path('../../internal/config/database.yml', __FILE__)

if File.exist?(database_yml)
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.default_timezone = :utc
  ActiveRecord::Base.configurations = YAML.load_file(database_yml)
  config = ActiveRecord::Base.configurations[db_name]

  ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
  ActiveRecord::Base.connection.drop_database(config['database'])
  ActiveRecord::Base.connection.create_database(config['database'], config.merge('encoding' => 'utf8'))

  ActiveRecord::Base.establish_connection(config)

  ActiveRecord::Migrator.migrate File.expand_path("../../internal/db/migrate/", __FILE__)
  Dir[File.dirname(__FILE__) + '/../internal/app/models/*.rb'].each do |model|
    load model
  end
else
  fail "Please create #{database_yml} first to configure your database. Take a look at: #{database_yml}.example"
end

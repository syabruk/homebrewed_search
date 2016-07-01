module Search
  class Engine < Rails::Engine
    initializer 'searches.autoload', before: :set_autoload_paths do |app|
      app.config.autoload_paths << "#{Rails.root}/app/searches"
    end

    config.to_prepare do
      Dir[Rails.root.join('app/searches/**/*_search.rb')].each do |path|
        require_dependency path
      end
    end
  end
end

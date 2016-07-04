Gem::Specification.new do |s|
  s.name        = 'search'
  s.version     = '0.1.0'
  s.authors     = ['Vladislav Syabruk']
  s.summary     = 'Homebrewed search library with great extensible power.'
  s.files       = ['lib/search.rb']

  s.add_runtime_dependency 'activerecord'
  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'actionview'
  s.add_runtime_dependency 'activerecord-import'
  s.add_runtime_dependency 'ruby-stemmer'
  s.add_runtime_dependency 'ngram'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rails', '~> 5.0'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pg'
end

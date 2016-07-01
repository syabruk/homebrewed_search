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
end

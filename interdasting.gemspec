$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rocket_docs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rocket_docs'
  s.version     = RocketDocs::VERSION
  s.authors     = ['Stanko Krtalić Rusendić']
  s.email       = ['stanko.krtalic@gmial.com']
  s.homepage    = 'http://github.com/stankec/Rocket_Docs'
  s.summary     = 'Interactive API documentation for rails apps'
  s.description = 'Unintrusive interactive API documentation '\
                  'generator for rails apps'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc'
  ]

  s.add_dependency 'rails'
  s.add_dependency 'slim-rails',          '~> 3'
  s.add_dependency 'jquery-rails',        '~> 3.1'
  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap-sass',      '~> 3.3'
  s.add_dependency 'indentation-parser',  '~> 1'

  s.add_development_dependency 'rspec-rails',         '~> 3.2'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5'
  s.add_development_dependency 'rocket_pants',        '~> 1.10'
  s.add_development_dependency 'pry',                 '~> 0.10'
  s.add_development_dependency 'pry-rails',           '~> 0.3'
  s.add_development_dependency 'better_errors',       '~> 2.1'
  s.add_development_dependency 'binding_of_caller',   '~> 0.7'
  s.add_development_dependency 'sqlite3',             '~> 1.3'
  s.add_development_dependency 'appraisal',           '~> 1.0'
end

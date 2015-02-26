$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'interdasting/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'interdasting'
  s.version     = Interdasting::VERSION
  s.authors     = ['Stanko Krtalić Rusendić']
  s.email       = ['stanko.krtalic@gmial.com']
  s.homepage    = 'http://github.com/stankec'
  s.summary     = 'Interactive API documentation for rails apps'
  s.description = 'Unintrusive interactive API documentation '\
                  'generator for rails apps'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc'
  ]

  s.add_dependency 'rails',               '~> 4.1', '>= 4.1.8'
  s.add_dependency 'slim-rails',          '~> 3',   '>= 3.0.1'
  s.add_dependency 'jquery-rails',        '~> 3.1', '>= 3.1.2'
  s.add_dependency 'sass-rails',          '~> 3.2', '>= 3.2'
  s.add_dependency 'bootstrap-sass',      '~> 3.3', '>= 3.3.3'
  s.add_dependency 'indentation-parser',  '~> 1',   '>= 1.0.3'

  s.add_development_dependency 'rspec-rails',         '~> 3.2',  '>= 3.2.0'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5',  '>= 4.5.0'
  s.add_development_dependency 'rocket_pants',        '~> 1.10', '>= 1.10.0'
  s.add_development_dependency 'pry',                 '~> 0.10', '>= 0.10.1'
  s.add_development_dependency 'pry-rails',           '~> 0.3',  '>= 0.3.2'
  s.add_development_dependency 'better_errors',       '~> 2.1',  '>= 2.1.1'
  s.add_development_dependency 'binding_of_caller',   '~> 0.7',  '>= 0.7.2'
  s.add_development_dependency 'sqlite3',             '~> 1.3',  '>= 1.3.10'
end

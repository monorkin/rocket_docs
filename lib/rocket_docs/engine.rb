module RocketDocs
  class Engine < ::Rails::Engine
    isolate_namespace RocketDocs
    require 'jquery-rails'
    require 'bootstrap-sass'
    require 'animate-rails'
    require 'handlebars_assets'
    require 'underscore-rails'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    class << self
      def setup(&block)
        block.call(RocketDocs)
        {
          self => RocketDocs.url
        }
      end
    end
  end
end

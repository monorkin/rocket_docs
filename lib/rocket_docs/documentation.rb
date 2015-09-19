require 'rocket_docs/documentation/controller'
require 'rocket_docs/documentation/action'

module RocketDocs
  class Documentation
    attr_reader :version
    attr_reader :controllers
    attr_reader :controllers_in

    def initialize(version, controllers_hash)
      @version = version
      @controllers = []
      @controllers_in = controllers_hash || []

      generate!
    end

    private

    def generate!
      build_controllers
    end

    def build_controllers
      controllers_in.each do |name, values|
        @controllers << Controller.new(
          name, values[:path], values[:actions], self
        )
      end
    end
  end
end

require 'rocket_docs/documentation/controller'
require 'rocket_docs/documentation/action'

module RocketDocs
  class Documentation
    attr_reader :version
    attr_reader :controllers

    def initialize(version, controllers_hash)
      @version = version
      @controllers = []
      @controllers_in = controllers_hash
      generate
    end

    def should_update?
      should_update = false
      controllers.each { |c| should_update ||= c.should_update? }
      should_update
    end

    def update
      controllers.each(&:update)
      self
    end

    def update!
      controllers.each(&:update!)
      self
    end

    private

    def generate
      build_controllers
      update
    end

    def build_controllers
      @controllers = []
      @controllers_in.each do |n, v|
        @controllers << Controller.new(n, v[:path], v[:actions], self)
      end
    end
  end
end

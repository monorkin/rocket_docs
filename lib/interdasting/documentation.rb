require 'interdasting/documentation/controller'
require 'interdasting/documentation/action'

module Interdasting
  class Documentation
    attr_reader :version
    attr_reader :controllers

    def initialize(version, controllers_hash)
      @version = version
      @controllers = []
      @controllers_in = controllers_hash
      generate
    end

    def generate
      Interdasting::Router.api_full
      build_controllers
      update
    end

    def methods
      controllers.map(&:methods).flatten
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

    def build_controllers
      @controllers = []
      @controllers_in.each do |n, v|
        @controllers << Controller.new(n, v[:path], v[:actions], self)
      end
    end
  end
end

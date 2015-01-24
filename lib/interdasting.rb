require 'slim'
require 'pry'
require 'indentation-parser'
require 'interdasting/engine'
require 'interdasting/router'
require 'interdasting/parser'
require 'interdasting/documentation'

module Interdasting
  def self.documentation
    Router.api_full.map do |version, controller|
      Interdasting::Documentation.new(version, controller)
    end
  end

  def self.version(version)
    Interdasting::Documentation.new(version, Router.api_full[version])
  end
end

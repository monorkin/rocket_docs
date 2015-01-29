require 'pry'
require 'slim'
require 'indentation-parser'
require 'interdasting/engine'
require 'interdasting/router'
require 'interdasting/parser'
require 'interdasting/documentation'

module Interdasting
  def self.documentation
    Router.api_full.map do |version, controller|
      Documentation.new(version, controller)
    end
  end

  def self.documentation_for_version(version)
    Documentation.new(version, Router.api_full[version])
  end

  def self.documentation_for_files(files, version_name = 'Unknown')
    fake_controlers = files.map do |file|
      fake_controller = {
        path: file,
        actions: Hash[Parser.method_comments(file).keys.map { |m, _c| [m, []] }]
      }
      [File.basename(file, '.rb'), fake_controller]
    end
    Documentation.new(version_name, Hash[fake_controlers])
  end
end

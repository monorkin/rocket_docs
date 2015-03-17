require 'pry'
require 'slim'
require 'indentation-parser'
require 'rocket_docs/engine'
require 'rocket_docs/router'
require 'rocket_docs/parser'
require 'rocket_docs/documentation'

module RocketDocs
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

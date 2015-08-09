require 'slim'
require 'indentation-parser'
require 'rocket_docs/engine'
require 'rocket_docs/router'
require 'rocket_docs/parser'
require 'rocket_docs/documentation'

module RocketDocs
  class << self
    attr_accessor :url
    attr_accessor :title
    attr_accessor :description

    def config(&block)
      block.call(self)
    end

    def documentation
      Router.api_full.map do |version, controller|
        Documentation.new(version, controller)
      end
    end

    def documentation_for_version(version)
      Documentation.new(version.to_i, Router.api_full[version.to_i])
    end

    def documentation_for_files(files, version_name = 'Unknown')
      fake_controlers = files.map do |file|
        fake_controller = {
          path: file,
          actions: Hash[
            Parser.method_comments(file).keys.map { |m, _c| [m, []] }
          ]
        }
        [File.basename(file, '.rb'), fake_controller]
      end
      Documentation.new(version_name, Hash[fake_controlers])
    end

    def title
      @title || 'RocketDocs'
    end

    def format_string(string)
      return unless string
      CGI.escapeHTML(string).gsub("\n", '<br>').html_safe
    end
  end
end

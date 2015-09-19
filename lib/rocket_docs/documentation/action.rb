module RocketDocs
  class Documentation
    class Action
      attr_reader :name
      attr_reader :controller
      attr_reader :comments
      attr_reader :methods
      attr_reader :params

      def initialize(name, comments, methods, params, controller)
        @name = name
        @controller = controller
        @comments = comments

        @methods = sanitize_methods(methods)
        @params = params
        @params.delete(:version) if params
        @params = @params.presence

        generate!
      end

      def url(method = default_method)
        documentation_attribute_for_method('URL', method) || router_url(method)
      end

      def description(method = default_method)
        temp_description = documentation_attribute_for_method('DOC', method)

        RocketDocs.format_string(temp_description)
      end

      def params(method = default_method)
        documentation_attribute_for_method('PARAMS', method) || params
      end

      def methods
        return @methods if @methods.present?

        documentation.keys.select do |method|
          Parser.http_keywords.include?(method)
        end
      end

      private

      attr_reader :documentation

      def default_method
        methods.first || 'GET'
      end

      def documentation_attribute_for_method(attribute, method)
        (documentation[method] && documentation[method][attribute]) ||
          documentation[attribute]
      end

      def generate!
        return @documentation = {} unless comments.present?
        @documentation = RocketDocs::Parser.parse_comments(comments).value
      end

      def _routes
        RocketDocs::Router.app_routes
      end

      def sanitize_methods(methods)
        return unless methods

        methods.flat_map do |method|
          if method.is_a?(String)
            method
          else
            # Convert to string if symbol or regex
            method.to_s.sub('(?-mix:^', '').sub('$)', '').split('|')
          end
        end
      end

      def router_url(method = default_method)
        route = _routes.url_for(url_params(method))
        route = route.split('?').first unless method == 'GET'

        CGI.unescape(route)
      rescue ActionController::UrlGenerationError
        nil
      end

      def url_params(method = default_method)
        hash = {}
        hash = deflated_url_params(params(method)) if @params

        hash.merge(
          controller: controller.full_name.downcase,
          action: name,
          version: controller.documentation.version,
          only_path: true
        )
      end

      def deflated_url_params(params, wrapper = nil)
        new_params = {}

        params.each do |attribute, type|
          new_attribute = wrapper ? "#{wrapper}[#{attribute}]" : attribute

          if type.is_a?(Hash)
            new_params[attribute] = deflated_url_params(type, attribute)
          else
            new_params[attribute] = "{#{new_attribute}}"
          end
        end

        new_params.symbolize_keys
      end
    end
  end
end

module RocketDocs
  class Documentation
    class Action
      attr_reader :name
      attr_reader :controller
      attr_reader :comments

      def initialize(name, comments, methods, params, controller)
        @name = name
        @comments = comments
        @methods = sanitize_methods(methods)
        @params  = params
        @params.delete(:version) if params
        @params = @params.presence
        @controller = controller
        generate
      end

      def url(method = default_method)
        (@doc[method] && @doc[method]['URL']) || @doc['URL'] ||
          router_url(method)
      end

      def description(method = default_method)
        desc = (@doc[method] && @doc[method]['DOC']) || @doc['DOC']
        RocketDocs.format_string(desc)
      end

      def params(method = default_method)
        (@doc[method] && @doc[method]['PARAMS']) || @doc['PARAMS'] ||
          @params
      end

      def default_method
        methods.first || 'GET'
      end

      def methods
        @methods.presence ||
          @doc.keys.select { |m| Parser.http_keywords.include?(m) }
      end

      private

      def generate
        return @doc = {} unless @comments.present?
        @doc = RocketDocs::Parser.parse_comments(@comments).value
      end

      def _routes
        RocketDocs::Router.app_routes
      end

      def sanitize_methods(methods)
        return unless methods
        methods.map do |m|
          if m.is_a?(String)
            m
          else
            m.to_s.sub('(?-mix:^', '').sub('$)', '').split('|')
          end
        end.flatten
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

      def deflated_url_params(hash, wrapper = nil)
        nh = {}
        hash.each do |k, v|
          new_v = wrapper ? "#{wrapper}[#{k}]" : k
          if v.is_a?(Hash)
            nh[k] = deflated_url_params(v, k)
          else
            nh[k] = "{#{new_v}}"
          end
        end
        nh.symbolize_keys
      end
    end
  end
end

module Interdasting
  class Documentation
    class Action
      attr_reader :name
      attr_reader :controller
      attr_reader :comments
      attr_reader :methods

      def initialize(name, comments, methods, controller)
        @name = name
        @comments = comments
        @methods = sanitize_methods(methods)
        @controller = controller
        generate
      end

      def url
        _routes.url_for(controller: controller.name.downcase, action: name)
      end

      def description(method = default_method)
        (@doc[method] && @doc[method]['DOC']) || @doc['DOC']
      end

      def params(method = default_method)
        (@doc[method] && @doc[method]['PARAMS']) || @doc['PARAMS']
      end

      def default_method
        methods.first || 'GET'
      end

      private

      def generate
        return @doc = {} unless @comments.present?
        @doc = Interdasting::Parser.parse_comments(@comments).value
      end

      def _routes
        Interdasting::Router.app_routes
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
    end
  end
end

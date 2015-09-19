module RocketDocs
  module Router
    class << self
      def api_full
        result = {}

        versions.each { |version| result[version] = {} }
        result.each do |version, controllers|
          fill_controllers_hash_for_version(version, controllers)
        end

        result
      end

      def api_controller_paths(controllers = api_controllers)
        controllers.flat_map do |controller|
          controller.action_methods.map do |action_method|
            controller.instance_method(action_method).source_location.first
          end
        end.uniq.compact
      end

      def api_controllers(names = api_controller_names)
        names.map do |controller_name|
          controller_name += '_controller'
          controller_name.classify.constantize
        end
      end

      def api_controller_names
        api_routes = routes.named_routes.select do |_k, route|
          route_with_version?(route)
        end

        api_routes.values.map { |r| r.defaults[:controller] }.uniq
      end

      def routes_for_version(version)
        routes.to_a
          .select do |r|
            versions = extract_versions_from_route(r)
            versions && versions.include?(version)
          end
      end

      def versions
        routes.to_a
          .flat_map { |r| extract_versions_from_route(r) }
          .uniq.compact
      end

      def routes
        app_routes.routes
      end

      def app_routes
        Rails.application.class.routes
      end

      private

      def route_with_version?(route)
        route && route.path && route.path.requirements[:version]
      end

      def extract_versions_from_route(route)
        return unless route_with_version?(route)

        # WARNING:
        # A lot of regex magic happening here
        #
        # A tipical version string is a regex used by Rails to detect which
        # version should be called and looks something like this "(?-mix:(v?1))"
        #
        # The first regex removes everything from the starting '?' untill it
        # finds a number in front of a '?' sign.
        #
        # The second regex removes all non-numbers from the string
        #
        # In the end the resulting string gets converted in to a number
        route.path.requirements[:version].to_s.split('|').map do |version|
          version.gsub(/[^\?]*\?(?=\d+)/, '').gsub(/[^\d]*/, '').to_i
        end
      end

      def fill_controllers_hash_for_version(version, controllers)
        routes = routes_for_version(version)
        routes.each do |route|
          route_controller(controllers, route)
        end
      end

      def route_controller(controllers, route)
        controller_name = route.defaults[:controller]
        controllers[controller_name] ||= {}

        controllers[controller_name][:path] ||=
          api_controller_paths(api_controllers([controller_name])).first

        controllers[controller_name][:actions] ||= {}
        route_action(controllers[controller_name][:actions], route)
      end

      def route_action(actions, route)
        action = actions[route.defaults[:action]] ||= {}
        action[:params] = route_params(route)
        route_methods(action, route)
      end

      def route_params(route)
        Hash[
          route.required_parts.map do |attribute|
            type = route.constraints[name.to_sym] || '???'
            [attribute, type]
          end
        ]
      end

      def route_methods(action, route)
        action[:methods] ||= []
        action[:methods] << route.constraints[:request_method]
      end
    end
  end
end

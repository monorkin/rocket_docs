module RocketDocs
  module Router
    class << self
      def api_full
        result = {}
        versions.each { |v| result[v] = {} }
        result.each { |k, v| fill_controllers_hash_for_version(k, v) }
        result
      end

      def api_controller_paths(controllers = api_controllers)
        cp = controllers.map do |c|
          c.instance_methods(false).map do |m|
            c.instance_method(m).source_location.first
          end
        end
        cp.flatten.uniq.compact
      end

      def api_controllers(names = api_controller_names)
        names.map do |cn|
          cn += '_controller'
          cn.classify.constantize
        end
      end

      def api_controller_names
        ar = routes.named_routes.select { |_k, v| v.defaults[:rp_prefix] }
        ar.values.map { |r| r.defaults[:controller] }.uniq
      end

      def routes_for_version(version)
        routes.to_a.select do |r|
          extract_versions_from_route(r).include?(version)
        end
      end

      def versions
        routes.to_a.map { |r| extract_versions_from_route(r) }
          .flatten.uniq.compact
      end

      def routes
        app_routes.routes
      end

      def app_routes
        Rails.application.class.routes
      end

      private

      def extract_versions_from_route(route)
        return unless route && route.path && route.path.requirements[:version]
        route.path.requirements[:version].to_s.split('|').map do |v|
          v.gsub!(/[^\?]*\?(?=\d+)/, '')
          v.gsub!(/[^\d]*/, '')
          v.to_i
        end
      end

      def fill_controllers_hash_for_version(version, hash)
        routes = routes_for_version(version)
        routes.each do |r|
          route_controller(hash, r)
        end
      end

      def route_controller(ch, r)
        cn = r.defaults[:controller]
        ch[cn] ||= {}
        ch[cn][:path] ||= api_controller_paths(api_controllers([cn])).first
        ch[cn][:actions] ||= {}
        route_action(ch[cn][:actions], r)
      end

      def route_action(hash, r)
        ah = hash[r.defaults[:action]] ||= {}
        ah[:params] = route_params(r)
        route_methods(ah, r)
      end

      def route_params(r)
        Hash[
          r.required_parts.map do |name|
            type = r.constraints[name.to_sym] || '???'
            [name, type]
          end
        ]
      end

      def route_methods(hash, r)
        hash[:methods] ||= []
        hash[:methods] << r.constraints[:request_method]
      end
    end
  end
end

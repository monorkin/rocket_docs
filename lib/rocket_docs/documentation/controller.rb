module RocketDocs
  class Documentation
    class Controller
      attr_reader :name
      attr_reader :file
      attr_reader :documentation
      attr_reader :actions

      alias_method :full_name, :name

      def initialize(name, file, actions_hash, documentation)
        @actions = []
        @actions_in = actions_hash
        @name = name
        @file = file
        @documentation = documentation

        generate!
      end

      def name
        return unless @name
        @name.split('/').last.sub('_controller', '').humanize
      end

      private

      def generate!
        @actions = []
        comments = RocketDocs::Parser.method_comments(file)

        @actions_in.each do |name, action|
          @actions << Action.new(
            name, comments[name], action[:methods], action[:params], self
          )
        end
      end
    end
  end
end

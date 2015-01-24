module Interdasting
  class Documentation
    class Controller
      attr_accessor :name
      attr_accessor :file
      attr_reader :documentation
      attr_reader :actions

      def initialize(name, file, actions_hash, documentation)
        @file_md5  = ''
        @actions = []
        @actions_in = actions_hash
        self.name = name
        self.file = file
        @documentation = documentation
        update!
      end

      def update
        should_update? && update!
      end

      def update!
        @file_md5 = generate_hash
        generate
      end

      def should_update?
        return false if generate_hash == @file_md5
        true
      end

      def name
        return unless @name
        @name.split('/').last.sub('_controller', '').humanize
      end

      def full_name
        @name
      end

      private

      def generate
        @actions = []
        comments = Interdasting::Parser.method_comments(file)
        @actions_in.each do |name, methods|
          @actions << Action.new(name, comments[name], methods, self)
        end
      end

      def generate_hash
        Digest::MD5.file(file).hexdigest
      end
    end
  end
end

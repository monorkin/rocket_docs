module RocketDocs
  module Parser
    class << self
      def comments_for_method(method_name, file_path)
        method_comments(file_path)[method_name.to_s]
      end

      def method_comments(file_path)
        comments = {}
        temp_comment = []
        File.read(file_path).each_line do |line|
          if extract_method_comment(line, comments, temp_comment)
            temp_comment = []
          end
        end
        clean_comments(comments)
      end

      def parse_comments(comments)
        indentation_parser.read(comments, {})
      end

      def keywords
        http_keywords + parser_keywords
      end

      def parser_keywords
        string_keywords + hash_keywords
      end

      def http_keywords
        %w(GET POST PUT PATCH DELETE)
      end

      private

      def string_keywords
        %w(DOC URL)
      end

      def hash_keywords
        %w(PARAMS)
      end

      def indentation_parser
        IndentationParser.new do |parser|
          indentation_parser_default(parser)
          indentation_parser_leafs(parser)
        end
      end

      def indentation_parser_default(parser)
        parser.default do |parent, source|
          parent ||= {}
          words = source.split

          build_parser_default_node(parent, words)
        end
      end

      def indentation_parser_leafs(parser)
        parser.on_leaf do |parent, source|
          build_parser_leaf_node(parent, source)
        end
      end

      def build_parser_default_node(parent, words)
        key = words.first
        keyword = key.upcase

        return unless words.count == 1

        if keywords.include?(keyword)
          parent[keyword] = string_keywords.include?(keyword) ? '' : {}
        elsif parent.is_a?(Hash)
          parent[key] = {}
        end
      end

      def build_parser_leaf_node(parent, source)
        case parent
        when String
          parent << "\n" if parent.length != 0
          parent << source.try(:strip) || ''
        when Hash
          key, value = source.split(':', 2)
          parent[key] = value ? value.try(:strip) : {}
        end
      end

      def extract_method_comment(line, comments = {}, temp_comment = [])
        return true unless valid_line?(line)

        if line =~ /^\s*def\s+\w+$/
          comments[method_name(line)] = temp_comment.join("\n")
          true
        else
          temp_comment << line
          false
        end
      end

      def valid_line?(line)
        line =~ /^\s*#.*$/ || line =~ /^\s*def\s+\w+$/ || line =~ /^\s+$/
      end

      def method_name(line)
        line.match(/^\s*def\s+\w+$/).to_s.split(' ').last
      end

      def clean_comments(comments)
        comments.each do |method, comment|
          comments[method] = comment.gsub(/^\s*#\s?/, '').gsub(/\n+/, "\n")
        end

        comments
      end
    end
  end
end

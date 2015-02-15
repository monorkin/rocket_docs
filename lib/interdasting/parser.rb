module Interdasting
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

      def http_keywords
        %w(GET POST PUT PATCH DELETE)
      end

      def parser_keywords
        string_keywords + hash_keywords
      end

      private

      def string_keywords
        %w(DOC URL)
      end

      def hash_keywords
        %w(PARAMS)
      end

      def indentation_parser
        IndentationParser.new do |p|
          indentation_parser_default(p)
          indentation_parser_leafs(p)
        end
      end

      def indentation_parser_default(p)
        p.default do |parent, source|
          parent ||= {}
          words = source.split
          keyword = words.first.upcase
          if words.count == 1 && keywords.include?(keyword)
            node = string_keywords.include?(keyword) ? '' : {}
          end
          parent[keyword] = node
          node
        end
      end

      def indentation_parser_leafs(p)
        p.on_leaf do |parent, source|
          case parent
          when String
            parent << ' ' if parent.length != 0
            parent << source.try(:strip) || ''
          when Hash
            k, v = source.split(':', 2)
            parent[k] = v.try(:strip)
          end
        end
      end

      def extract_method_comment(line, comments = {}, temp_comment = [])
        return true unless valid_line?(line)
        if line =~ /^\s*def\s+\w+$/
          comments[method_name(line)] = temp_comment.join("\n")
          return true
        else
          temp_comment << line
          return false
        end
      end

      def valid_line?(line)
        line =~ /^\s*#.*$/ || line =~ /^\s*def\s+\w+$/ || line =~ /^\s+$/
      end

      def method_name(line)
        line.match(/^\s*def\s+\w+$/).to_s.split(' ').last
      end

      def clean_comments(comments)
        comments.each do |k, v|
          comments[k] = v.gsub(/^\s*#\s?/, '').gsub(/\n+/, "\n")
        end
        comments
      end
    end
  end
end

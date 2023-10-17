# frozen_string_literal: true

require_relative 'hash_insensitive'
require 'base64'

class LdifParser
  class EntryMaker
    R_LINE_SPLIT = /(\w+)(:+)\s*(.*)/.freeze
    BASE64_SEPARATOR = '::'

    class << self
      def call(str)
        new(str).make
      end

      def call_minimized(str)
        new(str).make_minimized
      end
    end

    def initialize(str)
      @str = str
      @str.gsub!(/\n\s+/, '')
      @str.gsub!(/\n+$/, '')
    end

    def make
      hash = lines_decoded_to_h
      hash.extend(HashInsensitive)
      hash.default = []
      hash
    end

    def make_minimized
      make.transform_values do |v|
        v.length == 1 ? v.first : v
      end
    end

    private

    def lines_decoded_to_h
      lines_decoded.each_with_object({}) do |(k, v), h|
        init_hash(h, k)
        h[k].push(v)
      end
    end

    def init_hash(h, k)
      h[k] ||= []
    end

    def lines_decoded
      lines.map do |line|
        line_decoder(line)
      end
    end

    def line_decoder(line)
      parts = line.scan(R_LINE_SPLIT).first
      parts[0] = parts[0].to_sym
      parts[2] = Base64.decode64(parts[2]).force_encoding('UTF-8') if parts[1] == BASE64_SEPARATOR
      parts.delete_at(1)
      parts
    end

    def lines
      @str.split(/\n/)
    end
  end
end

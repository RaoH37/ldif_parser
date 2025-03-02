# frozen_string_literal: true

require_relative 'entry'
require 'base64'

class LdifParser
  class EntryMaker
    R_LINE_SPLIT = /(\w+)(:+)\s*(.*)/
    BASE64_SEPARATOR = '::'

    def initialize(str, minimized: false, only_regexp: nil, except_regexp: nil)
      @str = str
      @str.gsub!(/\n\s+/, '')
      @str.gsub!(/\n+$/, '')

      @minimized = minimized
      @only_regexp = only_regexp
      @except_regexp = except_regexp
    end

    def make
      hash = lines_decoded_to_h
      hash[:dn] = hash[:dn].first

      if @minimized
        hash.transform_values! do |v|
          v.length == 1 ? v.first : v
        end
      end

      hash
    end

    private

    def lines_decoded_to_h
      lines_decoded.each_with_object(Entry.new) do |(k, v), h|
        (h[k] ||= []) << v
      end
    end

    def lines_decoded
      lines.map do |line|
        line_decoder(line)
      end
    end

    def line_decoder(line)
      key, separator, value = line.scan(R_LINE_SPLIT).first

      if separator == BASE64_SEPARATOR
        [key.to_sym, Base64.decode64(value).force_encoding('UTF-8')]
      else
        [key.to_sym, value]
      end
    end

    def lines
      arr = @str.split(/\n/)
      arr.select! { |line| line.match?(@only_regexp) } unless @only_regexp.nil?
      arr.reject! { |line| line.match?(@except_regexp) } unless @except_regexp.nil?
      arr
    end
  end
end

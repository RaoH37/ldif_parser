# frozen_string_literal: true

require_relative 'entry_maker'
require_relative 'version'

class LdifParser
  NEW_LDIF_OBJECT_PATTERN = 'dn:'

  class << self
    def parse_file(ldif_path, minimized: false, only: [], except: [])
      parse(IO.read(ldif_path), minimized: minimized, only: only, except: except)
    end

    def parse(str, minimized: false, only: [], except: [])
      included_pattern(only)
      excluded_pattern(except)
      parser = new(str)
      minimized ? parser.parse_minimized! : parser.parse!
    end

    def included_pattern(patterns)
      @included_patterns = patterns.map { |pattern| "#{pattern}:" }
    end

    def excluded_pattern(patterns)
      @excluded_patterns = patterns.map { |pattern| "#{pattern}:" }
    end

    attr_reader :included_patterns, :excluded_patterns
  end

  def initialize(str)
    @str = str
  end

  def parse!
    str_parts.map do |str|
      EntryMaker.call(str)
    end
  end

  def parse_minimized!
    str_parts.map do |str|
      EntryMaker.call_minimized(str)
    end
  end

  def str_parts
    parts = []
    str = ''.dup

    @str.each_line do |line|
      next if line_has_to_be_excluded?(line)

      if line.start_with?(NEW_LDIF_OBJECT_PATTERN) && !str.empty?
        parts << str
        str = ''.dup
      end

      str << line
    end

    parts << str

    @str = nil

    parts
  end

  def line_has_to_be_excluded?(line)
    return false if line.start_with?(NEW_LDIF_OBJECT_PATTERN)

    line.start_with?(*self.class.excluded_patterns) || (!self.class.included_patterns.empty? && !line.start_with?(*self.class.included_patterns))
  end
end

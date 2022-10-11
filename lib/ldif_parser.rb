# frozen_string_literal: true

require_relative 'entry_maker'
require_relative 'version'

class LdifParser
  NEW_LDIF_OBJECT_PATTERN = 'dn'

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
      @included_patterns = patterns.map(&:downcase)
    end

    def excluded_pattern(patterns)
      @excluded_patterns = patterns.map(&:downcase)
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
    previous_key = nil

    @str.each_line do |line|
      line_key = get_line_key(line, previous_key)
      next if line_key.nil?

      if line_has_to_be_excluded?(line_key)
        previous_key = line_key
        next
      end

      if new_ldif_object?(line_key, str, line)
        parts << str
        str = ''.dup
      end

      str << line
      previous_key = line_key
    end

    parts << str

    @str = nil

    parts
  end

  def new_ldif_object?(line_key, str, line)
    line_key == NEW_LDIF_OBJECT_PATTERN && !str.empty? && !line.start_with?(' ')
  end

  def get_line_key(line, previous_key)
    return previous_key if line.start_with?(' ')

    line.split(':').first&.downcase || previous_key
  end

  def line_has_to_be_excluded?(line_key)
    return false if line_key == NEW_LDIF_OBJECT_PATTERN

    self.class.excluded_patterns.include?(line_key) || (!self.class.included_patterns.empty? && !self.class.included_patterns.include?(line_key))
  end
end

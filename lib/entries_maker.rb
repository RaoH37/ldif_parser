# frozen_string_literal: true

require_relative 'entry_maker'
require 'base64'

class LdifParser
  class EntriesMaker
    R_INPUT_ENTRIES_SEPARATOR = /^\s*$/

    class << self
      def parse(input, options = {})
        content = []

        next until input.eof? || (line = input.readline).match(R_INPUT_ENTRIES_SEPARATOR)

        return if !line || line.empty?

        until input.eof? || (line = input.readline).match(R_INPUT_ENTRIES_SEPARATOR)
          line.chomp!
          content << line
        end

        input.seek(-line.length, IO::SEEK_CUR) if !input.eof? && line

        EntryMaker.new(content.join("\n"), **options).make
      end
    end
  end
end

# frozen_string_literal: true

require_relative 'entries_maker'
require_relative 'version'
require 'stringio'

class LdifParser
  class << self
    def open(path, minimized: false, only: [], except: [])
      options = {
        minimized: minimized,
        only_regexp: build_regexp(only),
        except_regexp: build_regexp(except)
      }.freeze

      input = File.open(File.expand_path(path))

      new(input, options).tap do |parser|
        if block_given?
          yield parser

          parser.close
        else
          ObjectSpace.define_finalizer parser, finalizer(input)
        end
      end
    end

    private

    def build_regexp(keys)
      return nil if keys.empty?

      or_map = keys.map { |key| "#{key}:" }
      Regexp.new("^(#{or_map.join('|')})", Regexp::IGNORECASE)
    end

    def finalizer(io)
      proc { io.close }
    end
  end

  attr_reader :input

  def initialize(what, options = {})
    @input = if what.respond_to? :to_io
               what.to_io
             elsif what.is_a? String
               StringIO.new(what)
             else
               raise ArgumentError, 'I do not know what to do.'
             end

    @options = options
  end

  def close
    @input.close
  end

  def lock
    @input.flock File::LOCK_SH if @input.respond_to? :flock

    return unless block_given?

    begin
      yield self
    ensure
      unlock
    end
  end

  def unlock
    return unless @input.respond_to? :flock

    @input.flock File::LOCK_UN
  end

  def each(&block)
    @input.seek 0

    lock do
      each_no_lock(&block)
    end
  end

  private

  def each_no_lock
    while (entry = EntriesMaker.parse(@input, @options))
      yield entry
    end
  end
end

# frozen_string_literal: true

class LdifParser
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 2
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].compact.join('.')
  end
end

# frozen_string_literal: true

class LdifParser
  class << self
    def version
      File.read(File.expand_path('../VERSION', __dir__)).strip
    end
    alias gem_version version
  end
end

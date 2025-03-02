# frozen_string_literal: true

class LdifParser
  class Entry < Hash
    def dn
      return @dn if defined?(@dn)

      @dn = self[:dn]
    end

    def get(key)
      self[key.to_s.downcase.to_sym]
    end
  end
end

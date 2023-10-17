# frozen_string_literal: true

module HashInsensitive
  def dn
    @dn ||= self['dn'].first
  end

  def insensitive_origin_keys
    keys.select { |key| key.respond_to?(:to_s) }
  end

  def insensitive_keys
    insensitive_origin_keys.map(&:to_s).map(&:downcase)
  end

  def default=(obj)
    @default = obj
  end

  def default(key)
    return @default unless key.respond_to?(:to_s)

    tmp_key = key.to_s.downcase
    tmp_index = insensitive_keys.index(tmp_key)
    return @default if tmp_index.nil?

    insensitive_origin_key = insensitive_origin_keys.at(tmp_index)

    self[insensitive_origin_key]
  end
end

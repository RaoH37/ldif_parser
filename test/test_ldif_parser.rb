# frozen_string_literal: true

require_relative 'test_helper'
require 'mocha/minitest'

class TestLdifParser < Minitest::Test
  def test_has_version_number
    refute_nil LdifParser.gem_version
  end

  def test_parse_str
    result = LdifParser.parse(LDIF_ENTRY_STR)
    assert result.is_a?(Array)
    assert result.any?
    assert result.length == 1
  end

  def test_parse_big_ldif
    result = LdifParser.parse_file(BIG_LDIF_PATH)
    assert result.is_a?(Array)
    assert result.any?
  end

  def test_parse_big_ldif_with_only
    result = LdifParser.parse_file(BIG_LDIF_PATH, only: %w[displayName mail sn])
    uniq_keys = result.map(&:keys).flatten.uniq
    assert (uniq_keys - %i[mail sn dn displayName]).empty?
  end

  def test_parse_big_ldif_with_except
    result = LdifParser.parse_file(BIG_LDIF_PATH, except: %w[mail])
    uniq_keys = result.map(&:keys).flatten.uniq
    refute uniq_keys.include?(:mail)
  end
end

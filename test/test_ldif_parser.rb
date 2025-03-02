# frozen_string_literal: true

require_relative 'test_helper'

class TestLdifParser < Minitest::Test
  def test_has_version_number
    refute_nil LdifParser.gem_version
  end

  def test_stringio_from_str
    parser = LdifParser.new(LDIF_ENTRY_STR)
    assert parser.input.is_a?(StringIO)
  end
end

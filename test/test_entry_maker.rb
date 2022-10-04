# frozen_string_literal: true

require_relative 'test_helper'
require 'mocha/minitest'

class TestEntryMaker < Minitest::Test
  def test_is_a_hash
    assert LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup).is_a?(Hash)
  end

  def test_mail_is_a_array
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:mail].is_a?(Array)
  end

  def test_sn_base64
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:sn] == 'désécot'
  end

  def test_multi_lines
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:userApiKey].length == 205
  end
end

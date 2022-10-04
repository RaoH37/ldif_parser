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

  def test_sn_is_a_array
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:sn].is_a?(Array)
  end

  def test_sn_base64
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:sn].first == 'désécot'
  end

  def test_multi_lines
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:userApiKey].first.length == 205
  end

  def test_default_value
    entry = LdifParser::EntryMaker.call(LDIF_ENTRY_STR.dup)
    assert entry[:foo].is_a?(Array)
    assert entry[:foo].empty?
  end

  def test_minimized
    entry = LdifParser::EntryMaker.call_minimized(LDIF_ENTRY_STR.dup)
    assert entry[:uuid].is_a?(String)
    assert entry[:mail].is_a?(Array)
  end
end

# frozen_string_literal: true

require_relative 'test_helper'

class TestEntryMaker < Minitest::Test
  def test_is_a_hash
    assert LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make.is_a?(LdifParser::Entry)
  end

  def test_mail_is_a_array
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry[:mail].is_a?(Array)
  end

  def test_sn_is_a_array
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry[:sn].is_a?(Array)
  end

  def test_sn_base64
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry[:sn].first == 'désécot'
  end

  def test_multi_lines
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry[:userApiKey].first.length == 205
  end

  def test_dn_is_a_string
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry.dn.is_a?(String)
    refute entry.dn.empty?
  end

  def test_insensitive_key
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup).make
    assert entry[:uuid] == entry.get('uuid')
    assert entry[:uuid] == entry.get('UUID')
    assert entry[:uuid] == entry.get(:UUID)
  end

  def test_minimized
    entry = LdifParser::EntryMaker.new(LDIF_ENTRY_STR.dup, minimized: true).make
    assert entry[:uuid].is_a?(String)
    assert entry[:mail].is_a?(Array)
  end
end

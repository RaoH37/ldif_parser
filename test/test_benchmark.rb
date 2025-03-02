# frozen_string_literal: true

require_relative 'test_helper'
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('mini ldif file') do
    LdifParser.open(MINI_LDIF_PATH).each do |_entry|
    end
  end

  x.report('medium ldif file') do
    LdifParser.open(MEDIUM_LDIF_PATH).each do |_entry|
    end
  end
end

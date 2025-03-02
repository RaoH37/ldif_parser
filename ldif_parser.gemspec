# frozen_string_literal: true

require_relative 'lib/version'

Gem::Specification.new do |spec|
  spec.name = 'ldif_parser'
  spec.version = LdifParser.gem_version
  spec.authors = ['Maxime Désécot']
  spec.email = ['maxime.desecot@gmail.com']

  spec.summary = 'LDIF parser'
  spec.description = 'Simple class to parse ldif file'
  spec.homepage = 'https://github.com/RaoH37/ldif_parser'
  spec.license = 'GPL-3.0-only'

  spec.required_ruby_version = '>= 3.1'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.require_paths = ['lib']
end

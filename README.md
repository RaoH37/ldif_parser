# ldif_parser
`LdifParser` is a simple class to parse ldif file

```ruby
require 'ldif_parser'

ldif_path = '/tmp/ldap.bak'
result = LdifParser.parse_file(ldif_path, only: %w[displayName givenName sn mail])

result.each do |res|
  p res
end
```

## Installation

```console
$ gem install ldif_parser
```

## Usage

In the example `result` is an `Array[Hash[Symbol, Array[String]]]`.

Each entry has default a default `Array` value.

If the ldif file is too large, you can optimize the processing of the file with the `only` and `except` options.

These options allow you to limit the number of lines in the ldif file that will be parsed.

## Options

- minimized: minimize has string all array with only one value
- only: captures only the specified ldap attributes
- except: ignore the specified ldap attributes
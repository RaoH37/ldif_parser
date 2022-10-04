# ldif_parser
`LdifParser` is a simple class to parse ldif file

```ruby
require 'ldif_parser'

ldif_path = '/tmp/ldap.bak'
result = LdifParser.parse_file(ldif_path, only: %w[displayName zimbraMailQuota mail])

result.each do |res|
  p res
end
```

## Installation

```console
$ gem install ldif_parser
```

## Options

- only: captures only the specified ldap attributes
- except: ignore the specified ldap attributes
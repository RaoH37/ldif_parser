# ldif_parser
`LdifParser` is a simple class to parse ldif file

```ruby
require 'ldif_parser'

ldif_path = '/tmp/ldap.bak'
LdifParser.open(ldif_path, only: %w[displayName givenName sn mail]).each do |entry|
  p entry
end
```

## Installation

```console
$ gem install ldif_parser
```

## Usage

Use `each` method to iterate on each ldif entries and do what you want.

If the ldif file is too large, you can optimize the processing of the file with the `only` and `except` options.

These options allow you to limit the number of lines in the ldif file that will be parsed.

## Options

- minimized: minimize has string all array with only one value
- only: captures only the specified ldap attributes
- except: ignore the specified ldap attributes

## Speed test

````bash
$ time ruby test/speed.rb 
ruby -v => 3.1.6p260
wc -l $path => 1000000

real    0m4,562s
user    0m4,457s
sys     0m0,091s
````
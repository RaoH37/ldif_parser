# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'ldif_parser'

require 'minitest/autorun'

LDIF_ENTRY_STR = %(dn: uid=maxime,ou=people,dc=desecot,dc=fr
objectClass: Account
uid: maxime
uuid: 8848d872-df23-48c8-8900-9d35d25f7c56
givenName: maxime
sn:: ZMOpc8OpY290
displayName:: bWF4aW1lIGTDqXPDqWNvdA==
mail: maxime.desecot@gmail.com
mail: desecot.maxime@gmail.com
userApiKey: 69643d33363a39616532633038372d653832612d343363352d62616
 3632d3238633461313532326137393b6578703d31333a313437303730323133373331353b73
 69643d383a36373432363836393b:31057703fd7f75eca97a27383bc39d44:1470702137315
createTimestamp: 20131122132657Z
modifyTimestamp: 20131122132657Z
)

MINI_LDIF_PATH = '/home/maxime/dev/ldif/ldap_mini.bak'
MEDIUM_LDIF_PATH = '/home/maxime/dev/ldif/ldap_medium.bak'
BIG_LDIF_PATH = '/home/maxime/dev/ldif/ldap_big.bak'
VERY_BIG_LDIF_PATH = '/home/maxime/dev/ldif/ldap_very_big.bak'
TOO_BIG_LDIF_PATH = '/home/maxime/dev/ldif/ldap.bak'

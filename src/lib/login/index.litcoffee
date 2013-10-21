
# Login Controller

To access this module, use the following code: 
`login = require('../login')`.  Methods can be called as:
`login.checkUser(name, password, (user, securityLevel) -> { ... })`.

    module.exports = {}

## securityLevel

This app includes very basic support for security levels.  Levels can be
attached to pages or actions, and they will only be executed if the currently
logged in user has the same or greater level.

Levels are represented as integers everywhere except when they are "set".

    module.exports.securityLevel = securityLevel =
      anonymous:  0
      user:       100
      editor:     500
      staff:      600
      manager:    700
      admin:      800
      root:       900

## securityLevelName

Requires:

- **securityLevel** - interger from `securityLevel.\*`

Returns:

- String - description of security level.

Code:

    module.exports.securityLevelName = securityLevelName = (securityLevel) ->
      switch
        when 0    then return 'Anonymous'
        when 100  then return 'User'
        when 500  then return 'Editor'
        when 600  then return 'Staff'
        when 700  then return 'Manager'
        when 800  then return 'Admin'
        when 900  then return 'root'
      return 'Unknown'

## checkUser

Check the user's name and password.  Passwords are hashed with **bcrypt**.

TODO look at npm mongoose-password when it comes time to integrate into the
database and don't hard code this password.

Requires:

- **name** - user name
- **password** - password to check
- **callback** - (user, securityLevel)
    - **user** - user name or null if authentication failed
    - **securityLevel** - security level authorized by the authentication
      attempt

Code:

    module.exports.checkUser = checkUser = (name, password, callback) ->
      if name != 'parkrow'
        callback null, securityLevel.anonymous
      bcrypt = require 'bcrypt'
      bcrypt.compare password, '$2a$08$YGuZyKrN070rU1WrTqW2Cupnh0bRWtThJxJyXaKLWpt.I7Fl8Jlb2', (err, res) ->
        if res
          callback name, securityLevel.user
        else
          callback null, securityLevel.anonymous
          
## Copying

This software is released under the ISC License.

Copyright (c) 2013, Cameron King <cking@ecc12.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.

<!-- vim: ts=2 sts=2 sw=2 expandtab
     CoffeeScript-friendly tabstops in vim. -->

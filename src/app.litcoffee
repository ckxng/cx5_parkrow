
# Application Startup

This code starts up the application.

## Configure

First, include required modules.

    express = require 'express'
    exp3hbs = require 'express3-handlebars'
    redis_store = require('connect-redis')(express)
    config = require './config/config.js'
    secrets = require './config/private.js'

Next, initialize the application.

    app = express()

Configure HBS to glue Express and Handlebars together with HTML file extensions
for templates.

    app.set 'view engine', 'html'
    exp3hbs_config =
      defaultLayout: 'default',
      extname: '.html'
    app.engine 'html', exp3hbs(exp3hbs_config)

Configure Express to serve static files.

    app.use express.static('public', { maxAge: 86400000 })

Initialize a session for later use.  Associate session data with
`res.locals.session`.

    app.use express.cookieParser(secrets.session_key)
    app.use express.session({
      store: new redis_store({host: config.redis_host, port: config.redis_port, prefix: config.redis_prefix}),
      secret: secrets.session_key,
      maxAge: 86400000
    })
    app.use (req, res, next) ->
      res.locals.session = req.session
      next()

Place directory URL in a place where we can find it later.

    app.directory_url = secrets.directory_url

## Cross-Site Request Forgeries

Add the CSRF submission protection middleware.  This generates
`req.session.\_csrf` and maps it to `res.locals.token` so it will be available
in all templates as {{{token}}}.

Anything other than a GET, HEAD, or OPTIONS will require a valid `\_CSRF` field
or else it will be rejected with a 403.

Must be after sessions and before routers.

    app.use express.bodyParser()
    app.use express.csrf()
    app.use (req, res, next) ->
      res.locals.token = req.csrfToken()
      next()

## Database

Connect to MongoDB through Mongoose and initialize models.

    app.models = require('./lib/models')(config)

## Routes

Execute routes module.

    app.use (req, res, next) ->
      if req.session.securityLevel
        res.header('Cache-Control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0')
      next()

    require('./lib/routes')(app)

## Errors

Execute error handling module.

    require('./lib/error')(app)

    # This must be the very last middleware added to the app
    require('./lib/error/404')(app)

## Startup

Finally, start the server.

    app.listen config.port, config.ip

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

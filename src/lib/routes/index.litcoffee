
# Application Routes

The purpose of a route is to connect URL resources with underlying code.  I
also do explicit data normalization (input -> dictionary to pass to method/dict
from method -> view) at this stage.

To configure routes, the only object we need access to is `app`.  This module
can be called with `require("./lib/routes")(app)` as long as `app` is an
already initialized ExpressJS application.

Also note, app.models contians:

- **app.models.db** - Mongoose MongoDB connection
- **app.models.MODELNAME** - model objects

    module.exports = (app) ->

## GET /

Render the main index page.

      app.get '/', (req, res) ->
        fs = require('fs')
        res.render 'index', {
          title: 'Welcome',
          extra_head_css: fs.readFileSync('views/extra/nivo.css'),
          extra_foot_js: fs.readFileSync('views/extra/nivo.js')
        }

## GET /page/:name

Render static pages at /view/page/name.html

      app.get '/page/:name', (req, res) ->
        require('../page').getPage(app.models.page, req.params.name, (page) ->
          if page
            res.render 'page', page
          else
            console.error 'page '+req.params.name+' not found in db, showing static'
            res.render 'page/'+req.params.name
        )

## POST /page/_post

Post a page into the database

WARNING no security! .. then again, it doesn't read input at the moment either.

      app.post '/page/_post', (req, res) ->
        sample =
          name: 'test'
          title: 'Test Page'
          body: 'Hello world, from inside the DB'
        require('../page').setPage(app.models.page, sample, (page) ->
          if page
            res.render 'page', page
          else
            page =
              name: 'error'
              title: 'Error'
              body: 'There was an error posting your page, please try again.'
            res.render 'page', page
        )
          
## GET /login

Render static pages at /view/login/index.html

      app.get '/login', (req, res) ->
        res.render 'login'

          
## POST /login/_post

Render static pages at /view/login/index.html

      app.post '/login/_post', (req, res) ->
        require('../login').checkUser req.body.username, req.body.password, (user, securityLevel) ->
          console.info 'login callback = '+user+', '+securityLevel
          req.session.user = user
          req.session.securityLevel = securityLevel
          if securityLevel
            res.redirect '/'
          else
            res.redirect '/login'

## GET /login/clear

Logout from the website by clearing the session

      app.get '/login/clear', (req, res) ->
        req.session.destroy (err) ->
          res.redirect '/login'

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

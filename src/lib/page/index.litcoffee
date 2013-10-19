
# Page Controller

The Page controller requires access to models.  In this application, models can
be found at `app.models`.  To access this module, use the following code: 
`page = require('../page')(app.models)`.

Also note, `models` contians:

- **models.db** - Mongoose MongoDB connection
- **models.MODELNAME** - model objects

Code:

    module.exports = {}

## getPage

Requires:

- **model** - the Page model
- **name** - the name of the page to fetch
- **callback** - (page) -> {...}
    - **page** - a dict containing:
        - **page.name** - a string of the page name
        - **page.title** - a string of the page title
        - **page.body** - a string of the page body

Code:

    
    getPage = (model, name, callback) ->
      model.findOne {name: name}, (err, doc) ->
        if err
          console.error err.stack
        if !doc
          callback null
        else
          callback {
            name: doc.get 'name'
            title: doc.get 'title'
            body: doc.get 'body'
          }
    module.exports.getPage = getPage

## setPage

Requires:

- **model** - the Page model
- **page** - a dict of the page to set containing:
    - **page.name** - a string of the page name
    - **page.title** - a string of the page title
    - **page.body** - a string of the page body
- **callback** - (page) -> {...}
    - **page** - a dict of the page written to the db (uses getPage):
        - **page.name** - a string of the page name
        - **page.title** - a string of the page title
        - **page.body** - a string of the page body

Code:

    setPage = (model, page, callback) ->
      if !page || !page.name || !page.title || !page.body
        console.error 'setPage called with invalid page'
        callback null
      model.create [page], (err) ->
        if err
          console.error err.stack
          callback null
        else
          getPage model, page.name, callback
    module.exports.setPage = setPage
          
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

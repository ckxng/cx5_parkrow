
# Application Documentation Browser

This code starts up the application.

## Configure

First, include required modules.

    express = require 'express'

Next, initialize the application.

    app = express()

Configure Express to serve static files.

    app.use express.static('doc')
    app.use express.directory('doc')

## Startup

Finally, start the server.

    app.listen 3001

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

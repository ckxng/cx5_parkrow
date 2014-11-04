
# Model - Page

Models require access to the DynamoDB db object.

    module.exports = (db) ->

      table = "Cx5ParkRow_Page"

## Page object

A page is represented by the following data structure:

- name: (string) url slug
- title: (string) title of the page
- content: (string) the body of the page in raw HTML
- published: (boolean) true if page is published and visible by users
- securitylevel: (number) the minimum security level required to view this page

## get(name, cb)

Fetch a page by name (slug).

callback expects (err, data).  Data will contain a page object on success.

      page = 
        get: (name, cb) ->
          apireq =
            TableName: table
            Key:
              Name:
                S: name
                
          db.getItem apireq, (err, data) ->
            if err
              console.error 'Error getting page from '+table+': '+err
              cb err, data
            else if not data or not data.hasOwnProperty("Item") or not data.Item.hasOwnProperty("Name")
              console.error 'There is no '+name+' in '+table
              cb new Error('There is no '+name+' in '+table), data
            else
              pageret =
                name: data.Item.Name.S
                published: 1
                securitylevel: 0
              if data.Item.hasOwnProperty "Title"
                pageret.title = data.Item.Title.S
              if data.Item.hasOwnProperty "Content"
                pageret.content = data.Item.Content.S
              if data.Item.hasOwnProperty "Published"
                pageret.published = data.Item.Published.BOOL
              if data.Item.hasOwnProperty "SecurityLevel" 
                pageret.securitylevel = data.Item.SecurityLevel.N
              cb err, pageret

## set(page, cb)

Sets a page based on the object passed in.

callback expects (err, data)

Returns a page object if sucessful.  Returns null on error.

        set: (data, cb) ->
          if not data or not 'name' in data
            return null
          if not 'published' in data
            data.published = 1
          if not 'securitylevel' in data
            data.securitylevel = 0
            
          apireq = 
            TableName: table
            Item:
                Name: 
                  S: data.name
                Title:
                  S: data.title
                Content:
                  S: data.content
                Published:
                  BOOL: data.published
                SecurityLevel:
                  N: data.securitylevel
                  
          db.putItem apireq, (err, data) ->
            if err
              console.error "Error putting page to "+table+": "+err
            cb(err, data)
        
      return page

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

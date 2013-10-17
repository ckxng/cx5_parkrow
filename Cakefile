
fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

run = (cmd, params) ->
  coffee = spawn cmd, params
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'build', 'Build all', ->
  run './bin/makelinks.sh'
  run 'coffee', ['-c', '-o', '.', 'src']

task 'watch', 'Build all and watch src/ for changes', ->
  run './bin/makelinks.sh'
  run 'coffee', ['-w', '-c', '-o', '.', 'src']

task 'docs', 'Build docs', ->
  run './bin/makedocs.sh'

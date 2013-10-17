
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

task 'build', 'Build lib/ from src/', ->
  run './makelinks.sh'
  run 'coffee', ['-c', '-o', 'lib', 'src']

task 'watch', 'Watch src/ for changes', ->
  run './makelinks.sh'
  run 'coffee', ['-w', '-c', '-o', 'lib', 'src']


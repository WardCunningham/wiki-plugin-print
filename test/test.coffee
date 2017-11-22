# build time tests for print plugin
# see http://mochajs.org/

print = require '../client/print'
expect = require 'expect.js'

describe 'print plugin', ->

  describe 'expand', ->

    it 'can make itallic', ->
      result = print.expand 'hello *world*'
      expect(result).to.be 'hello <i>world</i>'

path = require 'path'
resolve = path.resolve

fs = require 'fs'
exists = fs.existsSync

rimraf = require 'rimraf'

assertDirEqual = require 'assert-dir-equal'

coffee = require '../../'

Metalsmith = require 'metalsmith'

describe 'metalsmith-coffee', () ->

	expected = source = target = undefined

	it 'should compile coffee script', (done) ->

		source = resolve './test/fixtures/basic'

		target = resolve './test/fixtures/basic/build'

		expected = resolve './test/fixtures/basic/expected'

		Metalsmith source
		
		.use coffee()
		
		.build (err) ->

			if err then return done(err)
			
			assertDirEqual expected, target

			done()

	afterEach (done) ->

		rimraf target, done
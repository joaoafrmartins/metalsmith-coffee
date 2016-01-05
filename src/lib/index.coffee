{ join } = require "path"

{ basename } = require "path"

coffee = require 'coffee-script'

async = require 'async'

class Coffee

	constructor: (options) ->

		class Middleware

			constructor: (@options) ->

				@regex = coffee.FILE_EXTENSIONS.join("$|")

				@regex = new RegExp @regex.replace(/\./g,"\\.") + "$", "g"

				if typeof @options isnt "object"

					@options = {}

				for method in ["filter", "output"]

					if @options[method] and

					typeof @options[method] isnt "function"

						delete @options[method]

						console.error "invalid option.#{method} method"

			filter: (filepath) =>

				return @regex.test filepath

			output: (filepath) =>

				return filepath.replace(@regex, '.js')

			convert: (options, files, source, done) =>

				data = files[source]

				if not data or not data.contents

					message = 'data does not exist'

					return done new Error message

				try

					outputFile = (options.output || @output)(source)
					outputMap = basename((options.output || @output)(source) + '.map') if options.sourceMap
					options.generatedFile = basename outputFile if options.sourceMap
					options.sourceFiles = [ basename(outputFile) ] if options.sourceMap
					options.inline = true if options.sourceMap

					contents = coffee.compile(data.contents.toString(), options)

					if options.sourceMap
						files[outputFile] =
							contents: new Buffer(contents.js + '\n//# sourceMappingURL=' + basename(outputMap))
						files[outputMap] =
							contents: new Buffer contents.v3SourceMap
					else
						files[outputFile] =
							contents: new Buffer contents

					return done null

				catch err then return done err

			plugin: (files, metalsmith, done) ->

				try

					paths = Object.keys(files).filter(@options.filter || @filter )

				catch err then return done err

				async.each paths, @convert.bind(null, @options, files), (err) =>

					if err then return done err

					if not @options.preserveSources

						paths.map (file) -> delete files[file]

					done null

		middleware = new Middleware options

		return middleware.plugin.bind(middleware)

module.exports = Coffee

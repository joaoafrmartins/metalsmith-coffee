path = require 'path'
join = path.join

async = require 'async'
coffee = require 'coffee-script'

module.exports = (options={}) ->

	try
		
		for name in ["filter", "output"]

			if options[name] and typeof options[name] != "function"

				throw new Error "invalid option #{name}! option #{name} is not a function!"

	catch error then console.log error.message


	regex = coffee.FILE_EXTENSIONS.join("$|")

	regex = new RegExp regex.replace(/\./g,"\\.") + "$", "g"

	filter = (filepath) ->

		return regex.test filepath

	output = (filepath) ->

		return filepath.replace(regex, '.js')

	convert = (options, files, source, done) ->

		data = files[source]

		if not data or not data.contents then return done new Error 'data does not exist'

		try

			contents = coffee.compile(data.contents.toString(), options)

			files[(options.output || output)(source)] =

				contents: new Buffer contents
		  
		catch err then return done err

		return done null
	
	return (files, metalsmith, done) ->
		
		try
			
			paths = Object.keys(files).filter(options.filter || filter )

		catch err then return done err

		async.each paths, convert.bind(null, options, files), (err) ->

			if err then return done err

			if not options.preserveSources then	paths.map (file) -> delete files[file]

			done null
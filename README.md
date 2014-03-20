# metalsmith-coffee

[![Build Status](https://travis-ci.org/christophercliff/metalsmith-less.png?branch=master)](https://travis-ci.org/christophercliff/metalsmith-less)

A [CoffeeScript][coffee] plugin for [Metalsmith][metalsmith].

## Installation

```
npm install metalsmith-coffee
```

## Usage

```js
var coffee = require('metalsmith-coffee')

Metalsmith(__dirname)
  .use(coffee(options))
  .build()
```

### Options

Use any or all of the following:

#### `filter`

A function to filter source files. By default all files with a valid coffeescript extension (.coffee, .litcoffee, .coffee.md) are included.

#### `output`

A function that receives as argument a coffee-script source file matched by filter and that shoud
return de compiled file destination filepath.

#### `preserveSources`

if preserveSources is a truthy value then the files matched by filter will also be in the build folder

Aditional options to the coffee-script compile method can also be passed in the options object.

check the coffee-script [compiler][compile] documentation for details

## Tests

```
$ npm test
```

## License

MIT License, see [LICENSE](https://github.com/joaoafrmartins/metalsmith-coffee/blob/master/LICENSE.md) for details.

## Credits

This metalsmith plugin is an adaptation of the Metalsmith [LESS][less] plugin by Cristopher Cliff 

[coffee]: http://coffeescript.org/
[compile]: http://coffeescript.org/documentation/docs/coffee-script.html#section-5
[metalsmith]: http://www.metalsmith.io/
[default filter]: https://github.com/joaoafrmartins/metalsmith-coffee/blob/master/lib/index.js#L32-L34
[default output]: https://github.com/joaoafrmartins/metalsmith-coffee/blob/master/lib/index.js#L35-L37
[default preserveSources]: https://github.com/joaoafrmartins/metalsmith-coffee/blob/master/lib/index.js#L67
[less]: https://github.com/christophercliff/metalsmith-less
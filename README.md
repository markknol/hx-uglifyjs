# Haxe/JavaScript Uglify
[![Build Status](https://travis-ci.org/markknol/hx-uglifyjs.svg?branch=master)](https://travis-ci.org/markknol/hx-uglifyjs) [![Haxelib Version](https://img.shields.io/github/tag/markknol/hx-uglifyjs.svg?label=haxelib)](http://lib.haxe.org/p/uglifyjs)

UglifyJS is a JavaScript parser, minifier, compressor and beautifier toolkit.

This library runs the [`uglify-js` node module](https://www.npmjs.com/package/uglify-js) after your Haxe/JavaScript build completed.

## Installation

First: Install the node module using NPM:

To install locally on your project: (recommended)
```cli
npm install uglify-js --save-dev
```

To install globally use:
```cli
npm install uglify-js -g
```

Second: Install using [Haxelib](https://lib.haxe.org/p/uglifyjs/):

```bash
haxelib install uglifyjs
```

To use in code, add to your build hxml:

```bash
-lib uglifyjs


# disable uglifyjs from being executed:
-D uglifyjs_disabled

# overwrite original output rather then generating a .min.js next to it
-D uglifyjs_overwrite

# disable compression
-D uglifyjs_no_compress

# disable mangling (renaming of local variables)
-D uglifyjs_no_mangle

# keep JavaScript comments
-D uglifyjs_comments
-D uglifyjs_comments=filter

# keep line breaks and indent the generated code
-D uglifyjs_beautify

# override default uglify-js node module path
-D uglifyjs_bin=path/to/bin/uglifyjs

# enable source map generation
-D uglifyjs_sourcemap

# sourcemap generation options.
# See UglifyJS docs for details on usage.
## url='url/to/sourcemap/directory/OutFile.map'
## value will default to just OutFile.map if define value is not specified
-D uglifyjs_sourcemap_url[='url/to/sourcemap/directory/']

## includeSources
-D uglifyjs_sourcemap_sources

## base=path/to/base
-D uglifyjs_sourcemap_base=path/to/base

## root=path/to/root
-D uglifyjs_sourcemap_root=path/to/root

## content=path/to/inputmap.js.map
-D uglifyjs_sourcemap_content=path/to/inputmap.js.map

## file=path/to/InFile.js
-D uglifyjs_sourcemap_file=path/to/InFile.js

```

## Using Terser as alternative of Uglify

If you are using [`terser` node module](https://www.npmjs.com/package/terser) instead of `uglifyjs`, you can just use `-D uglifyjs_bin=node_modules/.bin/terser` (assuming it's a local dependency) since both API's are the same.

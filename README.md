# Haxe/JavaScript Uglify
[![Build Status](https://travis-ci.org/markknol/hx-uglifyjs.svg?branch=master)](https://travis-ci.org/markknol/hx-uglifyjs)

UglifyJS is a JavaScript parser, minifier, compressor and beautifier toolkit.

This library runs the [uglify-js node module](https://www.npmjs.com/package/uglify-js) after your Haxe/JavaScript build completed.

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
-D uglify_no_compress

# disable mangling (renaming of local variables)
-D uglify_no_mangle

# keep JavaScript comments
-D uglifyjs_comments
-D uglifyjs_comments=filter

# enable source map generation
-D uglifyjs_sourcemap

# override default uglify-js node module path
-D uglifyjs_bin=path/to/bin/uglifyjs
```

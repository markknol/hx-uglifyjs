import haxe.macro.Context;
import sys.FileSystem;
using StringTools;
using haxe.io.Path;

class UglifyJS {

	public static function run() {
		#if !display
		if (!Context.defined("uglifyjs_disabled")) {
			Context.onAfterGenerate(compile);
		}
		#end
	}

	static function compile() {
		var inPath = haxe.macro.Compiler.getOutput();
		if (!inPath.endsWith('.js')) {
			Context.warning('Expected .js extension for output file $inPath', Context.currentPos());
		} else {
			var outputPath = if (Context.defined("uglifyjs_overwrite")) inPath else '${inPath.withoutExtension()}.min.js';
			compileFile(inPath, outputPath);
		}
	}

	static public function compileFile(inPath: String, outPath: String) {
		var params = [
			#if !uglifyjs_no_compress
			'--compress',
			#end
			#if !uglifyjs_no_mangle
			'--mangle',
			#end
			#if uglifyjs_comments
			'--comments',
			#end
			'--output', outPath,
			'--', inPath
		];

		#if uglifyjs_comments
		var uglifyjs_comments = Context.definedValue("uglifyjs_comments");
		if (uglifyjs_comments.length > 1) params.insert(params.indexOf("--comments") + 1, uglifyjs_comments);
		#end

		Sys.command(getCmd(), params);
	}

	static function getCmd() {
		var cmd = Context.defined('uglifyjs_bin')
			? Context.definedValue('uglifyjs_bin')
			: Sys.systemName() == 'Windows'
				? 'node_modules\\.bin\\uglifyjs.cmd'
				: './node_modules/.bin/uglifyjs';
		if (!FileSystem.exists(cmd)) cmd = 'uglifyjs'; // try global
		return cmd;
	}
}

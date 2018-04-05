import haxe.macro.Context;
import sys.FileSystem;
using StringTools;
using haxe.io.Path;

class UglifyJS {

	public static function run() {
        if (!Context.defined("uglifyjs_disabled")) {
			Context.onAfterGenerate(compile);
		}
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
		Sys.command(getCmd(), [
			#if !uglifyjs_no_compress
			'--compress',
			#end
			#if !uglifyjs_no_mangle
			'--mangle',
			#end
			'--output', outPath,
			'--', inPath
		]);
	}

	static function getCmd() {
		var cmd = Sys.systemName() == 'Windows'
			? 'node_modules\\.bin\\uglifyjs.cmd'
			: './node_modules/.bin/uglifyjs';
		if (!FileSystem.exists(cmd)) cmd = 'uglifyjs'; // try global
		return cmd;
	}
}

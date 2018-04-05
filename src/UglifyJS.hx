import haxe.macro.Context;
using StringTools;
using haxe.io.Path;

class UglifyJS {
	public static function run() {
		if (!Context.defined("uglifyjs_disabled")) { 
			Context.onAfterGenerate(function() { 
				var args = Sys.args();
				var inPath = haxe.macro.Compiler.getOutput();
				if (!inPath.endsWith('.js')) {
					Context.warning('Expected .js extension for output file $inPath', Context.currentPos());
				} else {
					var outputPath = if (Context.defined("uglifyjs_overwrite"))	'$inPath' else '${inPath.withoutExtension()}.min.js';
					Sys.command("node_modules/.bin/uglifyjs", ['--compress', '--mangle', '--output', '$outputPath', '--', '$inPath']);
				}
			});
		}
	}
}
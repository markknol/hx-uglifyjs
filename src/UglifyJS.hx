#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;
#end
import sys.FileSystem;
using StringTools;
using haxe.io.Path;

class UglifyJS {

	public static function run() {
		#if (!display && macro)
		if (!Context.defined("uglifyjs_disabled") && !Context.defined("uglifyjs_slavemode")) {
			Context.onAfterGenerate(compile);
		}
		#end
	}

	static function compile() {
		#if macro
		var inPath = Compiler.getOutput();
		if (!inPath.endsWith('.js')) {
			Context.warning('Expected .js extension for output file $inPath', Context.currentPos());
		} else {
			var outputPath = if (Context.defined("uglifyjs_overwrite")) inPath else '${inPath.withoutExtension()}.min.js';
			compileFile(inPath, outputPath);
		}
		#end
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
			#if uglifyjs_sourcemap
			'--source-map',
			#end
			'--output', outPath,
			'--', inPath
		];

		#if uglifyjs_sourcemap
		var sourcemapParams = [
			#if uglifyjs_sourcemap_url
			"url='" +
				#if macro (Context.definedValue("uglifyjs_sourcemap_url") != "1"
					? Context.definedValue("uglifyjs_sourcemap_url")
					: "")
				+ #end Path.withoutDirectory(outPath) + ".map'",
			#end
			#if uglifyjs_sourcemap_sources
			'includeSources',
			#end
			#if macro
			#if uglifyjs_sourcemap_base
			"base='" + Context.definedValue("uglifyjs_sourcemap_base") + "'",
			#end
			#if uglifyjs_sourcemap_content
			"content='" + Context.definedValue("uglifyjs_sourcemap_content") + "'",
			#end
			#if uglifyjs_sourcemap_filename
			"filename='" + Context.definedValue("uglifyjs_sourcemap_filename") + "'",
			#end
			#if uglifyjs_sourcemap_root
			"root='" + Context.definedValue("uglifyjs_sourcemap_root") + "'",
			#end
			#end
		];

		var sourcemapArgs = sourcemapParams.join(',');
		if (sourcemapArgs.trim().length > 0) {
			params.insert(params.indexOf("--source-map") + 1, sourcemapArgs);
		}
		#end


		#if uglifyjs_comments
		var uglifyjs_comments = Context.definedValue("uglifyjs_comments");
		if (uglifyjs_comments.length > 1) params.insert(params.indexOf("--comments") + 1, uglifyjs_comments);
		#end

		Sys.command(getCmd(), params);
	}

	static function getCmd() {
		
		var cmd = #if macro Context.defined('uglifyjs_bin')
			? Context.definedValue('uglifyjs_bin')
			: #end Sys.systemName() == 'Windows'
				? 'node_modules\\.bin\\uglifyjs.cmd'
				: './node_modules/.bin/uglifyjs';
		
		if (!FileSystem.exists(cmd)) cmd = 'uglifyjs'; // try global
		return cmd;
	}
}

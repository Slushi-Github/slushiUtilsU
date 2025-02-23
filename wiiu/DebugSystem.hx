package wiiu;

import wut.coreinit.Debug;
import haxe.PosInfos;

@:cppInclude("coreinit/debug.h") 
@:include("coreinit/debug.h")
// @:include("slushiUtilsU_DebugSystem.h")
class DebugSystem {
	// @:include("slushiUtilsU_DebugSystem.h")
	@:include("haxe_PosInfos.h")
	@:cppInclude("coreinit/debug.h")
	@:include("coreinit/debug.h")
	// @:topLevel
	public static function info(msg:String, ?pos:PosInfos = null) {
		Debug.OSReportInfo(getAndPrepareString(msg, "info", pos));
	}

	// @:include("slushiUtilsU_DebugSystem.h")
	@:cppInclude("coreinit/debug.h")
	@:include("coreinit/debug.h")
	// @:topLevel
	public static function warn(msg:String) {
		Debug.OSReportWarn(getAndPrepareString(msg, "warn"));
	}

	// @:include("slushiUtilsU_DebugSystem.h")
	@:cppInclude("coreinit/debug.h")
	@:include("coreinit/debug.h")
	// @:topLevel
	public static function error(msg:String) {
		Debug.OSReportInfo(getAndPrepareString(msg, "error"));
	}

	//////////////////////////////////////////

	// @:include("slushiUtilsU_DebugSystem.h")
	@:cppInclude("coreinit/debug.h")
	@:include("coreinit/debug.h")
	// @:topLevel
	public static function criticalStop(msg:String) {
		Debug.OSFatal(getAndPrepareString(msg, "fatal"));
	}

	//////////////////////////////////////////

	public static function getHaxeFilePos(pos:PosInfos):String {
		return pos.className + "/" + pos.methodName + ":" + pos.lineNumber;
	}

	public static function getHaxeFilePosForCrash(pos:PosInfos):String {
		return pos.fileName + ":\n\t" + pos.className + "/" + pos.methodName + ":" + pos.lineNumber;
	}

	private static function getAndPrepareString(s:String, mode:String, ?pos:PosInfos):ConstCharPtr {
		var strPtr:ConstCharPtr;

		var classDataStr:String = getHaxeFilePos(pos);
		if(classDataStr == "") {
			classDataStr = "CLASS_DATA_ERROR";
		}

		switch (mode) {
			case "info":
				strPtr = ConstCharPtr.fromString("[Slushi Debuging - INFO -> " + classDataStr + "] " + s);
			case "warn":
				strPtr = ConstCharPtr.fromString("[Slushi Debuging - WARN -> " + classDataStr + "] " + s);
			case "error":
				strPtr = ConstCharPtr.fromString("[Slushi Debuging - ERROR -> " + classDataStr + "] " + s);
			case "fatal":
				strPtr = ConstCharPtr.fromString("[Slushi Debuging - FATAL]" + "\n\nCall stack:\n" + getHaxeFilePosForCrash(pos) + "\n\nError: " + s
					+ "\n\n\t\t    Please reset the Wii U.");
			default:
				strPtr = ConstCharPtr.fromString("[Slushi Debuging - UNKNOWN -> " + classDataStr + "] " + s);
		}

		return strPtr;
	}
}

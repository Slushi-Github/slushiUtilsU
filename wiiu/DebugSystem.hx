package wiiu;

import wut.coreinit.Debug;
import haxe.PosInfos; 

@:include("wiiu_DebugSystem.h")
class DebugSystem {
	@:include("wiiu_DebugSystem.h")
	@:include("haxe_PosInfos.h")
	public static function info(msg:String, ?pos:PosInfos = null) {
		Debug.OSReportInfo(getAndPrepareString(msg, "info", pos));
	}

	@:include("wiiu_DebugSystem.h")
	@:include("haxe_PosInfos.h")
	public static function warn(msg:String, ?pos:PosInfos = null) {
		Debug.OSReportWarn(getAndPrepareString(msg, "warn", pos));
	}

	@:include("wiiu_DebugSystem.h")
	@:include("haxe_PosInfos.h")
	public static function error(msg:String, ?pos:PosInfos = null) {
		Debug.OSReportInfo(getAndPrepareString(msg, "error", pos));
	}

	//////////////////////////////////////////

	@:include("wiiu_DebugSystem.h")
	@:include("haxe_PosInfos.h")
	public static function criticalStop(msg:String, ?pos:PosInfos = null) {
		Debug.OSFatal(getAndPrepareString(msg, "fatal", pos));
	}

	//////////////////////////////////////////

	private static function getHaxeFilePos(pos:PosInfos):String {
		return pos.className + "/" + pos.methodName + ":" + pos.lineNumber;
	}

	private static function getHaxeFilePosForCrash(pos:PosInfos):String {
		return pos.fileName + ":\n\t" + pos.className + "." + pos.methodName + ":" + pos.lineNumber;
	}

	private static function getAndPrepareString(s:String, mode:String, ?pos:PosInfos):ConstCharPtr {
		var strPtr:ConstCharPtr = untyped __cpp__("nullptr");

		var classDataStr:String = getHaxeFilePos(pos);
		if(classDataStr == "") {
			classDataStr = "CLASS_DATA_ERROR";
		}

		switch (mode) {
			case "info":
				strPtr = ConstCharPtr.fromString("[Slushi Debugging - INFO -> " + classDataStr + "] " + s);
			case "warn":
				strPtr = ConstCharPtr.fromString("[Slushi Debugging - WARN -> " + classDataStr + "] " + s);
			case "error":
				strPtr = ConstCharPtr.fromString("[Slushi Debugging - ERROR -> " + classDataStr + "] " + s);
			case "fatal":
				strPtr = ConstCharPtr.fromString("[Slushi Debugging - CRASH]" + "\n\nCall stack:\n" + getHaxeFilePosForCrash(pos) + "\n\nError: " + s
					+ "\n\n\n\t\t    Please reset the Wii U.");
			default:
				strPtr = ConstCharPtr.fromString("[Slushi Debugging - UNKNOWN -> " + classDataStr + "] " + s);
		}

		return strPtr;
	}
}
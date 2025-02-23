package wiiu;

import wut.whb.Sdcard;
import Std;

class SDCardUtil {
	public static function getSDCardPathFixed():String {
		var consoleSDPath:Ptr<Char> = Sdcard.WHBGetSdCardMountPath();
		return Std.string(consoleSDPath + "/wiiu/");
	}

	@:topLevel
	public static function prepareSDCard():Void {
		Sdcard.WHBMountSdCard();
	}

	@:topLevel
	public static function getSDCardPath():String {
		return Std.string(Sdcard.WHBGetSdCardMountPath());
	}

	@:topLevel
	public static function unmountSDCard():Void {
		Sdcard.WHBUnmountSdCard();
	}
}

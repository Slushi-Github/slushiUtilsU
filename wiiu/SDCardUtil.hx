package wiiu;

import wut.whb.Sdcard;
import Std;

class SDCardUtil {
	/**
	 * Get the fixed SD Card path ("/fs/vol/external01/wiiu/").
	 * @return String
	 */
	public static function getSDCardPathFixed():String {
		var consoleSDPath:Ptr<Char> = Sdcard.WHBGetSdCardMountPath();
		return Std.string(consoleSDPath + "/wiiu/");
	}

	/**
	 * Mount the SD Card on the console.
	 */
	@:topLevel
	public static function prepareSDCard():Void {
		Sdcard.WHBMountSdCard();
	}

	/**
	 *	Get the SD Card path ("/fs/vol/external01/").
	 *	@return String
	 */
	@:topLevel
	public static function getSDCardPath():String {
		return Std.string(Sdcard.WHBGetSdCardMountPath());
	}

	/**
	 *	Unmount the SD Card from the console..
	 */
	@:topLevel
	public static function unmountSDCard():Void {
		Sdcard.WHBUnmountSdCard();
	}
}

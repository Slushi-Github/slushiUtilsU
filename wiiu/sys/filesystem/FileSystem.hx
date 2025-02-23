package wiiu.sys.filesystem;

@:native("std::filesystem")
@:include("filesystem", true)
extern class FileSystem {
	@:native("std::filesystem::rename")
	@:include("filesystem", true)
	@:topLevel
	extern public static function moveDirectory(oldDir:ConstCharPtr, newDir:ConstCharPtr):Void;

	@:native("std::filesystem::remove_all")
	@:include("filesystem", true)
	@:topLevel
	extern public static function removeDirectory(path:ConstCharPtr):Void;

	@:native("std::filesystem::create_directory")
	@:include("filesystem", true)
	@:topLevel
	extern public static function createDirectory(path:ConstCharPtr):Void;

	@:native("std::filesystem::exists")
	@:include("filesystem", true)
	@:topLevel
	extern public static function exists(path:ConstCharPtr):Bool;
}

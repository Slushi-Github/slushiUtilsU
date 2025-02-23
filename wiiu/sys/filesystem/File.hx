package wiiu.sys.filesystem;

@:cppFileCode("
#include <string>
#include <iostream>
#include <fstream>
#include <filesystem>

const char* read_file(const char* filePath)
{
	static std::string content;
	std::ifstream file(filePath);
	content.assign((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
	return content.c_str();
}

void write_file(const char* path, const std::string& content) {
	std::ofstream file(path);
	file << content;
}
")
class File {
	@:topLevel
	public static function readFile(path:ConstCharPtr):ConstCharPtr {
		return untyped __cpp__("read_file({0})", path);
	}

	@:topLevel
	public static function writeFile(path:ConstCharPtr, content:String):Void {
		untyped __cpp__("write_file({0}, {1});", path, content);
	}

	@:topLevel
	@:native("std::filesystem::remove")
	extern public static function deleteFile(path:ConstCharPtr):Void;
}

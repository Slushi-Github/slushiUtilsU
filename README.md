# SlushiUtilsU
![mainImage](https://github.com/Slushi-Github/slushiUtilsU/blob/main/docs/readme/MainImage.png)

A library that helps to facilitate the use of certain Wii U libraries.
This library includes the following:
- ``wiiu.DebugSystem``: A class for writing debug messages to the internal console terminal (possibly visible using a Wii U emulator, such as [Cemu](https://github.com/cemu-project/Cemu) or [Defac](https://github.com/decaf-emu/decaf-emu)).
- ``wiiu.sys.ConsoleScreen``: A class for handling the Wii U screens, allowing text to be typed or pixels to be placed on console displays.
- ``wiiu.SDCardUtil``: A class for handling the Wii U's SD card.
- ``wiiu.network.UDPServer``: A class to start a UDP server (Untested).
- ``wiiu.gamepad.GamepadInput``: A class for handling Wii U Gamepad input (For now only the gamepad buttons. Partially broken (?)).


This library is made to work in conjunction with the HxCompileU project, which allows to compile Haxe code to C++ via [reflaxe.cpp](https://github.com/SomeRanDev/reflaxe.CPP) and [DevKitPro tools](https://devkitpro.org/wiki/Getting_Started).

# Installation
To install this library, just install it through Haxelib:
```
haxelib git slushiUtilsU https://github.com/Slushi-Github/slushiUtilsU
```
And then add the library to your HxCompileU JSON config (You need HxCompileU version 1.2.0 or higher):
```json
{
    "extraLibs": ["slushiUtilsU"],
}
```
package wiiu.gamepad;

import wut.vpad.Input;
import wut.vpadbase.Base.VPADChan;

enum DRCErrorState {
	NO_ERROR;
	GAMEPAD_DISCONNECTED;
	UNKNOWN_ERROR;
}

enum DRCVec2D {
	X;
	Y;
}

enum DRCVec3D {
	X;
	Y;
	Z;
}

typedef DRCVec2DValues = {
	var X:Float;
	var Y:Float;
};

typedef DRCVec3DValues = {
	var X:Float;
	var Y:Float;
	var Z:Float;
};

class GamepadInput {
	////////////////////////////////////////////////////////////////////////
	// Gamepad Input Definitions
	public static var buttonA:VPADButtons = VPADButtons.VPAD_BUTTON_A;
	public static var buttonB:VPADButtons = VPADButtons.VPAD_BUTTON_B;
	public static var buttonX:VPADButtons = VPADButtons.VPAD_BUTTON_X;
	public static var buttonY:VPADButtons = VPADButtons.VPAD_BUTTON_Y;
	public static var buttonL:VPADButtons = VPADButtons.VPAD_BUTTON_L;
	public static var buttonR:VPADButtons = VPADButtons.VPAD_BUTTON_R;
	public static var buttonZL:VPADButtons = VPADButtons.VPAD_BUTTON_ZL;
	public static var buttonZR:VPADButtons = VPADButtons.VPAD_BUTTON_ZR;
	public static var buttonMinus:VPADButtons = VPADButtons.VPAD_BUTTON_MINUS;
	public static var buttonPlus:VPADButtons = VPADButtons.VPAD_BUTTON_PLUS;
	public static var buttonDpadLeft:VPADButtons = VPADButtons.VPAD_BUTTON_RIGHT;
	public static var buttonDpadRight:VPADButtons = VPADButtons.VPAD_BUTTON_LEFT;
	public static var buttonDpadUp:VPADButtons = VPADButtons.VPAD_BUTTON_UP;
	public static var buttonDpadDown:VPADButtons = VPADButtons.VPAD_BUTTON_DOWN;
	public static var buttonHome:VPADButtons = VPADButtons.VPAD_BUTTON_HOME;
	public static var buttonTV:VPADButtons = VPADButtons.VPAD_BUTTON_TV;
	public static var buttonLeftStick:VPADButtons = VPADButtons.VPAD_BUTTON_STICK_L;
	public static var buttonRightStick:VPADButtons = VPADButtons.VPAD_BUTTON_STICK_R;

	////////////////////////////////////////////////////////////////////////
	public static var drcStatus:VPADStatus;
	public static var drcError:VPADReadError;
	public static var vpadError:Bool = false;

	public static var drcTrigger:UInt32 = untyped __cpp__("drcStatus.trigger");
	public static var drcHold:UInt32 = untyped __cpp__("drcStatus.hold");
	public static var drcRelease:UInt32 = untyped __cpp__("drcStatus.release");
	
	// public static var drcAngle:VPADVec3D = untyped __cpp__("drcStatus.angle");
	// public static var drcGyroX:Float = untyped __cpp__("drcStatus.gyro.x");
	// public static var drcGyroY:Float = untyped __cpp__("drcStatus.gyro.y");
	// public static var drcGyroZ:Float = untyped __cpp__("drcStatus.gyro.z");

	// public static var drcLeftStick:VPADVec2D = untyped __cpp__("drcStatus.stick.l");
	// public static var drcRightStick:VPADVec2D = untyped __cpp__("drcStatus.stick.r");

	public static function gamepadUpdateState():Void {
		VPAD.VPADRead(VPADChan.VPAD_CHAN_0, Syntax.toPointer(drcStatus), 1, Syntax.toPointer(drcError));

		// update this values
		drcTrigger = untyped __cpp__("drcStatus.trigger");
		drcHold = untyped __cpp__("drcStatus.hold");
		drcRelease = untyped __cpp__("drcStatus.release");

		// drcAngle = untyped __cpp__("drcStatus.angle");
		// drcGyroX = untyped __cpp__("drcStatus.gyro.x");
		// drcGyroY = untyped __cpp__("drcStatus.gyro.y");
		// drcGyroZ = untyped __cpp__("drcStatus.gyro.z");
	}

	// Better use C++ code directly in this function
	public static function gamepadGetError():DRCErrorState {
		untyped __cpp__("
			switch (drcError) {
				case VPAD_READ_SUCCESS: {
					return slushiUtilsU::gamepad::DRCErrorState::NO_ERROR();
				}
				case VPAD_READ_NO_SAMPLES: {
					return slushiUtilsU::gamepad::DRCErrorState::NO_ERROR();
				}
				case VPAD_READ_INVALID_CONTROLLER: {
					vpadError = true;
					return slushiUtilsU::gamepad::DRCErrorState::GAMEPAD_DISCONNECTED();
				}
				default: {
					vpadError = true;
					return slushiUtilsU::gamepad::DRCErrorState::UNKNOWN_ERROR();
				}
			}
		");

		return null;
	}

	public static function gamepadButtonPressed(button:VPADButtons):Bool {
		return (drcHold & Stdlib.ccast(button)) != 0;
	}

	public static function gamepadButtonJustPressed(button:VPADButtons):Bool {
		return (drcTrigger & Stdlib.ccast(button)) != 0;
	}

	public static function gamepadButtonJustReleased(button:VPADButtons):Bool {
		return (drcRelease & Stdlib.ccast(button)) != 0;
	}

	public static function gamepadButtonReleased(button:VPADButtons):Bool {
		return (!gamepadButtonPressed(button));
	}

	public static function getButton(button:VPADButtons) {
		return Stdlib.ccast(button);
	}
}

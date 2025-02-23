package wiiu.network;

import wut.arpa.Inet;
import wut.sys.Socket;
import wut.netinet.In;
import wut.coreinit.Thread;
import wut.coreinit.Time;

@:cppInclude("sys/socket.h")
@:cppInclude("netinet/in.h")
@:include("sys/socket.h")
@:include("netinet/in.h")
class UDPServer {
	static var udp_socket:Int = -1;
	static var udp_lock:Bool = false;

	public static function init(ip:ConstCharPtr, port:Int16):Void {
		udp_socket = Socket.socket(Socket.AF_INET, Socket.SOCK_DGRAM, In.IPPROTO_UDP);

		if (udp_socket < 0) {
			return;
		}

		var connect_addr:Ptr<Sockaddr_in> = null;
		var sockaddr:Sockaddr = null;
		Stdlib.memset(connect_addr, 0, Stdlib.sizeof(connect_addr));
		connect_addr.sin_family = Socket.AF_INET;
		connect_addr.sin_port = Inet.htons(port);
		Inet.inet_aton(ip, connect_addr.sin_addr);

		sockaddr.sa_family = Socket.AF_INET;

		if (Socket.connect(udp_socket, sockaddr, Stdlib.sizeof(connect_addr)) < 0) {
			Stdlib.close(udp_socket);
			udp_socket = -1;
			return;
		}
	}

	public static function close():Void {
		if (udp_socket < 0) {
			return;
		}
		Stdlib.close(udp_socket);
		udp_socket = -1;
	}

	public static function print(str:ConstCharPtr):Void {
		if (udp_socket < 0) {
			return;
		}

		while (udp_lock) {
			Thread.OSSleepTicks(Time.OSSecondsToTicks(1));
			udp_lock = true;

			var len:Int = Stdlib.strlen(str);
			while (len > 0) {
				var block = len < 1400 ? len : 1400; // 1400 bytes max
				var result = Socket.send(udp_socket, Syntax.toPointer(str), block, 0);

				if (result < 0) {
					break;
				}

				len -= result;
				// Stupid Haxe syntax
				untyped __cpp__("str += result;");
			}
		}

		udp_lock = false;
	}

	public static function receive(buf:Ptr<Char>, max_len:Int):Int {
		if (udp_socket < 0) {
			return -1;
		}

		var sender_addr:Ptr<Sockaddr_in> = null;
		var addr_len:Socklen_t = Stdlib.sizeof(sender_addr);
		var result = Socket.recvfrom(udp_socket, Stdlib.ccast(buf), max_len, 0, Stdlib.ccast(sender_addr), addr_len);
		
		if (result < 0) {
			DebugSystem.error("UDPClient");
			return -1;
		}
		
		return result;
	}
}

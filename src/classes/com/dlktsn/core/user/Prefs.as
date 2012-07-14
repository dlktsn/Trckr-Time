package com.dlktsn.core.user {

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	/**
	 * @author valck
	 */
	public class Prefs {
		private static var file : File;
		private static var data : XML;

		public static function init() : void {
			file = File.applicationStorageDirectory.resolvePath("prefs.xml");
			
			if (file.exists) {
				var stream : FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				data = new XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();
			} else {
				data = 
				<prefs>
					<user>
						<username> </username>
						
						<password> </password>
					</user>
				</prefs>;
			}
		};

		public static function login() : String{
			return data..user.username;
		}
		
		public static function password() : String{
			return data.user.password;
		}
		
		public static function write(p_login : String, p_pass:String) : void {
			data..user.username = p_login;
			data..user.password = p_pass;
			
			save();
		}

		public static function clear() : void {
			data..user.username = "";
			data..user.password = "";
			
			save();
		}

		private static function save() : void {
			var stream : FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(data.toXMLString());
			stream.close();
		}
	}
}


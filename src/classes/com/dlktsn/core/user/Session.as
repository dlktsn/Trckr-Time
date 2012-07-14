package com.dlktsn.core.user {
	/**
	 * @author valck
	 */
	public class Session {
		private static var _username : String;
		private static var _password : String;
		private static var _id : String;
		
		public function Session(p_username : String = "", p_password : String = "") {
			super();

			_username = p_username;
			_password = p_password;
		}

		public static function get id() : String {
			return _id;
		}

		public static function set id(p_id : String) : void {
			_id = p_id;
		}

		public static function get username() : String {
			return _username;
		}

		public static function set username(p_value : String) : void {
			_username = p_value;
		}

		public static function get password() : String {
			return _password;
		}

		public static function set password(p_value : String) : void {
			_password = p_value;
		}
	}
}
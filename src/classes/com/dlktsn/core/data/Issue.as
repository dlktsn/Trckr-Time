package com.dlktsn.core.data {
	/**
	 * @author valck
	 */
	public class Issue {
		
		private var _id : String;
		private var _name : String;

		public function Issue() {
		};

		public function get id() : String {
			return _id;
		}

		public function set id(p_id : String) : void {
			_id = p_id;
		}

		public function get name() : String {
			return _name;
		}

		public function set name(p_name : String) : void {
			_name = p_name;
		}
	}
}

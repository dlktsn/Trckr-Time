package com.dlktsn.core.data {
	/**
	 * @author valck
	 */
	public class Project {
		
		private var _id : String;
		private var _name : String;
		private var _todos : Vector.<Todo>;
		
		public function Project(){
		
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

		public function get todos() : Vector.<Todo> {
			return _todos;
		}

		public function set todos(p_todos : Vector.<Todo>) : void {
			_todos = p_todos;
		}
	}
}

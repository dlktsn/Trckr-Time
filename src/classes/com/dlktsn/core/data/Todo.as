package com.dlktsn.core.data {
	/**
	 * @author valck
	 */
	public class Todo {
		
		private var _id : String;
		private var _project : String;
		private var _name : String;
		private var _issues : Vector.<Issue>;
		
		public function Todo(){
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

		public function get issues() : Vector.<Issue> {
			return _issues;
		}

		public function set issues(p_items : Vector.<Issue>) : void {
			if(_issues) _issues.splice(0, _issues.length);
			_issues = p_items;
		}

		public function get project() : String {
			return _project;
		}

		public function set project(p_project : String) : void {
			_project = p_project;
		}
	}
}

package com.dlktsn.core.user {

	import com.dlktsn.utils.VectorUtils;
	import com.dlktsn.core.data.Project;
	import com.dlktsn.core.data.Todo;

	/**
	 * @author valck
	 */
	public class User {
		private var _name : String;
		private var _email : String;
		private var _role : String;
		private var _avatar : String;
		
		private var _projects : Vector.<Project>;
		private var _todos : Vector.<Todo>;

		public function User(p_name : String = "", p_email : String = "", p_role : String = "", p_avatar : String = "") {
			_name = p_name;
			_email = p_email;
			_role = p_role;
			_avatar = p_avatar;
		};
		
		public function get name() : String {
			return _name;
		}

		public function set name(p_name : String) : void {
			_name = p_name;
		}

		public function get email() : String {
			return _email;
		}

		public function set email(p_email : String) : void {
			_email = p_email;
		}

		public function get role() : String {
			return _role;
		}

		public function set role(p_role : String) : void {
			_role = p_role;
		}

		public function get avatar() : String {
			return _avatar;
		}

		public function set avatar(p_avatar : String) : void {
			_avatar = p_avatar;
		}

		public function get projects() : Vector.<Project> {
			return _projects;
		}

		public function set projects(p_projects : Vector.<Project>) : void {
			if(_projects) _projects.splice(0, _projects.length);
			_projects = Vector.<Project>(VectorUtils.sortOn(p_projects, "name"));
		}

		public function get todos() : Vector.<Todo> {
			return _todos;
		}

		public function set todos(p_todos : Vector.<Todo>) : void {
			if(_todos) _todos.splice(0, _todos.length);
			_todos = Vector.<Todo>(VectorUtils.sortOn(p_todos, "name"));
		}
	}
}

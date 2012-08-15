package com.dlktsn.events {

	import com.dlktsn.core.data.Project;
	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class ProjectsListEvent extends Event {
		private var _project : Project;
		
		public function ProjectsListEvent(p_type : String, p_project:Project = null, p_bubbles : Boolean = false, p_cancelable : Boolean = false) {
			_project = p_project;
			
			super(p_type, p_bubbles, p_cancelable);
		}

		public function get project() : Project {
			return _project;
		}

		public function set project(p_project : Project) : void {
			_project = p_project;
		}
	}
}

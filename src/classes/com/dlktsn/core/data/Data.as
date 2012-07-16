package com.dlktsn.core.data {


	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Session;
	/**
	 * @author valck
	 */
	public class Data extends EventDispatcher{
		
		public function Data() {
			Application.basecamp.addEventListener(BasecampEvent.COMPLETE, result);
			Application.basecamp.addEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.projects();
		};

		public function refresh() : void {
			
		};
		
		private function error(evt : BasecampErrorEvent) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);

			trace("Error", evt.errorID);
		}

		private function merge() : void {
			var i : int;
			var j : int;
			
			for(j = 0; j<Session.user.projects.length; j++) {
				var todos : Vector.<Todo> = new Vector.<Todo>();

				for (i = 0; i < Session.user.todos.length; i++) {
					if(Session.user.projects[j].id == Session.user.todos[i].project) todos.push(Session.user.todos[i]);
				}
				
				Session.user.projects[j].todos = todos;
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function result(evt : BasecampEvent) : void {
			if(Session.user.todos && Session.user.projects){
				Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
				Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);
				
				merge();
			}else{
				Application.basecamp.todos();
			}
		}
	}
}

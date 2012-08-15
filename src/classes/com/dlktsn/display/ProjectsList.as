package com.dlktsn.display {

	import com.bit101.components.List;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.data.Project;
	import com.dlktsn.core.display.Base;
	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Session;
	import com.dlktsn.events.ProjectsListEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class ProjectsList extends Base {

//		private var combo : ComboBox;
		private var list : List;
		
		public function ProjectsList() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);

			refresh();
		}

		public function refresh() : void {
			Application.basecamp.addEventListener(BasecampEvent.COMPLETE, result);
			Application.basecamp.addEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.projects();
		}
		
		private function error(evt : BasecampErrorEvent) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);
			
			trace("Error", evt.errorID);
		}

		private function result(evt : Event = null) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);
			
//			if(combo){
//				combo.removeAll();
//				combo.removeEventListener(Event.SELECT, change);
//				combo = null;
//			}
			
//			combo = new ComboBox(this, 0, 0, "SELECT SOME JOB");
//			combo.width = Application.size.width - (Application.padding*2);
//			combo.autoHideScrollBar = true;
			
//			for (var j : int = 0; j < Session.user.projects.length; j++) {
//				if(Session.user.projects[j].todos.length == 0) continue;
//				combo.addItem({id:Session.user.projects[j].id, label:String(Session.user.projects[j].name.toUpperCase()), data:Session.user.projects[j]});
//			}
//			
//			combo.addEventListener(Event.SELECT, change);
			
			
			if(list){
				TweenMax.killTweensOf(list);
				removeChild(list);
				list.removeAll();
				list.removeEventListener(Event.SELECT, change);
				list = null;
			}
			
			list = new List(null, Application.size.width, 0);
			addChild(list);
			list.width = Application.size.width - (Application.padding*2);
			list.height = 200;
			list.autoHideScrollBar = true;
			
			for (var j : int = 0; j < Session.user.projects.length; j++) {
				if(Session.user.projects[j].todos.length == 0) continue;
				list.addItem({id:Session.user.projects[j].id, label:String(Session.user.projects[j].name.toUpperCase()), data:Session.user.projects[j]});
			}			
			
			list.addEventListener(Event.SELECT, change);
			
			TweenMax.killTweensOf(list);
			TweenMax.to(list, .55, {
				x:0,
				ease:Back.easeOut
			});
		}
		
		private function change(evt : Event) : void {
			dispatchEvent(new ProjectsListEvent(Event.CHANGE, Project(list.selectedItem.data)));
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);
			
//			combo.removeAll();
//			combo.removeEventListener(Event.SELECT, change);
//			DisplayObjectUtils.remove(combo, true);
//			combo = null;

			if(list){
				TweenMax.killTweensOf(list);
				removeChild(list);
				list.removeAll();
				list.removeEventListener(Event.SELECT, change);
				list = null;
			}
		}
	}
}

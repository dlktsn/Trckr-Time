package com.dlktsn.views {

	import com.dlktsn.ui.CheckListItem;
	import sweatless.utils.DisplayObjectUtils;

	import com.bit101.components.List;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.display.BaseView;
	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Session;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;

	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * @author valck
	 */
	public class Todos extends BaseView {
		private var projects : List;
		private var todos : List;
		private var issues : List;

		public function Todos() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);

			Application.topbar = true;

			scrollRect = new Rectangle(0, 0, Application.size.width, 375);
			
			refresh();
		}

		public function refresh() : void {
			Application.basecamp.addEventListener(BasecampEvent.COMPLETE, addProjects);
			Application.basecamp.addEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.projects();
		}
		
		private function error(evt : BasecampErrorEvent) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, addProjects);
			
			trace("Error", evt.errorID);
		}

		private function addProjects(evt : Event = null) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, addProjects);
			
			if(issues){
				TweenMax.killTweensOf(issues);
				issues.removeAll();
				issues.removeEventListener(Event.SELECT, check);
				removeChild(issues);
				issues = null;
			}
			
			if(todos){
				TweenMax.killTweensOf(todos);
				removeChild(todos);
				todos.removeAll();
				todos.removeEventListener(Event.SELECT, addIssues);
				todos = null;
			}
			
			if(projects){
				TweenMax.killTweensOf(projects);
				removeChild(projects);
				projects.removeAll();
				projects.removeEventListener(Event.SELECT, addTodos);
				projects = null;
			}
			
			projects = new List(null, Application.size.width, 90);
			addChild(projects);
			projects.width = Application.size.width - (Application.padding*2);
			projects.height = 200;
			projects.autoHideScrollBar = true;
			
			for (var j : int = 0; j < Session.user.projects.length; j++) {
				if(Session.user.projects[j].todos.length == 0) continue;
				projects.addItem({id:Session.user.projects[j].id, label:String(Session.user.projects[j].name.toUpperCase()), data:Session.user.projects[j]});
			}
			
			projects.addEventListener(Event.SELECT, addTodos);
			
			TweenMax.killTweensOf(projects);
			TweenMax.to(projects, .55, {
				x:Application.padding,
				ease:Back.easeOut
			});
		}
		
		private function addTodos(evt : Event) : void {
			if(issues){
				TweenMax.killTweensOf(issues);
				issues.removeAll();
				issues.removeEventListener(Event.SELECT, check);
				removeChild(issues);
				issues = null;
			}
			
			if(todos){
				TweenMax.killTweensOf(todos);
				removeChild(todos);
				todos.removeAll();
				todos.removeEventListener(Event.SELECT, addIssues);
				todos = null;
			}

			todos = new List(null, Application.size.width, 90);
			addChild(todos);
			todos.width = Application.size.width - (Application.padding*2);
			todos.height = 200;
			todos.autoHideScrollBar = true;
			
			for (var i : int = 0; i<projects.selectedItem.data.todos.length; i++) {
				todos.addItem({id:projects.selectedItem.data.todos[i].id, label:projects.selectedItem.data.todos[i].name.toUpperCase(), issues:projects.selectedItem.data.todos[i].issues});
			}
			
			todos.addEventListener(Event.SELECT, addIssues);
			
			TweenMax.killTweensOf(todos);
			TweenMax.to(todos, .55, {
				x:Application.padding,
				ease:Back.easeOut
			});
		}

		private function addIssues(event : Event) : void {
			if(issues){
				TweenMax.killTweensOf(issues);
				issues.removeAll();
				issues.removeEventListener(Event.SELECT, check);
				removeChild(issues);
				issues = null;
			}
			
			TweenMax.killTweensOf(todos);
			TweenMax.to(todos, .55, {
				x:-Application.size.width,
				ease:Back.easeIn
			});
			
			issues = new List(null, Application.size.width, 90);
			issues.listItemClass = CheckListItem;
			addChild(issues);
			issues.width = Application.size.width - (Application.padding*2);
			issues.height = 200;
			issues.autoHideScrollBar = true;
			
			for (var i : int = 0; i<todos.selectedItem.issues.length; i++) {
				issues.addItem({id:todos.selectedItem.issues[i].id, label:todos.selectedItem.issues[i].name.toUpperCase()});
			}
			
			issues.addEventListener(Event.SELECT, check);
			
			TweenMax.killTweensOf(issues);
			TweenMax.to(issues, .55, {
				x:Application.padding,
				ease:Back.easeOut
			});
		}
		
		private function check(evt : Event) : void {
			trace(issues.selectedItem.id);
		}
		
		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			TweenMax.killTweensOf(todos);
			TweenMax.killTweensOf(issues);
			
			issues.removeAll();
			issues.removeEventListener(Event.SELECT, check);
			DisplayObjectUtils.remove(issues, true);
			issues = null;
			
			todos.removeAll();
			todos.removeEventListener(Event.SELECT, addIssues);
			DisplayObjectUtils.remove(todos, true);
			todos = null;
			
			projects.removeAll();
			projects.removeEventListener(Event.SELECT, addTodos);
			DisplayObjectUtils.remove(projects, true);
			projects = null;
		}
	}
}

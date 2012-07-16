package com.dlktsn.views {
	import com.dlktsn.core.data.Project;
	import com.bit101.components.ComboBox;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.data.Data;
	import com.dlktsn.core.display.BaseView;
	import com.dlktsn.core.user.Session;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class TodosList extends BaseView {
		public function TodosList() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);

			Application.topbar = true;

			var data : Data = new Data();
			data.addEventListener(Event.COMPLETE, received);
		}

		private function received(evt : Event = null) : void {
			(evt.target).removeEventListener(Event.COMPLETE, received);

			for (var j : int = 0; j < Session.user.projects.length; j++) {
				trace(Session.user.projects[j].name, Session.user.projects[j].todos.length);
			}

			// function toArray():Array {
			// var ret:Array = [];
			// for each (var elem:Project in Session.user.projects) ret.push(elem.name);
			// return ret;
			// }
			//			
			// var ba : Array = toArray();
			//			
			// var c : ComboBox = new ComboBox(this, Application.padding, 90, "teste", ba);
			// c.width = Application.size.width - (Application.padding*2);
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
		}

		override public function show() : void {
			super.show();
		}

		override public function hide() : void {
			super.hide();
		}
	}
}
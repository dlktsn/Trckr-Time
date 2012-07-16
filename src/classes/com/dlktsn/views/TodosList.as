package com.dlktsn.views {
	import com.bit101.components.ComboBox;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.display.BaseView;
	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Session;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class TodosList extends BaseView {
		
		private var combo : ComboBox;
		
		public function TodosList() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);

			Application.topbar = true;

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

			combo = new ComboBox(this, Application.padding, 90, "SELECT SOME JOB");
			combo.width = Application.size.width - (Application.padding*2);
			combo.autoHideScrollBar = true;
			
			for (var j : int = 0; j < Session.user.projects.length; j++) {
				if(Session.user.projects[j].todos.length > 0) combo.addItem(Session.user.projects[j].name.toUpperCase());
			}
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

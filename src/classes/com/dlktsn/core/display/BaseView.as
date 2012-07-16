package com.dlktsn.core.display {

	import sweatless.events.Broadcaster;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class BaseView extends Base {
		public static const READY : String = "ready";
		public static const SHOWED : String = "showed";
		public static const HIDDEN : String = "closed";
		public static const DESTROYED : String = "destroyed";
		private var _id : String;

		public function BaseView() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);
			dispatchEvent(new Event(READY));
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);

			dispatchEvent(new Event(DESTROYED));
		}

		public function show() : void {
			dispatchEvent(new Event(SHOWED));
		}

		public function hide() : void {
			dispatchEvent(new Event(HIDDEN));
		}

		protected function addListeners() : void {
		}

		protected function removeListeners() : void {
		}

		public function get id() : String {
			return _id;
		}

		public function set id(p_id : String) : void {
			_id = p_id;
		}

		public function get broadcaster() : Broadcaster {
			return Broadcaster.getInstance();
		}
	}
}

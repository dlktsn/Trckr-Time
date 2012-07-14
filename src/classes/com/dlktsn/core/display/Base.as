package com.dlktsn.core.display{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Base extends Sprite {
		private var listeners : Array;

		public function Base() {
			super();

			listeners = new Array();
			addEventListener(Event.ADDED_TO_STAGE, create);
		}

		override public function addEventListener(p_type : String, p_listener : Function, p_useCapture : Boolean = false, p_priority : int = 0, p_useWeakReference : Boolean = false) : void {
			listeners.push({type:p_type, listener:p_listener, capture:p_useCapture});

			super.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
		}

		override public function removeEventListener(p_type : String, p_listener : Function, p_useCapture : Boolean = false) : void {
			for (var i : uint = 0; i < listeners.length; i++) {
				if (listeners[i].type == p_type && listeners[i].listener == p_listener && listeners[i].capture == p_useCapture) {
					listeners[i] = null;
					listeners.splice(i, 1);

					break;
				};
			}

			super.removeEventListener(p_type, p_listener, p_useCapture);
		}

		public function getAllEventListeners() : Array {
			return listeners;
		}

		public function removeAllEventListeners() : void {
			var i : uint = listeners.length;

			while (i) {
				super.removeEventListener(listeners[i - 1].type, listeners[i - 1].listener, listeners[i - 1].capture);

				listeners[i - 1] = null;
				listeners.splice(i - 1, 1);

				i--;
			}
			
			listeners = null;
			listeners = new Array();
		}

		public function create(evt : Event = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, create);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		public function destroy(evt : Event = null) : void {
			removeAllEventListeners();
		}

		public function set position(p_position : Point) : void {
			super.x = p_position.x;
			super.y = p_position.y;
		}

		public function get position() : Point {
			return new Point(super.x, super.y);
		}
	}
}

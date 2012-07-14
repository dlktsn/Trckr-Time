package com.dlktsn.core.events {

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class BasecampEvent extends Event {
		
		public static const COMPLETE : String = "complete";
		
		private var _data : XML;
		
		public function BasecampEvent(p_type : String, p_data:XML, p_bubbles : Boolean = false, p_cancelable : Boolean = false) {
			_data = p_data;
			super(p_type, p_bubbles, p_cancelable);
		}

		public function get data() : XML {
			return _data;
		}

		public function set data(p_data : XML) : void {
			_data = p_data;
		}
	}
}

package com.dlktsn.core.events {

	import flash.events.IOErrorEvent;

	/**
	 * @author valck
	 */
	public class BasecampErrorEvent extends IOErrorEvent {
		public static const ERROR : String = "error";
		
		public function BasecampErrorEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, text : String = "", id : int = 0) {
			super(type, bubbles, cancelable, text, id);
		}
	}
}

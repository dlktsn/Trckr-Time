package com.dlktsn.core.events {

	import flash.events.ProgressEvent;

	/**
	 * @author valck
	 */
	public class BasecampProgressEvent extends ProgressEvent {
		
		public static const PROGRESS : String = "progress";
		
		public function BasecampProgressEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, bytesLoaded : Number = 0, bytesTotal : Number = 0) {
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}

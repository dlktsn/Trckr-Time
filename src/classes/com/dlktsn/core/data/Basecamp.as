package com.dlktsn.core.data {

	import com.dlktsn.core.events.BasecampErrorEvent;
	import flash.events.IOErrorEvent;
	import com.dlktsn.core.events.BasecampProgressEvent;
	import flash.events.ProgressEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Session;

	import mx.utils.Base64Encoder;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;

	/**
	 * @author valck
	 */

	public class Basecamp extends EventDispatcher{
		private static const URL : String = "https://dlktsn.basecamphq.com";
		private var _loader : URLLoader;
		
		public function Basecamp(){
			 super();
		};
		
		private function get loader():URLLoader{
			_loader = _loader || new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			return _loader;
		}

		private function request(p_method:String, p_url:String):URLRequest{
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode(Session.username+":"+Session.password);
			
			var _request:URLRequest = new URLRequest(URL + p_url);
			_request.method = p_method;
			_request.contentType = "application/xml";
			_request.authenticate = true;
			
			_request.followRedirects = false;
			_request.requestHeaders = [new URLRequestHeader("Authorization", "Basic " + encoder.drain()), new URLRequestHeader("Accept", "application/xml")];

			return _request;
		}

//			loader.load(Basecamp.request(URLRequestMethod.GET, String("/me.xml")));
//			loader.load(Basecamp.request(URLRequestMethod.GET, String("/todo_lists.xml?responsible_party=4857266")));
		
		private function addListeners():void{
			loader.addEventListener(Event.COMPLETE, result);
			loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			loader.addEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		private function removeListeners():void{
			loader.removeEventListener(Event.COMPLETE, result);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, error);
			loader.removeEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		private function progress(evt:ProgressEvent):void{
			dispatchEvent(new BasecampProgressEvent(BasecampProgressEvent.PROGRESS, evt.bubbles, evt.cancelable, evt.bytesLoaded, evt.bytesTotal));
		}
		
		private function error(evt:IOErrorEvent):void{
			dispatchEvent(new BasecampErrorEvent(BasecampErrorEvent.ERROR, evt.bubbles, evt.cancelable, evt.text));
		}
		
		private function result(evt:Event):void{
			removeListeners();
			dispatchEvent(new BasecampEvent(BasecampEvent.COMPLETE, new XML((evt.target).data)));
		}
		
		public function account(p_callback:Function=null):void{
			addListeners();
			loader.load(request(URLRequestMethod.GET, String("/me.xml")));
		};
		
	}
}
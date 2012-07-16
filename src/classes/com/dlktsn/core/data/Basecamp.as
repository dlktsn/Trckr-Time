package com.dlktsn.core.data {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.events.BasecampProgressEvent;
	import com.dlktsn.core.user.Session;

	import mx.utils.Base64Encoder;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

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

		private function progress(evt:ProgressEvent):void{
			dispatchEvent(new BasecampProgressEvent(BasecampProgressEvent.PROGRESS, evt.bubbles, evt.cancelable, evt.bytesLoaded, evt.bytesTotal));
		}
		
		private function error(evt:IOErrorEvent):void{
			dispatchEvent(new BasecampErrorEvent(BasecampErrorEvent.ERROR, evt.bubbles, evt.cancelable, evt.text));
		}
		
		private function todosResults(evt:Event):void{
			loader.removeEventListener(Event.COMPLETE, todosResults);
			
			var data : XML = new XML((evt.target).data);
			var result : Vector.<Todo> = new Vector.<Todo>();
			
			for (var i : int = 0; i < data["todo-list"].length(); i++) {
				var todo : Todo = new Todo();
				todo.id = data["todo-list"][i].id; 
				todo.name = data["todo-list"][i].name;
				todo.project = data["todo-list"][i]["project-id"];
				
				var items : Vector.<TodoItem> = new Vector.<TodoItem>();
				for (var j : int = 0; j < data["todo-list"][j]["todo-items"]["todo-item"].length(); j++) {
					var item : TodoItem = new TodoItem();
					item.id = data["todo-list"][i]["todo-items"]["todo-item"][j].id;
					item.name = data["todo-list"][i]["todo-items"]["todo-item"][j].content;
					items.push(item);
				}
				
				todo.items = items;
				
				result.push(todo);
			}
			
			Session.user.todos = result;
			dispatchEvent(new BasecampEvent(BasecampEvent.COMPLETE, result));
		}
		
		private function projectsResults(evt:Event):void{
			loader.removeEventListener(Event.COMPLETE, projectsResults);
			
			var data : XML = new XML((evt.target).data);
			var result : Vector.<Project> = new Vector.<Project>();
			
			for (var i : int = 0; i < data..project.length(); i++) {
				var project : Project = new Project();
				project.id = data..project[i].id; 
				project.name = data..project[i].name; 
				
				result.push(project);
			}
			
			Session.user.projects = result;
			dispatchEvent(new BasecampEvent(BasecampEvent.COMPLETE, result));
		}
		
		private function accountResults(evt:Event):void{
			loader.removeEventListener(Event.COMPLETE, accountResults);
			
			var data : XML = new XML((evt.target).data);
			Session.id = String(data["id"]);
			Session.user.name = String(data["first-name"]);
			Session.user.email = String(data["user-name"]);
			Session.user.role = String(data["title"]);
			Session.user.avatar = String(data["avatar-url"]);
			
			var bulkloader : BulkLoader = BulkLoader.getLoader("trckrtime") || new BulkLoader("trckrtime");
			bulkloader.add(Session.user.avatar, {id:"avatar", context:new LoaderContext(false, ApplicationDomain.currentDomain)});
			bulkloader.addEventListener(BulkProgressEvent.COMPLETE, complete);
			bulkloader.start();
			
			function complete(evt:Event):void {
				BulkLoader.getLoader("trckrtime").removeEventListener(BulkProgressEvent.COMPLETE, complete);
				dispatchEvent(new BasecampEvent(BasecampEvent.COMPLETE, null));
			};
		}
		
		public function projects():void{
			loader.addEventListener(Event.COMPLETE, projectsResults);
			loader.load(request(URLRequestMethod.GET, String("/projects.xml")));
		}
		
		public function todos():void{
			loader.addEventListener(Event.COMPLETE, todosResults);
			loader.load(request(URLRequestMethod.GET, String("/todo_lists.xml?responsible_party="+Session.id)));
		}
		
		public function account():void{
			loader.addEventListener(Event.COMPLETE, accountResults);
			loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			loader.addEventListener(ProgressEvent.PROGRESS, progress);
			
			loader.load(request(URLRequestMethod.GET, String("/me.xml")));
		};
		
	}
}
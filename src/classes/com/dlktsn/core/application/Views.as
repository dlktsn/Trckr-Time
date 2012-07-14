package com.dlktsn.core.application {

	import sweatless.events.Broadcaster;

	import com.dlktsn.core.display.BaseView;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	
	public final class Views{
		
		private static var _instance : Views;
		private static var broadcaster : Broadcaster;
		
		private var views : Dictionary;
		private var current : BaseView;
		private var last : BaseView;
		private var currentViewID : String;
		private var scope : DisplayObjectContainer;
		
		public function Views(){
			if(_instance) throw new Error("Views already initialized.");
			
			broadcaster = Broadcaster.getInstance();
			views = new Dictionary(true);
		}
		
		public static function get instance():Views{
			_instance = _instance || new Views();
			return _instance;
		}
		
		public function removeView(p_id:String):void{
			views[p_id] = null;
			delete views[p_id];
		};
		
		public function getView(p_id:String):Class{
			return Class(views[p_id]);
		};
		
		public function addView(p_id:String, p_view:Class):void{
			broadcaster.setEvent("show_" + p_id);
			broadcaster.setEvent("hide_" + p_id);
			
			broadcaster.addEventListener(broadcaster.getEvent("show_" + p_id), hide);
			broadcaster.addEventListener(broadcaster.getEvent("hide_" + p_id), unload);
			
			p_view.id = p_id;
			views[p_id] = p_view;
		};
		
		public function start(p_scope:DisplayObjectContainer, p_first:String):void {
			if(last) return;
			
			scope = p_scope;
			currentViewID = p_first;
			load(null);
		};
		
		public static function goto(p_viewID:String):void{
			broadcaster.dispatchEvent(new Event(broadcaster.getEvent("show_" + p_viewID)));
		}
		
		private function show(evt:Event):void{
			current.removeEventListener(BaseView.READY, show);
			current.show();
		}
		
		private function hide(evt:Event):void{
			currentViewID = String(evt.type).slice(5);
			
			if(last) {
				last.addEventListener(BaseView.HIDDEN, load);
				last.hide();
			}else{
				load(null);
			}
		}
		
		private function load(evt:Event):void{
			if(last){
				last.removeEventListener(BaseView.HIDDEN, load);
				broadcaster.dispatchEvent(new Event(broadcaster.getEvent("hide_" + last.id)));
			}
			
			try{
				var Klass : Class = getView(currentViewID);
				current = new Klass();
				current.addEventListener(BaseView.READY, show);

				current.id = currentViewID;
				scope.addChild(current);
				
				last = current;
			}catch(e:Error){
				trace(e.getStackTrace());
			}
		}

		private function unload(evt:Event):void{
			if(last){
				last.destroy();
				scope.removeChild(last);
			}
			
			System.gc();
		}
		
		public function destroy(): void{
			for(var key:* in views){
                removeView(key);
            }
			
			broadcaster.clearAllEvents();
		}
	}
}

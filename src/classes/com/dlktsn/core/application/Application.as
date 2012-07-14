package com.dlktsn.core.application {

	import com.dlktsn.core.data.Basecamp;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	/**
	 * @author valck
	 */
	public class Application {

		private static var _basecamp : Basecamp = new Basecamp();
		private static var _size : Rectangle = new Rectangle();
		private static var _position : Point = new Point();
		private static var _stage : Stage;
		private static var _padding : uint = 10;
		
		public function Application(){
			
		};

		public static function get size() : Rectangle {
			return _size;
		}

		public static function set size(p_size : Rectangle) : void {
			_size = p_size;
		}

		public static function get position() : Point {
			return _position;
		}

		public static function set position(p_position : Point) : void {
			_position = p_position;
		}

		public static function get stage() : Stage {
			return _stage;
		}

		public static function set stage(p_stage : Stage) : void {
			_stage = p_stage;
		}

		public static function get padding() : uint {
			return _padding;
		}

		public static function set padding(p_padding : uint) : void {
			_padding = p_padding;
		}

		public static function get basecamp() : Basecamp {
			return _basecamp;
		}

		public static function set alwaysOnTop(p_value:Boolean) : void {
			stage.nativeWindow.alwaysInFront = p_value;
		}
		
		public static function center(p_size:Point=null) : void {
			var screenBounds:Rectangle = Screen.mainScreen.bounds;
			var nativeWindow:NativeWindow  = stage.nativeWindow;

	        nativeWindow.x = (screenBounds.width - (p_size ? p_size.x : size.width))/2;
	        nativeWindow.y = (screenBounds.height - (p_size ? p_size.y : size.height))/2;
		}
		
		public static function shake() : void {
			TweenMax.killTweensOf(NativeApplication.nativeApplication.activeWindow);
			
			TweenMax.to(NativeApplication.nativeApplication.activeWindow, .1, {
				repeat:2, 
				y:NativeApplication.nativeApplication.activeWindow.y+(1+Math.random()*2), 
				x:NativeApplication.nativeApplication.activeWindow.x+(1+Math.random()*2), 
				delay:.1, 
				ease:Expo.easeInOut
			});
			
   			TweenMax.to(NativeApplication.nativeApplication.activeWindow, .1, {
				y:NativeApplication.nativeApplication.activeWindow.y+(Math.random()*0), 
				x:NativeApplication.nativeApplication.activeWindow.x+(Math.random()*0), 
				delay:.3, 
				onComplete:TweenMax.killTweensOf, 
				onCompleteParams:[NativeApplication.nativeApplication.activeWindow], 
				ease:Expo.easeInOut
			});
		}

		public static function startDrag() : void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		
		public static function addListeners() : void {
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deactivate, false, 0, true);
		}

		public static function removeListeners() : void {
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, activate);
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, deactivate);

			stage.removeEventListener(MouseEvent.MOUSE_DOWN, down);
		}

		private static function activate(evt : Event) : void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			trace("active");
		}

		private static function down(evt : Event) : void {
			stage.nativeWindow.startMove();
		}

		private static function deactivate(evt : Event) : void {
			trace("deactive");
		}

		public static function exit(evt:Event=null) : void {
			removeListeners();

			System.gc();
			NativeApplication.nativeApplication.exit();
		}
	}
}
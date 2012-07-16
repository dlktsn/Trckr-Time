package com.dlktsn.display {

	import sweatless.graphics.SmartRectangle;
	import sweatless.interfaces.IDisplay;

	import com.dlktsn.core.basics.Colors;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class Avatar extends Sprite implements IDisplay {
		
		public static const HORIZONTAL : String = "HORIZONTAL";
		public static const VERTICAL : String = "VERTICAL";
		
		private var _type : String;
		private var _source : DisplayObject;
		private var fill : SmartRectangle;
		private var colors : uint;
		
		public function Avatar(p_source:DisplayObject, p_color:uint=Colors.BLACK, p_type:String=VERTICAL) {
			_source = p_source;
			_type = p_type;
			colors = p_color;
			
			addEventListener(Event.ADDED_TO_STAGE, create);	
		}

		public function get type() : String {
			return _type;
		}

		public function set type(p_type : String) : void {
			_type = p_type;
		}
		
		public function get source() : DisplayObject {
			return _source;
		}

		public function set source(p_source : DisplayObject) : void {
			if(_source){
				function change():void{
					removeEventListener(Event.COMPLETE, change);
					
					removeChild(_source);
					_source = null;
					
					_source = p_source;
					update();
					show();
				}
				
				addEventListener(Event.COMPLETE, change);
				hide();
			}else{
				_source = p_source;
				update();
				show();
			}
		}
		
		public function show() : void {
			if(!_source) return;
			
			fill.x = _source.x;
			fill.y = _source.y;
			
			_source.visible = false;
			
			TweenMax.killTweensOf(fill);
			
			if(_type == VERTICAL){
				TweenMax.to(fill, .5, {
					height:_source.height,
					y:_source.y,
					ease:Cubic.easeIn,
					onComplete:function():void{
						_source.visible = true;
						TweenMax.killTweensOf(fill);
						TweenMax.to(fill, .3, {
							height:0,
							y:_source.y + _source.height,
							ease:Cubic.easeOut
						});
					}
				});
			}else if(_type == HORIZONTAL){
				TweenMax.to(fill, .5, {
					width:_source.width,
					x:_source.x,
					ease:Cubic.easeIn,
					onComplete:function():void{
						_source.visible = true;
						TweenMax.killTweensOf(fill);
						TweenMax.to(fill, .3, {
							width:0,
							x:_source.x + _source.width,
							ease:Cubic.easeOut
						});
					}
				});
			}
		}
		
		public function hide() : void {
			if(!_source) return;
			
			TweenMax.killTweensOf(fill);
			
			if(_type == VERTICAL){
				TweenMax.to(fill, .3, {
					y:_source.y,
					height:_source.height,
					ease:Cubic.easeIn,
					onComplete:function():void{
						_source.visible = false;
						TweenMax.killTweensOf(fill);
						TweenMax.to(fill, .3, {
							y:_source.y,
							height:0,
							ease:Cubic.easeOut,
							onComplete:function():void{
								dispatchEvent(new Event(Event.COMPLETE));
							}
						});
					}
				});
			}else if(_type == HORIZONTAL){
				TweenMax.to(fill, .3, {
					x:_source.x,
					width:_source.width,
					ease:Cubic.easeIn,
					onComplete:function():void{
						_source.visible = false;
						TweenMax.killTweensOf(fill);
						TweenMax.to(fill, .3, {
							x:_source.x,
							width:0,
							ease:Cubic.easeOut,
							onComplete:function():void{
								dispatchEvent(new Event(Event.COMPLETE));
							}
						});
					}
				});
			}
		}
		
		private function update():void {
			if(fill){
				TweenMax.killTweensOf(fill);
				
				fill.width = 0;
				fill.height = 0;
			}
		    
		    if(_source){
				addChild(_source);
				fill = new SmartRectangle(_type == VERTICAL ? _source.width : 0, _type == HORIZONTAL ? _source.height : 0);
				addChild(fill);
				
				fill.colors = [colors];
				
				_source.visible = false;
		    }
		};
		
		public function create(evt : Event = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, create);
			
			update();
		}
		
		public function destroy(evt : Event = null) : void {
			if(fill){
				TweenMax.killTweensOf(fill);
				fill.destroy();
				removeChild(fill);
				fill = null;
			}
			
			if(_source){
				if(_source is Bitmap){
					removeChild(_source);
					_source = null;
				}
			}
		}
	}
}

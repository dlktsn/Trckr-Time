package com.dlktsn.views {

	import sweatless.graphics.SmartRectangle;

	import com.dlktsn.assets.ALogo;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.application.Views;
	import com.dlktsn.core.basics.Colors;
	import com.dlktsn.core.display.BaseView;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	/**
	 * @author valck
	 */
	public class Splash extends BaseView {
		private var trckr : ALogo;
		private var rect : SmartRectangle;
		
		public function Splash() {
			super();
		}
		
		override public function create(evt : Event = null) : void {
			super.create(evt);
			
			TweenPlugin.activate([BlurFilterPlugin]);
			
			rect = new SmartRectangle();
			addChild(rect);
			rect.allCorners = 3;
			rect.stroke = true;
			rect.strokeColors = [Colors.BLACK];
			rect.colors = [Colors.DARK_GRAY];
			
			trckr = new ALogo();
			addChild(trckr);
			
			rect.width = trckr.width + 50;
			rect.height = trckr.height + 50;
			
			trckr.x = (rect.width - trckr.width)/2;
			trckr.y = (rect.height - trckr.height)/2;
			
			Application.center(new Point(rect.width, rect.height));
			Application.alwaysOnTop = true;
			
			filters = [new BlurFilter(10, 10)];
			alpha = 0;
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			TweenMax.killTweensOf(this);
			
			rect.destroy();
			removeChild(rect);
			rect = null;

			removeChild(trckr);
			trckr = null;
		}
		
		override public function show():void{
			TweenMax.from(this, 2.5, {
				y:300,
				ease:Sine.easeOut
			});
			
			TweenMax.to(this, 1.5, {
				alpha:1,
				blurFilter:{
					blurX:0,
					blurY:0
				},
				ease:Quad.easeOut,
				onComplete:Views.goto,
				onCompleteParams:["login"]
			});
			
			super.show();
		}
		
		override public function hide():void{
			TweenMax.to(this, .3, {
				delay:2,
				alpha:0,
				blurFilter:{
					blurX:10,
					blurY:10
				},
				ease:Quad.easeOut,
				onComplete:super.hide
			});
		}
	}
}

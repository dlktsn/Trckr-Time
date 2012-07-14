package com.dlktsn.display {

	import com.dlktsn.assets.ADlktsnLogo;
	import com.dlktsn.assets.ALogo;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.basics.Colors;
	import com.dlktsn.core.display.Base;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import sweatless.graphics.SmartRectangle;



	/**
	 * @author valck
	 */
	public class Background extends Base {
		
		private var trckr : ALogo;
		private var dlktsn : ADlktsnLogo;
		
		private var rect : SmartRectangle;

		public function Background() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);
			
			rect = new SmartRectangle(Application.size.width, Application.size.height);
			addChild(rect);
			rect.allCorners = 3;
			rect.colors = [Colors.DARK_GRAY];
			
			trckr = new ALogo();
			addChild(trckr);
			trckr.tabChildren = trckr.tabEnabled = false;

			trckr.buttonMode = true;
			trckr.addEventListener(MouseEvent.CLICK, clickTrckr);

			trckr.x = Application.padding;
			trckr.y = Application.padding;

			dlktsn = new ADlktsnLogo();
			addChild(dlktsn);

			dlktsn.tabChildren = dlktsn.tabEnabled = false;
			dlktsn.buttonMode = true;
			dlktsn.addEventListener(MouseEvent.CLICK, clickDlktsn);
			
			dlktsn.scaleX = dlktsn.scaleY = .1;
			dlktsn.x = (Application.size.width - dlktsn.width) - Application.padding;
			dlktsn.y = (Application.size.height - dlktsn.height) - Application.padding;
		}

		private function clickDlktsn(evt : Event) : void {
			navigateToURL(new URLRequest("http://dlktsn.com/"), "_blank");
		}
		
		private function clickTrckr(evt : Event) : void {
			navigateToURL(new URLRequest("http://dlktsn.basecamphq.com/"), "_blank");
		}
		
		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);

			rect.destroy();
			removeChild(rect);
			rect = null;
			
			removeChild(trckr);
			trckr = null;
		}
	}
}

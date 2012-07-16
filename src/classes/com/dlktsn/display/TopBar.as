package com.dlktsn.display {

	import br.com.stimuli.loading.BulkLoader;

	import sweatless.utils.TransformUtils;

	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.display.Base;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class TopBar extends Base {
		
		private var avatar : Avatar;
		
		public function TopBar() {
			super();
		}
		
		override public function create(evt : Event = null) : void {
			super.create(evt);
			
			var loader : BulkLoader = BulkLoader.getLoader("trckrtime") || new BulkLoader("trckrtime");
			
			avatar = new Avatar(loader.getBitmap("avatar"));
			addChild(avatar);
			
			if(avatar.width != 55 && avatar.height != 55) TransformUtils.resize(avatar, 55, 55);
			
			avatar.x = (Application.size.width - avatar.width) - Application.padding;
			avatar.y = Application.padding;
			
			avatar.show();
		}
		
		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			avatar.destroy();
			removeChild(avatar);
			avatar = null;
		}
	}
}

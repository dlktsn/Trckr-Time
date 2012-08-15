package com.dlktsn.display {

	import br.com.stimuli.loading.BulkLoader;

	import sweatless.utils.DisplayObjectUtils;
	import sweatless.utils.StringUtils;
	import sweatless.utils.TransformUtils;

	import com.bit101.components.Label;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.display.Base;
	import com.dlktsn.core.user.Session;

	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class TopBar extends Base {
		
		private var avatar : Avatar;
		
		private var userName : Label;
		
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

			userName = new Label(this, 0, 0, "LOGGED AS " + StringUtils.abbreviate(Session.user.name.toUpperCase(), 15));
			userName.x = int(avatar.x + avatar.width) - userName.width;
			userName.y = int(avatar.y + avatar.height + 3);
			
			avatar.show();
		}
		
		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			DisplayObjectUtils.remove(userName, true);
			userName = null;
			
			avatar.destroy();
			removeChild(avatar);
			avatar = null;
		}
	}
}

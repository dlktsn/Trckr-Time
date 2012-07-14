package {

	import com.dlktsn.views.Login;
	import com.dlktsn.views.Splash;
	import com.dlktsn.core.application.Config;
	import com.dlktsn.core.application.Views;
	import com.dlktsn.core.display.Base;

	import flash.events.Event;

	[SWF(width="250", height="350", frameRate="60", backgroundColor="#111111")]
	public class Main extends Base {
		private var views : Views;

		public function Main() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);
			
			Config.init(this);

			views = new Views();
			views.addView("splash", Splash);
			views.addView("login", Login);

			views.start(this, "splash");
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			views.destroy();
		}
	}
}
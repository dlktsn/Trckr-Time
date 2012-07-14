package com.dlktsn.core.application {

	import sweatless.text.FontRegister;

	import com.bit101.components.Style;
	import com.dlktsn.core.display.Base;
	import com.dlktsn.core.user.Prefs;
	import com.dlktsn.fonts.PFRondaSeven;

	import flash.desktop.NativeApplication;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	/**
	 * @author valck
	 */
	public class Config extends EventDispatcher {
		public static const VERSION : String = "1.0";
		public static const CODENAME : String = "trckrtime";

		public function Config() {
		};

		public static function init(p_scope : Base) : void {
			Application.stage = p_scope.stage;

			Application.stage.scaleMode = StageScaleMode.NO_SCALE;
			Application.stage.align = StageAlign.TOP_LEFT;

			Application.size = new Rectangle(0, 0, Application.stage.stageWidth, Application.stage.stageHeight);

			Application.addListeners();
			
			addFonts();
			addIcons();
			
			Prefs.init();
			
			Style.setStyle(Style.DARK);

			trace("Initializing...");
		}

		private static function addFonts() : void {
			FontRegister.add(PFRondaSeven, "pixel");
		}

		private static function addIcons() : void {
			if (NativeApplication.supportsDockIcon) {
				trace("Dock icon IS supported");
			} else {
				trace("Dock icon IS NOT supported :(");
			}

			if (NativeApplication.supportsSystemTrayIcon) {
				trace("System Tray icon IS supported");
			} else {
				trace("System Tray icon IS NOT supported :(");
			}
		}

	}
}

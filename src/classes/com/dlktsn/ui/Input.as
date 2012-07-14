package com.dlktsn.ui {

	import sweatless.utils.ValidateUtils;

	import com.bit101.components.InputText;
	import com.dlktsn.core.basics.Colors;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;

	/**
	 * @author valck
	 */
	public class Input extends InputText {
		
		private var _initial : String = "";
		
		public function Input(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0, text : String = "", defaultHandler : Function = null) {
			super(parent, xpos, ypos, text, defaultHandler);
			addListeners();
		}
		
		private function addListeners():void {
			textField.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			textField.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		};
		
		private function removeListeners():void {
			textField.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			textField.removeEventListener(FocusEvent.FOCUS_OUT, focusIn);
		};
		
		private function focusIn(evt:FocusEvent):void{
			TweenMax.to(textField, .3, {
				alpha:1,
				tint:Colors.WHITE,
				ease:Linear.easeNone
			});
			
			textField.text = textField.text == _initial ? "" : textField.text;
		}
		
		private function focusOut(evt:FocusEvent):void{
			TweenMax.to(textField, .3, {
				alpha:.5,
				tint:Colors.LIGHT_GRAY,
				ease:Linear.easeNone
			});
			
			textField.text = textField.text == "" ? _initial : textField.text;
		}

		public function set initial(p_initial : String) : void {
			textField.text = _initial = p_initial;
		}
		
		public function isValid(p_length:uint=3, p_email:Boolean=false) : Boolean{
			if(textField.text == _initial || "" || textField.text.length < p_length){
				return false;
			}else if(p_email){
				return ValidateUtils.isEmail(textField.text);
			}
			
			return true;
		}
		
		public function destroy() : void {
			removeListeners();
			TweenMax.killTweensOf(textField);
		}
	}
}

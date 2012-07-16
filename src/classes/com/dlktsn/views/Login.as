package com.dlktsn.views {
	import sweatless.utils.DisplayObjectUtils;

	import com.bit101.components.CheckBox;
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.dlktsn.core.application.Application;
	import com.dlktsn.core.application.Views;
	import com.dlktsn.core.display.BaseView;
	import com.dlktsn.core.events.BasecampErrorEvent;
	import com.dlktsn.core.events.BasecampEvent;
	import com.dlktsn.core.user.Prefs;
	import com.dlktsn.core.user.Session;
	import com.dlktsn.ui.Input;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * @author valck
	 */
	public class Login extends BaseView {
		private var fieldLogin : Input;
		private var fieldPassword : Input;
		private var keepme : CheckBox;
		private var button : PushButton;
		private var incorrect : Label;

		public function Login() {
			super();
		}

		override public function create(evt : Event = null) : void {
			super.create(evt);

			Application.center();
			Application.background = true;
			Application.alwaysOnTop = false;
			Application.startDrag();
			
			var rowFields : HBox = new HBox();
			addChild(rowFields);
			
			rowFields.spacing = Application.padding*2;
			rowFields.x = Application.padding;
			rowFields.y = 110;

			var fields : VBox = new VBox(rowFields);
			var labelLogin : Label = new Label(fields);
			labelLogin.text = "E-MAIL";

			fieldLogin = new Input(fields);
			fieldLogin.restrict = "A-Z ��������������� 0-9 @ _ . \\-";
			fieldLogin.width = Application.size.width - (Application.padding * 2);
			fieldLogin.initial = "DARTH.VADER@DLKTSN.COM";
			fieldLogin.textField.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			fieldLogin.textField.addEventListener(FocusEvent.FOCUS_OUT, focusOut);

			var labelPassword : Label = new Label(fields);
			labelPassword.text = "PASSWORD";

			fieldPassword = new Input(fields);
			fieldPassword.password = true;
			fieldPassword.width = Application.size.width - (Application.padding * 2);
			fieldPassword.initial = "YOUR PASSWORD";
			fieldPassword.textField.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			fieldPassword.textField.addEventListener(FocusEvent.FOCUS_OUT, focusOut);

			var checks : HBox = new HBox(null, Application.padding, (rowFields.y + 95));
			addChild(checks);
			checks.alignment = HBox.MIDDLE;
			checks.spacing = 114;

			keepme = new CheckBox(checks);
			keepme.label = "KEEP ME LOGGED IN";

			button = new PushButton(checks, 0, 0, "LOGIN", prepare);
			button.label = "LOGIN";
			
			incorrect = new Label(null, Application.padding, rowFields.y + 120);
			addChild(incorrect);
			
			if(Prefs.login()){
				keepme.enabled = false;
				button.enabled = false;
				fieldLogin.enabled = false;
				fieldPassword.enabled = false;
				
				keepme.selected = true;
				fieldLogin.text = Session.username = Prefs.login();
				fieldPassword.text = Session.password = Prefs.password();
				
				getData();
			}else{
				stage.focus = fieldLogin.textField;
			}
			
			alpha = 0;
		}

		private function focusIn(evt : FocusEvent) : void {
			stage.addEventListener(KeyboardEvent.KEY_UP, press);
		}

		private function focusOut(evt : FocusEvent) : void {
			stage.removeEventListener(KeyboardEvent.KEY_UP, press);
		}

		private function press(evt : KeyboardEvent) : void {
			if (evt.altKey == Keyboard.ENTER || evt.charCode == 13) prepare(null);
		}

		private function prepare(evt : Event = null) : void {
			if(!fieldLogin.isValid(3, true)){
				message(incorrect.text = "PLEASE TYPE A CORRECT E-MAIL.");

				stage.focus = fieldLogin.textField;
				fieldLogin.textField.setSelection(0, fieldLogin.textField.getLineLength(0));
				
				Application.shake();
				
			}else if(!fieldPassword.isValid(3)){
				message("PLEASE TYPE A CORRECT PASSWORD.");
				
				stage.focus = fieldPassword.textField;
				fieldPassword.textField.setSelection(0, fieldPassword.textField.getLineLength(0));
				
				Application.shake();
				
			}else{
				incorrect.text = "";
				
				keepme.enabled = false;
				button.enabled = false;
				fieldLogin.enabled = false;
				fieldPassword.enabled = false;
				
				Session.username = fieldLogin.text;
				Session.password = fieldPassword.text;
				
				if(keepme.selected){
					Prefs.write(Session.username, Session.password);
				}else{
					Prefs.clear();
				}
				
				getData();
			}
		}

		private function message(p_text:String) : void {
			incorrect.text = p_text;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, move);

			function move():void{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, move);
				incorrect.text = "";
			}
		}
		
		private function getData() : void {
			Application.basecamp.addEventListener(BasecampEvent.COMPLETE, result);
			Application.basecamp.addEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.account();
		}

		private function error(evt : BasecampErrorEvent) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);
			
			keepme.enabled = true;
			button.enabled = true;
			fieldLogin.enabled = true;
			fieldPassword.enabled = true;
			
			message("SOME ERROR OCCURRED, PLEASE TRY AGAIN.");
			
			trace("Error", evt.errorID);
		}
		
		private function result(evt : BasecampEvent) : void {
			Application.basecamp.removeEventListener(BasecampErrorEvent.ERROR, error);
			Application.basecamp.removeEventListener(BasecampEvent.COMPLETE, result);

			Views.goto("list");
		}
		
		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
			stage.removeEventListener(KeyboardEvent.KEY_UP, press);
			
			fieldLogin.textField.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			fieldLogin.textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			
			fieldPassword.textField.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			fieldPassword.textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);

			DisplayObjectUtils.remove(fieldLogin, true);
			fieldLogin = null;

			DisplayObjectUtils.remove(fieldPassword, true);
			fieldPassword = null;

			DisplayObjectUtils.remove(keepme, true);
			keepme = null;
			
			DisplayObjectUtils.remove(button, true);
			button = null;
			
			DisplayObjectUtils.remove(this.incorrect, true);
			incorrect = null;
		}

		override public function show() : void {
			TweenMax.to(this, .3, {
				alpha:1,
				ease:Quad.easeOut,
				onComplete:super.show
			});
		}

		override public function hide() : void {
			TweenMax.to(this, .3, {
				alpha:0,
				ease:Quad.easeOut,
				onComplete:super.hide
			});
		}
	}
}

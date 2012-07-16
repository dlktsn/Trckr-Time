package com.dlktsn.ui {

	import com.bit101.components.CheckBox;
	import com.bit101.components.ListItem;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author valck
	 */
	public class CheckListItem extends ListItem {
		protected var _checkBox : CheckBox;

		public function CheckListItem(parent : DisplayObjectContainer = null, xpos : Number = 0, ypos : Number = 0, data : Object = null) {
			super(parent, xpos, ypos, data);
		}

		protected override function addChildren() : void {
			super.addChildren();
			_checkBox = new CheckBox(this, 5, 5, "", onCheck);
			_label.visible = false;
		}

		public override function draw() : void {
			super.draw();
			if (_data is String) {
				_checkBox.label = _data as String;
			} else if (_data.label is String) {
				_checkBox.label = _data.label;
			} else {
				_checkBox.label = _data.toString();
			}

			if (_data.checked != null) {
				_checkBox.selected = _data.checked;
			}
		}

		protected function onCheck(event : Event) : void {
			_data.checked = _checkBox.selected;
		}
	}
}

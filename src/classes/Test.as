package {

	import com.dlktsn.core.display.Base;

	import flash.events.Event;


	[SWF(width="550", height="400", frameRate="60", backgroundColor="#cccccc")]
	public class Test extends Base {
		
		public static const GET_LISTS_BY_PARTY : String = "/todo_lists.xml?responsible_party=#{id}";
		
		public function Test() {
			super();
		}
		
		override public function create(evt : Event = null) : void {
			super.create(evt);
		}

		override public function destroy(evt : Event = null) : void {
			super.destroy(evt);
			
		}
	}
}
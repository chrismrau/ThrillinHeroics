package 
{
	import flash.events.Event;
	
	public class MouseClickEvent extends Event
	{
		public static const EVENT_MOUSE_CLICK:String = "Mouse Click Event";
		
		private var _parent:String;
		public function get Parent():String { return _parent; }
		
		private var _child:String;
		public function get Child():String { return _child; }
		
		public function MouseClickEvent(parent:String, child:String)
		{
			super(EVENT_MOUSE_CLICK, false, false);
			_parent = parent;
			_child = child;
		}
		
		override public function clone():Event
		{
			return new MouseClickEvent(Parent, Child);
		}
		
	}
}
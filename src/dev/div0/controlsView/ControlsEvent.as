package dev.div0.controlsView
{
	import flash.events.Event;
	
	public class ControlsEvent extends Event
	{
		public static const START_SEARCH:String = "startSearch";
		public static const STOP_SEARCH:String = "stopSearch";
		public static const SEND_CHAT_MESSAGE:String = "sendChatMessage";
		
		public var data:Object;
		
		public function ControlsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
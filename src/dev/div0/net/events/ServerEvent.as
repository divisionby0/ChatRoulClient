package dev.div0.net.events
{
	import flash.events.Event;
	
	public class ServerEvent extends Event
	{
		public static const CHAT_MESSAGE:String = "chatMessage"; 
		public static const USER_STATE_CHANGED:String = "userStateChanged"; 
		public static const OPPONENT_CONNECTION_REQUEST:String = "opponentConnectionRequest"; 
		public var data:Object;
		public function ServerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
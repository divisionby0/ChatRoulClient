package dev.div0.textChat
{
	import flash.events.Event;
	
	public class TextChatEvent extends Event
	{
		public static const SEND_MESSAGE:String="sendMessage";
		public var data:Object;
		public function TextChatEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
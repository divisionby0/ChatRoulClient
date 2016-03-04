package dev.div0.textChat
{
	public class TextChatMessage
	{
		private var _prefix:String;
		private var _message:String;
		
		public function TextChatMessage(prefix:String, message:String)
		{
			this.prefix = prefix;
			this.message = message;
		}

		[Bindable]
		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

		[Bindable]
		public function get prefix():String
		{
			return _prefix;
		}

		public function set prefix(value:String):void
		{
			_prefix = value;
		}

	}
}
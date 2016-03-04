package dev.div0.controls
{
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.Event;
	
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	import spark.events.RendererExistenceEvent;
	
	public class TextChatList extends List
	{
		public function TextChatList()
		{
			super();
			addEventListener(RendererExistenceEvent.RENDERER_ADD, rendererAddHandler);
			addEventListener(UpdateCompleteEvent.UPDATE_COMPLETE, updateCompleteHandler);
		}
		
		private function updateCompleteHandler(event:FlexEvent):void
		{
			log("upadte complete");
			ensureIndexIsVisible(dataProvider.length - 1);
		}
		
		private function rendererAddHandler(event:RendererExistenceEvent):void
		{
			log("chat message index: "+event.index);
			ensureIndexIsVisible(event.index);
		}
		
		private function log(param0:String):void
		{
			trace(param0);
			var logEvent:LogEvent = new LogEvent(LogEvent.LOG);
			logEvent.data = param0;
			Dispatcher.getInstance().dispatchEvent(logEvent);
		}
	}
}
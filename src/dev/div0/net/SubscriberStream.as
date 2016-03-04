package dev.div0.net
{
	import dev.div0.Settings;
	import dev.div0.media.PublisherMedia;
	import dev.div0.net.events.StreamEvent;
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.NetStatusEvent;
	import flash.media.H264VideoStreamSettings;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class SubscriberStream extends BaseStream
	{
		private var smallBuffer:Number = 0.1;
		private var bigBuffer:Number = 1;
		
		
		public function SubscriberStream(_id:String)
		{
			super(_id);
		}
		
		public function setStreamId(value:String):void{
			_id = value;
		}
		
		public function onMetaData(data:Object):void
		{
			trace("on Meta data ");
		}
		
		override protected function createStream():void
		{
			log("Subscriber create stream. Stream = "+stream);
			if(!stream){
				stream = new NetStream(connection);
				stream.client = this;
				
				var streamEvent:StreamEvent = new StreamEvent(StreamEvent.STREAM_READY);
				Dispatcher.getInstance().dispatchEvent(streamEvent);
			}
			
			stream.addEventListener(NetStatusEvent.NET_STATUS,streamStatusHandler);
			stream.play(_id);
		}
		
		override protected function onStreamConnected():void
		{
			log("start play opp stream "+_id);
			stream.play(_id);
			stream.bufferTime = smallBuffer;
			Dispatcher.getInstance().dispatchEvent(new StreamEvent(StreamEvent.STREAM_STARTED));
		}
		override protected function streamStatusHandler(event:NetStatusEvent):void{
			super.streamStatusHandler(event);
			
			switch(event.info.code){
				case "NetStream.Buffer.Full":
					if (stream.bufferTime != smallBuffer) 
					{
						stream.bufferTime = smallBuffer;
					}
					break;
				case "NetStream.Buffer.Empty":
					if (stream.bufferTime != bigBuffer) 
					{
						stream.bufferTime = bigBuffer;
					}
					break;
			}
		}
	}
}
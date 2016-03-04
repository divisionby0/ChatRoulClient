package dev.div0.net
{
	import dev.div0.Settings;
	import dev.div0.net.events.StreamEvent;
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;

	public class BaseStream
	{
		protected var _id:String  = "-1";
		protected var streamer:String = "";
		protected var stream:NetStream;
		protected var connection:NetConnection;
		protected var connectionClient:ConnectionClient;
		
		protected var groupSpecifier:GroupSpecifier;
		private var streamEvent:StreamEvent;
		
		public function BaseStream(_id:String):void
		{
			if(_id){
				this._id = _id;
			}
			if(Settings.rtmp){
				streamer = Settings.rtmp;
			}
			connectionClient = new ConnectionClient();
		}
		public function start():void{
			connect();
		}
		
		public function stop():void{
			if(stream)
			{
				stream.close();
				stream.removeEventListener(NetStatusEvent.NET_STATUS, streamStatusHandler);
			}
			
			stream = null;
		}
		
		public function disconnect():void{
			if(connection){
				connection.close();
			}
			connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHander);
		}
		public function getConnection():NetConnection{
			return connection;
		}
		
		public function getStream():NetStream{
			return stream;
		}
		
		private function connect():void
		{
			if(!connection){
				connection = new NetConnection();
				connection.client = connectionClient;
			}
			
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHander);
			connection.connect(streamer);
		}
		
		protected function log(param0:String):void
		{
			var logEvent:LogEvent = new LogEvent(LogEvent.LOG);
			logEvent.data = param0;
			Dispatcher.getInstance().dispatchEvent(logEvent);
		}
		protected function netStatusHander(event:NetStatusEvent):void
		{
			//log("Base netStatus:"+event.info.code);
			switch(event.info.code) 
			{
				case 'NetConnection.Connect.Success':
					createStream();
					break;
				case "NetGroup.Connect.Success": // e.info.group
					netGroupConnected();
					break;
				case "NetStream.Connect.Success":
					onStreamConnected();
					break;
			}
		}
		
		protected function onStreamConnected():void
		{
			
		}
		
		protected function netGroupConnected():void
		{
			log('netGroupConnected');
		}
		
		protected function streamStatusHandler(event:NetStatusEvent):void
		{
			//log("BaseStream streamStatus:"+event.info.code);
			switch(event.info.code){
				case "NetStream.Play.Start":
					streamEvent = new StreamEvent(StreamEvent.STREAM_STARTED);
					streamEvent.data = _id;
					Dispatcher.getInstance().dispatchEvent(streamEvent);
					break;
				case "NetStream.Publish.Start":
					streamEvent = new StreamEvent(StreamEvent.STREAM_STARTED);
					streamEvent.data = _id;
					Dispatcher.getInstance().dispatchEvent(streamEvent);
					sendMetadata();
					break;
				
			}
		}
		
		protected function sendMetadata():void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function createStream():void
		{
			
		}
	}
}
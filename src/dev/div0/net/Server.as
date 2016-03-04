package dev.div0.net
{
	import dev.div0.net.request.GetOpponentRequest;
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;

	public class Server
	{
		private var connection:NetConnection;
		private var connectionClient:ConnectionClient;
		private var connectionUrl:String;
		private var userId:String;
		
		public function Server(connectionUrl:String, userId:String)
		{
			this.connectionUrl = connectionUrl;
			this.userId = userId;
			createConnection();
		}
		
		private function createConnection():void
		{
			connection = new NetConnection();
			connectionClient = new ConnectionClient();
			connection.client = connectionClient;
			connection.addEventListener(NetStatusEvent.NET_STATUS, serverConnectionStatusHandler);
			connection.connect(connectionUrl, userId);
		}
		
		public function startSearch():void{
			new GetOpponentRequest(connection);
		}
		public function sendChatMessage(message:String):void{
			connection.call("sendChatMessageRequest", null, message);
		}
		public function stopSearch():void{
			log("Server stop search");
			connection.call("stopSearchForOpponent",null);
		}
		public function isConnected():Boolean{
			return connection.connected;
		}
		
		private function serverConnectionStatusHandler(event:NetStatusEvent):void
		{
			log("ServerConnection: "+event.info.code);
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
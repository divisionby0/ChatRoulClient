package dev.div0.net
{
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.EventDispatcher;
	import dev.div0.net.events.ServerEvent;

	public class ConnectionClient extends EventDispatcher
	{
		public function helloServerResponce():void{
			log("on hello from server");
		}
		
		public function opponentConnectRequest(opponentStreamId:String, opponentName:String):void{
			log("opponentConnectRequest stream="+opponentStreamId+"  opponentName="+opponentName);
			var serverEvent:ServerEvent = new ServerEvent(ServerEvent.OPPONENT_CONNECTION_REQUEST);
			serverEvent.data = {opponentStreamId:opponentStreamId, opponentName:opponentName};
			Dispatcher.getInstance().dispatchEvent(serverEvent);
		}
		public function stateChanged(state:String):void{
			var serverEvent:ServerEvent = new ServerEvent(ServerEvent.USER_STATE_CHANGED);
			serverEvent.data = state;
			Dispatcher.getInstance().dispatchEvent(serverEvent);
		}
		
		public function chatMessage(message:String):void{
			log(message);
			var serverEvent:ServerEvent = new ServerEvent(ServerEvent.CHAT_MESSAGE);
			serverEvent.data = message;
			//dispatchEvent(serverEvent);
			Dispatcher.getInstance().dispatchEvent(serverEvent);
		}
		
		private function log(message:String):void{
			trace(message);
			var logEvent:LogEvent = new LogEvent(LogEvent.LOG);
			logEvent.data = message;
			Dispatcher.getInstance().dispatchEvent(logEvent);
		}
	}
}
package dev.div0.net.request
{
	import flash.net.NetConnection;

	public class GetOpponentRequest
	{
		public function GetOpponentRequest(connection:NetConnection)
		{
			connection.call("getOpponentRequest",null);
		}
	}
}
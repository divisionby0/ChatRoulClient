package dev.div0.net
{
	import dev.div0.Settings;
	import dev.div0.media.PublisherMedia;
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.NetStatusEvent;
	import flash.media.H264Level;
	import flash.media.H264Profile;
	import flash.media.H264VideoStreamSettings;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class PublisherStream extends BaseStream
	{
		private var media:PublisherMedia;
		
		public function PublisherStream(_id:String, media:PublisherMedia)
		{
			super(_id);
			this.media = media;
		}
		
		override protected function createStream():void
		{
			if(!stream){
				stream = new NetStream(connection);
			}
			
			stream.addEventListener(NetStatusEvent.NET_STATUS,streamStatusHandler);
			
			//log("camera="+media.getCamera().name);
			
			stream.attachCamera(media.getCamera());
			stream.attachAudio(media.getMicrophone());
			
			//var h264VieoCodec:H264VideoStreamSettings = new H264VideoStreamSettings();
			//h264VieoCodec.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_1);
			//stream.videoStreamSettings = h264VieoCodec;
			
			//log("start publishing stream "+_id);
			stream.publish(_id, 'live');
		}
		
		/*
		override protected function sendMetadata():void{
			var metaData:Object = new Object();
			metaData.cameraWidth = media.getCamera().width;
			metaData.cameraHeight = media.getCamera().height;
			stream.send("@setDataFrame", "onMetaData", metaData);
			log("metadata sent");
		}
		*/
	}
}
package dev.div0.media
{
	import flash.events.Event;
	
	public class MediaEvent extends Event
	{
		public static const CAMERA_MUTED:String = "cameraMuted";
		public static const CAMERA_UNMUTED:String = "cameraUnmuted";
		
		public function MediaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
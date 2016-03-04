package dev.div0.media
{
	import dev.div0.utils.Dispatcher;
	import dev.div0.utils.log.LogEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.MicrophoneEnhancedMode;
	import flash.media.MicrophoneEnhancedOptions;
	import flash.media.SoundCodec;

	public class PublisherMedia
	{
		private var camera:Camera;
		private var mic:Microphone;
		
		private var cameraWidth:int = 480;
		private var cameraHeight:int = 360;
		
		private var cameraNames:Array; 
		
		public function PublisherMedia()
		{
			getMedia();
		}
		public function init():void{
			getMedia();
		}
		private function getMedia():void{
			camera = Camera.getCamera();
			mic = Microphone.getEnhancedMicrophone();
			
			//getRandomCamera();
			
			log("camera = "+camera.name);
			
			if(camera.muted){
				camera.addEventListener(StatusEvent.STATUS, cameraStatusHandler);
				Dispatcher.getInstance().dispatchEvent(new MediaEvent(MediaEvent.CAMERA_MUTED));
				return;
			}
			else{
				camera.removeEventListener(StatusEvent.STATUS, cameraStatusHandler);
				Dispatcher.getInstance().dispatchEvent(new MediaEvent(MediaEvent.CAMERA_UNMUTED));
			}
			
			updateCameraSettings();
			updateMicSettings();
		}
		
		private function getRandomCamera():void
		{
			cameraNames = Camera.names;
			
			var selectedCameraIndex:int = Math.round(Math.random()*(cameraNames.length-1)); 
			var selectedCameraName:String = cameraNames[selectedCameraIndex];			
			camera = Camera.getCamera(selectedCameraIndex.toString());
		}
		
		private function updateMicSettings():void
		{
			if(mic){
				
				try{
					//mic.setSilenceLevel(0);
					mic.codec = SoundCodec.NELLYMOSER;
					mic.encodeQuality = 10;
					//mic.rate = 44;
					
					var micOptions : MicrophoneEnhancedOptions = new MicrophoneEnhancedOptions();
					micOptions.echoPath = 128;
					micOptions.mode = MicrophoneEnhancedMode.FULL_DUPLEX;
					micOptions.nonLinearProcessing = true;
					mic.setSilenceLevel(0);
					mic.rate = 44;
					mic.enhancedOptions = micOptions;
				}
				catch(error:Error){
					log("set mic properties error: "+error.message);
				}
			}
		}
		
		private function updateCameraSettings():void
		{
			if(camera){
				try{
					camera.setMode(cameraWidth, cameraHeight, 16, true);
					camera.setQuality(0, 85);
					//camera.setKeyFrameInterval(15);
				}
				catch(error:Error){
					log("set camera properties error: "+error.message);
				}
			}
		}
		
		private function cameraStatusHandler(event:StatusEvent):void
		{
			//log("Camera status : "+event.code);
			if(event.code == "Camera.Unmuted"){
				updateCameraSettings();
				updateMicSettings();
				Dispatcher.getInstance().dispatchEvent(new MediaEvent(MediaEvent.CAMERA_UNMUTED));
			}
		}
		public function getCamera():Camera{
			return camera;
		}
		public function getMicrophone():Microphone{
			return mic;
		}
		public function clear():void{
			camera = null;
			mic = Microphone.getMicrophone();
			mic = null;
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
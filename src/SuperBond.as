package{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import img.Assets;
	
	public class SuperBond extends Sprite{
		
		public function SuperBond(){
			if( stage )setStage();
			else addEventListener(Event.ADDED_TO_STAGE, onAdd );
			
			addLogo();
		}
		
		private function onAdd(event:Event):void{
			setStage();			
		}
		
		private function setStage():void{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			var bg :Bitmap = Assets.assets().bg;
			bg.x = -512;
			addChildAt( bg, 0 );
		}
		
		private function addLogo():void{
			var logo :Bitmap = Assets.assets().logoIcon;
			logo.x = 880;
			logo.y = 550;
			logo.smoothing = true;
			logo.scaleX = logo.scaleY = 0.2;
			addChild( logo );
		}
	}
}
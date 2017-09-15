package img{
	import flash.display.Bitmap;
	
	import skin.allButtons;
	import skin.backGround;
	import skin.ballAsset;
	import skin.bomboRing;
	import skin.logo;
	import skin.tripleSceneCropped;
	
	public class Assets{
		
		public var textureBomboRing : Bitmap;
		public var bg : Bitmap;
		public var textureTripleSceneCropped : Bitmap;
		public var logoIcon :Bitmap;
		public var buttons :Bitmap;
		public var balls :Bitmap;
		
		private static var instance :Assets;
		
		public static function assets():Assets{
			if( !instance )instance = new Assets;
			return instance;
		}
		
		public function Assets(){
			textureBomboRing = new Bitmap( new bomboRing() );
			bg = new Bitmap( new backGround );
			textureTripleSceneCropped = new Bitmap( new tripleSceneCropped );
			logoIcon = new Bitmap( new logo );
			buttons = new Bitmap( new allButtons );
			balls = new Bitmap( new ballAsset );
		}
	}
}
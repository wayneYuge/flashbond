package projo.balls{
	
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import h5swc.TextureBitmap;
	
	import img.Assets;
	
	import projo.GameText;
	import h5swc.ModelSprite;
	
	internal class GameExtra extends ModelSprite{
		
		private var normalExtra : TextureBitmap;
		private var extraBox : TextureBitmap;
		private var extraText : TextField;
		
		public function GameExtra(){
			normalExtra = new TextureBitmap( Assets.assets().balls, new Rectangle( 3093, 2370, 182, 182 ) );			
			normalExtra.x = 5;
			normalExtra.y = 5;
			
			extraBox = new TextureBitmap( Assets.assets().textureTripleSceneCropped, new Rectangle( 1148, 136, 172, 212 ) );
			extraBox.x = 10;
			extraBox.y = -195;
			addChild( extraBox );
			addChild( normalExtra );
			
			extraText = GameText.createText( 160, GameText.getExtraCss(), 15, 70, "FREE", true );
			addChild( extraText );
		}
	}
}
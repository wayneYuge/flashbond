package projo.card{
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import h5swc.TextureBitmap;
	
	import img.Assets;
	
	public class CardRewadItem{
		
		private var rect : Rectangle;
		private var position : Point;
		
		public function CardRewadItem( rect : Rectangle, position : Point ){
			this.rect = rect;
			this.position = position;
		}
		
		public function getIcon():Shape{
			var tx :TextureBitmap = new TextureBitmap( Assets.assets().textureTripleSceneCropped, rect );
			tx.x = position.x;
			tx.y = position.y;
			return tx;
		}
	}
}
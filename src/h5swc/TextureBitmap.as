package h5swc{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class TextureBitmap extends Shape{
		
		private var texture : Bitmap;
		
		public function TextureBitmap( texture : Bitmap, rect : Rectangle ){
			graphics.beginBitmapFill( texture.bitmapData, new Matrix( 1,0,0,1,-rect.x,-rect.y ), true, true );
			graphics.drawRect( 0, 0, rect.width, rect.height );
			graphics.endFill();
			this.cacheAsBitmap = true;
		}
	}
}
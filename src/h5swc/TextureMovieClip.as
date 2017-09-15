package h5swc{
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	public class TextureMovieClip extends ModelSprite{
		
		private var msk :Shape;
		
		private var texture : TextureBitmap; 
		
		private var size :Point = new Point;
		
		private var pointVector :Vector.<Rectangle>;
		
		private var intervalIndex : int = 0;
		
		private var freeFrames : int;
		
		private var currentFrame : int = 0;
		
		public function get totalFrames():int{
			if( !pointVector )return 0;
			return pointVector.length;
		}
		
		public function TextureMovieClip( texture : Bitmap, pointVector : Vector.<Rectangle>, freeFrames : int = 1 ){
			var rect :Rectangle = new Rectangle( 0, 0, texture.width, texture.height );
			this.texture = new TextureBitmap( texture, rect );
			addChild( this.texture );
			msk = new Shape;
			entity.mask = msk;
			addChild( msk );
			
			this.pointVector = pointVector;
			this.freeFrames = freeFrames;
			
			flushTexturePosition();
		}
		
		public function get height():Number{
			return size.y;
		}
		
		public function set height(value:Number):void{
			size.y = value;
			redrawMsk();
		}
		
		public function get width():Number{
			return size.x;
		}
		
		public function set width(value:Number):void{
			size.x = value;
			redrawMsk();
		}
		
		private function redrawMsk():void{
			msk.graphics.clear();
			msk.graphics.beginFill(0);
			msk.graphics.drawRect( 0, 0, size.x, size.y );
			msk.graphics.endFill();
		}
		
		public function play():void{
			entity.addEventListener( Event.ENTER_FRAME, onFrame );			
		}
		
		private function onFrame(event:Event):void{
			if( !entity.parent )return;
			intervalIndex ++;
			if( intervalIndex == freeFrames ){
				intervalIndex = 0;
				currentFrame++;
				if( currentFrame == pointVector.length )currentFrame = 0;
				flushTexturePosition();
			}
		}		
		
		private function flushTexturePosition():void		{
			this.texture.x = -pointVector[currentFrame].x;
			this.texture.y = -pointVector[currentFrame].y;
		}
	}
}
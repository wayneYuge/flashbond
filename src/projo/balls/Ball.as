package projo.balls{
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import h5swc.TextureBitmap;
	
	public class Ball extends TextureBitmap{
		
		private var path : Vector.<Point>;
		public var speed : int;
		
		public function Ball(texture:Bitmap, rect:Rectangle){
			super(texture, rect);
		}
		
		public function setTargetPositions(pt:Array):void{
			path = Vector.<Point>( pt );
			TweenLite.to( this, 0.01, { onComplete : toNextPoint } );
		}
		
		private function toNextPoint():void{
			if( !speed )speed = 1;
			if( !path.length )return;
			var nextTargetPosition : Point = path.shift();
			var dis : int = Point.distance( new Point( x, y ), nextTargetPosition );
			var duration : Number = dis / speed / 60;
			TweenLite.to( this, duration, { x : nextTargetPosition.x, y : nextTargetPosition.y, ease:Linear.easeNone, onComplete : toNextPoint } );
		}
	}
}
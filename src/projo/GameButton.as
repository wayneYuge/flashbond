package projo{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import h5swc.ModelSprite;
	import h5swc.TextureBitmap;
	
	public final class GameButton extends ModelSprite{
		
		private var normal : TextureBitmap;
		private var down : TextureBitmap;
		private var disabled : TextureBitmap;
		
		private var _enabled :Boolean;
		public function get enabled():Boolean{
			return _enabled;
		}
		public function set enabled(value:Boolean):void{
			if( _enabled == value )return;
			_enabled = value;
			if( value ){
				this.removeChildren();
				this.addChild( normal );
				this.mouseEnabled = true;
			}
			else{
				this.removeChildren();
				this.addChild( disabled );
				this.mouseEnabled = false;
			}
		}
		
		public function GameButton( texture : Bitmap, position :Vector.<Rectangle> ){
			if( texture && position && position.length ){
				normal = new TextureBitmap( texture, position[0] );
			}
			else throw new Error( "error: reference" );
			
			if( position.length > 1 )down = new TextureBitmap( texture, position[1] );
			else down = normal;
			
			if( position.length > 2 )disabled = new TextureBitmap( texture, position[2] );
			else disabled = normal;
			
			enabled = true;
			buttonMode = true;
			entity.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		private function onUp(event:MouseEvent):void{
			this.removeChildren();
			this.addChild( normal );
			
			entity.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			entity.removeEventListener( MouseEvent.MOUSE_OUT, onUp );
		}
		
		private function onDown(event:MouseEvent):void{
			this.removeChildren();
			this.addChild( down );
			
			entity.addEventListener( MouseEvent.MOUSE_UP, onUp );
			entity.addEventListener( MouseEvent.MOUSE_OUT, onUp );
		}
	}
}
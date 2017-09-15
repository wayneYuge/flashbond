package h5swc{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ModelSprite extends ModelDisplayObject{		
		
		public function ModelSprite(){
			entity = new Sprite;
		}
		
		private function get realEntity():Sprite{
			return entity as Sprite;
		}
		
		public function addChild( child : DisplayObject ):void{
			realEntity.addChild( child );
		}
		
		public function removeChildren():void{
			realEntity.removeChildren();
		}
		
		public function set mouseChildren( value : Boolean ):void{
			realEntity.mouseChildren = value;
		}
		
		public function set mouseEnabled( value : Boolean ):void{
			realEntity.mouseEnabled = value;
		}
		
		public function addChildAt( child : DisplayObject, index : int ):void{
			realEntity.addChildAt( child, index );
		}
		
		public function removeChild( child : DisplayObject ):void{
			realEntity.removeChild( child );
		}
		
		public function contains( child : DisplayObject ):Boolean{
			return realEntity.contains( child );
		}
		
		public function set buttonMode( value : Boolean ):void{
			realEntity.buttonMode = value;
		}
	}
}
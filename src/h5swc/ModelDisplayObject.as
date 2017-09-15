package h5swc{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	public class ModelDisplayObject extends EventDispatcher{
		
		private var _entity : DisplayObject;
		public function set entity(value:DisplayObject):void{
			_entity = value;
		}
		public function get entity():DisplayObject{
			return _entity;
		}
		
		private var _x : int;
		public function get x():int{
			return _x;
		}
		public function set x(value:int):void{
			_x = value;
			entity.x = value;
		}
		
		private var _y : int;
		public function get y():int{
			return _y;
		}
		public function set y(value:int):void{
			_y = value;
			entity.y = value;
		}
		
		public function ModelDisplayObject(){
		}
	}
}
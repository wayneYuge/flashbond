package h5swc{	
	import flash.display.Shape;
	
	public class ModelShape extends ModelDisplayObject{
		
		public function get realEntity():Shape{
			return entity as Shape;
		}
		
		public function ModelShape(){
			entity = new Shape;
		}
	}
}
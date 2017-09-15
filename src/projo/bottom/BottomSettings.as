package projo.bottom{
	import flash.net.SharedObject;
	
	public class BottomSettings{
		
		public static function getOriginMoney():int{
			var shareOb : SharedObject = SharedObject.getLocal( "/bond" );
			if( shareOb.data["money"] )return shareOb.data["money"];
			return 2000;
		}
		
		public static function setOriginMoney(value:int):void{
			var shareOb : SharedObject = SharedObject.getLocal( "/bond" );
			shareOb.data["money"] = value;
		}
	}
}
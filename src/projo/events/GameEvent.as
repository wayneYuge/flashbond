package projo.events{
	
	import flash.events.Event;
	
	public class GameEvent extends Event{
		
		public var info : String;
		
		public function GameEvent(type:String){
			super(type);
		}
	}
}
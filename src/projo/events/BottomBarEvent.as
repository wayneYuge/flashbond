package projo.events{
	
	public class BottomBarEvent extends GameEvent{
		
		public static const BOTTOM_CHANGE_BET : String = "bottomChangeBet";
		public static const BOTTOM_PLAY : String = "bottomPlay";
		public static const BOTTOM_EXTRA : String = "bottomExtra";
		public static const BOTTOM_EXIT : String = "bottomExit";
		public static const START_AUTO : String = "startAuto";
		public static const STOP_AUTO : String = "stopAuto";
		
		public function BottomBarEvent(type:String){
			super(type);
		}
	}
}
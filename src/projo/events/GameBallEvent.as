package projo.events{
	
	public class GameBallEvent extends GameEvent{
		
		public static const BALL_CREATE : String = "ballCreate";
		public static const USER_BALL_EMPTY : String = "userBallEmpty";
		public static const EXTRA_BALL : String = "extraBall";
		public static const EXTRA_END : String = "extraEnd";
		
		public function GameBallEvent(type:String){
			super(type);
		}
	}
}
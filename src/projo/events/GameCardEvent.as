package projo.events{
	
	public final class GameCardEvent extends GameEvent{
		
		public static const CARD_CHANGE_BET : String = "cardChangeBet";
		public static const CARD_CHANGE_NUMBER : String = "cardChangeNumber";
		public static const CARD_ENABLED_CARD : String = "cardEnabledCard";
		
		public function GameCardEvent(type:String){
			super(type);
		}
	}
}
package projo.card{
	
	internal class GameCardInfo{
		
		internal static function getCards():Vector.<GameCard>{			
			var cards : Vector.<GameCard> = new Vector.<GameCard>;
			for (var i:int = 0; i < 4; i++){
				cards[i] = new GameCard;
				cards[i].x = 25 + ( i & 1 ) * 615;
				cards[i].y = 117 + ( i >> 1 ) * 213;
			}
			return cards;
		}
	}
}
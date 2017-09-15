package projo.card{
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	internal final class CardAssetInfo{
		
		private static var iconRect : Dictionary;
		
		internal static function getCardBackgrounds():Array{
			var cardBackgrounds : Array = [];
			var cardWidth : int = 364;
			var cardHeight : int = 207;
			for( var i : int  = 0; i < 11; i++ ){
				cardBackgrounds[i] = new Rectangle( 8 + i % 3 * 381, 144 + int( i / 3 ) * 224, cardWidth, cardHeight );
			}			
			cardBackgrounds[11] = new Rectangle( 8 + 12 % 3 * 381, 144 + int( 12 / 3 ) * 224, cardWidth, cardHeight );
			var orderArray : Array = [9,6,7,11,3,5,0,4,1,2,8,10];
			var orderBGs : Array = [];
			for( i = 0; i < orderArray.length; i++ )orderBGs[i] = cardBackgrounds[ orderArray[i] ];
			return orderBGs;
		}
		
		private static function getRewardIconPositions():Dictionary{
			var iconPositios : Array = [[380,1031,350,172],[1048,1116,318,156],[760,960,334,157],[380,1202,336,156],[1095,805,294,136],[731,1116,318,157],[1025,0,300,130],[762,805,334,156],[1096,940,289,127]];
			var iconNames : Array = ["round", "tan", "guo", "tt", "fly", "bao", "ta", "gang", "shan" ];
			var iconOffset : Array = [new Point(8,30), new Point(25,41), new Point(14,41), new Point(22,42), new Point(42,55), new Point(24,42), new Point(42,55), new Point(18,37), new Point(42,55) ];
			var icons :Dictionary = new Dictionary;
			for( var i :int = 0; i < iconPositios.length; i++ ){
				var ar :Array = iconPositios[i];
				var rect :Rectangle = new Rectangle( ar[0], ar[1], ar[2], ar[3] );
				icons[iconNames[i]] = new CardRewadItem( rect, iconOffset[i] );
			}
			return icons;
		}
		
		internal static function getRewardIcon(item:String):Shape{
			if( !iconRect )iconRect = getRewardIconPositions();
			var rewardItem : CardRewadItem = iconRect[item];
			if( !rewardItem )return null;
			return rewardItem.getIcon();
		}
	}
}
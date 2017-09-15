package projo.rewards{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import h5swc.TextureBitmap;
	import h5swc.TextureMovieClip;
	
	import img.Assets;
	
	internal final class RewardItemFactory{
		
		private static const positionList:Array = [22,84,146,208,270,332,640,702,764,826,888,950];
		internal static const rewardWidth:int = 55;
		internal static const rewardHeight:int = 25;
		
		internal static function getRewardItems():Vector.<RewardItem>{
			const rewardY :int = 68;
			const texturePositionList:Array = [[0,1321],[1326,203],[307,1285],[1219,389],[1326,290],[295,1321],[1142,490],[1219,418],[1278,360],[1327,0],[1327,29],[58,1321]];
			const texturePositionListBlink:Array = [[0,1321],[1327,87],[118,1321],[1327,116],[1326,145],[177,1321],[1326,174],[236,1321],[1326,232],[307,1256],[1219,360],[1326,261]];			
			
			if( positionList.length != texturePositionList.length )throw new Error( "listNumberWrong" );
			
			var rewards :Vector.<RewardItem> = new Vector.<RewardItem>;
			for( var i : int = 0; i<positionList.length;i++ ){
				var normalBg : TextureBitmap = new TextureBitmap( Assets.assets().textureTripleSceneCropped, new Rectangle( texturePositionList[i][0], texturePositionList[i][1], rewardWidth, rewardHeight ) );
				var blinkBg : TextureBitmap = new TextureBitmap( Assets.assets().textureTripleSceneCropped, new Rectangle( texturePositionListBlink[i][0], texturePositionListBlink[i][1], rewardWidth, rewardHeight ) );
				var mc : TextureMovieClip = null;
				if( i < 2 ){
					var rectArr : Vector.<Rectangle> = ( i != 0 ?  Vector.<Rectangle>([new Rectangle(0,1350,47,12), new Rectangle(100,1350,47,12)]) : Vector.<Rectangle>([new Rectangle(100,1350,47,12),new Rectangle(47,1350,47,12)]) );
					mc =  new TextureMovieClip( Assets.assets().textureTripleSceneCropped, rectArr, 50 );
					mc.x = 5;
					mc.y = 8;
					mc.width = 47;
					mc.height = 12;
				}
				var sp : RewardItem = new RewardItem( normalBg, blinkBg, mc );
				rewards[i] = sp;
				rewards[i].x = positionList[i];
				rewards[i].y = rewardY;
			}
			return rewards;
		}
		
		internal static function getRewardPrices():Vector.<TextField>{
			var prices : Vector.<TextField> = new Vector.<TextField>;
			for( var i:int = 0; i<positionList.length;i++ ){
				var tx : TextField = new TextField();
				var tf : TextFormat = new TextFormat;
				tf.font = "Arial";
				tf.size = 16;
				tf.color = 0xFFFFFF;
				tf.bold = true;
				tf.align = "center";
				tx.defaultTextFormat = tf;				
				tx.x = positionList[i];
				tx.y = 95;
				tx.width = 55;
				prices[i] = tx;
			}
			return prices
		}
	}
}
package projo.bottom{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import img.Assets;
	
	import projo.GameButton;
	
	internal class ButtonInfo{
		
		private var position : Point;
		private var size : Point;
		private var texturepositions :Vector.<Rectangle>;
		
		public function ButtonInfo( x, y, width, height, ...rest ){
			position = new Point(x,y);
			size = new Point(width,height);
			texturepositions = new Vector.<Rectangle>;
			
			if( rest.length != 3 )throw new Error( "wrong button positions" );
			for( var i : int = 0; i < rest.length; i++ ){
				if( rest[i] is Array && rest[i].length == 2 ){
					texturepositions.push( new Rectangle( rest[i][0], rest[i][1], size.x, size.y ) );
				}
				else throw new Error( "wrong button positions" );
			}
		}
		
		internal static function getPlayerButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 820, -30, 190, 101, [607, 283], [807,173], [407, 395] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getAutoButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 663, 10, 138, 59, [1350, 173], [1005, 427], [1005, 355] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getBetDownButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 68, 10, 59, 55, [1727,399], [1727,466], [1437,313] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getBetUpButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 180, 10, 59, 55, [1648,539], [1703,191], [1727,529] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getBuyButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 820, -30, 190, 101, [7, 395], [207, 285], [207, 171] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getExitButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 663, 10, 138, 59, [1150, 382], [1295, 314], [1150, 312] );
			return createButtonByInfo( buttonInfo );
		}
		
		internal static function getStopButton():GameButton{
			var buttonInfo : ButtonInfo = new ButtonInfo( 663, 10, 138, 59, [1440, 399], [1440, 471], [1646, 329] );
			return createButtonByInfo( buttonInfo );
		}
		
		private static function createButtonByInfo(buttonInfo:ButtonInfo):GameButton{
			var gameButton : GameButton = new GameButton( Assets.assets().buttons, buttonInfo.texturepositions );
			gameButton.x = buttonInfo.position.x;
			gameButton.y = buttonInfo.position.y;
			return gameButton;
		}
	}
}
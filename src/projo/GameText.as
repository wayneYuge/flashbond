package projo{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class GameText extends TextField{
		
		private static var gridCss : TextFormat;
		public static function getGridCss():TextFormat{
			if( !gridCss )
				gridCss = createNewTextFormat( "Arial Black", 45, 0x000000 );
			return gridCss;
		}
		
		private static var betCss : TextFormat;
		public static function getBetCss():TextFormat{
			if( !betCss )
				betCss = createNewTextFormat( "Arial Black", 15, 0x000000, false );
			return betCss;
		}
		
		private static var onOffCss : TextFormat;
		public static function getOnOffCss():TextFormat{
			if( !onOffCss )
				onOffCss = createNewTextFormat( "Arial Black", 20, 0xFFFFFF );
			return onOffCss;
		}
		
		public static function getBottomBarCss():TextFormat{	
			return getOnOffCss();
		}
		
		private static var extraCss : TextFormat;
		public static function getExtraCss():TextFormat{
			if( !extraCss )
				extraCss = createNewTextFormat( "Arial Black", 30, 0xFFFFFF );
			return extraCss;
		}
		
		private static function createNewTextFormat( font:String, size:int, color:uint, alignCenter:Boolean = true ):TextFormat{
			var tf :TextFormat = new TextFormat( font, size, color );
			tf.align = alignCenter ? "center" : "left";
			return tf;
		}
		
		public static function createText( textWidth : int, css : TextFormat, x : int = 0, y : int = 0, text : String = "", needBlackSide : Boolean = false, size : int = 0 ):TextField{
			var textField : TextField = new TextField;	
			textField.x = x;
			textField.y = y;
			
			var textForamt :TextFormat = css;
			textField.defaultTextFormat = textForamt;
			textField.width = textWidth;			
			textField.mouseEnabled = false;
			if( needBlackSide ) textField.filters = [ new GlowFilter(0,1,5,5,3,1) ];
			if( size ){
				var newTF :TextFormat = textField.defaultTextFormat;
				newTF.size = size;
				textField.defaultTextFormat = newTF;
			}
			textField.text = text;
			return textField;
		}
	}
}
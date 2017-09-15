package projo.card{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import h5swc.ModelSprite;
	
	import projo.GameText;
	
	internal class GameCardGrid extends ModelSprite{
		
		internal static const GridWidth : int = 69;
		internal static const GridHeight :int = 56;
		
		private var numText : TextField;
		private var gridBg : GridBG;
		
		private var _number : int;
		internal function get number():int{
			return _number;
		}
		internal function set number(value:int):void{
			_number = value;
			numText.text = "" + value;
		}
		
		public function GameCardGrid(){
			gridBg = new GridBG
			addChild( gridBg.entity );
			
			numText = new TextField();
			numText.defaultTextFormat = GameText.getGridCss();
			numText.y = -7;
			numText.width = GridWidth;
			numText.height = GridHeight;
			addChild( numText );
			
			status = GameGridStatus.NORMAL;
		}
		
		private function drawGrid( color :uint ):void{
			gridBg.drawGrid( color );
		}
		
		private function drawCross():void{
			gridBg.drawCross();
		}
		
		private var freeFrame : int = 10;
		private var currentFree : int;
		
		private var _status : int = 1;
		internal function get status():int{
			return _status;
		}
		internal function set status(value:int):void{
			if( _status == value )return;
			_status = value;
			switch( value ){
				case GameGridStatus.CROSS:
					setNormalStatus();
					drawCross();
					break;
				case GameGridStatus.BLINK:
					blink();
					break;
				case GameGridStatus.RED:
					setNormalStatus( true );
					break;
				case GameGridStatus.NORMAL:
				default:
					setNormalStatus();
					break;
			}
		}
		
		private function setNormalStatus( isRed :Boolean = false ):void{
			drawGrid( isRed ? 0xFF0000 :0xFFFFFF );
			resetTextColor( 0x0 );
			if( entity.hasEventListener( Event.ENTER_FRAME ) )entity.removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function resetTextColor( color : uint ):void{
			var tf : TextFormat = numText.defaultTextFormat;
			if( tf.color == color )return;
			tf.color = color;
			numText.defaultTextFormat = tf;
			numText.text = numText.text;
		}
		
		private function blink():void{
			currentFree = 0;
			entity.addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(event:Event):void{
			currentFree++;
			if( currentFree % freeFrame )return;
			
			if( currentFree / freeFrame & 1 ){
				drawGrid( 0xFF0000 );
				resetTextColor( 0xFFFFFF );
			}
			else{
				drawGrid( 0xFFFF00 );
				resetTextColor( 0x000000 );
			}
			if( entity.parent )entity.parent.addChild( this.entity );		
		}
	}
}
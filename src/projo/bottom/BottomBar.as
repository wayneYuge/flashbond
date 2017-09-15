package projo.bottom{
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import h5swc.ModelSprite;
	
	import projo.GameButton;
	import projo.GameText;
	import projo.events.BottomBarEvent;
	
	[Event(name="bottomChangeBet", type="projo.events.BottomBarEvent")]
	[Event(name="bottomPlay", type="projo.events.BottomBarEvent")]
	[Event(name="bottomExtra", type="projo.events.BottomBarEvent")]
	[Event(name="bottomExit", type="projo.events.BottomBarEvent")]
	[Event(name="startAuto", type="projo.events.BottomBarEvent")]
	[Event(name="stopAuto", type="projo.events.BottomBarEvent")]
	public final class BottomBar extends ModelSprite{
		private var textBet:TextField;
		private var textWin:TextField;
		private var textCredits:TextField;
		private var betNumber:TextField;
		private var coinsNumber:TextField;
		private var winNumber:TextField;
		
		private var playButton:GameButton;
		private var leftBetButton:GameButton;
		private var rightBetButton:GameButton;
		private var autoButton:GameButton;
		private var buyExtraButton:GameButton;
		private var exitButton:GameButton;
		private var stopButton:GameButton;
		
		private var _money : int;
		public function get money():int{
			return _money;
		}
		public function set money(value:int):void{
			_money = value;
			coinsNumber.text = "" + value;
			BottomSettings.setOriginMoney( value )
		}
		
		private var _bet : int;
		public function set bet(value:int):void{
			_bet = value;
			betNumber.text = "" + value;
		}
		
		private var _win : int = 0;
		public function set win(value:int):void{
			_win = value;
			winNumber.text = "" + ( value ? value : "" );
		}
		
		public function BottomBar(){
			playButton = addButtonAt( ButtonInfo.getPlayerButton(), onPlayerButtonClick );
			autoButton = addButtonAt( ButtonInfo.getAutoButton(), onAutoButtonClick );
			leftBetButton = addButtonAt( ButtonInfo.getBetDownButton(), onBetButtonClick );
			rightBetButton = addButtonAt( ButtonInfo.getBetUpButton(), onBetButtonClick );
			buyExtraButton = addButtonAt( ButtonInfo.getBuyButton(), onBuyExtraButtonClick, false );
			exitButton = addButtonAt( ButtonInfo.getExitButton(), onExitButtonClick, false );
			stopButton = addButtonAt( ButtonInfo.getStopButton(), onStopButtonClick, false );
			
			textBet = addText( "BET", 125, -8, 60 );
			textWin = addText( "WIN", 315, -6, 80 );
			textCredits = addText( "CREDITS", 488, 10, 120 );
			betNumber = addText( "4", 125, 15, 60, 30 );
			winNumber = addText( "", 315, 18, 80, 30 );
			coinsNumber = addText( "", 488, 30, 120, 25 );
			
			y = 695;
			money = BottomSettings.getOriginMoney();
		}
		
		private function onAutoButtonClick( event:MouseEvent ):void{
			dispatchEvent( new BottomBarEvent( BottomBarEvent.START_AUTO ) );
		}
		
		private function onBetButtonClick(event:MouseEvent):void{
			if( event.target == leftBetButton.entity ){
				var ev :BottomBarEvent = new BottomBarEvent( BottomBarEvent.BOTTOM_CHANGE_BET );
				ev.info = "true";
				dispatchEvent( ev );
			}
			else if( event.target == rightBetButton.entity ){
				dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_CHANGE_BET ) );
			}
		}
		
		private function onPlayerButtonClick(event:MouseEvent):void{
			dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_PLAY ) );
		}
		
		private function addButtonAt( button : GameButton, onClickCallBack : Function = null, addToStage : Boolean = true ) : GameButton{			
			if( onClickCallBack )button.entity.addEventListener(MouseEvent.CLICK, onClickCallBack );
			if( addToStage )addChild( button.entity );
			return button;
		}
		
		private function addText( text : String, x : int, y : int, textWidth : int, size : int = 0 ):TextField{
			var tx : TextField = GameText.createText( textWidth, GameText.getBottomBarCss(), x, y, text, true, size );
			addChild( tx );
			return tx;
		}
		
		public function enablePlayButtons( enbled : Boolean ):void{
			playButton.enabled = enbled;
			leftBetButton.enabled = enbled;
			rightBetButton.enabled = enbled;
			autoButton.enabled = enbled;
		}
		
		public function showExtraAndExitButton():void{
			if( contains( playButton.entity ) )removeChild( playButton.entity );
			addChild( buyExtraButton.entity );
			
			if( contains( autoButton.entity ) )removeChild( autoButton.entity );
			addChild( exitButton.entity );
		}
		
		private function onBuyExtraButtonClick( e : MouseEvent ):void	{
			dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_EXTRA ) );
		}
		
		public function showPlayAndAutoButton():void{
			if( contains( buyExtraButton.entity ) )removeChild( buyExtraButton.entity );
			addChild( playButton.entity );
			
			if( contains( exitButton.entity ) )removeChild( exitButton.entity );
			addChild( autoButton.entity );
		}
		
		public function addMoneyAndClear():void{
			money += _win;
			win = 0;
		}
		
		private function onExitButtonClick( e : MouseEvent ):void	{
			dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_EXIT ) );
		}
		
		public function startAuto():void{
			if( autoButton && contains( autoButton.entity ) )removeChild( autoButton.entity );
			addChild( stopButton.entity );
			dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_PLAY ) );
		}
		
		private function onStopButtonClick( e : MouseEvent ):void	{
			trace( "stopAuto" );
			dispatchEvent( new BottomBarEvent( BottomBarEvent.STOP_AUTO ) );
		}
		
		public function autoGiveExtra():void{
			dispatchEvent( new BottomBarEvent( BottomBarEvent.BOTTOM_EXTRA ) );
		}
	}
}
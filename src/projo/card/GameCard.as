package projo.card{
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import h5swc.TextureBitmap;
	
	import img.Assets;
	
	import projo.GameNumbers;
	import projo.GameText;
	import h5swc.ModelSprite;
	import projo.events.GameCardEvent;
	
	[Event(name="cardChangeNumber", type="projo.events.GameCardEvent")]
	[Event(name="cardChangeBet", type="projo.events.GameCardEvent")]
	[Event(name="cardEnabledCard", type="projo.events.GameCardEvent")]
	public class GameCard extends ModelSprite{
		
		private static var cardBgsPositionArray : Array;
		
		private static var currentBg : int = 0;
		private static const betList : Array = [1,2,3,4,5,6,8,10,12,15,20]
		public static function get currentBetCount():int{
			return betList[currentBg];
		}
		
		public static var gamecards:Vector.<GameCard>;
		
		private var cardBgs : Array;
		
		private var _enabled : Boolean;
		public function get enabled():Boolean{
			return _enabled;
		}
		public function set enabled(value:Boolean):void{
			if( _enabled == value )return;
			_enabled = value;
			onOffText.text = value ? "OFF" : "ON";
			if( !value ){
				addBg( cardBgs.length - 1, true );
				addChild( onOffText );
			}
			else showCurrentBg();
		}
		
		private var numberList : Vector.<GameCardGrid>;
		
		private var betText :TextField;
		private var onOffText:TextField;
		
		private var _rewardList : Array;
		public function get rewardList():Array{
			return _rewardList.concat();
		}
;
		private var rewardLayer :Sprite;
		
		public function GameCard(){
			
			if( !cardBgsPositionArray ) cardBgsPositionArray = CardAssetInfo.getCardBackgrounds();
			cardBgs = new Array( cardBgsPositionArray.length );
			
			initNumberList();
			
			entity.addEventListener( MouseEvent.CLICK, onClick );
			entity.addEventListener( MouseEvent.RIGHT_CLICK, onClick );
			mouseChildren = false;
			
			betText = createTextAt( GameText.getBetCss(), 10, 4, 70 );
			
			onOffText = createTextAt( GameText.getOnOffCss(), 300, -3, 65 );
			onOffText.text = "OFF";
			
			rewardLayer = new Sprite;
			addChild( rewardLayer );
			
			enabled = true;
		}
		
		private function createTextAt( css : TextFormat, x, y, width ):TextField{
			var tx :TextField = new TextField;
			tx.defaultTextFormat = css;
			tx.x = x;
			tx.y = y;
			tx.width = width;
			addChild( tx );
			return tx;
		}
		
		private function initNumberList():void{
			numberList = new Vector.<GameCardGrid>;
			for( var i:int = 0; i < 15; i++ ){
				var gcg : GameCardGrid = new GameCardGrid();
				gcg.x = int( i / 3 ) * 71 + 6;
				gcg.y = 30 + i % 3 * 58;
				numberList.push(gcg);
				addChild(gcg.entity);
			}
		}
		
		public static function currentBetChange( isUp : Boolean = true ):void{
			var bgIndex : int = currentBg + ( isUp ? 1 : -1 );
			if( bgIndex > betList.length - 1 )bgIndex = 0;
			else if( bgIndex < 0 )bgIndex = betList.length - 1;	
			currentBg = bgIndex;
			
			gamecards.forEach( function(a:GameCard,b,c):void{ a.showCurrentBg() } );
		}
		
		private function showCurrentBg():void{
			if( !enabled )return;
			for( var i :int = 0; i < this.cardBgs.length; i++ ) {
				if ( cardBgs[i] && contains( cardBgs[i] ) )removeChild(cardBgs[i]);
			}
			betText.text = "BET " + GameCard.currentBetCount;
			addBg( currentBg );
		}
		
		private function addBg( index :int, onTop :Boolean = false ) :void{
			if( !cardBgs[index] )cardBgs[index] = new TextureBitmap( Assets.assets().textureTripleSceneCropped, cardBgsPositionArray[index] );
			if( onTop )	addChild( cardBgs[index] );
			else addChildAt( cardBgs[index], 0);
		}
		
		private function onClick(event:MouseEvent):void{
			if( event.localY > 29 ){
				if( event.type == MouseEvent.RIGHT_CLICK )return;
				if( !enabled )return;
				dispatchEvent( new GameCardEvent( GameCardEvent.CARD_CHANGE_NUMBER ) );
			}
			else{
				if( event.localX <= 300 ){
					if( !enabled )return;
					var ev :GameCardEvent = new GameCardEvent( GameCardEvent.CARD_CHANGE_BET );
					if( event.type == MouseEvent.RIGHT_CLICK )ev.info = "true";
					dispatchEvent( ev );
				}
				else{
					if( event.type == MouseEvent.RIGHT_CLICK )return;
					enabled = !enabled;
					dispatchEvent( new GameCardEvent( GameCardEvent.CARD_ENABLED_CARD ) );
				}
			}
		}
		
		public function getNumberIndex( number : int ):int{
			for( var i : int = 0; i < numberList.length; i++ ){
				if( numberList[i].number == number )return i;
			}
			return -1;
		}
		
		public function getNumberAt( index : int ):void{
			numberList[index].status = GameGridStatus.CROSS;
			_rewardList.push( index );
			addChild( rewardLayer );//I want rewardLayer always on top
		}
		
		public function getReward( rewardArr : Array ):void{
			for( var i : int = 0; i < rewardArr.length; i++ ){
				numberList[ rewardArr[i] ].status = GameGridStatus.RED;
			}
		}
		
		public function getLeftReward( item : String, index : int ):void{
			numberList[ index ].status = GameGridStatus.BLINK;
			var rewardIcon : Shape = CardAssetInfo.getRewardIcon( item );
			if( rewardIcon )rewardLayer.addChild( rewardIcon );
		}
		
		public function clearCardStatus( isReclear : Boolean ):void{
			for( var i : int = 0; i < numberList.length; i++ ){
				numberList[i].status = GameGridStatus.NORMAL;
			}
			if( !isReclear )_rewardList = [];
			rewardLayer.removeChildren();
		}
		
		public function crossAll():void{
			for( var i : int = 0; i < _rewardList.length; i++ ){
				numberList[_rewardList[i]].status = GameGridStatus.CROSS;
			}
		}
		
		public static function getCards():Vector.<GameCard>{
			gamecards = GameCardInfo.getCards() as Vector.<GameCard>;
			return gamecards;
		}
		
		public static function resetCardNumbers():void{
			var cardGroups :Vector.<Array> = GameNumbers.getCardGroups();
			for (var i:int = 0; i < gamecards.length; i++){
				gamecards[i].setNumbers( cardGroups[i] );
			}
		}
		
		private function setNumbers( numArr : Array ):void{
			numArr.sort(function(a,b):int{return a-b});
			for (var i : int =0; i< numberList.length; i++)numberList[i].number = numArr[i];
		}
		
		public static function get currentAllBetNumber() : int{
			var avalibleCardCount : int = 0;
			for (var i : int = 0; i < gamecards.length; i++){
				if( gamecards[i].enabled )avalibleCardCount++;
			}
			return avalibleCardCount * GameCard.currentBetCount;
		}
		
		public static function set mouseEnable( enable : Boolean ):void{
			for (var i : int = 0; i < gamecards.length; i++){
				gamecards[i].entity.mouseEnabled = enable;
			}
		}
		
		public static function findNumberInWitchCardAndAdd(num:int):void{
			for (var i : int = 0; i < gamecards.length; i++){
				if( !gamecards[i].enabled )continue;
				var numIndex : int = gamecards[i].getNumberIndex( num );
				if( numIndex >= 0 ){
					gamecards[i].getNumberAt( numIndex );
					break;
				}
			}
		}
		
		public static function showAllCross():void{
			for (var i : int = 0; i < gamecards.length; i++){
				if( !gamecards[i].enabled )return;
				gamecards[i].crossAll();
			}
		}
		
		public static function clearAllCardStatus(isReclear:Boolean):void{
			for (var i:int = 0; i<gamecards.length; i++) {
				gamecards[i].clearCardStatus( isReclear );
			}
		}
	}
}
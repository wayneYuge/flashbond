package{
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import projo.GameNumbers;
	import projo.balls.GameBalls;
	import projo.balls.LotteryBall;
	import projo.balls.LotteryStatus;
	import projo.bottom.BottomBar;
	import projo.card.GameCard;
	import projo.events.BottomBarEvent;
	import projo.events.GameBallEvent;
	import projo.events.GameCardEvent;
	import projo.events.GameEvent;
	import projo.rewards.RewardBar;
	import projo.rewards.RewardObject;
	
	[SWF(frameRate=60,width=1024,height=768)]
	public class bond extends SuperBond{
		
		private var lotteryBalls:LotteryBall;
		private var rewardBar:RewardBar;
		private var cards:Vector.<GameCard>;
		private var bottomBar :BottomBar;
		
		private var gameBalls :GameBalls;
		
		private var needClearCard:Boolean = true;
		
		private var isAuto :Boolean = false;
		
		public function bond(){	
			initialize();
		}
		
		private function initialize():void{
			lotteryBalls =  new LotteryBall;
			addChild( lotteryBalls.entity );
			
			rewardBar = new RewardBar;
			addChild( rewardBar.entity );
			
			addCards();
			addBottom();
			
//			addChild( new Stats );
		}
		
		private function clearPlayStatus( isReclear : Boolean = false ):void	{
			needClearCard = false;
			if( !gameBalls )gameBalls = getGameBalls();
			rewardBar.active = false;
			GameCard.clearAllCardStatus( isReclear );
			if( !isReclear ){
				lotteryBalls.status = LotteryStatus.ROLLER;
				gameBalls.removeAllBalls();
				bottomBar.addMoneyAndClear();
			}
		}
		
		private function onPlay(event:BottomBarEvent):void{
			if( needClearCard )clearPlayStatus();
			
			var cardGroups : Vector.<Array> = GameNumbers.getCardGroups();
			gameBalls.getBallShowOrder( cardGroups[0].concat(cardGroups[1]), cardGroups[2] );
			gameBalls.beginToMoveBalls();
			
			bottomBar.enablePlayButtons( false );	
			
			GameCard.mouseEnable = false;
			bottomBar.money -= GameCard.currentAllBetNumber;
			rewardBar.active = true;
		}
		
		private function onUserBallEmpty(event:GameBallEvent):void{
			countReward();
		}
		
		private function countReward():void{
			var winCount : int = 0;
			var hasExtra : Boolean = false;
			for (var i:int = 0; i<cards.length; i++) {
				if( !cards[i].enabled )continue;
				var rewardObj : RewardObject = rewardBar.getReward( cards[i].rewardList );
				for( var j:int = 0; j < rewardObj.rewards.length; j++ ) {
					var gotRewardItem : String = rewardObj.rewards[j];
					cards[i].getReward(rewardBar.getRewardsItemArray(gotRewardItem));
					rewardBar.showGotReward( gotRewardItem );
					winCount += GameCard.currentBetCount * rewardBar.getWinPricae(gotRewardItem);
				}
				for( var ob : String in rewardObj.leftReward ) {
					cards[i].getLeftReward(ob, rewardObj.leftReward[ob]);
					rewardBar.showGotLeftReward( ob, rewardObj.leftReward[ob] );
					hasExtra = true;
				}
			}
			bottomBar.win = winCount;
			if( hasExtra )giveExtra();
			else resetPlayStatus();
		}
		
		protected function onExtraButtonClick(event:BottomBarEvent):void{			
			clearPlayStatus( true );
			rewardBar.active = true;
			gameBalls.createExtraBall();
		}
		
		private function resetPlayStatus():void{
			bottomBar.enablePlayButtons( true );
			bottomBar.showPlayAndAutoButton();
			GameCard.mouseEnable = true;
			needClearCard = true;
			if( isAuto ){
				clearTimeout( timeoutId );
				timeoutId = setTimeout( onStartAuto, 1500 );
			}
		}
		
		private var timeoutId : int;
		
		private function giveExtra():void{
			lotteryBalls.status = LotteryStatus.EXTRA;
			if( !isAuto )bottomBar.showExtraAndExitButton();
			else {
				clearTimeout( timeoutId );
				timeoutId = setTimeout( bottomBar.autoGiveExtra, 1500 );
			}
		}
		
		private function onBallAdd(event:GameBallEvent):void{
			GameCard.findNumberInWitchCardAndAdd( int( event.info ) );
		}
		
		private function getGameBalls():GameBalls{
			var gameBalls : GameBalls = new GameBalls;
			gameBalls.addEventListener(GameBallEvent.BALL_CREATE, onBallAdd );
			gameBalls.addEventListener(GameBallEvent.USER_BALL_EMPTY, onUserBallEmpty );
			gameBalls.addEventListener(GameBallEvent.EXTRA_BALL, onExtraBall );
			gameBalls.addEventListener(GameBallEvent.EXTRA_END, onExtraEnd );
			addChild( gameBalls.entity );
			return gameBalls;
		}
		
		private function onExtraEnd(event:GameBallEvent):void	{
			resetPlayStatus();
			if( isAuto ){
				clearTimeout( timeoutId );
				timeoutId = setTimeout( onStartAuto, 1500 );
			}
		}
		
		private function onExtraBall(event:GameBallEvent):void{
			GameCard.findNumberInWitchCardAndAdd( int( event.info ) );
			GameCard.showAllCross();
			countReward();
		}		
		
		protected function onExit(event:BottomBarEvent):void{
			resetPlayStatus();
			clearPlayStatus();
		}
		
		private function addBottom():void	{
			bottomBar = new BottomBar;
			bottomBar.addEventListener(BottomBarEvent.BOTTOM_CHANGE_BET, onChangeBet);
			bottomBar.addEventListener(BottomBarEvent.BOTTOM_PLAY, onPlay );
			bottomBar.addEventListener(BottomBarEvent.BOTTOM_EXTRA, onExtraButtonClick );
			bottomBar.addEventListener(BottomBarEvent.BOTTOM_EXIT, onExit );
			bottomBar.addEventListener(BottomBarEvent.START_AUTO, onStartAuto );
			bottomBar.addEventListener(BottomBarEvent.STOP_AUTO, onStopAuto );
			addChild( bottomBar.entity );
		}
		
		protected function onStopAuto(event:BottomBarEvent):void{
			isAuto = false;
		}
		
		protected function onStartAuto(event:BottomBarEvent = null):void{
			trace( "startAuto" );
			isAuto = true;
			clearTimeout( timeoutId );
			bottomBar.startAuto();
		}
		
		private function addCards():void{
			cards = GameCard.getCards();
			GameCard.resetCardNumbers();
			for (var i:int = 0; i < cards.length; i++){
				addChild( cards[i].entity );
				cards[i].addEventListener(GameCardEvent.CARD_CHANGE_NUMBER, onChangeNumber );
				cards[i].addEventListener(GameCardEvent.CARD_CHANGE_BET, onChangeBet );
				cards[i].addEventListener(GameCardEvent.CARD_ENABLED_CARD, onEnabledCard );
			}
		}
		
		private function onChangeNumber(event:Event):void{
			if( needClearCard )clearPlayStatus();
			GameCard.resetCardNumbers();
			if( isAuto )stopAutoDirectly();
		}
		
		private function onChangeBet(event:GameEvent):void{
			if( needClearCard )clearPlayStatus();
			GameCard.currentBetChange( !event.info );
			rewardBar.changePrices( GameCard.currentBetCount );
			bottomBar.bet = GameCard.currentAllBetNumber;
			if( isAuto )stopAutoDirectly();
		}
		
		private function onEnabledCard(event:Event):void{
			if( needClearCard )clearPlayStatus();
			bottomBar.bet = GameCard.currentAllBetNumber;
			if( isAuto )stopAutoDirectly();
		}
		
		private function stopAutoDirectly():void{
			isAuto = false;
			clearTimeout( timeoutId );
		}
	}
}
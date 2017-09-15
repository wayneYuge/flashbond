package projo.balls{

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import h5swc.ModelSprite;
	
	import img.Assets;
	
	import projo.events.GameBallEvent;
	
	[Event(name="ballCreate", type="projo.events.GameBallEvent")]
	[Event(name="userBallEmpty", type="projo.events.GameBallEvent")]
	[Event(name="extraBall", type="projo.events.GameBallEvent")]
	[Event(name="extraEnd", type="projo.events.GameBallEvent")]
	public class GameBalls extends ModelSprite{
		
		private var ballAssetsPositions:Array;
		private var ballAssetIndex:Array;
		private static const ballSize :Point = new Point( 45, 45 );
		private static const startPosition :Point = new Point( 490, 450 );
		private static const extraPosition :Point = new Point( 490, 220 );
		
		private var playerGotBaslls :Array;
		private var extraBalls : Array;
		
		private var texture : Bitmap;
		
		private var getBallInterval:int;
		private var currentGetBallInterval:int;
		private var movingBalls:Vector.<Ball>;
		private var ballLastPositions:Vector.<Array>;
		private var extraBallLastPositions:Vector.<Array>;
		
		private var movingBallLayer :Sprite;
		
		public function GameBalls(){
			texture = Assets.assets().balls;
			ballAssetsPositions = BallAssetInfo.getBallPositions();
			ballAssetIndex = BallAssetInfo.getBallOrders();
			ballLastPositions = BallAssetInfo.setBallsLastPositions();
			extraBallLastPositions = BallAssetInfo.setExtraBallsLastPositions();
			
			movingBallLayer = new Sprite;
			addChild( movingBallLayer );
		}

		public function getBallShowOrder( playerGotBaslls : Array, extraBalls : Array ):void{
			this.playerGotBaslls = playerGotBaslls;
			this.extraBalls = extraBalls;
		}

		public function beginToMoveBalls():void{
			if( !playerGotBaslls || !extraBalls )throw new Error( "empty ball orders" );
			
			getBallInterval = 3;
			currentGetBallInterval = 0;
			entity.addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(event:Event):void{
			if( checkNeedCreat() )movingBalls.push( createNewPlayerBall() );
		}
		
		private function checkNeedCreat():Boolean{
			if( !currentGetBallInterval ){
				currentGetBallInterval = getBallInterval;
				return true;
			}
			if( playerGotBaslls.length )currentGetBallInterval--;
			else{
				entity.removeEventListener( Event.ENTER_FRAME, onFrame );
				var ev : GameBallEvent = new GameBallEvent( GameBallEvent.USER_BALL_EMPTY );
				dispatchEvent( ev );
			}
			return false;
		}
		
		private function createNewPlayerBall():Ball{
			var ballIndex : int = playerGotBaslls.shift()
			var ball :Ball = createBall( ballIndex, startPosition );
			
			var pt : Array = ballLastPositions[ playerGotBaslls.length ];
			ball.setTargetPositions( pt );
			var ev : GameBallEvent = new GameBallEvent( GameBallEvent.BALL_CREATE );
			ev.info = "" + ballIndex;
			dispatchEvent( ev );
			return ball;
		}
		
		private function createBall( ballIndex : int, position : Point ):Ball{
			var rect : Rectangle = new Rectangle( ballAssetsPositions[ballAssetIndex[ballIndex]][0], ballAssetsPositions[ballAssetIndex[ballIndex]][1],	ballSize.x, ballSize.y );
			var ball : Ball = new Ball( texture, rect );
			ball.x = position.x;
			ball.y = position.y;
			ball.speed = 8;
			movingBallLayer.addChild( ball );
			return ball;
		}
		
		public function createExtraBall():Ball{
			var ballIndex : int = extraBalls.shift();
			var ball :Ball = createBall( ballIndex, extraPosition );
			
			var pt : Array = extraBallLastPositions[ extraBalls.length ];
			ball.setTargetPositions( pt );
			var ev : GameBallEvent = new GameBallEvent( GameBallEvent.EXTRA_BALL );
			ev.info = "" + ballIndex;
			dispatchEvent( ev );
			if( extraBalls.length <= 5 ){
				var endEv : GameBallEvent = new GameBallEvent( GameBallEvent.EXTRA_END );
				dispatchEvent( endEv );
			}
			return ball;
		}
		
		public function removeAllBalls():void{
			movingBallLayer.removeChildren();
			movingBalls = new Vector.<Ball>;
		}
	}
}
package projo.balls{
	import flash.geom.Rectangle;
	
	import h5swc.TextureMovieClip;
	
	import img.Assets;
	
	import h5swc.ModelSprite;
	
	public class LotteryBall extends ModelSprite{	
		
		private var roller : TextureMovieClip;
		private var extraBalls : GameExtra;
		
		private var _status : int = 1;
		public function get status():int{
			return _status;
		}
		public function set status(value:int):void{
			if( _status == value)return;
			_status = value;
			switch( value ){
				case LotteryStatus.ROLLER:
					removeChildren();
					addChild( roller.entity );
				default:
					break;
				case LotteryStatus.EXTRA:
					removeChildren();
					if( !extraBalls )extraBalls = new GameExtra;
					addChild( extraBalls.entity );
					break;
			}
		}
		
		public function LotteryBall(){
			
			addRoller();
			
			x = 417;
			y = 260;
			
			status = LotteryStatus.ROLLER;
		}
		
		private function addRoller():void	{
			var pointVector :Vector.<Rectangle> = new Vector.<Rectangle>;
			for( var i : int = 0; i<27; i++ ){
				pointVector.push( new Rectangle( Math.floor(i/5)*190,Math.floor(i%5)*190, 190, 190 ) );
			}
			
			roller = new TextureMovieClip( Assets.assets().textureBomboRing, pointVector, 2 );
			roller.width = 190;
			roller.height = 190;			
			roller.play();
		}
	}
}
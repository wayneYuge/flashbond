package projo.rewards{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import h5swc.ModelSprite;
	
	public class RewardBar extends ModelSprite{
		
		private static const priceList : Array = [1500,600,300,200,100,100,40,40,10,8,3,3];
		
		private var rewards : Vector.<RewardItem>;
		private var prices : Vector.<TextField>;
		private var rewardsType : Dictionary;
		private var rewardsItemIndex : Dictionary;
		
		private var rewardConlict : RewardConflict;
		
		private var _active:Boolean;
		public function get active():Boolean{
			return _active;
		}
		public function set active(value:Boolean):void{
			if( _active == value )return;
			_active = value;
			if( value )	{
				rewards.forEach( function( a:RewardItem,b,c ):void{ a.active = true; } );
				entity.addEventListener( Event.ENTER_FRAME, onFrame );
			}
			else{
				rewards.forEach( function( a:RewardItem,b,c ):void{ a.active = false; } );
				prices.forEach( function( a:TextField,b,c ):void{
					var tf :TextFormat = a.defaultTextFormat;
					if( tf.color == 0xFFFFFF )return;
					tf.color = 0xFFFFFF;
					a.defaultTextFormat = tf;
					a.text = a.text;
				} );
				entity.removeEventListener( Event.ENTER_FRAME, onFrame );	
			}
		}
		
		public function RewardBar(){
			rewards = RewardItemFactory.getRewardItems();
			prices = RewardItemFactory.getRewardPrices();
			for( var i :int = 0; i < rewards.length; i++ ){
				addChild( rewards[i].entity );
				addChild( prices[i] );
			}
			rewardsType = new RewardTypes;
			rewardsItemIndex = new RewardItemIndex;
			rewardConlict = new RewardConflict( rewardsType );
			
			mouseChildren = false;
			mouseEnabled = false;
			
			changePrices( 1 );
		}
		
		public function changePrices( betCount : int ):void{
			for( var i :int = 0; i < prices.length; i++ ){
				var text :String = "" + priceList[i] * betCount;
				prices[i].text = text;
			}
		}
		
		public function getReward( numberList : Array ):RewardObject{
			var rewardObj : RewardObject = new RewardObject;
			rewardObj.checkReward( rewardsType, numberList );
			rewardObj.checkConflict( rewardConlict );
			return rewardObj;
		}
		
		public function showGotReward( gotRewardItem:String ):void{
			var itemIndex :int = rewardsItemIndex[gotRewardItem];
			var tf : TextFormat = prices[itemIndex].defaultTextFormat;
			tf.color = 0xFF0000;
			prices[itemIndex].defaultTextFormat = tf;
			prices[itemIndex].text = prices[itemIndex].text;
			rewards[itemIndex].status = "blink";
		}
		
		public function getRewardsItemArray(gotRewardItem:String):Array{
			return rewardsType[gotRewardItem];
		}
		
		public function showGotLeftReward( ob : String, number : int ):void{
			rewards[rewardsItemIndex[ob]].addBlickAt( number );
		}
		
		private function onFrame(event:Event):void{
			rewards.forEach( function(a:RewardItem,b,c):void{ a.onFrame(null) } );
		}
		
		public function getWinPricae(gotRewardItem:String):int{
			var itemIndex :int = rewardsItemIndex[gotRewardItem];
			return priceList[itemIndex];
		}
	}
}
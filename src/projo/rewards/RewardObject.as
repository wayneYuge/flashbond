package projo.rewards{
	import flash.utils.Dictionary;
	
	import projo.ArrayCheck;
	
	public class RewardObject{
		
		public var rewards : Array;
		public var leftReward : Object;
		
		public function RewardObject(){
			rewards = [];
			leftReward = {};
		}
		
		internal function checkReward( rewardsType : Dictionary, numberList : Array ):void{
			for ( var ob : Object in rewardsType ){
				var result : Array = ArrayCheck.checkArrContain( rewardsType[ob], numberList );
				if( result == null )continue;
				else if( result.length == 0 )rewards.push( ob );
				else leftReward[ob] = result[0];
			}
		}
		
		internal function checkConflict( rewardConlict  :Dictionary ):void{
//			trace( "rewards:" + rewards );
			conflictRewards( rewardConlict );
//			trace( "leftRewards:" );
//			for( var ob :Object in leftReward )trace( "  " + ob );
			conflictLeftRewards( rewardConlict );
		}
		
		private function conflictLeftRewards(rewardConlict:Dictionary):void{
			for( var ob : String in leftReward ){
				var arr : Array = rewardConlict[ob];
				for( var j : int = 0; j < arr.length; j++ ){
					var item : Object = leftReward[arr[j]];
					if( item != null && item == leftReward[ob] ){
//						trace( "get rid of:" + arr[j] );
						leftReward[arr[j]] = null;
						delete leftReward[arr[j]];
						conflictLeftRewards( rewardConlict );
					}
				}
			}
		}
		
		private function conflictRewards(rewardConlict:Dictionary):void{			
			for( var i : int = 0; i < rewards.length; i++ ){
				var item :String = rewards[i];
				var arr : Array = rewardConlict[item];
				for( var j : int = 0; j < arr.length; j++ ){
					var index : int = rewards.indexOf( arr[j] );
					if( index >= 0 ){
//						trace( "get rid of:" + arr[j] );
						rewards.splice( index, 1 );
						conflictRewards( rewardConlict );
					}
				}
			}
		}
	}
}
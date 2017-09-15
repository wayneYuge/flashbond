package projo.rewards{
	import flash.utils.Dictionary;
	
	import projo.ArrayCheck;
	
	public dynamic class RewardConflict extends Dictionary{
		
		public function RewardConflict( rewardType : Dictionary ){
			for( var name1 : Object in rewardType ){
				this[name1] = [];
				for( var name2 : Object in rewardType ){
					if( name1 == name2 )continue;
					else{
						var result : Array = ArrayCheck.checkArrContain( rewardType[name2], rewardType[name1] );
						if( result && result.length == 0 ){
							this[name1].push(name2);
						}
					}
				}
			}
		}
	}
}
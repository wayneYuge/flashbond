package projo.rewards{
	
	import flash.utils.Dictionary;
	
	internal final dynamic class RewardTypes extends Dictionary{
		
		public function RewardTypes(){
			super(false);
			
			this["bingo"] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14];
			this["round"] = [0,1,2,3,5,6,8,9,11,12,13,14];
			this["tan"] = [0,1,2,4,6,7,8,10,12,13,14];
			this["guo"] = [0,3,4,5,6,8,9,10,11,12];
			this["tt"] = [0,3,4,5,6,9,10,11,12];
			this["tl1"] = [0,1,3,4,6,7,9,10,12,13];
			this["tl2"] = [1,2,4,5,7,8,10,11,13,14];
			this["tl3"] = [0,2,3,5,6,8,9,11,12,14];
			this["fly"] = [0,2,4,6,8,10,12,14];
			this["bao"] = [0,1,4,7,8,10,12,13];
			this["ta"] = [2,4,5,6,8,10,11,14];
			this["gang"] = [0,1,2,12,13,14];
			this["shan"] = [2,4,6,10,14];
			this["ol1"] = [0,3,6,9,12];
			this["ol2"] = [1,4,7,10,13];
			this["ol3"] = [2,5,8,11,14];
		}
	}
}
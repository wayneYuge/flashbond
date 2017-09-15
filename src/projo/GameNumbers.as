package projo{
	
	public class GameNumbers{
		
		public function GameNumbers(){
		}
		
		public static function getCardGroups():Vector.<Array>{
			var nums : Array = [];
			var groups : Vector.<Array> = Vector.<Array>([[],[],[],[]]);
			for( var i : int = 0; i < 60; i++ )nums[i] = i + 1;
			var groupIndex : int = 0;
			while ( nums.length ){
				groups[groupIndex].push( nums.splice( Math.floor( Math.random() * nums.length ), 1 )[0] );
				if( groups[groupIndex].length == 15 )groupIndex++;
			}
			return groups;
		}
	}
}
package projo{
	
	public class ArrayCheck{
		
		public static function checkArrContain( arr1, arr2 ):Array{
			var unContainNumber : Array = [];
			for( var i:int = 0; i < arr1.length; i++ ){
				if( arr2.indexOf(arr1[i])<0 ){
					unContainNumber.push(arr1[i]);
					if( unContainNumber.length >= 2 )return null;
				}
			}
			return unContainNumber;
		}
	}
}
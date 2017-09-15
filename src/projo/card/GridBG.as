package projo.card{
	import h5swc.ModelShape;
	
	internal class GridBG extends ModelShape{
		
		public function GridBG(){
		}
		
		internal function drawGrid( color :uint ):void{
			realEntity.graphics.clear();
			realEntity.graphics.beginFill( color );
			realEntity.graphics.drawRect( 0, 0, GameCardGrid.GridWidth, GameCardGrid.GridHeight );
			realEntity.graphics.endFill();
		}
		
		internal function drawCross():void{
			realEntity.graphics.beginFill( 0xFF0000 );
			realEntity.graphics.moveTo( 11, 14 );
			realEntity.graphics.lineTo( 16,  8 );
			realEntity.graphics.lineTo( 34, 23 );
			realEntity.graphics.lineTo( 51,  8 );
			realEntity.graphics.lineTo( 57, 14 );
			realEntity.graphics.lineTo( 40, 28 );
			realEntity.graphics.lineTo( 57, 42 );
			realEntity.graphics.lineTo( 51, 49 );
			realEntity.graphics.lineTo( 34, 34 );
			realEntity.graphics.lineTo( 16, 50 );
			realEntity.graphics.lineTo( 11, 44 );
			realEntity.graphics.lineTo( 28, 28 );
			realEntity.graphics.lineTo( 11, 14 );
			realEntity.graphics.endFill();
		}
	}
}
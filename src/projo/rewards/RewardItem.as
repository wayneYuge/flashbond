package projo.rewards{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import h5swc.ModelSprite;
	import h5swc.TextureBitmap;
	import h5swc.TextureMovieClip;
	
	internal class RewardItem extends ModelSprite{
		
		private var normalBg:TextureBitmap;
		private var blinkBg:TextureBitmap;
		private var mc:TextureMovieClip;
		
		private var _status : String;
		internal function get status():String{
			return _status;
		}
		internal function set status(value:String):void{
			if( value == "blink" ){
				_status = "blink";
				if( contains( normalBg ) )removeChild( normalBg );
				addChildAt( blinkBg, 0 );
			}
			else{
				_status = "normal";
				if( blinkBg && this.contains( blinkBg ) )removeChild( blinkBg );
				addChildAt( normalBg, 0 );
			}
		}
		
		private var _active : Boolean;
		internal function get active():Boolean{
			return _active;
		}
		internal function set active(value:Boolean):void{
			if( _active == value )return;
			_active = value;
			if( value ){
				intervalIndex = 0;
				blinkList = [];
				if( !blinkLayer )blinkLayer = new Sprite;
				addChild( blinkLayer );
			}
			else{							
				if( blinkLayer && contains( blinkLayer ) ){
					blinkLayer.graphics.clear();
					removeChild( blinkLayer );
				}
				status = "normal"
			}
		}	
		
		private var blinkLayer : Sprite;
		
		public function RewardItem( bit1 : TextureBitmap, bit2 : TextureBitmap, mc : TextureMovieClip = null ){
			this.normalBg = bit1;
			this.blinkBg = bit2;
			this.addChild( this.normalBg );
			if( mc ){
				this.mc = mc;
				mc.play();
				addChild( mc.entity );
			}			
		}
		
		internal function addBlickAt( index : int ):void{
			if( blinkList.indexOf( index ) >= 0 )return;
			blinkList.push( index );
		}
		
		private var intervalIndex : int = 0;
		private static const freeFrames : int = 30;
		private var blinkList : Array;
		
		internal function onFrame(event:Event):void{
			intervalIndex++;
			if( intervalIndex % freeFrames )return;
			if( intervalIndex / freeFrames & 1 )blinkLayer.graphics.clear();
			else{
				var rewardWidth : Number = ( RewardItemFactory.rewardWidth - 2 ) / 5;
				var rewardHeight : Number = ( RewardItemFactory.rewardHeight - 2 ) / 3;
				blinkLayer.graphics.beginFill( 0xFFFF00 );
				for( var i :int = 0; i < blinkList.length; i++ )blinkLayer.graphics.drawRect( int( blinkList[i] / 3 ) * rewardWidth + 1, blinkList[i] % 3 * rewardHeight + 1, rewardWidth - 0.5,rewardHeight - 0.5 );
				blinkLayer.graphics.endFill();
			}
		}	
	}
}
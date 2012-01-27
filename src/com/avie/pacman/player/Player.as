package com.avie.pacman.player
{
	import com.avie.pacman.data.GameVO;
	
	import flash.display.Sprite;
	
	public class Player extends Sprite
	{
		public static const MOVE_UP:int = 0;
		public static const MOVE_DOWN:int = 1;
		public static const MOVE_LEFT:int = 2;
		public static const MOVE_RIGHT:int = 3;
		public static const MOVE_STOP:int = 4;
		
		public var direction:int = MOVE_STOP;
		public var nextRow:int;
		public var nextCol:int;
		public var nextX:int;
		public var nextY:int;
		public var dirX:int;
		public var dirY:int;
		public var currRow:int;
		public var currCol:int;
		public var step:int = 3;
		
		public var ghost:Boolean = false;
		private var ticks:int = 0;
		
		protected var player:Sprite;
		protected var playerType:String;
		
		protected var _data:GameVO;
		
		public function Player(tileX:int,tileY:int,data:GameVO)
		{
			super();
		}
		public function turnToNormal():void
		{
			
		}
		public function turnToHunter():void
		{
			
		}
		public function update():void
		{
			if(ghost){
				
				player.visible = false;
				if(ticks>200){
					ghost=false;
					player.visible = true;
					ticks = 0;
					return;
				}
				ticks++;
			}
			nextX = this.x + dirX * step;
			nextY = this.y + dirY * step;
			this.x = nextX;
			this.y = nextY;
		}
	}
}
package com.avie.pacman.player
{
	import com.avie.pacman.data.GameVO;
	
	public class Actor extends Player
	{
		[Embed(source="assets/library.swf", symbol="ActorNormal")]
		private var ActorNormal:Class;
		[Embed(source="assets/library.swf", symbol="ActorHunter")]
		private var ActorHunter:Class;
		
		
		public function Actor(tileX:int, tileY:int, data:GameVO)
		{
			super(tileX, tileY, data);
			currRow = tileY;
			currCol = tileX;
			init();
		}
		private function init():void
		{
			player = new ActorNormal();
			addChild(player);
		}
		override public function turnToNormal():void
		{
			removeChild(player);
			player = new ActorNormal();
			addChild(player);
		}
		override public function turnToHunter():void
		{
			removeChild(player);
			player = new ActorHunter();
			addChild(player);
		}
	}
}
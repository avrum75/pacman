package com.avie.pacman.player
{
	import com.avie.pacman.data.GameVO;
	
	public class Enemy extends Player
	{
		[Embed(source="assets/library.swf", symbol="EnemyNormal")]
		private var EnemyNormal:Class;
		[Embed(source="assets/library.swf", symbol="EnemyHunter")]
		private var EnemyHunter:Class;
		
		public function Enemy(tileX:int, tileY:int, data:GameVO)
		{
			super(tileX, tileY, data);
			init();
		}
		private function init():void
		{
			player = new EnemyHunter();
			addChild(player);
		}
		override public function turnToNormal():void
		{
			removeChild(player);
			player = new EnemyNormal();
			addChild(player);
		}
		override public function turnToHunter():void
		{
			removeChild(player);
			player = new EnemyHunter();
			addChild(player);
		}
	}
}
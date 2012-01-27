package com.avie.pacman.statem
{
	import com.avie.pacman.player.Enemy;
	import com.avie.pacman.view.Board;

	public class NormalState implements IState
	{
		private var _controler:Board;
		public function NormalState(c:Board)
		{
			_controler = c;
		}
		
		public function enter():void
		{
			_controler.actor.turnToNormal();
			for(var i in _controler.enemys){
				(_controler.enemys[i] as Enemy).turnToHunter();
			}
		}
		
		public function update(ticks:int):void
		{
		}
		
		public function exit():void
		{
		}
	}
}
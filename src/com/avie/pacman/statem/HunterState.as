package com.avie.pacman.statem
{
	import com.avie.pacman.player.Enemy;
	import com.avie.pacman.view.Board;

	public class HunterState implements IState
	{
		private var _controler:Board;
		public function HunterState(c:Board)
		{
			_controler = c;
		}
		
		public function enter():void
		{
			trace("Hunter Enter State")
			_controler.actor.turnToHunter();
			for(var i in _controler.enemys){
				(_controler.enemys[i] as Enemy).turnToNormal();
			}
		}
		
		public function update(ticks:int):void
		{
			trace("update " + ticks)
			if(ticks > 400){
				_controler.machine.setState(Board.SYS_STATE_NORMAL);
			}
			
		}
		
		public function exit():void
		{
		}
	}
}
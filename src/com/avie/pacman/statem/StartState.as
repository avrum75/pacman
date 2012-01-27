package com.avie.pacman.statem
{
	import com.avie.pacman.view.Board;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class StartState implements IState
	{
		private var _controler:Board;
		public function StartState(c:Board)
		{
			_controler = c;
		}
		
		public function enter():void
		{
			_controler.stage.addEventListener(KeyboardEvent.KEY_DOWN,_controler.keyDownHandler);
			_controler.stage.addEventListener(KeyboardEvent.KEY_UP, _controler.keyUpHandler);
			_controler.addEventListener(Event.ENTER_FRAME, _controler.update,false,0,true);
			
			_controler.machine.setState(Board.SYS_STATE_NORMAL);
		}
		
		public function update(ticks:int):void
		{
		}
		
		public function exit():void
		{
		}
	}
}
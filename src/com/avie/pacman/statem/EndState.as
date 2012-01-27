package com.avie.pacman.statem
{
	import com.avie.pacman.view.Board;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class EndState implements IState
	{
		private var _controler:Board;
		public function EndState(c:Board)
		{
			_controler = c;
		}
		
		public function enter():void
		{
			trace("Machine Enter END")
			_controler.stage.removeEventListener(KeyboardEvent.KEY_DOWN,_controler.keyDownHandler);
			_controler.stage.removeEventListener(KeyboardEvent.KEY_UP, _controler.keyUpHandler);
			_controler.removeEventListener(Event.ENTER_FRAME, _controler.update);
			
			_controler.gameEnd();
		}
		
		public function update(ticks:int):void
		{
		}
		
		public function exit():void
		{
		}
	}
}
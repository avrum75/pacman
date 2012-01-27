package com.avie.pacman.statem
{
	public class StateMachine
	{
		public var current:String;
		public var previous:String;
		
		private var states:Object;
		
		public var tick:int = 0;
		
		public function StateMachine()
		{
			states = new Object();
		}
		public function setState(name:String):void
		{
			if(current == null){
				current = name;
				states[current].state.enter();
				return;
			}
			if(current == name){
				trace('StateMachine : object already in ' + name + ' state. ');
				return;
			}
			trace("set state : from : " + states[current].from);
			if(states[current].from.indexOf(name) != -1){
				states[current].state.exit();
				previous = current;
				current = name;
			}else{
				trace("StateMachine : " + name + " cannot be used while in > " + current + " state.");
				return;
			}
			
			states[current].state.enter();
			tick = 0;
		}
		public function getState():String
		{
			return current;
		}
		public function addState(name:String, stateObj:IState, fromStates:Array):void
		{
			states[name] = {state:stateObj, from:fromStates.toString()};
		}
		public function update():void
		{
			states[current].state.update(tick++);
		}
	}
}
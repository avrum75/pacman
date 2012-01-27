package com.avie.pacman.statem
{
	public interface IState
	{
		function enter():void;
		function update(ticks:int):void;
		function exit():void;
	}
}
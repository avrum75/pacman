package com.avie.pacman.data
{
	public class GameVO
	{
		public var map = [
			[3 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 3],
			[2 , 0 , 0 , 0 , 0 , 2 , 0 , 0 , 0 , 0 , 2],
			[2 , 2 , 2 , 2 , 0 , 2 , 0 , 2 , 2 , 2 , 2],
			[0 , 0 , 2 , 0 , 0 , 2 , 0 , 0 , 2 , 0 , 0],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 0 , 0 , 0 , 0 , 2 , 0 , 0 , 0 , 0 , 2],
			[2 , 2 , 2 , 2 , 0 , 2 , 0 , 2 , 2 , 2 , 2],
			[0 , 0 , 0 , 2 , 0 , 2 , 0 , 2 , 0 , 0 , 0],
			[3 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 2 , 3]
		];
		public var life:int		= 3;
		public var monster:int	= 3;
		public var tileWidth:int	= 60;
		public var tileHeight:int	= 60;
		public var rows:int = 8;
		public var cols:int = 10;
	}
}
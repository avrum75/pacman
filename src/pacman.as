package
{
	import com.avie.pacman.data.GameVO;
	import com.avie.pacman.view.Board;
	import com.avie.pacman.view.Score;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="692", height="663", frameRate="60")]
	public class pacman extends Sprite
	{
		[Embed(source="assets/library.swf", symbol="GameBG")]
		private var GameBG:Class;
		
		private var _gameBG:*;
		
		public var data:GameVO = new GameVO();
		public var board:Board;
		public var score:Score;
		
		public function pacman()
		{
			trace("Welcome to PacMan Game !! Human's");
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event=null):void
		{
			// add board background graphic
			_gameBG = new GameBG();
			addChild(_gameBG);
			
			// add score
			score = new Score();
			addChild(score);
			score.x = 16;
			score.y = 558;
			
			//add board class
			board = new Board(data,score);
			addChild(board);
			board.init();
			board.gameStart();
			board.x = 16;
			board.y = 18;			
		}
		
	}
}
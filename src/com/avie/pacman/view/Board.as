package com.avie.pacman.view
{
	import com.avie.pacman.data.GameVO;
	import com.avie.pacman.player.Actor;
	import com.avie.pacman.player.Enemy;
	import com.avie.pacman.player.Player;
	import com.avie.pacman.statem.EndState;
	import com.avie.pacman.statem.HunterState;
	import com.avie.pacman.statem.NormalState;
	import com.avie.pacman.statem.StartState;
	import com.avie.pacman.statem.StateMachine;
	
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Board extends Sprite
	{
		[Embed(source="assets/library.swf", symbol="Pill2")]
		private var Pill2:Class;
		[Embed(source="assets/library.swf", symbol="Pill3")]
		private var Pill3:Class;
		
		public static const SYS_STATE_SPLASH:String = "splash";
		public static const SYS_STATE_START:String = "playGame";
		public static const SYS_STATE_END:String = "endGame";
		public static const SYS_STATE_NORMAL:String = "normal";
		public static const SYS_STATE_HUNTER:String = "hunter";
		
		public var machine:StateMachine;
		
		private var _data:GameVO;
		private var _actor:Actor;
		private var _enemys:Array = [];
		private var _score:Score;
		
		private var _keysPressed:Array = [];
		
		public function Board(data:GameVO,score:Score)
		{
			super();
			_data = data;
			_score = score;
			
			// set states
			machine = new StateMachine();
			machine.addState(SYS_STATE_START, new StartState(this), [SYS_STATE_END, SYS_STATE_NORMAL]);
			machine.addState(SYS_STATE_END, new EndState(this), [SYS_STATE_NORMAL, SYS_STATE_HUNTER]);
			machine.addState(SYS_STATE_NORMAL, new NormalState(this), [SYS_STATE_START, SYS_STATE_HUNTER,SYS_STATE_END]);
			machine.addState(SYS_STATE_HUNTER, new HunterState(this), [SYS_STATE_NORMAL]);
			
		}
		public function init():void
		{
			trace("Board.init()");
			for(var row in _data.map){
				for(var col in _data.map[row]){
					var tile:Sprite = new Sprite();
					tile.graphics.lineStyle(1,0x0,0);
					tile.graphics.beginFill(0x0,0);
					tile.graphics.drawRect(0,0,_data.tileWidth,_data.tileHeight);
					tile.x = col*60;
					tile.y = row*60;
					addChild(tile);
					switch(_data.map[row][col]){
						case 2:
							var p2:* = new Pill2();
							addChild(p2);
							p2.name = "p2_"+row+"_"+col;
							p2.x = tile.x + _data.tileWidth/2;
							p2.y = tile.y + _data.tileHeight/2;
							break;
						case 3:
							var p3:* = new Pill3();
							addChild(p3);
							p3.name = "p3_"+row+"_"+col;
							p3.x = tile.x + _data.tileWidth/2;
							p3.y = tile.y + _data.tileHeight/2;
							break;
						default:
							break;
					}
				}
			}

			_actor = new Actor(5,7,_data);
			addChild(_actor);
			_actor.x = 5 * _data.tileWidth + _data.tileWidth/2;
			_actor.y = 7 * _data.tileHeight + _data.tileHeight/2;
			
			for(var xx:int = 0; xx<3; xx++){
				var enemy:Enemy = new Enemy(int(4+xx),0,_data);
				_enemys.push(enemy);
				addChild(enemy);
				enemy.x = int(4+xx) * _data.tileWidth + _data.tileWidth/2;
				enemy.y = _data.tileHeight/2
			}
			Enemy(_enemys[0]).direction = Player.MOVE_LEFT;
			Enemy(_enemys[1]).direction = Player.MOVE_DOWN;
			Enemy(_enemys[2]).direction = Player.MOVE_RIGHT;
			
		}
		public function gameStart():void
		{
			trace("Board.gameStart()");
			machine.setState(SYS_STATE_START);
		}
		public function gameLifeDownReset():void
		{
			_actor.currRow = 7;
			_actor.currCol = 5;
			_actor.x = 5 * _data.tileWidth + _data.tileWidth/2;
			_actor.y = 7 * _data.tileHeight + _data.tileHeight/2;
			_actor.direction = Player.MOVE_STOP;
				
			for(var i:int = 0; i<_enemys.length; i++){
				
				_enemys[i].currRow = 0;
				_enemys[i].currCol = 4+i;
				_enemys[i].x = int(4+i) * _data.tileWidth + _data.tileWidth/2;
				_enemys[i].y = _data.tileHeight/2
			}
			Enemy(_enemys[0]).direction = Player.MOVE_LEFT;
			Enemy(_enemys[1]).direction = Player.MOVE_DOWN;
			Enemy(_enemys[2]).direction = Player.MOVE_RIGHT;
		}
		public function gameEnd():void
		{
			machine.setState(SYS_STATE_END);
			removeChild(_actor);
			for(var i in _enemys){
				removeChild(_enemys[i]);
			}
			for(var i in this.numChildren){
				if(this.getChildAt(i).name.indexOf("p") != -1)
					removeChildAt(i);
			}
		}
		public function update(e:Event=null):void
		{
			checkKeyInput();
			checkEnemyMove();
			machine.update();
		}
		/**
		 * 
		 * movment
		 * 
		 * */
		private function checkNextTile(dir:int,obj:Player):Boolean
		{
			
			var row:int = obj.currRow;
			var col:int = obj.currCol;
			switch(dir) {
				case Player.MOVE_UP:
					row--;
					if(row < 0)
						return false;
					break;
				case Player.MOVE_DOWN:
					row++;
					if(row > _data.rows)
						return false;
					break;
				case Player.MOVE_RIGHT:
					col++;
					if(col > _data.cols)
						return false;
					break;
				case Player.MOVE_LEFT:
					col--;
					if(col < 0)
						return false;
					break;
			}
			//trace("checkNextTile() row : " + obj.currRow + " >> " + row + " /col/ " + obj.currCol + " >> " + col + " /map/ " + _data.map[row][col]);
			if(_data.map[row][col] > 0){
				//trace("checkNextTile() Player can move!");
				return true;
			}else {
				//trace("checkNextTile() Player cannot move!");
				return false;				
			}
		}
		private function playerMove(dir:int, player:Player):void
		{
			switch(dir) {
				case Player.MOVE_UP:
					player.dirX = 0;
					player.dirY = -1;
					player.direction = Player.MOVE_UP;
					break;
				case Player.MOVE_DOWN:
					player.dirX = 0;
					player.dirY = 1;
					player.direction = Player.MOVE_DOWN;
					break;
				case Player.MOVE_LEFT:
					player.dirX = -1;
					player.dirY = 0;
					player.direction = Player.MOVE_LEFT;
					break;
				case Player.MOVE_RIGHT:
					player.dirX = 1;
					player.dirY = 0;
					player.direction = Player.MOVE_RIGHT;
					break;
				case Player.MOVE_STOP:
					player.dirX = 0;
					player.dirY = 0;
					player.direction = Player.MOVE_STOP;
					break;
			}
			player.nextRow = player.currRow + player.dirY;
			player.nextCol = player.currCol + player.dirX ;
		}
		private function checkPlayerInCenterTile(player:Player):Boolean
		{
			//trace("Board.checkPlayerInCenterTile() ");
			var centerX:int = (player.currCol * _data.tileWidth) + _data.tileWidth/2;
			var centerY:int= (player.currRow * _data.tileHeight) + _data.tileHeight/2;
			
			if (player.x == centerX && player.y == centerY) {
				//trace("in center tile");
				return true;
				
			}else {
				//trace("not in center tile");
				return false;
				
			}	
		}
		private function checkForFood(row:int,col:int):void
		{
			//trace("checkForFood(col,row) " + row + "  // " + col + " /p2/ " + this.getChildByName("p2_"+row+"_"+col) + " /p3/ " + this.getChildByName("p3_"+row+"_"+col) + " /map/ " + _data.map[row][col]);
			if(this.getChildByName("p2_"+row+"_"+col)){
				if(this.getChildByName("p2_"+row+"_"+col).hitTestObject(_actor)){
					this.removeChild(this.getChildByName("p2_"+row+"_"+col));
					_data.map[row][col] = 1;
					_score.scoreUp(2);
				}
			}
			if(this.getChildByName("p3_"+row+"_"+col)){
				if(this.getChildByName("p3_"+row+"_"+col).hitTestObject(_actor)){
					this.removeChild(this.getChildByName("p3_"+row+"_"+col));
					_data.map[row][col] = 1;
					machine.setState(SYS_STATE_HUNTER);
					_score.scoreUp(10);
				}
			}
		}
		private function checkEnemyHit():void
		{
			for(var i in enemys){
				//trace(machine.getState() + " // " + Enemy(_enemys[i]) + " /// " + _actor + " // " + Enemy(_enemys[i]).hitTestObject(_actor));
				if(Enemy(_enemys[i]).hitTestObject(_actor)){
					switch(machine.getState()){
						case SYS_STATE_HUNTER:
							_score.scoreUp(100);
							Enemy(_enemys[i]).ghost = true;
							break;
						case SYS_STATE_NORMAL:
							_score.lifeDown();
							gameLifeDownReset();
							if(!_score.isAlive())
								machine.setState(SYS_STATE_END);
							
							break;
					}
				}
			}
		}
		/**
		 * 
		 * Enemy moves
		 * 
		 * */
		private function checkEnemyMove():void
		{
			for(var i in enemys){
				checkEnemyAvailableDirection(enemys[i]);
			}
			checkEnemyHit();
		}
		private function checkEnemyAvailableDirection(enemy:Player):void
		{
			var prevDir = enemy.direction;
			var inJunction:Boolean = false;
			var moveUp:Boolean = checkNextTile(Player.MOVE_UP,enemy);
			var moveDown:Boolean = checkNextTile(Player.MOVE_DOWN,enemy);
			var moveLeft:Boolean = checkNextTile(Player.MOVE_LEFT,enemy);
			var moveRight:Boolean = checkNextTile(Player.MOVE_RIGHT,enemy);
			
			if(prevDir == Player.MOVE_UP || prevDir == Player.MOVE_DOWN || prevDir == Player.MOVE_STOP){
				if(moveLeft || moveRight){
					inJunction = true;
				}else{
					
					//continue
					//return
				}
			}
			else if(prevDir == Player.MOVE_RIGHT || prevDir == Player.MOVE_LEFT || prevDir == Player.MOVE_STOP){
				if(moveUp || moveDown){
					inJunction = true;
				}else{
					
					//continue
					//return
				}
			}else{
				//reverse
				//return
			}
			if(inJunction){
				var arr:Array = [];
				moveUp		? arr.push(Player.MOVE_UP):null;
				moveDown	? arr.push(Player.MOVE_DOWN):null;
				moveRight	? arr.push(Player.MOVE_RIGHT):null;
				moveLeft	? arr.push(Player.MOVE_LEFT):null;
				
				var r:int = Math.random()*arr.length;
				
				enemy.direction = r;
				playerMove(arr[r],enemy);
			}
			enemy.currRow = enemy.nextY / _data.tileWidth;
			enemy.currCol = enemy.nextX / _data.tileHeight;
			enemy.update();
			
		}
		/**
		 * 
		 * Input Handlers
		 * 
		 * */
		private function checkKeyInput():void
		{
			var lastDir = actor.direction;
			if(_keysPressed[38]){
				if(checkNextTile(Player.MOVE_UP, actor)){
					if(actor.direction == Player.MOVE_UP || actor.direction == Player.MOVE_DOWN || actor.direction == Player.MOVE_STOP){
						playerMove(Player.MOVE_UP,actor);
					}else if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}else{
					//trace("Board. MOVE_UP is blocked ");
					if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}
				
			}
			if(_keysPressed[40]){
				if(checkNextTile(Player.MOVE_DOWN, actor)){
					if(actor.direction == Player.MOVE_UP || actor.direction == Player.MOVE_DOWN || actor.direction == Player.MOVE_STOP){
						playerMove(Player.MOVE_DOWN,actor);
					}else if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}else{
					//trace("Board. MOVE_DOWN is blocked ");
					if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}
				
			}
			if(_keysPressed[39]){
				if(checkNextTile(Player.MOVE_RIGHT, actor)){
					if(actor.direction == Player.MOVE_RIGHT || actor.direction == Player.MOVE_LEFT || actor.direction == Player.MOVE_STOP){
						playerMove(Player.MOVE_RIGHT,actor);
					}else if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}else{
					//trace("Board. MOVE_RIGHT is blocked ");
					if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}
				
			}
			if(_keysPressed[37]){
				if(checkNextTile(Player.MOVE_LEFT, actor)){
					if(actor.direction == Player.MOVE_RIGHT || actor.direction == Player.MOVE_LEFT || actor.direction == Player.MOVE_STOP){
						playerMove(Player.MOVE_LEFT,actor);
					}else if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}else{
					//trace("Board. MOVE_LEFT is blocked ");
					if(checkPlayerInCenterTile(actor)){						
						playerMove(Player.MOVE_STOP,actor);
					}
				}
				
			}
			
			actor.currRow = actor.nextY / _data.tileWidth;
			actor.currCol = actor.nextX / _data.tileHeight;
			actor.update();
			checkForFood(actor.currRow,actor.currCol)
		}
		public function keyDownHandler(e:KeyboardEvent):void
		{
			_keysPressed[e.keyCode] = true;
		}
		public function keyUpHandler(e:KeyboardEvent):void
		{
			_keysPressed[e.keyCode] = false;
		}
		/**
		 * 
		 * GETTER / SETTER
		 * 
		 * */
		public function get actor():Actor
		{
			return _actor;
		}
		public function get enemys():Array
		{
			return _enemys;
		}
	}
}
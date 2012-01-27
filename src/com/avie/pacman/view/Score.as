package com.avie.pacman.view
{
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Score extends Sprite
	{
		[Embed(source="assets/library.swf", symbol="ScoreMC")]
		private var ScoreMC:Class;
		[Embed(source="assets/library.swf", symbol="Font1" )]
		private var Font1:Class;
		
		private var _score:Sprite;
		private var _format:TextFormat;
		private var _scoreTF:TextField;
		private var _lifeTF:TextField;
		
		private var _intScore:int = 0;
		private var _numLife:Number = 3;
		
		public function Score()
		{
			super();
			init();
		}
		private function init():void
		{
			
			_score = new ScoreMC();
			addChild(_score);
			setText();
		}
		public function scoreUp(val:int):void
		{
			_scoreTF.text = String(int(_intScore += val));
			_format.color = 0xD7A11D;
			_scoreTF.setTextFormat(_format);
		}
		public function lifeDown():void
		{
			_numLife -= 1;
			_lifeTF.text = _numLife.toString();
			_format.color = 0xFFFFFF;
			_lifeTF.setTextFormat(_format);
		}
		public function isAlive():Boolean{
			if(_numLife <= 0){
				return false;
			}else{
				return true;
			}
		}
		private function setText():void
		{
			var font:Font = new Font1();
			_format = new TextFormat();
			_format.font = font.fontName;
			_format.size = 30;
			_format.color = 0xD7A11D;
			
			_scoreTF = new TextField();
			_scoreTF.autoSize = TextFieldAutoSize.LEFT;
			_scoreTF.embedFonts = true;
			_scoreTF.text = _intScore.toString();
			addChild(_scoreTF);

			_format.color = 0xFFFFFF;
			
			_lifeTF = new TextField();
			_lifeTF.autoSize = TextFieldAutoSize.LEFT;
			_lifeTF.embedFonts = true;
			_lifeTF.text = _numLife.toString();
			addChild(_lifeTF);
			
			_scoreTF.setTextFormat(_format);
			_lifeTF.setTextFormat(_format);
			
			_scoreTF.x = 340;
			_scoreTF.y = 30;
			
			_lifeTF.x = 590;
			_lifeTF.y = 30;
		}
		
	}
}
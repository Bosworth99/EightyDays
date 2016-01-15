package com.b99.display.composite
{
	import com.b99.display.element.*;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class GameLog extends Sprite
	{
		private var _canvas	:Sprite;
		private var _text	:String;
		private var _txt	:TextFieldFormat;
		private var _base	:CustomRoundRectGrad;
		
		public function GameLog() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);

			_base = new CustomRoundRectGrad(500, 70, 20, "linear", [0xFFFFFF, 0xE4E8CA], [1, 1], [1, 255], 270, 2, 0x515726, 1);
			_canvas.addChild(_base);

			_txt = new TextFieldFormat("", 0x4E5324, 12, "verdana_text", 70, 480);
			with (_txt) 
			{
				x 		= 10;
				y		= 10;
			}
			_base.addChild(_txt);
		}
		
		public function logtext(value:String):void 
		{
			_txt.set_text = value;
		}
		
		
	}
}
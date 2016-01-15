package com.b99.display.prototype 
{
	import com.b99.data.GameData;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class SimpleMessageFlyout extends Sprite
	{
	
		private var _canvas		:Sprite;
		private var _base		:CustomRoundRectGrad;
		private var _text		:TextFieldFormat;
		private var _message	:String;
		private var _width		:uint;
		
		public function SimpleMessageFlyout(message:String, width:uint) 
		{
			super();
			
			_message	= message;
			_width		= width;
			
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			_canvas.mouseChildren = false;
			this.addChild(_canvas);
			
			_base 	= new CustomRoundRectGrad(	_width,
												40, 
												10, 
												"linear", 
												[0xFFFFFF, 0xE2E3C4], 
												[1, 1], 
												[1, 255], 
												270, 
												2, 
												GameData.COLOR_TEXT, 
												1);
			_base.mouseChildren = false;
			_canvas.addChild(_base);
			_base.filters = [new DropShadowFilter(4, 45, GameData.COLOR_TEXT, .5)];
			
			_text	= new TextFieldFormat( _message, GameData.COLOR_TEXT, 18, "verdana", 30, _width);
			with (_text) 
			{
				x	= 10;
				y 	= 6;
				mouseEnabled 	= false;
				buttonMode 		= false;
			}
			_canvas.addChild(_text);
		}
		
		public function destroy():void
		{
			_text.destroy();
			_text = null;
			
			_base.filters = [];
			_base.destroy();
			_base = null;
			
			this.removeChild(_canvas);
			_canvas = null;
			
			this.parent.removeChild(this);
		}
		
	}
}
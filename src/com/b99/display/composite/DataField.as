package com.b99.display.composite 
{
	import com.b99.data.GameData;
	import flash.display.Sprite;
	import com.b99.display.element.*;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class DataField extends Sprite
	{
		private var _canvas		:Sprite;
		private var _base		:CustomRoundRectGrad;
		private var _label		:TextFieldFormat;
		private var _data		:TextFieldFormat;
		private var _offset		:uint;
		
		private var _height		:int;
		private var _width		:int;
		private var _txt_label	:String;
		private var _txt_data	:String;
		private var _color		:int;
		
		public function DataField(height:int, width:int, label:String, data:String, color:uint = GameData.COLOR_TEXT, offset:uint = 65) 
		{
			super();
			
			_height 	= height;
			_width 		= width;
			_txt_label 	= label;
			_txt_data 	= data;
			_color 		= color;
			_offset		= offset;
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
			
			_base = new CustomRoundRectGrad(_width,
											_height, 
											10, 
											"linear", 
											[0xFFFFFF, 0xE2E3C4], 
											[1, 1], 
											[1, 255], 
											270, 
											2, 
											GameData.COLOR_TEXT, 
											1);
			_canvas.addChild(_base);
			
			_label = new TextFieldFormat("", _color, 10, "verdana", 20, 30);
			_label.set_text =_txt_label;
			_label.x = 6;
			_label.y = 6;
			_canvas.addChild(_label);
			
			_data = new TextFieldFormat("", _color, 12, "verdana", 20, 30);
			_data.set_text = _txt_data;
			_data.x = _offset;
			_data.y = 4;
			_canvas.addChild(_data);
			
		}
		
		public function setData(data:String):void
		{
			_data.set_text = data;
		}
		
	}
}
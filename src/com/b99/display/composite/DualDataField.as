package com.b99.display.composite 
{
	import flash.display.Sprite;
	import com.b99.display.element.*;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class DualDataField extends Sprite
	{
		private var _canvas		:Sprite;
		private var _base		:CustomRoundRectGrad;
		private var _label		:TextFieldFormat;
		private var _data1		:TextFieldFormat;
		private var _data2		:TextFieldFormat;
		private var _separator	:TextFieldFormat;

		private var _height		:int;
		private var _width		:int;
		private var _txt_label	:String;
		private var _txt_data1	:String;
		private var _txt_data2	:String;
		
		private var _offset1	:uint;
		private var _offset2	:uint;
		
		private var _color		:int;
		
		public function DualDataField(height:int, width:int, label:String, data1:String, data2:String, color:uint = 0x4E5324, offset1:uint = 50, offset2:uint = 85  ) 
		{
			super();
			
			_height 	= height;
			_width 		= width;
			_txt_label 	= label;
			_txt_data1 	= data1;
			_txt_data2 	= data2;
			
			_offset1	= offset1;
			_offset2	= offset2
			
			_color 		= color;
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
											0x5C5E2D, 
											1);
			_canvas.addChild(_base);
			
			_label 			= new TextFieldFormat("", _color, 10, "verdana", 20, 30);
			_label.set_text =_txt_label;
			_label.x 		= 6;
			_label.y 		= 6;
			_canvas.addChild(_label);
			
			_data1 			= new TextFieldFormat("", _color, 12, "verdana", 20, 40);
			_data1.set_text = _txt_data1;
			_data1.x 		= _offset1;
			_data1.y 		= 4;
			_canvas.addChild(_data1);	
			
			_separator 		= new TextFieldFormat("/", _color, 14, "verdana", 20, 10);
			_separator.x 	= _offset2;
			_separator.y 	= 2;
			_canvas.addChild(_separator);
			
			_data2 			= new TextFieldFormat("", _color, 12, "verdana", 20, 30);
			_data2.set_text = _txt_data2;
			_data2 .x 		= (_separator.width + _separator.x);
			_data2 .y 		= 4;
			_canvas.addChild(_data2);
		}
		
		public function setData1(data:String):void
		{
			_data1.set_text = data;
		}
		public function setData2(data:String):void
		{
			_data2.set_text = data;
		}

	}
}
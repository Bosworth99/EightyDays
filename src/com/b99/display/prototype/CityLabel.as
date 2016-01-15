package com.b99.display.prototype
{
	import com.b99.display.element.*;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CityLabel extends Sprite
	{
		
		private var _canvas			:Sprite;
		private var _base			:CustomRoundRectGrad;
		
		private var _txt_name		:TextFieldFormat;
		private var _txt_dist		:TextFieldFormat;
		private var _distance		:int;
		
		private var _cityName		:String;
		private var _cityType		:String;
		
		public function CityLabel(cityName:String, cityType:String, distance:int) 
		{
			super();
			
			_cityName = cityName;
			_cityType = cityType;
			_distance = distance;
			
			init();
		}
		private function init():void
		{
			assembleDisplayObjects();
			//trace(_cityName, _cityType, _distance);
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);

			_base = new CustomRoundRectGrad(80,40,10,"linear", [0xFFFFFF,0xE4E8CA],[1,1],[1,255], 270, 2,0x515726,1);
			_canvas.addChild(_base);

			_txt_name = new TextFieldFormat(_cityName,0x4E5324,12,"verdana",20,40);
			with (_txt_name) 
			{
				x 		= 10;
				y		= 4;
			}
			_base.addChild(_txt_name);
			
			_txt_dist = new TextFieldFormat(_distance + " Klm",0x4E5324,12,"verdana",20,40);
			with (_txt_dist) 
			{
				x 		= 10;
				y		= 20;
			}
			_base.addChild(_txt_dist);
			
		}
		
		public function destroy():void
		{
			
			_txt_name.destroy();
			_txt_name 	= null;
			
			_txt_dist.destroy();
			_txt_dist 	= null;
			
			_base.destroy();
			_base 		= null;
			
			this.removeChild(_canvas);
			_canvas 	= null;

			this.parent.removeChild(this);
		}
		
		
	}
}
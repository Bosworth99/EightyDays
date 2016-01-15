package com.b99.display.prototype
{
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.greensock.*;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class City extends Sprite
	{
		private var _cityType	:String;
		private var _cityName	:String;
		private var _targetYes	:Sprite;
		private var _targetNo	:Sprite;
		private var _scale		:Number;
		
		private var _isAvailable	:Boolean = true;
		
		public function City(cityType:String, cityName:String) 
		{
			super();
			
			_cityType = cityType;
			_cityName = cityName;
			
			init();
		}
		private function init():void
		{
			assembleDisplayObject();
		}
		
		private function assembleDisplayObject():void
		{
			switch (_cityType)
			{
				case "city":
				{
					_scale = 1;
					break;
				}
				case "town":
				{
					_scale = 1;
					break;
				}
			}
			
			_targetYes = new GFX_TargetG();
			with (_targetYes) 
			{
				scaleX = scaleY = _scale;
			}
			this.addChild(_targetYes);
			
			_targetNo = new GFX_TargetR();
			with (_targetNo) 
			{
				scaleX = scaleY = _scale;
			}
			this.addChild(_targetNo);
			
		}

		public function isAvailable():void
		{
			
			TweenLite.to(_targetNo, .2, { alpha:0 } );
			TweenLite.to(_targetYes, .4, { alpha:1 } );
			
			_isAvailable = true;
		}
		
		public function notAvailable():void
		{
			TweenLite.to(_targetNo, .4, { alpha:1 } );
			TweenLite.to(_targetYes, .2, { alpha:0 } );
			
			_isAvailable = false;
		}
		
		
		public function get cityType()		:String 		{ return _cityType; }
		public function get cityName()		:String 		{ return _cityName; }
		public function get cityGfx()		:DisplayObject 	{ return this as DisplayObject  }
		public function get isItAvailable()	:Boolean 		{ return _isAvailable; }
		
	}
}
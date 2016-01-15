///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>element>Commodity.as
//
//	extends : Object
//	
//	Data Element representing a generic commodity
//
///////////////////////////////////////////////////////////////////////////////


package com.b99.data.prototype 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Commodity extends Object
	{
		
		private var _name			:String;
		private var _note			:String;
		private var _volume			:Number;
		private var _weight			:Number;
		private var _rarity			:String;
		private var _img			:String;
		private var _currentPrice	:Number;
		private var _sellPrice		:Number;
		private var _minMax			:Array = new Array();
		private var _history		:Array = new Array();
		private var _info			:String;
		
		public function Commodity() 
		{
			super();
			init();
		}
		
		private function init():void
		{
		}
		
		public function get name():String { return _name; }
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get note():String { return _note; }
		public function set note(value:String):void 
		{
			_note = value;
		}
		
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void 
		{
			_volume = value;
		}
		
		public function get weight():Number { return _weight; }
		public function set weight(value:Number):void 
		{
			_weight = value;
		}
		
		public function get rarity():String { return _rarity; }
		public function set rarity(value:String):void 
		{
			_rarity = value;
		}
		
		public function get img():String { return _img; }
		public function set img(value:String):void 
		{
			_img = value;
		}
		
		public function get currentPrice():Number { return _currentPrice; }
		public function set currentPrice(value:Number):void 
		{
			_currentPrice = value;
		}
		
		public function get sellPrice():Number { return _sellPrice; }
		public function set sellPrice(value:Number):void 
		{
			_sellPrice = value;
		}
		
		public function get minMax():Array { return _minMax; }
		public function set minMax(value:Array):void 
		{
			_minMax = value;
		}
		
		public function get history():Array { return _history; }
		public function set history(value:Array):void 
		{
			_history = value;
		}
		
		public function get info():String { return _name + ", buy: " + _currentPrice.toFixed(2) +", sell: " + _sellPrice.toFixed(2) + ", rarity: "+ _rarity};
		


	}
}
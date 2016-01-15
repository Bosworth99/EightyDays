///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>data>prototype>Component.as
//
//	extends : Object
//	
//	Data Element representing a generic Component
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data.prototype 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Component extends Object
	{
		private var _id					:String		= "";
		private var _type				:String		= "";
		private var _name				:String		= "";
		private var _level				:uint		= 0;
		private var _rarity				:String		= "";
		private var _weight				:uint		= 0;
		private var _buyPrice			:uint		= 0;
		private var _sellPrice			:uint		= 0;
		private var _note				:String		= "";
		private var _info				:String		= "";
		private var _img				:String;
		
		//+++++++++++++++++++ bonuses
		private var _travelSpeed		:Number		= 0;
		private var _crewCapacity		:uint		= 0;
		private var _passengerCapacity	:uint		= 0;
		private var _cargoCapacity		:Number		= 0;
		private var _weightCapacity		:Number		= 0;
		private var _fuelCapacity		:Number		= 0;
		private var _fuelEfficiency		:Number		= 0;
		private var _attack				:Number		= 0;
		private var _defense			:Number		= 0;
		
		
		public function Component() 
		{
			super();
			init();
		}
		
		private function init():void
		{
		}
		
		public function get id():String { return _id; }
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get type():String { return _type; }
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get name():String { return _name; }
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get level():uint { return _level; }
		public function set level(value:uint):void 
		{
			_level = value;
		}
		
		public function get rarity():String { return _rarity; }
		public function set rarity(value:String):void 
		{
			_rarity = value;
		}
		
		public function get weight():uint { return _weight; }
		public function set weight(value:uint):void 
		{
			_weight = value;
		}
		
		public function get buyPrice():uint { return _buyPrice; }
		public function set buyPrice(value:uint):void 
		{
			_buyPrice = value;
		}
		
		public function get sellPrice():uint { return _sellPrice; }
		public function set sellPrice(value:uint):void 
		{
			_sellPrice = value;
		}
		
		public function get travelSpeed():Number { return _travelSpeed; }
		public function set travelSpeed(value:Number):void 
		{
			_travelSpeed = value;
		}

		public function get crewCapacity():Number { return _crewCapacity; }
		public function set crewCapacity(value:Number):void 
		{
			_crewCapacity = value;
		}
		
		public function get passengerCapacity():Number { return _passengerCapacity; }
		public function set passengerCapacity(value:Number):void 
		{
			_passengerCapacity = value;
		}
		
		public function get cargoCapacity():Number { return _cargoCapacity; }
		public function set cargoCapacity(value:Number):void 
		{
			_cargoCapacity = value;
		}
		
		public function get weightCapacity():Number { return _weightCapacity; }
		public function set weightCapacity(value:Number):void 
		{
			_weightCapacity = value;
		}
		
		public function get fuelCapacity():Number { return _fuelCapacity; }
		public function set fuelCapacity(value:Number):void 
		{
			_fuelCapacity = value;
		}
		
		public function get fuelEfficiency():Number { return _fuelEfficiency; }
		public function set fuelEfficiency(value:Number):void 
		{
			_fuelEfficiency = value;
		}
			
		
		public function get attack():Number { return _attack; }
		public function set attack(value:Number):void 
		{
			_attack = value;
		}
		
		public function get defense():Number { return _defense; }
		public function set defense(value:Number):void 
		{
			_defense = value;
		}

		public function get note():String { return _note; }
		public function set note(value:String):void 
		{
			_note = value;
		}
		
		public function get img():String { return _img; }
		public function set img(value:String):void 
		{
			_img = value;
		}
		
		public function get info():String { 
			_info = "Name: "+ _name + " Type: " + _type + " Level: " + _level + " Price: " + _buyPrice+ " Rarity: " + _rarity;
			return _info; 
		}

	}
}
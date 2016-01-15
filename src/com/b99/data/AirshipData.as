package com.b99.data 
{
	import com.b99.data.prototype.Component;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class AirshipData extends Object
	{
		private static var _airspeed			:Number = 0;  
		private static var _efficiency			:int 	= 0;
		
		private static var _attack				:uint;
		private static var _defense				:uint;
		
		private static var _weightCapacity		:int	= 0;
		private static var _weightCurrent		:int 	= 0;
		private static var _baseWeight			:int 	= 0;
		
		private static var _fuelCapacity		:int 	= 0;
		private static var _fuelCurrent			:int 	= 0;
		
		private static var _cargoCapacity		:int 	= 0;
		private static var _cargoCurrent		:int 	= 0;
		private static var _cargoWeight			:int 	= 0;
		
		private static var _crewCapacity		:int	= 0;
		private static var _crewCurrent			:int	= 0;
		
		private static var _passengerCapacity	:int	= 0;
		private static var _passengerCurrent	:int 	= 0;
		
		private static var _maxDistance			:int;
		private static var _burnedFuel			:int;

		
		//+++++++++++++++++++++++++++++++++++++++ Components
		private static var _quarters 				:Component;
		private static var _cargoHold			:Component;
		private static var _balloon				:Component;
		private static var _fuelTank			:Component;
		private static var _engine				:Component;
		private static var _wing				:Component;
		private static var _weapon				:Component;
		private static var _armor				:Component;
		
		public function AirshipData(){}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									airship
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		static public function get airspeed():Number { return _airspeed; }
		static public function set airspeed(value:Number):void 
		{
			_airspeed = value;
		}	

		static public function get efficiency():int { return _efficiency; }
		static public function set efficiency(value:int):void 
		{
			_efficiency = value;
		}
		
		static public function get attack():uint { return _attack; }
		static public function set attack(value:uint):void 
		{
			_attack = value;
		}
		
		static public function get defense():uint { return _defense; }
		static public function set defense(value:uint):void 
		{
			_defense = value;
		}
		
		static public function get weightCapacity():int { return _weightCapacity; }
		static public function set weightCapacity(value:int):void 
		{
			_weightCapacity = value;
		}
		
		static public function get weightCurrent():int { return _baseWeight + _cargoWeight; }
		static public function set weightCurrent(value:int):void 
		{
			_weightCurrent = value;
		}
		
		static public function get baseWeight():int { return _baseWeight; }
		static public function set baseWeight(value:int):void 
		{
			_baseWeight = value;
		}
		
		static public function get fuelCapacity():int { return _fuelCapacity; }
		static public function set fuelCapacity(value:int):void 
		{
			_fuelCapacity = value;
		}
		
		static public function get fuelCurrent():int { return _fuelCurrent; }
		static public function set fuelCurrent(value:int):void 
		{
			_fuelCurrent = value;
		}
		
		static public function get cargoCapacity():int { return _cargoCapacity; }
		static public function set cargoCapacity(value:int):void 
		{
			_cargoCapacity = value;
		}
		
		static public function get cargoWeight():int { return _cargoWeight; }
		static public function set cargoWeight(value:int):void 
		{
			_cargoWeight = value;
		}
		
		
		static public function get cargoCurrent():int { return _cargoCurrent; }
		static public function set cargoCurrent(value:int):void 
		{
			_cargoCurrent = value;
		}
		
		static public function get maxDistance():int { return _fuelCurrent * _efficiency; }
		static public function set maxDistance(value:int):void 
		{
			_maxDistance = value;
		}
		
		static public function get burnedFuel():int { return _burnedFuel; }
		static public function set burnedFuel(value:int):void 
		{
			_burnedFuel = value;
		}
		
		static public function get crewCapacity():int { return _crewCapacity; }
		static public function set crewCapacity(value:int):void 
		{
			_crewCapacity = value;
		}
		
		static public function get crewCurrent():int { return _crewCurrent; }
		static public function set crewCurrent(value:int):void 
		{
			_crewCurrent = value;
		}
		
		static public function get passengerCapacity():int { return _passengerCapacity; }
		static public function set passengerCapacity(value:int):void 
		{
			_passengerCapacity = value;
		}
		
		static public function get passengerCurrent():int { return _passengerCurrent; }
		static public function set passengerCurrent(value:int):void 
		{
			_passengerCurrent = value;
		}
		
		//++++++++++++++++++++++++++++++++++++++++++ Components
		
		static public function get quarters():Component { return _quarters; }
		static public function set quarters(value:Component):void 
		{
			_quarters = value;
		}
		
		static public function get cargoHold():Component { return _cargoHold; }
		static public function set cargoHold(value:Component):void 
		{
			_cargoHold = value;
		}
		
		static public function get balloon():Component { return _balloon; }
		static public function set balloon(value:Component):void 
		{
			_balloon = value;
		}
		
		static public function get fuelTank():Component { return _fuelTank; }
		static public function set fuelTank(value:Component):void 
		{
			_fuelTank = value;
		}
		
		static public function get engine():Component { return _engine; }
		static public function set engine(value:Component):void 
		{
			_engine = value;
		}
		
		static public function get wing():Component { return _wing; }
		static public function set wing(value:Component):void 
		{
			_wing = value;
		}
		
		static public function get weapon():Component { return _weapon; }
		static public function set weapon(value:Component):void 
		{
			_weapon = value;
		}
		
		static public function get armor():Component { return _armor; }
		static public function set armor(value:Component):void 
		{
			_armor = value;
		}

	}
}
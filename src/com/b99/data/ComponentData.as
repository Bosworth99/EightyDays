package com.b99.data 
{
	/**
	 * ...
	 * @author bosworth99
	 */
	public class ComponentData extends Object
	{
		private static var _bonusList			:Array = new Array();
		private static var _allComponents		:Array = new Array();
		private static var _quartersComponents	:Array = new Array();
		private static var _cargoComponents		:Array = new Array();
		private static var _balloonComponents	:Array = new Array();
		private static var _fuelComponents		:Array = new Array();
		private static var _engineComponents	:Array = new Array();
		private static var _wingComponents		:Array = new Array();
		private static var _weaponComponents	:Array = new Array();
		private static var _armorComponents		:Array = new Array();
		
		private static var _availableComponents	:Array = new Array();

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									(non)constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		public function ComponentData() { }
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									Upgrade Lists
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		static public function get bonusList():Array { return _bonusList; }
		static public function set bonusList(value:Array):void 
		{
			_bonusList = value;
		}		
		
		static public function get allComponents():Array { return _allComponents; }
		static public function set allComponents(value:Array):void 
		{
			_allComponents = value;
		}
		
		static public function get quartersComponents():Array { return _quartersComponents; }
		static public function set quartersComponents(value:Array):void 
		{
			_quartersComponents = value;
		}
		
		static public function get cargoComponents():Array { return _cargoComponents; }
		static public function set cargoComponents(value:Array):void 
		{
			_cargoComponents = value;
		}
		
		static public function get balloonComponents():Array { return _balloonComponents; }
		static public function set balloonComponents(value:Array):void 
		{
			_balloonComponents = value;
		}
		
		static public function get fuelComponents():Array { return _fuelComponents; }
		static public function set fuelComponents(value:Array):void 
		{
			_fuelComponents = value;
		}
		
		static public function get engineComponents():Array { return _engineComponents; }
		static public function set engineComponents(value:Array):void 
		{
			_engineComponents = value;
		}
		
		static public function get wingComponents():Array { return _wingComponents; }
		static public function set wingComponents(value:Array):void 
		{
			_wingComponents = value;
		}
		
		static public function get weaponComponents():Array { return _weaponComponents; }
		static public function set weaponComponents(value:Array):void 
		{
			_weaponComponents = value;
		}
		
		static public function get armorComponents():Array { return _armorComponents; }
		static public function set armorComponents(value:Array):void 
		{
			_armorComponents = value;
		}
		
		static public function get availableComponents():Array { return _availableComponents; }
		static public function set availableComponents(value:Array):void 
		{
			_availableComponents = value;
		}
		
	}
}

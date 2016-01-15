///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>data>CargoData.as
//
//	extends : Object	
//	data container for cargo information
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data 
{
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CargoData extends Object
	{
		
		private static var _cargoQuantities	:Array = new Array();
		
		public function CargoData(){}
		
		static public function get cargoQuantities():Array { return _cargoQuantities; }
		static public function set cargoQuantities(value:Array):void 
		{
			_cargoQuantities = value;
		}

		
	}
}
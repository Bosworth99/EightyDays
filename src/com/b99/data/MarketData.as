///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>app>data>MatketData.as
//
//	extends : Object
//	
//	Data Controller
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data 
{
	import com.b99.data.prototype.Commodity;

	/**
	 * ...
	 * @author bosworth99
	 */
	public class MarketData extends Object
	{
		private static var _fuel				:Commodity;
		
		//+++++++++++++++++++ commodity list
		private static var _allCommodities		:Array = new Array();
		private static var _commonCommodities	:Array = new Array();
		private static var _uncommonCommodities	:Array = new Array();
		private static var _rareCommodities		:Array = new Array();
		
		private static var _currentMarket		:Array = new Array();
		
		private static var _marketIsOpen		:Boolean;
		//+++++++++++++++++++ drop rates
		public static const DROP_UNCOMMON		:int = 25;
		public static const DROP_RARE			:int = 10;
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									(non)constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		public function MarketData() { }
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									Commodity Lists
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		
		static public function get fuel():Commodity { return _fuel; }
		static public function set fuel(value:Commodity):void 
		{
			_fuel = value;
		}

		//+++++++++++++++++++ commodity list
		static public function get allCommodities():Array { return _allCommodities; }
		static public function set allCommodities(value:Array):void 
		{
			_allCommodities = value;
		}
		
		static public function get commonCommodities():Array { return _commonCommodities; }
		static public function set commonCommodities(value:Array):void 
		{
			_commonCommodities = value;
		}
		
		static public function get uncommonCommodities():Array { return _uncommonCommodities; }
		static public function set uncommonCommodities(value:Array):void 
		{
			_uncommonCommodities = value;
		}
		
		static public function get rareCommodities():Array { return _rareCommodities; }
		static public function set rareCommodities(value:Array):void 
		{
			_rareCommodities = value;
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									market 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		
		static public function get marketIsOpen():Boolean { return _marketIsOpen; }
		static public function set marketIsOpen(value:Boolean):void 
		{
			_marketIsOpen = value;
		}

		static public function get currentMarket():Array { return _currentMarket; }
		static public function set currentMarket(value:Array):void 
		{
			_currentMarket = value;
		}
		
		
	}
}
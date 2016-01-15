///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>data>GameData.as
//
//	extends : Object
//	
//	Data Controller for global game variables 
//	ie. distance traveled, location, hours 
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data 
{
	import com.b99.data.prototype.Commodity;
	import com.b99.display.prototype.City;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class GameData extends Object
	{
		
		//+++++++++++++++++++ app level
		private static var _stageW			:int;
		private static var _stageH			:int;
		
		//+++++++++++++++++++ data
		private static var _commodityXML	:XML;
		private static var _component		:XML;
		
		//+++++++++++++++++++ 
		public static const CITYNUM			:int 		= 300;
		public static const MAP_HEIGHT		:int 		= 1000;
		public static const MAP_WIDTH		:int 		= 2250;
		
		public static const COLOR_COMMON	:uint		= 0xFFFFFF;
		public static const COLOR_UNCOMMON	:uint		= 0xE9EE06;
		public static const COLOR_RARE		:uint		= 0xEB200A;
		
		public static const COLOR_TEXT		:uint		= 0x4E5324;
		
		private static var _cash			:Number 	= 1000;
		
		private static var _gameOver		:Boolean 	= false;

		private static var _milesTraveled	:int		= 0;
		private static var _minutesTotal	:uint 		= 0;
		
		//+++++++++++++++++++travel
		private static var _oldLoc			:City
		private static var _currentLoc		:City;
		private static var _targetLoc		:City;

		private static var _currentDist		:int;
		private static var _isTraveling		:Boolean 	= false;
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									(non)constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function GameData() { };

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									app level
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		static public function get stageW():int { return _stageW; }
		static public function set stageW(value:int):void 
		{
			_stageW = value;
		}
		
		static public function get stageH():int { return _stageH; }
		static public function set stageH(value:int):void 
		{
			_stageH = value;
		}
		
		static public function get commodityXML():XML { return _commodityXML; }
		static public function set commodityXML(value:XML):void 
		{
			_commodityXML = value;
		}
		
		static public function get componentXML():XML { return _component; }
		static public function set componentXML(value:XML):void 
		{
			_component = value;
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									game stats
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		static public function get cash():Number { return _cash; }
		static public function set cash(value:Number):void 
		{
			_cash = value;
		}
		
		static public function get milesTraveled():int { return _milesTraveled; }
		static public function set milesTraveled(value:int):void 
		{
			_milesTraveled = value;
		}
			
		static public function get minutesTotal():uint { return _minutesTotal; }
		static public function set minutesTotal(value:uint):void 
		{
			_minutesTotal = value;
		}
		
		static public function get gameOver():Boolean { return _gameOver; }
		static public function set gameOver(value:Boolean):void 
		{
			_gameOver = value;
		}	
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									travel 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		static public function get oldLoc():City { return _oldLoc; }
		static public function set oldLoc(value:City):void 
		{
			_oldLoc = value;
		}
		
		static public function get currentLoc():City { return _currentLoc; }
		static public function set currentLoc(value:City):void 
		{
			_currentLoc = value;
		}
		
		static public function get targetLoc():City { return _targetLoc; }
		static public function set targetLoc(value:City):void 
		{
			_targetLoc = value;
		}
		
		static public function get currentDist():int { return _currentDist; }
		static public function set currentDist(value:int):void 
		{
			_currentDist = value;
		}
		
		static public function get isTraveling():Boolean { return _isTraveling; }
		static public function set isTraveling(value:Boolean):void 
		{
			_isTraveling = value;
		}
		
	}
}
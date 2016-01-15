///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>logic>GameLogic.as
//
//	extends : Object
//	
//	utility functions to run top level logic 
// 	total miles traveled, hour countdown etc...
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.logic 
{
	import com.b99.app.*;
	import com.b99.data.*;
	import com.b99.data.prototype.Commodity;
	import com.greensock.*; 
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class GameLogic extends Object
	{
		private static var _totalMinutes	:Array = new Array();
		private static var _totlaMiles		:Array = new Array();
		
		public function GameLogic(){}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									update game variables
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
	
		public static function addMinutes(minutes:uint, duration:uint):void
		{
			_totalMinutes[0] 	= Math.round(GameData.minutesTotal);
			var target:uint 	= _totalMinutes[0] + minutes;
			
			TweenMax.to(_totalMinutes, duration, { endArray:[target], onUpdate:updateMinutes } );
			GameData.minutesTotal += Math.round(minutes);
		}
		
		private static function updateMinutes():void
		{
			var total			:uint 	= Math.round(_totalMinutes[0]);
			
			//++++++++++++++++++ minutes
			var minutes			:uint 	= total % 60;
			var minutesString	:String;
			if (minutes < 10) 
			{
				minutesString = "0" + minutes.toString();
			} 
			else
			{
				minutesString = minutes.toString();
			}
			
			//+++++++++++++++++++ hours
			var hours 			:uint 	= (total / 60) % 24;
			var hoursString		:String;
			if (hours < 10) 
			{
				hoursString = "0" + hours.toString();
			}
			else
			{
				hoursString = hours.toString();
			}
			
			//+++++++++++++++++++ days
			var days			:uint 	= total / 1440;
			var daysString		:String;
			if (days < 10) 
			{
				daysString = "0" + days.toString();
			}
			else
			{
				daysString = days.toString();
			}
			
			var totalToString	:String = "D:" + daysString + " H:" + hoursString + " M:" + minutesString;
			
			//+++++++++++++++++++ update UI
			Main.display.UI.totalDays_data = totalToString;
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									update travel variables
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
		
		public static function addMiles():void
		{
			_totlaMiles[0] 		= Math.round(GameData.milesTraveled);
			var target:uint 	= _totlaMiles[0] + GameData.currentDist;
			
			TweenMax.to(_totlaMiles, GameData.currentDist / 30, { endArray:[target], onUpdate:updateMiles } );
			GameData.milesTraveled += GameData.currentDist;
		}
		
		private static function updateMiles():void
		{
			Main.display.UI.klmTraveled = _totlaMiles[0];
		}
		
		public static function setCurrentCity():void
		{
			Main.display.UI.targetCity = GameData.currentLoc.cityName;
		}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									utils
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			

		public static function randRange(minNum:Number, maxNum:Number):uint 
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }		
		
		public static function formatNumber(number:Number, precision:int, decimalDelimiter:String = ".", commaDelimiter:String = ",", prefix:String = "", suffix:String = ""):String
		{
			var decimalMultiplier:int = Math.pow(10, precision);
			var str:String = Math.round(number * decimalMultiplier).toString();
		
			var leftSide:String = str.substr(0, -precision);
			var rightSide:String = str.substr(-precision);
		
			var leftSideNew:String = "";
			for (var i:int = 0;i < leftSide.length;i++)
			{
				if (i > 0 && (i % 3 == 0 ))
			{
				leftSideNew = commaDelimiter + leftSideNew;
			}
				 
			leftSideNew = leftSide.substr( -i - 1, 1) + leftSideNew;
			} 
			   
			return prefix + leftSideNew + decimalDelimiter + rightSide + suffix;
		}
		
		
	}
}
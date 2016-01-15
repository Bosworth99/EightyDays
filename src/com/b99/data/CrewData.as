
package com.b99.data 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CrewData extends Object
	{
		public function CrewData() { };
		
		private static var _name_captain		:String = "Player";
		private static var _img_captain			:Bitmap;
		
		static public function get name_captain():String 	{ return _name_captain; }
		static public function set name_captain(value:String):void 
		{
			_name_captain = value;
		}
		
		static public function get img_captain():Bitmap		{ return _img_captain; }
		static public function set img_captain(value:Bitmap):void 
		{
			_img_captain = value;
		}
		
	}
}
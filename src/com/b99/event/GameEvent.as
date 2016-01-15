package com.b99.event 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author bosworth99
	 */
	public class GameEvent extends Event
	{
		public static const DISPLAY_ASSEMBLED		:String = "display objects assembled";
		public static const XML_LOAD				:String = "xml has loaded";
		public static const START_REMOVED			:String = "start screen removed";
		public static const PROFILE_REMOVED			:String = "profile screen removed";
		public static const TRAVEL_COMPLETE			:String = "travel complete";
		public static const PANEL_ADDED				:String = "panel added";
		public static const PANEL_REMOVED			:String = "panel removed";
		public static const UPDATE_AVATAR			:String = "update avatar";
		
		public var arg:*;
		
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, ...a:*) 
		{
			super(type, bubbles, cancelable);
			arg = a;
		}
		
		override public function clone():Event 
		{
			return new GameEvent(type, bubbles, cancelable, arg);
		}
		
	}

}

// use of custom event
//
//addEventListener(AppEvents.CHANGE_COMPLETE, changeComplete, false, 0, true);
//
//in responding class, any any extra parameters:
//var testParams:Array = new Array("one", "two");
//this.dispatchEvent(new GameEvent(GameEvent.CHANGE_COMPLETE, false, false, testParams, "hello", 12));
//
//private function changeComplete(e:GameEvent):void
//{ 
//	-- catch them via indexes
// trace(e.arg[0]); // one,two
// trace(e.arg[1]); // hello
// trace(e.arg[2]); // 12
//removeEventListener(GameEvent.CHANGE_COMPLETE, stateChangeComplete);
//}
//

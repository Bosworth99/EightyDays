///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>app>Main.as
//
//	extends : Sprite
//	
//	Main entry point for application
//  instantiate top level classes
//	activate game 
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.app
{
	import com.b99.data.util.DataLoader;
	import com.b99.util.MemoryGraph;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Main extends Sprite 
	{
		//+++++++++++++++++++++++
		public static var _stage		:Stage;
		
		//+++++++++++++++++++++++
		private static var _display		:DisplayControl;
		private static var _dataLoader	:DataLoader;
		
		//private var _memory			:MemoryGraph;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
			
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_stage = this.stage
			
			entryPoint();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								entry point	 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			

		private function entryPoint():void
		{
			_display 		= new DisplayControl();
			this.addChild(_display);
			
			_dataLoader 	= new DataLoader();
			
			//_memory 		= new MemoryGraph();
			//_memory.x		= 706;
			//_memory.y		= 58;
			//this.addChild(_memory);

			GameControl.entryPoint();
		}
	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									 get n set
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		static public function get display():DisplayControl { return _display; }
		static public function get dataLoader():DataLoader { return _dataLoader; }
		
	}
}
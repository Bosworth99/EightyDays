///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>display>EventContainer.as
//
//	extends : Sprite
//	
//	container object for user events
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.display 
{
	import com.b99.data.prototype.Commodity;
	import com.b99.display.composite.QuantityPane;
	import com.b99.display.events.Profile;
	import com.b99.display.events.StartScreen;
	import com.b99.event.GameEvent;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Events extends Sprite
	{
		//+++++++++++++++++++++++++ event objects
		private var _startScreen	:StartScreen;
		private var _buildProfile	:Profile;
		private var _quantityPane	:QuantityPane;
		
	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function Events() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			trace("Events.init();");
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									start screen
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function startScreen():void
		{
			_startScreen = new StartScreen();
			this.addChild(_startScreen);
			
			_startScreen.addEventListener(GameEvent.PANEL_ADDED, startScreenAdded, false, 0, true);
		}
		
		private function startScreenAdded(e:GameEvent):void
		{
			_startScreen.removeEventListener(GameEvent.PANEL_ADDED, startScreenAdded);
		}
		
		public function removeStartScreen():void
		{
			_startScreen.addEventListener(GameEvent.PANEL_REMOVED, startScreenRemoved, false, 0, true);
			_startScreen.destroy();
		}
		
		private function startScreenRemoved(e:GameEvent):void
		{
			_startScreen.removeEventListener(GameEvent.PANEL_REMOVED, startScreenRemoved);
			_startScreen = null;
			
			this.dispatchEvent(new GameEvent(GameEvent.START_REMOVED));
		}
	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									build profile
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function buildProfile():void
		{
			_buildProfile	= new Profile();
			this.addChild(_buildProfile);

			_buildProfile.addEventListener(GameEvent.PANEL_ADDED, buildProfileAdded, false, 0, true);
		}
		
		private function buildProfileAdded(e:GameEvent):void
		{
			_buildProfile.removeEventListener(GameEvent.PANEL_ADDED, buildProfileAdded);
		}
		
		public function removeBuildProfile():void
		{
			_buildProfile.addEventListener(GameEvent.PANEL_REMOVED, buildProfileRemoved, false, 0, true);
			_buildProfile.destroy();
		}
		
		private function buildProfileRemoved(e:GameEvent):void
		{
			_buildProfile.removeEventListener(GameEvent.PANEL_REMOVED, buildProfileRemoved);
			_buildProfile = null;
			
			this.dispatchEvent(new GameEvent(GameEvent.PROFILE_REMOVED));
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy and sell 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
			
		public function addQuanityPane(tempCommodity:Commodity, intent:String, fuel:Boolean = false):void
		{
			_quantityPane = new QuantityPane(tempCommodity, intent, fuel);
			this.addChild(_quantityPane);
			
			TweenLite.from(_quantityPane, .5, {alpha:0} );
		}
		
		public function removeQuanityPane():void
		{
			TweenLite.to(_quantityPane, .5, { alpha:0, onComplete:quantityPaneRemoved});
		}

		private function quantityPaneRemoved():void
		{
			_quantityPane.destroy();
			_quantityPane = null;
		}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									pirate attack ... yaaaaaar matey!
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
	








		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									game over 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		










	}
}
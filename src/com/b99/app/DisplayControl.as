///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>app>DisplayControl.as
//
//	extends : Sprite
//	
//	Display List Controller
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.app 
{
	import com.b99.display.*;
	import com.b99.event.*;
	import com.greensock.TweenLite;
	import flash.display.*;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class DisplayControl extends Sprite
	{
		private var _canvas		:Sprite;
		 
		private var _ground		:Background;
		private var _panel		:Panel;
		private var _overlay	:Overlay;
		private var _events		:Events;
		private var _UI			:UserInterface;

		public function DisplayControl() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			trace("DisplayControl.init();");
		}

		public function assembleDisplayObjects():void
		{
			_canvas 	= new Sprite();
			this.addChild(_canvas);
			
			_ground 	= new Background();
			_canvas.addChild(_ground);
			
			_panel 		= new Panel();
			_canvas.addChild(_panel);
			_panel.visible = false;
			
			_overlay 	= new Overlay();
			_canvas.addChild(_overlay);
			_overlay.visible = false;
			
			_UI 		= new UserInterface()
			_canvas.addChild(_UI);
			_UI.visible = false;
			
			_events		= new Events()
			_canvas.addChild(_events);
			
			this.dispatchEvent(new GameEvent(GameEvent.DISPLAY_ASSEMBLED));
		}
		
		/**
		 * this is where an intro animation sequence will be constructed
		 */
		public function firstTurn():void
		{
			_panel.visible 		= true;
			_overlay.visible	= true;
			_UI.visible 		= true;
			
			TweenLite.from(_panel, 	.5, {delay:0.1, alpha:0 });
			TweenLite.from(_UI, 	.5, {delay:0.3, alpha:0 });
			TweenLite.from(_overlay,.5, {delay:0.1, alpha:0 });
			
			_UI.firstTurn();
			_panel.firstTurn();		
		}

		
		
		public function get panel()	:Panel 			{ return _panel; }
		public function get UI()	:UserInterface 	{ return _UI; }
		public function get events():Events			{ return _events; }

	}
}
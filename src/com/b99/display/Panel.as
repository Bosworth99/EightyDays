///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>display>Panel.as
//
//	extends : Sprite
//	
//	Container, Controller for panels
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.display 
{
	
	import com.b99.app.DisplayControl;
	import com.b99.app.GameControl;
	import com.b99.display.panel.*;
	import com.b99.event.GameEvent;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Panel extends Sprite
	{
		//++++++++++++++++++++++++++ containers
		private var _canvas			:Sprite;
		private var _panelCon		:Sprite;
		private var _mask			:Sprite;
		
		//++++++++++++++++++++++++++ add/remove panels
		private var _newPanel		:Ipanel;
		private var _oldPanel		:Ipanel;
		private var _overlayPanel	:Ipanel;
		
		private var _overlayIsUp	:Boolean = false;
		
		//++++++++++++++++++++++++++ panels
		private var _map			:MapPanel;
		private var _port			:PortPanel;
		
		private var _airship		:AirshipPanel;
		
		private var _cargo			:CargoPanel;
		private var _crew			:CrewPanel;
		
		private var _market			:MarketPanel;
		private var _mechanic		:MechanicPanel;
		private var _tavern			:TavernPanel;
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		public function Panel() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
		
		public function firstTurn():void
		{
			trace("panel.firstTurn();");
			
			_map.entryPoint();
			addPanel("map");
		}	
		
		private function assembleDisplayObjects():void
		{
			_canvas 		= new Sprite();
			with (_canvas) 
			{
				x 			= 50;
				y 			= 50;
			}
			this.addChild(_canvas);
			
			_mask 			= new Sprite();
			with (_mask) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRect(0, 0, 860, 500);
				graphics.endFill();
				x 			= 50;
				y 			= 50;
			}
			this.addChild(_mask);
			_canvas.mask 	= _mask;
			
			_panelCon 		= new Sprite();
			_canvas.addChild(_panelCon);
			
			_map 			= new MapPanel();
			_port			= new PortPanel();
			_airship 		= new AirshipPanel();
			_cargo			= new CargoPanel();
			_crew			= new CrewPanel();
			_market			= new MarketPanel();
			_mechanic 		= new MechanicPanel();
			_tavern			= new TavernPanel();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									panel add/remove
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		public function addPanel(target:String):void
		{
			if (_newPanel) 
			{
				_oldPanel = _newPanel;
			}
			try 
			{
				switch (target) 
				{
					case "map":
					{
						_newPanel = _map as Ipanel;
						break;
					}
					case "port":
					{
						_newPanel = _port as Ipanel;
						break;
					}
					case "airship":
					{
						_newPanel = _airship as Ipanel;
						break;
					}
				}
				
				_panelCon.addChild(_newPanel as DisplayObject);
				TweenLite.from(_newPanel, 1, {y:-550, onComplete:removePanel} );
			} 
			catch (e:Error)
			{
				GameControl.updateGameLog(e.message);
			}
		}
		
		private function removePanel():void
		{
			if (_oldPanel)
			{
				_panelCon.removeChild(_oldPanel as DisplayObject);
			}
			this.dispatchEvent(new GameEvent(GameEvent.PANEL_ADDED));
		}

		public function addOverlayPanel(target:String):void
		{
			_overlayIsUp = true;
			switch (target) 
			{
				case "market":
				{
					_overlayPanel = _market;
					_market.reactivate();
					break;
				}
				case "mechanic":
				{
					_overlayPanel = _mechanic;
					_mechanic.reactivate();
					break;
				}
			}
			_panelCon.addChild(_overlayPanel as DisplayObject);
			DisplayObject(_overlayPanel).alpha = 1;
			
			TweenLite.from(DisplayObject(_overlayPanel), .5, {alpha:0, onComplete:overlayPanelAdded} );
		}
		
		private function overlayPanelAdded():void
		{
			this.dispatchEvent(new GameEvent(GameEvent.PANEL_ADDED));
		}
		
		public function removeOverlayPanel():void
		{
			TweenLite.to(DisplayObject(_overlayPanel), .5, { alpha:0, onComplete:overlayPanelRemoved } );
		}
		
		private function overlayPanelRemoved():void
		{
			_panelCon.removeChild(_overlayPanel as DisplayObject);
			
			this.dispatchEvent(new GameEvent(GameEvent.PANEL_REMOVED));
			_overlayIsUp = false;
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									get n set
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
				
		public function get map():MapPanel 				{ return _map; }	
		public function get port():PortPanel 			{ return _port; }
		public function get airship():AirshipPanel 		{ return _airship; }
		public function get cargo():CargoPanel 			{ return _cargo; }
		public function get crew():CrewPanel 			{ return _crew; }
		public function get market():MarketPanel 		{ return _market; }
		public function get mechanic():MechanicPanel 	{ return _mechanic; }
		public function get tavern():TavernPanel 		{ return _tavern; }
		public function get overlayIsUp():Boolean 		{ return _overlayIsUp; }
	}
}
package com.b99.display.panel 
{
	import com.b99.app.*;
	import com.b99.data.*;
	import com.b99.display.composite.*;
	import com.b99.display.prototype.*;
	import com.b99.event.*;
	import com.greensock.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class MapPanel extends Sprite  implements Ipanel
	{
		private var _canvas			:Sprite;
		private var _base			:Sprite;
		private var _frameTop		:Sprite;
		private var _mapCon			:Sprite;
		private var _map			:Sprite;
		private var _mapMask		:Sprite;
		
		private var _routeCon		:Sprite;
		private var _fullRoute		:Sprite;
		private var _travelRoute	:Sprite;
		private var _travelPoints	:Array = new Array();
		
		private var _cityCon		:Sprite;
		private var _cities 		:Array = new Array();
		private var _airship		:Sprite;
		
		private var _cityLabel		:CityLabel; 

		public function MapPanel() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			createCities();
			this.scrollRect = new Rectangle(0, 0, 860, 550);
		}
		
		public function entryPoint():void
		{
			GameData.currentLoc = _cities[0];
			GameData.targetLoc = GameData.currentLoc;
			
			updateRoute();
			
			addEventHandlers();
			addTravelHandlers();
		}
			
		private function assembleDisplayObjects():void
		{
			//+++++++++++++++++++++++++++++++ container
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_base 		= new GFX_Panel();
			_canvas.addChild(_base);
			
			//+++++++++++++++++++++++++++++++ mask for mapCon
			_mapMask = new Sprite();
			with (_mapMask) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRect(0, 0, 860, 500);
				graphics.endFill();
			}
			_canvas.addChild(_mapMask);
			
			//+++++++++++++++++++++++++++++++ map container
			_mapCon = new Sprite();
			_canvas.addChild(_mapCon);
			_mapCon.mask = _mapMask;
			
			//+++++++++++++++++++++++++++++++ map gfx 			
			_map = new GFX_Map();
			_mapCon.addChild(_map);
			
			//+++++++++++++++++++++++++++++++ route container
			_routeCon = new Sprite();
			with (_routeCon) 
			{
				x			= 0;
				y			= 0;
			}
			_mapCon.addChild(_routeCon);
			
			//+++++++++++++++++++++++++++++++ route gfx
			_fullRoute		= new Sprite();
			_mapCon.addChild(_fullRoute);
			
			_travelRoute 	= new Sprite();
			_mapCon.addChild(_travelRoute);
			
			//+++++++++++++++++++++++++++++++ airship gfx
			_airship 		= new GFX_Airship();
			with (_airship) 
			{
				scaleX 		= .65;
				scaleY 		= .65;
				x 			= (GameData.stageW / 2) - (_airship.width /2);
				y 			= 265;
			}
			_airship.mouseEnabled = false;
			_mapCon.addChild(_airship);
			
			//+++++++++++++++++++++++++++++++ city node container
			_cityCon		 = new Sprite();
			_cityCon.mouseChildren 	= true;
			_cityCon.mouseEnabled 	= true;
			_mapCon.addChild(_cityCon);
			
			
			_frameTop 	= new GFX_FrameTop()
			_frameTop.y 		= 530;
			_frameTop.scaleY 	= -1;
			_canvas.addChild(_frameTop);
		}
		
		private function createCities():void
		{
			var initCity:City = new City("city", "City 0");
			with (initCity) 
			{
				name 		= "city 0";
				x 			= _airship.x;
				y 			= _airship.y;
			}
			
			initCity.buttonMode = true;
			_cityCon.addChild(initCity);
			_cities.push(initCity)
			
			for (var i:int = 1; i < GameData.CITYNUM - 1; i++) 
			{
				var ranX			:int = (Math.random() * GameData.MAP_WIDTH) + 200;
				var ranY			:int = (Math.random() * GameData.MAP_HEIGHT) + 200;
				var ranCity			:int = Math.random() * 100;
				var generic			:City;
				
				if (ranCity > 80)
				{
					generic = new City("city","City "+i);
					with (generic) 
					{
						name 	= "city" + i;
						x 		= ranX;
						y 		= ranY;
						scaleX = scaleY = 1;
					}
				} 
				else 
				{
					generic = new City("town","Town "+i);
					with (generic) 
					{
						name 	= "town" + i;
						x 		= ranX;
						y 		= ranY;
						scaleX = scaleY = .75;
					}
				}
				generic.buttonMode = true;
				_cityCon.addChild(generic);
				_cities.push(generic)
			}
		}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								events
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		private function addEventHandlers():void
		{
			_cityCon.addEventListener(MouseEvent.MOUSE_OVER, 	city_over, false, 0, true);
			_cityCon.addEventListener(MouseEvent.MOUSE_OUT, 	city_out,  false, 0, true);
		}
		
		private function addTravelHandlers():void
		{
			_cityCon.addEventListener(MouseEvent.MOUSE_DOWN, 	city_down, false, 0, true);
		}

		private function removeTravelHandlers():void
		{
			_cityCon.removeEventListener(MouseEvent.MOUSE_DOWN, city_down);
		}
		

		private function city_over(e:MouseEvent):void 
		{
			if (_cityLabel) 
			{
				_cityLabel.destroy();
				_cityLabel = null;
			}
			
			var generic:City = e.target.parent as City;
			switch (generic.cityType) 
			{
				case "city":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:1.25, scaleY:1.25} );
					break;
				}
				case "town":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:1, scaleY:1} );
					break;
				}
			}
							
			_cityLabel = new CityLabel(generic.cityName, generic.cityType, distanceTo(generic));
			with (_cityLabel) 
			{
				x = mouseX  - 20;
				y = mouseY - 70;
			}
			_canvas.addChild(_cityLabel);
		}
		
		private function city_out(e:MouseEvent = null):void 
		{
			var generic:City = e.target.parent as City;
			switch (generic.cityType)  
			{
				case "city":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:1, scaleY:1} );
					break;
				}
				case "town":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:.75, scaleY:.75} );
					break;
				}
			}
			if (_cityLabel) 
			{
				_cityLabel.destroy();
				_cityLabel = null;
			}
		}
		
		private function city_down(e:MouseEvent):void 
		{
			var generic:City = e.target.parent as City;
			
			//define old location as the current, to be updated at end of funciton
			GameData.oldLoc = GameData.currentLoc;
			
			GameData.targetLoc = generic;
			
			switch (generic.cityType)  
			{
				case "city":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:1, scaleY:1} );
					break;
				}
				case "town":
				{
					TweenLite.to(generic.cityGfx, .3, {scaleX:.75, scaleY:.75} );
					break;
				}
			}

			if (GameData.targetLoc.isItAvailable && GameData.targetLoc != GameData.currentLoc) 
			{
					
				if (_cityLabel) 
				{
					_canvas.removeChild(_cityLabel);
					_cityLabel = null;
				}
				
					
				//set distance for UI to get after arrival
				//#do this @ GameControl#
				GameData.currentDist = distanceTo(GameData.targetLoc);
					
				GameControl.travel(GameData.targetLoc.cityName);
				GameData.currentLoc = GameData.targetLoc;
			} 
			else 
			{
				GameControl.updateGameLog( GameData.targetLoc.cityName + " is too far away. Buy more fuel?");
			}

		}		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								logic
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
		
		
		public function travel():void
		{
			removeTravelHandlers()
			
			var tempX, tempY = int;
			
			tempX = _mapCon.x - (GameData.targetLoc.x - _airship.x);
			tempY = _mapCon.y - (GameData.targetLoc.y - _airship.y);
			
			TweenLite.to(_mapCon, 	GameData.currentDist / 30, { x:tempX, y:tempY, onComplete:arrive } );
			TweenLite.to(_airship, 	GameData.currentDist / 40, { x:GameData.targetLoc.x, y:GameData.targetLoc.y } );
			
			_travelRoute.addEventListener(Event.ENTER_FRAME, travelRoute, false, 0, true);
		}
		
		public function arrive():void
		{
			_travelRoute.removeEventListener(Event.ENTER_FRAME, travelRoute);
			
			this.dispatchEvent(new GameEvent(GameEvent.TRAVEL_COMPLETE));
			
			sortCities();
			updateRoute();
			addTravelHandlers();
		}
		
		private function updateRoute():void
		{
			_travelRoute.graphics.clear();
			
			var newPoint:Point = new Point(GameData.currentLoc.x, GameData.currentLoc.y);
			_travelPoints.push(newPoint);
			
			with (_fullRoute) 
			{
				graphics.clear();
				graphics.lineStyle(5, 0xDD0000, .8, false);
				graphics.moveTo(_travelPoints[0].x, _travelPoints[0].y)
				
				for (var i:int = 1; i < _travelPoints.length; i++) 
				{
					graphics.lineTo(_travelPoints[i].x, _travelPoints[i].y);
				}
			}
		}
		
		private function travelRoute(e:Event):void
		{
			with (_travelRoute) 
			{
				graphics.clear();
				graphics.lineStyle(5, 0xDD0000, .8, false);
				graphics.moveTo(GameData.oldLoc.x, GameData.oldLoc.y)
				graphics.lineTo(_airship.x, _airship.y);
			}
		}
		
		public function sortCities():void
		{
			for (var i:int = 0; i < _cities.length; i++) 
			{
				var tempCity:City = _cities[i] as City;
				
				if ( distanceTo(tempCity) <= AirshipData.maxDistance) 
				{
					tempCity.isAvailable();
					
				} else {
					
					tempCity.notAvailable();
				}
			}
		}
		
		private function distanceTo(p1:DisplayObject):int
		{
			 var dx,dy:Number;
			 dx = _airship.x-p1.x;
			 dy = _airship.y-p1.y;
			 return Math.sqrt(dx*dx + dy*dy);
		}

	}
}
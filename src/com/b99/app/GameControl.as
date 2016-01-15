///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>app>GameControl.as
//
//	extends : Sprite
//	
//	Main entry point for application
//  instantiate top level classes
//	activate game 
// 	main controller for user interactions and application response
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.app 
{
	import com.b99.data.*;
	import com.b99.data.prototype.*;
	import com.b99.event.*;
	import com.b99.logic.*;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class GameControl extends Object
	{	
		public function GameControl() {}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									entry point
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	 
		/**
		* 	entry point for gameControl
		* 	assign stage dimension values
		* 	initiate external XML load, listener
		*/
		public static function entryPoint():void
		{
			GameData.stageH = Main._stage.stageHeight;
			GameData.stageW = Main._stage.stageWidth;

			Main.dataLoader.addEventListener(GameEvent.XML_LOAD, GameControl.initialize, false, 0, true);
			Main.dataLoader.loadXML();
		}
		
		/**
		* 	once XML is loaded, initialize commodities and components 
		* 	from the loaded xml
		* 
		* 	synchronously, initialize the display list
		*/
		private static function initialize(e:GameEvent):void
		{
			Main.dataLoader.removeEventListener(GameEvent.XML_LOAD, GameControl.initialize);
			
			//build initial market arrays
			MarketLogic.initializeMarket();
			
			//build component arrays
			ComponentLogic.initializeComponents();
		
			//set initial quanities (0)
			CargoLogic.initializeCargo();
			
			//activate 
			GameControl.assembleDisplayObjects();
		}
				
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									app activation
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		/**
		* 	activate the DisplayController class
		* 	main display list assembly for each of the main display objects 
		*/
		private static function assembleDisplayObjects():void
		{
			Main.display.addEventListener(GameEvent.DISPLAY_ASSEMBLED, displayListAssembled, false, 0, true);
			Main.display.assembleDisplayObjects();
		}

		/**
		 * 
		 * @param	e:GameEvent
		 * 
		 *  when the display list has been populated, and layers assembled,
		 * 	initialize the airship (it requires the display list has been filled)
		 * 	### this needs reworking - airship initialization should just be data,
		 * 	###	and not called separately here.
		 */
		private static function displayListAssembled(e:GameEvent):void
		{
			Main.display.removeEventListener(GameEvent.DISPLAY_ASSEMBLED, displayListAssembled);

			AirshipLogic.intializeAirship();
			
			GameControl.startScreen();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//							Start, Profile, First Turn 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		/**
		* 	once the application has been initialized, and its ready to go, 
		* 	add the start screen
		* 
		* 	### start screen should come prior to the display list being populated. 
		* 	### assets need to be split up to shrink the initial load time.
		* 	### start screen user activity is a great time to do this.
		*/
		private static function startScreen():void
		{
			Main.display.events.addEventListener(GameEvent.START_REMOVED, buildProfile, false, 0, true);
			Main.display.events.startScreen();
		}
		
		private static function buildProfile(e:GameEvent):void
		{
			Main.display.events.removeEventListener(GameEvent.START_REMOVED, buildProfile);

			Main.display.events.addEventListener(GameEvent.PROFILE_REMOVED, firstTurn, false, 0, true);
			Main.display.events.buildProfile();
		}
		
		/**
		* 	firstTurn activates the now funcitonal application. 
		* 	
		* 	### clicking on city should populate a "target" variable in the UI
		* 	### another button "depart" should activate travel()
		*/
		public static function firstTurn(e:GameEvent):void
		{
			Main.display.removeEventListener(GameEvent.PROFILE_REMOVED, firstTurn);
			
			trace("GameControl.firstTurn()");
			
			Main.display.firstTurn();
	
			Main.display.UI.captName_data 	= CrewData.name_captain;
			Main.display.UI.updateCaptAvatar();
			
			//assign commodity data. update display to reflect data
			MarketLogic.buildMarket(GameData.currentLoc.cityType);
			Main.display.panel.market.buildMarket();
			Main.display.panel.cargo.updateCargo();
			
			//assign component data. update display to reflect data
			ComponentLogic.buildAvailableComponents();
			Main.display.panel.mechanic.updateAvailableComponents();
			
			//assign fuel data. update display to reflect data
			MarketLogic.setFuelPrice();
			Main.display.UI.fuelPrice_data 		= MarketData.fuel.currentPrice;
			
			//define which cities are within distance
			Main.display.panel.map.sortCities();
			
			//assign value to the clock display
			GameLogic.addMinutes(0, 0);
			
			//assign value to the total miles display
			GameLogic.addMiles();
			
			//assign value to the city display
			GameLogic.setCurrentCity();
			
			//assign value to the fuel display
			AirshipLogic.burnFuel();
			
			GameControl.updateGameLog("Welcome to 80 Days, bitches.");
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									panel rotation
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		/**
		 * 
		 * @param	target: String  = panel to add to dispaly list
		 * 
		 * controller for the displayControl.panel 
		 * this basically assigns what user panel to drop into the frame
		 * 	
		 * if an overlay panel exists, remove it first	
		 */
		private static var _tempTarget:String;
		public static function addPanel(target:String):void
		{
			Main.display.UI.removeEventHandlers();

			if (Main.display.panel.overlayIsUp) 
			{
				_tempTarget = target;
				Main.display.panel.addEventListener(GameEvent.PANEL_REMOVED, lateAddPanel, false, 0, true);
				GameControl.removeOverlayPanel();
			} 
			else
			{
				Main.display.panel.addEventListener(GameEvent.PANEL_ADDED, panelAdded, false, 0, true);
				Main.display.panel.addPanel(target);
			}
		}
		
		private static function lateAddPanel(e:GameEvent):void
		{
			Main.display.panel.addEventListener(GameEvent.PANEL_ADDED, panelAdded, false, 0, true);
			Main.display.panel.addPanel(_tempTarget);
		}
		
		/**
		 * 
		 * @param	e:GameEvent
		 */
		public static function panelAdded(e:GameEvent):void
		{
			Main.display.panel.removeEventListener(GameEvent.PANEL_ADDED, panelAdded);
			Main.display.UI.addEventHandlers();
		}

		/**
		 * 
		 * @param	target:String = overlay panel to add
		 * 
		 * controller for the displayControl.panel 
		 * this adds secondary overlay panels into the frame
		 */
		public static function addOverlayPanel(target:String):void
		{
			Main.display.panel.addEventListener(GameEvent.PANEL_ADDED, overlayPanelAdded, false, 0, true);
			Main.display.panel.addOverlayPanel(target);
		}
		
		/**
		 * 
		 * @param	e:GameEvent
		 * 
		 * 	option to add additional activity one the overlay panel has been added
		 */
		public static function overlayPanelAdded(e:GameEvent):void
		{
			Main.display.panel.removeEventListener(GameEvent.PANEL_ADDED, overlayPanelAdded);
		}
		
		/**
		* 	controller for the displayControl.panel 
		* 	this removes secondary overlay panels from the frame
		*/
		public static function removeOverlayPanel():void
		{
			Main.display.panel.addEventListener(GameEvent.PANEL_REMOVED, overlayPanelRemoved, false, 0, true);
			Main.display.panel.removeOverlayPanel();
		}
		
		/**
		 * 
		 * @param	e:GameEvent
		 * 
		 * option to add additional activity once the overlay panel has been removed
		 */
		public static function overlayPanelRemoved(e:GameEvent):void
		{
			Main.display.panel.removeEventListener(GameEvent.PANEL_REMOVED, overlayPanelRemoved);
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									travel  / arrive
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		/**
		 * 
		 * @param	target:String = city to travel to (unused currently)
		 * 
		 *  activate travel between locations
		 * 	this involves activating an animation sequence in the map panel, and
		 * 	synchronously adding minutes and miles to the UI
		 */
		public static function travel(target:String):void
		{
			//boolean value to test against
			GameData.isTraveling = true;
			
			//activate travel animation in the map panel, listen for its completion event
			Main.display.panel.map.addEventListener(GameEvent.TRAVEL_COMPLETE, arrive, false, 0, true);
			Main.display.panel.map.travel();

			//activate minutes animation in the ui
			GameLogic.addMinutes( Math.round((GameData.currentDist / AirshipData.airspeed) * 60), GameData.currentDist / 30);
			
			//activate miles animation in the ui
			GameLogic.addMiles();
			
			//disable the UI functionality until travel has commenced
			Main.display.UI.removeEventHandlers();
			
			//tell the user whats up
			GameControl.updateGameLog("You've departed!");
			
			TravelEventLogic.travelEvent();
		}

		/**
		 *
		 * @param	e:GameEvent
		 * 
		 * called when travel() has completed, and an event has been dispatched from the map
		 */
		public static function arrive(e:GameEvent):void
		{
			Main.display.panel.map.removeEventListener(GameEvent.TRAVEL_COMPLETE, arrive);
			
			//boolean value to test against
			GameData.isTraveling = false;
			
			//update the current city in the display UI
			GameLogic.setCurrentCity();
			
			//update current fuel in the display UI
			AirshipLogic.burnFuel();
			
			//assign randomized commodity data. update display to reflect data
			MarketLogic.buildMarket(GameData.currentLoc.cityType);
			Main.display.panel.market.buildMarket();
			Main.display.panel.market.updateCargo();
			
			//assign randomized component data. update display to reflect data
			ComponentLogic.buildAvailableComponents();
			Main.display.panel.mechanic.updateAvailableComponents();

			//assign randomized fuel data. update display to reflect data
			MarketLogic.setFuelPrice();
			Main.display.UI.fuelPrice_data = MarketData.fuel.currentPrice;
			
			//add port panel into the display list
			GameControl.addPanel("port");
			Main.display.UI.currentPanel = "port";
			
			//wait for the panel to animate into place before reactivating the UI events
			TweenLite.delayedCall(1.10, Main.display.UI.addEventHandlers);
			
			//tell the user whats happening
			GameControl.updateGameLog("You've arrived at " + GameData.currentLoc.cityName +". The market is open!");
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy and sell commodities
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		/**
		 * 
		 * @param	tempCommodity:Commodity = target commodity for purchase
		 * 
		 *  attempt the purchase of a commodity. This activates a sequence in  MarketLogic
		 * 	that checks for available space, weight and cash. If the purchase is available, 
		 * 	it adds the quanity slider panel into the display list, and the user makes a selection
		 * 	eventually activating commodityPurchased.
		 */
		public static function purchaseCommodity(tempCommodity:Commodity):void
		{
			MarketLogic.purchaseCommodity(tempCommodity);
		}
		
		/**
		 * 
		 * @param	target:Commodity = commodity purchased
		 * @param	quantity:uint = number purchased
		 * @param	total:uint = total number currently in cargohold
		 * 
		 *  once a commodity has been successfully purchased, update variables and, finally,
		 *  the display list to reflect those changes
		 * 
		 */
		public static function commodityPurchased(target:Commodity, quantity:uint, total:uint):void
		{
			//remove quantity panel from display list
			Main.display.events.removeQuanityPane();
			
			//update market panel with current cargo data
			Main.display.panel.market.updateCargo();
			
			//update airship display with current available cargo slots 	
			Main.display.panel.airship.cargoCurrent_data 	= AirshipData.cargoCurrent;

			//update total weight of cargo, update airship display to match
			AirshipData.cargoWeight 						+= (target.weight * quantity);
			Main.display.panel.airship.weightCurrent_data 	= AirshipData.weightCurrent;
			
			//remove cash. update display to match 
			GameData.cash 									-= (target.currentPrice * quantity);
			Main.display.UI.cash_data 						= GameData.cash;
			
			//tell the user what happened
			GameControl.updateGameLog("You purchased "+quantity.toString()+ " "+ target.name +" for $"+target.currentPrice.toFixed(2)+". You have "+ total.toString()+"." );
		}

		/**
		 * 
		 * @param	target:Commodity = target commodity 
		 * 
		 * activate the sell sequence in MarketLogic. This adds the quantity panel
		 * into the display list, allowing the user to select a quantiy to remove, 
		 * eventually activating commoditySold()
		 */
		public static function sellCommodity(target:Commodity):void
		{
			MarketLogic.sellCommodity(target);
		}
		
		/**
		 * 
		 * @param	target:Commodity = commodity sold
		 * @param	quantity:uint = number of target commodities sold
		 * @param	total:uint = number of target commodities currently in the cargohold
		 * 
		 * once a commodity has been successfully sold, update variables and, finally,
		 * the display list to reflect those changes 
		 * 
		 */
		public static function commoditySold(target:Commodity, quantity:uint, total:uint):void
		{
			//remove quantity panel from display list
			Main.display.events.removeQuanityPane();
			
			//update market panel with current cargo data
			Main.display.panel.market.updateCargo();
			Main.display.panel.airship.cargoCurrent_data 	= AirshipData.cargoCurrent;
			
			//update total weight of cargo, update airship display to match
			AirshipData.cargoWeight 						-= (target.weight * quantity);
			Main.display.panel.airship.weightCurrent_data 	= AirshipData.weightCurrent;
			
			//add cash. update display to match 
			GameData.cash 									+= (target.sellPrice * quantity);
			Main.display.UI.cash_data 						= GameData.cash;
			
			//tell the user what happened
			GameControl.updateGameLog("You sold " + quantity.toString() + " " + target.name +" for " +target.sellPrice.toFixed(2)+". You have " + total.toString()+".");
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy fuel
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		/**
		 * initiate fuel purchase
		 * check for available quantity, cash and weight.
		 * if successful - add quantity panel and return quantity purchased
		 */
		public static function purchaseFuel():void
		{
			MarketLogic.purchaseFuel();
		}
		
		/**
		 * 
		 * @param	quantity:uint = quantity of fuel units purchased
		 * 
		 * upate values to reflect quantity of fuel units purchased
		 * 
		 */
		public static function fuelPurchased(quantity:uint):void
		{
			//remove quantity panel from display list
			Main.display.events.removeQuanityPane();
			
			//add fuel unitys. update display to match 
			AirshipData.fuelCurrent 						+= quantity;
			Main.display.UI.currentFuel_data 				= AirshipData.fuelCurrent;
			Main.display.panel.airship.fuelCurrent_data		= AirshipData.fuelCurrent;
			
			//remove cash. update display to match 
			GameData.cash 									-= MarketData.fuel.currentPrice * quantity;
			Main.display.UI.cash_data 						= GameData.cash;
			
			// delay call to sort cities (animation to reflect availablity of cities)
			TweenLite.delayedCall(.3, Main.display.panel.map.sortCities);
			
			// tell the user what happened
			GameControl.updateGameLog("You bought "+quantity+" gallons of gas! Your max distance is " + AirshipData.maxDistance + " Kms.");
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy components
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public static function purchaseComponent(component:Component):void
		{
			//trace("attempting purchase of :" + component.info);
			
			if (GameData.cash - component.buyPrice < 0 ) 
			{
				GameControl.updateGameLog("You completely can't afford that.");
			}
			else 
			{
				// ### run switch statement in AirshipLogic
				switch (component.type) 
				{
					case "quarters":
					{
						AirshipLogic.upgradeQuarters(component);
						break;
					}
					case "cargo":
					{
						AirshipLogic.upgradeCargo(component);
						break;
					}
					case "balloon":
					{
						AirshipLogic.upgradeBalloon(component);
						break;
					}
					case "fuel":
					{
						AirshipLogic.upgradeFuelTank(component);
						break;
					}
					case "engine":
					{
						AirshipLogic.upgradeEngine(component);
						break;
					}
					case "wing":
					{
						AirshipLogic.upgradeWing(component);
						break;
					}
					case "weapon":
					{ 
						AirshipLogic.upgradeWeapon(component);
						break;
					}
					case "armor":
					{
						AirshipLogic.upgradeArmor(component);
						break;
					}
				}
				
				GameData.cash -= component.buyPrice;
				GameData.cash += component.sellPrice;
				Main.display.UI.cash_data = GameData.cash;
				
				AirshipLogic.updateAirshipPanelData();
				
				
				Main.display.panel.mechanic.removeComponent(component.id);
				
				
				GameControl.updateGameLog("OMG, you purchased a "+ component.name);
			}
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									utils
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			

		public static function updateGameLog(text:String):void
		{
			Main.display.UI.gameLog_data = text;
		}
		
	}
}
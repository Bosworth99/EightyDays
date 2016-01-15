///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>logic>AirshipLogic.as
//
//	extends : Object
//	
//	utility functions to run airship logic 
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.logic 
{
	import com.b99.app.*;
	import com.b99.data.*;
	import com.b99.data.prototype.Component;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class AirshipLogic extends Object
	{
		

		public function AirshipLogic(){}
				
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									intialize 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public static function intializeAirship():void
		{
			AirshipData.quarters 		= ComponentData.quartersComponents[0];
			AirshipLogic.upgradeQuarters(AirshipData.quarters );
			
			AirshipData.cargoHold 		= ComponentData.cargoComponents[0]; 
			AirshipLogic.upgradeCargo(AirshipData.cargoHold);
			
			AirshipData.balloon			= ComponentData.balloonComponents[0];
			AirshipLogic.upgradeBalloon(AirshipData.balloon);
			
			AirshipData.fuelTank		= ComponentData.fuelComponents[0];
			AirshipLogic.upgradeFuelTank(AirshipData.fuelTank);
			
			AirshipData.engine			= ComponentData.engineComponents[0];
			AirshipLogic.upgradeEngine(AirshipData.engine);
			
			AirshipData.wing			= ComponentData.wingComponents[0];
			AirshipLogic.upgradeWing(AirshipData.wing);
			
			AirshipData.weapon			= ComponentData.weaponComponents[0];
			AirshipLogic.upgradeWeapon(AirshipData.weapon);
			
			AirshipData.armor			= ComponentData.armorComponents[0];
			AirshipLogic.upgradeArmor(AirshipData.armor);
			
			AirshipLogic.updateAirshipPanelData();
		}
		
		public static function updateAirshipPanelData():void
		{
			AirshipLogic.updateAirshipBaseWeight();

			Main.display.panel.airship.airspeed_data 			= AirshipData.airspeed;
			Main.display.panel.airship.efficiency_data			= AirshipData.efficiency;
			Main.display.panel.airship.weightCurrent_data		= AirshipData.weightCurrent;
			Main.display.panel.airship.fuelCurrent_data			= AirshipData.fuelCurrent;
			Main.display.panel.airship.cargoCurrent_data		= AirshipData.cargoCurrent;
			Main.display.panel.airship.crewCurrent_data			= AirshipData.crewCurrent;
			Main.display.panel.airship.passengerCurrent_data	= AirshipData.passengerCurrent;
			//attack
			//defense
		}
		
		public static function updateAirshipBaseWeight():void
		{
			AirshipData.baseWeight								= 0;
			AirshipData.baseWeight								+= AirshipData.quarters.weight;
			AirshipData.baseWeight								+= AirshipData.cargoHold.weight;
			AirshipData.baseWeight								+= AirshipData.balloon.weight;
			AirshipData.baseWeight								+= AirshipData.fuelTank.weight;
			AirshipData.baseWeight								+= AirshipData.engine.weight;
			AirshipData.baseWeight								+= AirshipData.wing.weight;
			AirshipData.baseWeight								+= AirshipData.weapon.weight;
			AirshipData.baseWeight								+= AirshipData.armor.weight;
			
			Main.display.panel.airship.weightCurrent_data		= AirshipData.weightCurrent;
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									upgrade 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public static function upgradeQuarters(quarters:Component):void
		{
			AirshipData.quarters 								= quarters;
			AirshipData.crewCapacity 							= AirshipData.quarters.crewCapacity;
			Main.display.panel.airship.crewCapacity_data 		= AirshipData.crewCapacity;
			
			AirshipData.passengerCapacity 						= AirshipData.quarters.passengerCapacity;
			Main.display.panel.airship.passengerCapacity_data	= AirshipData.passengerCapacity;
			
			Main.display.panel.airship.upgradeQuarters();
		}
		
		public static function upgradeCargo(cargo:Component):void
		{
			AirshipData.cargoHold 								= cargo;
			AirshipData.cargoCapacity							= AirshipData.cargoHold.cargoCapacity;
			Main.display.panel.airship.cargoCapacity_data		= AirshipData.cargoCapacity;
			
			Main.display.panel.airship.upgradeCargo();
		}
		
		public static function upgradeBalloon(balloon:Component):void
		{
			AirshipData.balloon  								= balloon;
			AirshipData.weightCapacity							= AirshipData.balloon.weightCapacity;
			Main.display.panel.airship.weightCapacity_data		= AirshipData.weightCapacity;
			
			Main.display.panel.airship.upgradeBalloon();
		}
		
		public static function upgradeFuelTank(fuel:Component):void
		{
			AirshipData.fuelTank								= fuel;
			AirshipData.fuelCapacity	 						= AirshipData.fuelTank.fuelCapacity;
			Main.display.panel.airship.fuelCapacity_data		= AirshipData.fuelCapacity;
			Main.display.UI.capacityFuel_data					= AirshipData.fuelCapacity;
			
			Main.display.panel.airship.upgradeFuelTank();
		}

		public static function upgradeEngine(engine:Component):void
		{
			AirshipData.engine 									= engine;
			AirshipData.airspeed								= AirshipData.engine.travelSpeed;
			Main.display.panel.airship.airspeed_data			= AirshipData.airspeed;
			
			if (AirshipData.wing) 
			{
				AirshipData.efficiency							= AirshipData.engine.fuelEfficiency + AirshipData.wing.fuelEfficiency;
				Main.display.panel.airship.efficiency_data		= AirshipData.efficiency;
			}
			
			Main.display.panel.airship.upgradeEngine();
		}
		
		public static function upgradeWing(wing:Component):void
		{
			AirshipData.wing 									= wing;
			
			AirshipData.efficiency								= AirshipData.engine.fuelEfficiency + AirshipData.wing.fuelEfficiency;
			Main.display.panel.airship.efficiency_data			= AirshipData.efficiency;
			
			Main.display.panel.airship.upgradeWing();
		}

		public static function upgradeWeapon(weapon:Component):void
		{
			AirshipData.weapon 									= weapon;
			AirshipData.attack									= AirshipData.weapon.attack;
			Main.display.panel.airship.attack_data				= AirshipData.attack;
			
			Main.display.panel.airship.upgradeWeapon();
		}
		
		public static function upgradeArmor(armor:Component):void
		{
			AirshipData.armor 									= armor;
			AirshipData.defense									= AirshipData.armor.defense;
			Main.display.panel.airship.defense_data				= AirshipData.defense;
			
			Main.display.panel.airship.upgradeArmor();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									travel 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
		
		public static function burnFuel():void
		{ 
			AirshipData.burnedFuel  							= GameData.currentDist/ AirshipData.efficiency;
			AirshipData.fuelCurrent				 				= AirshipData.fuelCurrent - AirshipData.burnedFuel;
			
			Main.display.UI.currentFuel_data 					= AirshipData.fuelCurrent;
			Main.display.panel.airship.fuelCurrent_data 		= AirshipData.fuelCurrent;
		}


	}
}
package com.b99.logic 
{
	import com.b99.data.*;
	import com.b99.data.prototype.Component;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class ComponentLogic extends Object
	{
		
		public function ComponentLogic(){}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									initialization
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		
		public static function initializeComponents():void
		{
			var xmlObj:XML = GameData.componentXML;
			var i:int;
			
			trace("\n+++++++++++++++++++   components   +++++++++++++++++++++\n")
			for (i = 0; i < xmlObj.bonus_list.bonus.length(); i++) 
			{
				ComponentData.bonusList.push(xmlObj.bonus_list.bonus[i]);
			}
			trace(ComponentData.bonusList);
			
			for (var j:int = 0; j < xmlObj.components.type.length(); j++) 
			{
				for (var k:int = 0; k < xmlObj.components.type[j].part.length(); k++) 
				{
					var generic:Component 		= new Component();
					generic.id 					= xmlObj.components.type[j].part[k].id;
					generic.type 				= xmlObj.components.type[j].part[k].type;
					generic.name 				= xmlObj.components.type[j].part[k].name;
					generic.level 				= xmlObj.components.type[j].part[k].level;
					generic.rarity 				= xmlObj.components.type[j].part[k].rarity;
					generic.weight 				= xmlObj.components.type[j].part[k].weight;
					generic.buyPrice 			= (xmlObj.components.type[j].part[k].buy) *10;
					generic.sellPrice 			= (xmlObj.components.type[j].part[k].sell)*5;
					generic.travelSpeed	 		= xmlObj.components.type[j].part[k].bonus.travel_speed;
					generic.crewCapacity 		= xmlObj.components.type[j].part[k].bonus.crew_capacity;
					generic.passengerCapacity 	= xmlObj.components.type[j].part[k].bonus.passenger_capacity;;
					generic.cargoCapacity 		= xmlObj.components.type[j].part[k].bonus.cargo_capacity;
					generic.weightCapacity 		= xmlObj.components.type[j].part[k].bonus.weight_capacity;
					generic.fuelCapacity 		= xmlObj.components.type[j].part[k].bonus.fuel_capacity;
					generic.fuelEfficiency 		= xmlObj.components.type[j].part[k].bonus.fuel_efficiency;
					generic.attack 				= xmlObj.components.type[j].part[k].bonus.attack_value;
					generic.defense 			= xmlObj.components.type[j].part[k].bonus.defense_value;
					generic.img					= xmlObj.components.type[j].part[k].img;
				

					ComponentData.allComponents.push(generic);
					
					switch (generic.type) 
					{
						case "quarters":
						{
							ComponentData.quartersComponents.push(generic);
							break;
						}
						case "cargo":
						{
							ComponentData.cargoComponents.push(generic);
							break;
						}
						case "balloon":
						{
							ComponentData.balloonComponents.push(generic);
							break;
						}
						case "fuel":
						{
							ComponentData.fuelComponents.push(generic);
							break;
						}
						case "engine":
						{
							ComponentData.engineComponents.push(generic);
							break;
						}
						case "wing":
						{
							ComponentData.wingComponents.push(generic);
							break;
						}
						case "weapon":
						{
							ComponentData.weaponComponents.push(generic);
							break;
						}
						case "armor":
						{
							ComponentData.armorComponents.push(generic);
							break;
						}
						
					}
				}
			}
			
			var tempComponent:Component;
			trace("\n+---------   Crew Components  	------------+\n");
			for (i = 0; i < ComponentData.quartersComponents.length; i++) 
			{
				tempComponent = ComponentData.quartersComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Cargo Components  	------------+\n");
			for (i = 0; i < ComponentData.cargoComponents.length;i++) 
			{
				tempComponent = ComponentData.cargoComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Balloon Components  ------------+\n");
			for (i = 0; i < ComponentData.balloonComponents.length;i++) 
			{
				tempComponent = ComponentData.balloonComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Fuel Components   ------------+\n");
			for (i = 0; i < ComponentData.fuelComponents.length;i++) 
			{
				tempComponent = ComponentData.fuelComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Engine Components   ------------+\n");
			for (i = 0; i < ComponentData.engineComponents.length;i++) 
			{
				tempComponent = ComponentData.engineComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Wing Components       ------------+\n");
			for (i = 0; i < ComponentData.wingComponents.length;i++) 
			{
				tempComponent = ComponentData.wingComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Weapon Components       ------------+\n");
			for (i = 0; i < ComponentData.weaponComponents.length;i++) 
			{
				tempComponent = ComponentData.weaponComponents[i];
				trace(tempComponent.info);
			}
			trace("\n+---------   Armor Components       ------------+\n");
			for (i = 0; i < ComponentData.armorComponents.length;i++) 
			{
				tempComponent = ComponentData.armorComponents[i];
				trace(tempComponent.info);
			}
			
			trace("\n+++++++++++++++++++ end components +++++++++++++++++++++\n")
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy and sell
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		public static function buildAvailableComponents():void
		{
			ComponentData.availableComponents.splice(0,ComponentData.availableComponents.length);
			
			
			trace("\n+++++++++++++++++++++++++++ available components ++++++++++++++++++++++++++++\n");
			ComponentData.availableComponents.push(		randomComponent(AirshipData.quarters)		);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.cargoHold)		);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.balloon)		);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.fuelTank)		);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.engine)			);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.wing)			);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.weapon)			);
			ComponentData.availableComponents.push(		randomComponent(AirshipData.armor)			);
			
			
			for (var i:int = 0; i < ComponentData.availableComponents.length;i++) 
			{
				trace(Component(ComponentData.availableComponents[i]).info);
			}
			trace("\n+++++++++++++++++++++++++++ available components ++++++++++++++++++++++++++++\n");
		}
		
		private static function randomComponent(component:Component):Component
		{
			var currentLevel		:Number		= component.level;
			var targetLevel			:uint;
			
			
			if (currentLevel == 3) 
			{
				targetLevel = 3;
			}
			else
			{
				targetLevel = currentLevel + 1;
			}
			
			var availableForType	:Array		= new Array();
			
			switch (component.type) 
			{
				case "quarters":
				{
					availableForType = ComponentData.quartersComponents;
					break;
				}
				case "cargo":
				{
					availableForType = ComponentData.cargoComponents;
					break;
				}
				case "balloon":
				{
					availableForType = ComponentData.balloonComponents;
					break;
				}
				case "fuel":
				{
					availableForType = ComponentData.fuelComponents;
					break;
				}
				case "engine":
				{
					availableForType = ComponentData.engineComponents;
					break;
				}
				case "wing":
				{
					availableForType = ComponentData.wingComponents;
					break;
				}
				case "weapon":
				{
					availableForType = ComponentData.weaponComponents;
					break;
				}
				case "armor":
				{
					availableForType = ComponentData.armorComponents;
					break;
				}
			}
			
			var tempCommon		:Component;
			var tempUncommon	:Component;
			var tempRare		:Component;
			
			//var availableForLevel	:Array 		= new Array();
			
			for (var i:int = 0; i < availableForType.length; i++) 
			{
				var tempComponent:Component = Component(availableForType[i]);
			
				if (tempComponent.level == targetLevel) 
				{	
					//availableForLevel.push(tempComponent);
					if (tempComponent.rarity == "common") 
					{
						tempCommon 		= tempComponent;
					}
					if (tempComponent.rarity == "uncommon") 
					{
						tempUncommon 	= tempComponent;
					}
					if (tempComponent.rarity == "rare") 
					{
						tempRare	 	= tempComponent;
					}
				}
			}
			
			var ranNum			:uint = GameLogic.randRange(0, 100);
			var targetComponent	:Component;
			
			if (ranNum <= 25) 
			{
				targetComponent = new Component();
				targetComponent.type = component.type;
				targetComponent.note = "Not Available";
			}
			else if (ranNum >= 26 && ranNum <= 75) 
			{
				targetComponent = tempCommon;
			}
			else if (ranNum >= 76 && ranNum <= 90) 
			{
				targetComponent = tempUncommon;
			}
			else if (ranNum >= 91) 
			{
				targetComponent = tempRare;
			}
			
			availableForType 	= null;
			tempCommon			= null;
			tempUncommon		= null;
			tempRare			= null;
			
			return targetComponent;
		}
	}
}
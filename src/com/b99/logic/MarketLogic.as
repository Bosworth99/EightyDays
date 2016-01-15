package com.b99.logic 
{
	import com.b99.app.*;
	import com.b99.data.*;
	import com.b99.data.prototype.*;
	import com.b99.display.composite.QuantityPane;
	import com.b99.event.GameEvent;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class MarketLogic extends Object
	{
		
		private static var _fuel :Commodity;
		
		public function MarketLogic() {}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									initialization
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		


		//initialize market @ commodityLogic, as I do with ComponentLogic??
		//will require some reworking
		
		public static function initializeMarket():void
		{
			_fuel	= new Commodity();
			with (_fuel) 
			{
				name 	= "fuel";
				rarity 	= "common";
				volume 	= "1";
				weight 	= "3.0";
				minMax	= [1.00, 4.00];
				note	= "this is fuel"
			}
			MarketData.fuel = _fuel;
			
			var xmlObj:XML = GameData.commodityXML;
			for (var i:int = 0; i < xmlObj.commodity.length(); i++) 
			{
				var generic:Commodity = new Commodity();
				generic.name 	= xmlObj.commodity[i].name;
				generic.rarity 	= xmlObj.commodity[i].rarity;
				generic.volume 	= xmlObj.commodity[i].volume;
				generic.weight 	= xmlObj.commodity[i].weight;
				generic.minMax	= [xmlObj.commodity[i].min_price, xmlObj.commodity[i].max_price];
				generic.img		= xmlObj.commodity[i].img;
				generic.note	= "note added"
				
				MarketData.allCommodities.push(generic);
				
				switch (generic.rarity) 
				{
					case "common":
					{
						MarketData.commonCommodities.push(generic);
						break;
					}
					case "uncommon":
					{
						MarketData.uncommonCommodities.push(generic);
						break;
					}
					case "rare":
					{
						MarketData.rareCommodities.push(generic);
						break;
					}
				}
			}
			
			trace("\n+++++++++++++++++++++++++++++++++++++++++\n");
			trace("This here be the available commodities:");
			var tempCommodity:Commodity
			trace("\n+---------   Common Commodities  ------------+\n");
			for (var k:int = 0; k < MarketData.commonCommodities.length; k++) 
			{
				tempCommodity = MarketData.commonCommodities[k];
				trace(tempCommodity.info);
			}

			trace("\n+---------   Uncommon Commodities  ------------+\n");
			for (var l:int = 0; l < MarketData.uncommonCommodities.length; l++) 
			{
				tempCommodity = MarketData.uncommonCommodities[l];
				trace(tempCommodity.info);
			}
			
			trace("\n+---------   Rare Commodities  ------------+\n");
			for (var m:int = 0; m < MarketData.rareCommodities.length; m++) 
			{
				tempCommodity = MarketData.rareCommodities[m];
				trace(tempCommodity.info);
			}
			trace("+++++++++++++++++++++++++++++++++++++++++\n");
	
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buildMarketplace
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			

		public static function buildMarket(type:String):void
		{
			//reset current market array
			MarketData.currentMarket.splice(0, MarketData.currentMarket.length);
			
			//define how many commodities are in the current market
			var marketMax		:uint;
			switch (type) 
			{
				case "city":
				{
					marketMax = GameLogic.randRange(8, 12);
					break;
				}
				case "town":
				{
					marketMax = GameLogic.randRange(4,6); 
					break;
				}
			}
			trace("\n+++++++++++++++  current marketplace  +++++++++++++++++++++");
			
			var tempMarket		:Array 	= new Array();
			var tempCommon		:Array 	= new Array();
			var tempUncommon	:Array 	= new Array();	
			var tempRare		:Array	= new Array();
			
			var index			:uint;
			var commodity		:Commodity;
			
			//set current price for all commodities in all arrays
			for (var k:int = 0; k < MarketData.commonCommodities.length; k++) 
			{
				commodity = MarketData.commonCommodities[k] as Commodity;
				commodity.currentPrice = commodity.minMax[1] - (Math.random() * (commodity.minMax[1] - commodity.minMax[0])); 
				commodity.history.push(commodity.currentPrice);
				
				tempCommon.push(MarketData.commonCommodities[k]);
			}
			for (var l:int = 0; l < MarketData.uncommonCommodities.length; l++) 
			{
				commodity = MarketData.uncommonCommodities[l] as Commodity;
				commodity.currentPrice = commodity.minMax[1] - (Math.random() * (commodity.minMax[1] - commodity.minMax[0])); 
				commodity.history.push(commodity.currentPrice);
				
				tempUncommon.push(MarketData.uncommonCommodities[l]);
			}
			for (var m:int = 0; m < MarketData.rareCommodities.length; m++) 
			{
				commodity = MarketData.rareCommodities[m] as Commodity;
				commodity.currentPrice = commodity.minMax[1] - (Math.random() * (commodity.minMax[1] - commodity.minMax[0])); 
				commodity.history.push(commodity.currentPrice);
				
				tempRare.push(MarketData.rareCommodities[m]);
			}
			
			//fill tempmarket with selection of array items equal to marketmax
			//if index is selected from temp array, remove it (ensureing unique selections)
				
			for (var i:int = 0; i < marketMax; i++) 
			{
				var ranNum: uint = GameLogic.randRange(0, 100);
				if (ranNum <= 50) 
				{
					index		= GameLogic.randRange(0, tempCommon.length - 1);
					commodity	= tempCommon[index];

					tempCommon.splice(index, 1);
				}
				else if (ranNum >= 51 && ranNum <= 85 )
				{
					index		= GameLogic.randRange(0, tempUncommon.length - 1);
					commodity	= tempUncommon[index];

					tempUncommon.splice(index, 1);
				}
				else if (ranNum >= 86)
				{
					index		= GameLogic.randRange(0, tempRare.length - 1);
					commodity	= tempRare[index];
						
					tempRare.splice(index, 1);
				}
				tempMarket.push(commodity);
			}
			
			tempMarket.sort();
			//push tempMarket to the current market
			for (var j:int = 0; j < tempMarket.length; j++) 
			{
				MarketData.currentMarket.push(tempMarket[j]);
			}
			
			//set sell price of all commodities ( apppy rarity bonus if commodity is not available)
			for (var h:int = 0; h < MarketData.allCommodities.length; h++) 
			{
				MarketData.allCommodities[h].sellPrice = MarketLogic.setSellPrice(MarketData.allCommodities[h]);
			}
			
			//kill temp arrays
			tempCommon 		= null;
			tempUncommon	= null; 
			tempRare 		= null;
			tempMarket 		= null;
			
			trace("market selected for "+type+":");
			for (var n:int = 0; n < MarketData.currentMarket.length; n++) 
			{
				var tempCommodity:Commodity = MarketData.currentMarket[n];
				trace(tempCommodity.info);
			}
			trace("\n+++++++++++++++  end current marketplace  ++++++++++++++++");
		}		
		
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buy and sell
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public static function purchaseCommodity(tempCommodity:Commodity):void
		{
			//run initial test on available cash and volue vs a single commodity
			if ( GameData.cash - tempCommodity.currentPrice  <= 0 || AirshipData.cargoCurrent + tempCommodity.volume >= AirshipData.cargoCapacity)
			{
				GameControl.updateGameLog("You can't purchase any "+ tempCommodity.name +", sir. Sell something?!");
			}
			else
			{
				Main.display.events.addQuanityPane(tempCommodity, "purchase");
			}
		}
		
		public static function sellCommodity(tempCommodity:Commodity):void
		{
			Main.display.events.addQuanityPane(tempCommodity, "sell");
		}

		public static function purchaseFuel():void
		{
			if (!GameData.isTraveling) 
			{
				if ( AirshipData.fuelCurrent + MarketData.fuel.volume <= AirshipData.fuelCapacity) 
				{
					var tempCash:int = GameData.cash - MarketData.fuel.currentPrice;
					if (tempCash <= 0) 
					{
						GameControl.updateGameLog("Awe, you're broke. Might I recommend selling something?");
					} 
					else 
					{
						Main.display.events.addQuanityPane(MarketData.fuel, "purchase", true);
					}
				} 
				else 
				{
					GameControl.updateGameLog("Your tanks are full, buddy");
				}
			} 
			else 
			{
				GameControl.updateGameLog("You can't buy fuel whilst traveling");
			}
		}
		
		public static function fuelPurchased(quantity:uint):void
		{
			GameControl.fuelPurchased(quantity);
		}
		

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									assign random prices
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				

		public static function setFuelPrice():void
		{
			MarketData.fuel.currentPrice = MarketData.fuel.minMax[1] - (Math.random() * (MarketData.fuel.minMax[1] - MarketData.fuel.minMax[0]));
		}
		
		private static function setSellPrice(commodity:Commodity):Number
		{
			var sellPrice:Number;
			var index:int = MarketData.currentMarket.indexOf(commodity, 0);
			
			// if item does not show up in an indexOf check - it returns "-1"
			if (index < 0) 
			{
				switch (commodity.rarity) 
				{
					case "rare": 
					{
						sellPrice = commodity.currentPrice * 1.2;
						break;
					}
					case "uncommon": 
					{
						sellPrice = commodity.currentPrice * 1.1;
						break;
					}
					case "common": 
					{
						sellPrice = commodity.currentPrice * 1.05;
						break;
					}
				}
			}
			else
			{
				switch (commodity.rarity) 
				{
					case "rare": 
					{
						sellPrice = commodity.currentPrice * .90;
						break;
					}
					case "uncommon": 
					{
						sellPrice = commodity.currentPrice * .80;
						break;
					}
					case "common": 
					{
						sellPrice = commodity.currentPrice * .70;
						break;
					}
				}
			}
			return sellPrice;
		}		
		
	}
}
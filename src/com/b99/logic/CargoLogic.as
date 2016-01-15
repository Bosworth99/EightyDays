package com.b99.logic 
{
	import com.b99.app.GameControl;
	import com.b99.data.*;
	import com.b99.data.prototype.Commodity;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CargoLogic extends Object
	{	
		public function CargoLogic(){}
		
		public static function initializeCargo():void
		{
			for (var i:int = 0; i < MarketData.allCommodities.length; i++) 
			{
				CargoData.cargoQuantities.push(0);
			}
		}
		
		public static function updateVolume():void
		{
			var tempVolume 		:int = 0;
			var tempCommodity	:Commodity;
			
			for (var i:int = 0; i < MarketData.allCommodities.length; i++) 
			{
				tempCommodity = MarketData.allCommodities[i];
				tempVolume += (tempCommodity.volume * CargoData.cargoQuantities[i]);
			}
			
			AirshipData.cargoCurrent = tempVolume;	
		}
		
		public static function addCargo(commodity:Commodity, quantity:uint):void
		{
			var index:uint = MarketData.allCommodities.indexOf(commodity, 0);
			var currentVolume:uint = commodity.volume * quantity;
			
			CargoData.cargoQuantities[index] += quantity;		
			CargoLogic.updateVolume();
			GameControl.commodityPurchased(commodity, quantity, CargoData.cargoQuantities[index]);
		}
		
		public static function removeCargo(commodity:Commodity, quantity:uint):void
		{
			var index:uint = MarketData.allCommodities.indexOf(commodity, 0);	
			var currentVolume:uint = commodity.volume * quantity;

			CargoData.cargoQuantities[index] -= quantity;		
			CargoLogic.updateVolume();
			
			GameControl.commoditySold(commodity, quantity, CargoData.cargoQuantities[index]);
		}
		
	}
}
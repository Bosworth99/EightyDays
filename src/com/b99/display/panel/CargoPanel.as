package com.b99.display.panel
{
	import com.b99.data.*;
	import com.b99.data.prototype.*;
	import com.b99.display.composite.*;
	import com.b99.display.element.*;
	import com.b99.display.prototype.CashButton;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CargoPanel extends Sprite implements Ipanel
	{
		private var _canvas			:Sprite;
		private var _base			:Sprite;
		private var _frameTop		:Sprite;
		private var _cargoCon		:Sprite
		
		private var _sellButtons	:Array = new Array();
		private var _cargo_title	:TextFieldFormat;
		
		public function CargoPanel() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);

			_base = new GFX_Panel();
			_canvas.addChild(_base);
			
			_frameTop 	= new GFX_FrameTop()
			_frameTop.y = -30;
			_canvas.addChild(_frameTop);
			
			_cargoCon = new Sprite();
			with (_cargoCon) 
			{
				x = 60;
				y = 26;
			}
			_canvas.addChild(_cargoCon);
			
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									the cargo hold
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		public function updateCargo():void
		{
			if (_cargoCon.numChildren > 0) 
			{
				killList();
				tempCargos 		= null;
				tempQuantities 	= null;
			}
			
			var tempCargos		:Array = new Array();
			var tempQuantities 	:Array = new Array();
			for (var k:int = 0; k < MarketData.allCommodities.length; k++) 
			{
				if (CargoData.cargoQuantities[k] != 0) 
				{
					tempCargos.push		(MarketData.allCommodities[k]);
					tempQuantities.push	(CargoData.cargoQuantities[k]);
				}
			}

			_cargo_title = new TextFieldFormat("Cargo Hold Inventory:",0x000000,18,"verdana",20,40);
			with (_cargo_title) 
			{
				x 		= 0;
				y		= 10;
			}
			_cargoCon.addChild(_cargo_title);
			
			for (var i:int = 0; i < tempCargos.length; i++) 
			{
				var tempCommodity	:Commodity 	= tempCargos[i];
				var tempQuantity	:uint 		= tempQuantities[i];
				var tempColor		:uint;
				
				var commodityName	:TextFieldFormat;
				var sellPrice		:TextFieldFormat;
				var quantity 		:TextFieldFormat;
				var cashButton		:CashButton;
				var line			:Sprite;
				
				switch (tempCommodity.rarity) 
				{
					case "rare":
					{
						tempColor = 0xFF2B2B;
						break;
					}
					case "uncommon":
					{
						tempColor = 0xE9EE06;
						break;
					}
					case "common":
					{
						tempColor = 0xFFFFFF;
						break;
					}
				}
				
				line = new GFX_marketLine();
				with (line ) 
				{
					x = -10;
					y = (_cargo_title.y + 30) + (i * 35);
				}
				_cargoCon.addChild(line);
				
				commodityName = new TextFieldFormat(tempCommodity.name, tempColor, 16, "verdana");
				with (commodityName) 
				{
					x = 0;
					y = (_cargo_title.y + 40) + (i * 35);
				}
				_cargoCon.addChild(commodityName);
				
				quantity = new TextFieldFormat("x "+tempQuantity.toString(), 0x000000, 14, "verdana");
				with (quantity) 
				{
					x = 80;
					y = commodityName.y + 2;
				}
				_cargoCon.addChild(quantity);
				
				sellPrice = new TextFieldFormat("sell $"+ tempCommodity.sellPrice.toFixed(2), 0x000000, 14, "verdana");
				with (sellPrice) 
				{
					x = 150;
					y = commodityName.y + 2;
				}
				_cargoCon.addChild(sellPrice);

				cashButton = new CashButton(tempCommodity, "sell");
				with (cashButton) 
				{
					x = 260;
					y = commodityName.y -1;
				}
				_cargoCon.addChild(cashButton);
				
				_sellButtons.push(cashButton);
			}
		}
		
		private function killList():void
		{
			for (var j:int = 0; j < _sellButtons.length; j++) 
				{
				var temp:CashButton = _sellButtons[j] as CashButton;
				temp.removeEventHandler();
			}
				
			while (_cargoCon.numChildren > 0)
			{
				var tempObj:DisplayObject = _cargoCon.getChildAt(0);
				_cargoCon.removeChildAt(0);
				tempObj = null;
			}
		}
		
	}
}
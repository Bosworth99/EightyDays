package com.b99.display.panel
{
	import com.b99.app.GameControl;
	import com.b99.data.*;
	import com.b99.data.prototype.*;
	import com.b99.display.composite.*;
	import com.b99.display.element.*;
	import com.b99.display.prototype.CashButton;
	import com.b99.display.prototype.CommodityBlock;
	import com.b99.display.prototype.SimpleMessageFlyout;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class MarketPanel extends Sprite  implements Ipanel
	{
		private var _canvas				:Sprite;
		private var _back				:Sprite;
		
		private var _frame				:CustomRoundRectGrad;
		
		private var _base				:Sprite;
		private var _mask				:Sprite;
		
		private var _marketCon			:Sprite;
		private var _marketTitle		:TextFieldFormat;
		private var _commodityBlock		:CommodityBlock;
		private var _commodityBlocks	:Array = new Array();
		
		private var _cargoCon			:Sprite;
		private var _cargoTitle			:TextFieldFormat;
		private var _cargoBlock			:CommodityBlock;
		private var _cargoBlocks		:Array = new Array();
		
		//temp solution
		
		private var _buyButton			:SimpleMessageFlyout;
		private var _sellButton			:SimpleMessageFlyout;
		private var _closeButton		:SimpleMessageFlyout;
		
		private var _marketUp			:Boolean;
		
		public function MarketPanel() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			addEventHandlers();
			
			_marketUp = true;
		}

		private function assembleDisplayObjects():void
		{
			_canvas 	= new Sprite();
			this.addChild(_canvas);
				
			_back		= new Sprite();
			with (_back) 
			{
				graphics.beginFill(0x000000, .5);
				graphics.drawRect(0, 0, 860, 500);
				graphics.endFill();
				
				buttonMode 		= false;
				mouseEnabled	= true;
			}
			_canvas.addChild(_back);
			
			_base 		= new GFX_Panel();
			_canvas.addChild(_base);
			
			_mask 		= new Sprite();
			with (_mask) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRoundRect(60, 40, 740, 420, 20, 20);
				graphics.endFill();
			}
			_canvas.addChild(_mask);
			_base.mask =_mask;
			
			_marketCon = new Sprite();
			with (_marketCon) 
			{
				x = 90;
				y = 110;
			}
			_canvas.addChild(_marketCon);
			
			_marketTitle = new TextFieldFormat("The Market", GameData.COLOR_TEXT, 20, "verdana", 20, 50);
			with (_marketTitle) 
			{
				x = 280;
				y = -30;
			}
			_marketCon.addChild(_marketTitle);
			
			_cargoCon = new Sprite();
			with (_cargoCon) 
			{
				x = 90;
				y = 110;
			}
			
			_cargoTitle = new TextFieldFormat("Your Cargo", GameData.COLOR_TEXT, 20, "verdana", 20, 50);
			with (_cargoTitle) 
			{
				x = 280;
				y = -30;
			}
			_cargoCon.addChild(_cargoTitle);
			
			_frame 	= new CustomRoundRectGrad(740, 420, 20, "linear", [0x000000], [0], [1], 270, 3, GameData.COLOR_TEXT, 1);
			with (_frame) 
			{
				x 	= 60;
				y	= 40;
				mouseEnabled 	= false;
				buttonMode 		= false;
				mouseChildren	= false;
			}
			_canvas.addChild(_frame);
			
			//temp buttons
			_buyButton = new SimpleMessageFlyout("Market", 90);
			with (_buyButton) 
			{
				x 				= 100;
				y 				= 30;
				buttonMode 		= true;
				mouseEnabled 	= true;
			}
			_canvas.addChild(_buyButton);
			
			_sellButton = new SimpleMessageFlyout("Cargo", 80);
			with (_sellButton) 
			{
				x 				= 200;
				y 				= 30;
				buttonMode 		= true;
				mouseEnabled 	= true;
			}
			_canvas.addChild(_sellButton);
			
			_closeButton = new SimpleMessageFlyout("Close", 70);
			with (_closeButton) 
			{
				x 				= 720;
				y 				= 30;
				buttonMode 		= true;
				mouseEnabled 	= true;
			}
			_canvas.addChild(_closeButton);
			
		}
	
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buttons
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		private function addEventHandlers():void
		{
			_sellButton.addEventListener(MouseEvent.MOUSE_DOWN, 	sellDown, 	false, 0, true);
			_closeButton.addEventListener(MouseEvent.MOUSE_DOWN, 	closeDown, 	false, 0, true);
			_buyButton.alpha = .5;
		}

		private function buyDown(e:MouseEvent = null):void 
		{
			_buyButton.removeEventListener(MouseEvent.MOUSE_DOWN, 	buyDown);
			_sellButton.addEventListener(MouseEvent.MOUSE_DOWN,  	sellDown, 	false, 0, true);
			
			_sellButton.alpha = 1;
			_buyButton.alpha = .5;
			
			var tempIndex: uint = _canvas.getChildIndex(_cargoCon);
			_canvas.removeChildAt(tempIndex);
			_canvas.addChildAt(_marketCon, tempIndex);
		
			_marketUp = true;
		}
		
		private function sellDown(e:MouseEvent):void 
		{
			_sellButton.removeEventListener(MouseEvent.MOUSE_DOWN,  sellDown);
			_buyButton.addEventListener(MouseEvent.MOUSE_DOWN, 		buyDown, 	false, 0, true);
			
			_sellButton.alpha = .5;
			_buyButton.alpha = 1;
			
			var tempIndex: uint = _canvas.getChildIndex(_marketCon);
			_canvas.removeChildAt(tempIndex);
			_canvas.addChildAt(_cargoCon, tempIndex);
			
			_marketUp = false;
		}

		private function closeDown(e:MouseEvent):void 
		{
			_buyButton.removeEventListener(MouseEvent.MOUSE_DOWN, 	buyDown);
			_sellButton.removeEventListener(MouseEvent.MOUSE_DOWN,  sellDown);
			_closeButton.removeEventListener(MouseEvent.MOUSE_DOWN, closeDown);
			
			GameControl.removeOverlayPanel();
		}
		
		public function reactivate():void
		{
			addEventHandlers();
			
			if (!_marketUp) 
			{
				buyDown();
			}
		}
		
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									market list
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
		
		public function buildMarket():void
		{	
			destroyMarket();
			
			var countY:uint = 0;
			for (var i:int = 0; i < MarketData.currentMarket.length; i++) 
			{
				var tempCommodity:CommodityBlock = new CommodityBlock(MarketData.currentMarket[i] as Commodity, "buy");
				
				if (i >= 6) 
				{
					tempCommodity.x = 375;
				}
				else
				{
					tempCommodity.x = 0;
				}
				if (countY >=  6) 
				{
					countY = 0;
					tempCommodity.y = countY * 55;
				} 
				else 
				{
					tempCommodity.y = countY * 55;
				}
				countY ++;
				
				_marketCon.addChild(tempCommodity);
				
				_commodityBlocks.push(tempCommodity);
			}
		}
		
		private function destroyMarket():void
		{	
			for (var i:int = 0; i < _commodityBlocks.length; i++) 
			{
				var tempObj:CommodityBlock = _commodityBlocks[i] as CommodityBlock;
				tempObj.destroy();
				tempObj = null;
			}
			_commodityBlocks.splice(0, _commodityBlocks.length);
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									cargo list
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function updateCargo():void
		{
			destroyCargo();
			
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
			
			var countY:uint = 0;
			for (var i:int = 0; i < tempCargos.length; i++) 
			{
				var tempCommodity:CommodityBlock = new CommodityBlock(tempCargos[i],"sell",tempQuantities[i]);
				
				if (i >= 6) 
				{
					tempCommodity.x = 375;
				}
				else
				{
					tempCommodity.x = 0;
				}
				if (countY >=  6) 
				{
					countY = 0;
					tempCommodity.y = countY * 55;
				} 
				else 
				{
					tempCommodity.y = countY * 55;
				}
				countY ++;
				
				_cargoCon.addChild(tempCommodity);
				
				_cargoBlocks.push(tempCommodity);
				
			}
			
			tempCargos.splice(0, tempCargos.length);
			tempCargos 		= null;
			tempQuantities.splice(0, tempQuantities.length);
			tempQuantities 	= null;
		}

		private function destroyCargo():void
		{	
			for (var i:int = 0; i < _cargoBlocks.length; i++) 
			{
				var tempObj:CommodityBlock = _cargoBlocks[i] as CommodityBlock;
				tempObj.destroy();
				tempObj = null;
			}
			_cargoBlocks.splice(0, _cargoBlocks.length);
		}
		
	}
}
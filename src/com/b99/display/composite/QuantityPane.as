package com.b99.display.composite 
{
	import com.b99.app.GameControl;
	import com.b99.data.*;
	import com.b99.data.prototype.*;
	import com.b99.data.util.DataLoader;
	import com.b99.display.element.*;
	import com.b99.logic.CargoLogic;
	import com.b99.logic.MarketLogic;
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class QuantityPane extends Sprite
	{
		private var _intent				:String;
		
		private var _canvas				:Sprite;
		private var _background			:CustomRoundRectGrad;
		private var _dataContainer		:Sprite;
		private var _quanityPanel 		:Sprite;
		private var _handle				:Sprite;
		private var _handleContstrain	:Rectangle;
		
		private var _transactionBtn		:ImgButton;
		private var _txt_intent			:TextFieldFormat;
	
		private var _tempCommodity		:Commodity;
		private var _commodityName		:DataField;
		private var _commodityColor		:uint;
		
		private var _currentPrice		:DataField;
		private var _currentWeight		:DataField;
		private var _currentVolume		:DataField;
		private var _currentQuantity	:DataField;
		
		private var _availableQuantity	:TextFieldFormat;
		private var _initialQuanity		:TextFieldFormat;

		private var _totalAvailble		:uint;
		private var _tempPrice			:Number;
		private var _tempWeight			:Number;
		private var _tempVolume			:Number;
		
		private var _quantity			:uint = 1;
		private var _fuel				:Boolean;
		
		
		public function QuantityPane(tempCommodity:Commodity, intent:String, fuel:Boolean) 
		{
			super();
			trace("setting quantity for " +tempCommodity.name);
			_tempCommodity  = tempCommodity;
			_intent			= intent;
			_fuel 			= fuel;
			
			if (_intent == "purchase") 
			{
				_tempPrice 	 	= _tempCommodity.currentPrice;
			}
			else
			{
				_tempPrice 	 	= _tempCommodity.sellPrice;
			}
			
			_tempVolume		= _tempCommodity.volume;
			_tempWeight		= _tempCommodity.weight;
				
			switch (_tempCommodity.rarity) 
				{
					case "rare":
					{
						_commodityColor = 0x402BFF;
						break;
					}
					case "uncommon":
					{
						_commodityColor = 0xE9EE06;
						break;
					}
					case "common":
					{
						_commodityColor = 0xFFFFFF;
						break;
					}
				}
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			setTotalAvailable();
			addEventHandlers();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas 			= new Sprite;
			this.addChild(_canvas);
			
			_background 		= new CustomRoundRectGrad(GameData.stageW, GameData.stageH, 0, "linear", [0x000000], [.4], [1], 90);
			with (_background) 
			{
				mouseEnabled 	= true;
				buttonMode  	= false;
			}
			_canvas.addChild(_background);

			//+++++++++++++++ graphics
			_quanityPanel 		= new GFX_QuantityPanel();
			with (_quanityPanel) 
			{
				x = (GameData.stageW / 2) - (_quanityPanel.width / 2);
				y = 150;
			}
			_canvas.addChild(_quanityPanel)
			
			_handle				= new GFX_QuantityHand();
			with (_handle) 
			{
				x 				= _quanityPanel.x + 120;
				y 				= 420;
				buttonMode 		= true;
				mouseEnabled	= true;
			}
			_canvas.addChild(_handle);
			_handleContstrain 	= new Rectangle(_quanityPanel.x + 120, 420, 355, 0);
			
			_dataContainer 		= new Sprite();
			_canvas.addChild(_dataContainer);
			
			//+++++++++++++++ data
			_commodityName 		= new DataField(25, 140, "Goods:", _tempCommodity.name.toUpperCase(), 0x4E5324, 50 );
			with (_commodityName) 
			{
				x 				= _quanityPanel.x + 80;
				y 				= _quanityPanel.y + 80;
			}
			_dataContainer.addChild(_commodityName);
			
			_currentPrice		= new DataField(25, 140, "Price:", _tempPrice.toFixed(2), 0x4E5324, 55 );
			with (_currentPrice) 
			{
				x 				= (_commodityName.x + _commodityName.width) + 10;
				y 				= _commodityName.y;
			}
			_dataContainer.addChild(_currentPrice);
			
			_currentWeight		= new DataField(25, 140, "Weight:", _tempWeight.toFixed(2), 0x4E5324, 50 );
			with (_currentWeight) 
			{
				x 				= _commodityName.x;
				y 				= (_commodityName.y + _commodityName.height) + 10;
			}
			_dataContainer.addChild(_currentWeight);
			
			_currentVolume		= new DataField(25, 140, "Volume:", _tempVolume.toFixed(2), 0x4E5324, 55  );
			with (_currentVolume) 
			{
				x 				= (_commodityName.x + _commodityName.width) + 10;
				y 				= (_commodityName.y + _commodityName.height) + 10;
			}
			_dataContainer.addChild(_currentVolume);
			
			_currentQuantity	= new DataField(25, 140, "Quantity:", _quantity.toString(), 0x4E5324, 80 );
			with (_currentQuantity) 
			{
				x 				= (_currentPrice.x + _currentPrice.width) + 10;
				y 				= _commodityName.y;
			}
			_dataContainer.addChild(_currentQuantity);

			_initialQuanity		= new TextFieldFormat("0", 0xFFFFFF, 16, "verdana", 30, 40);
			with (_initialQuanity) 
			{
				x 				= _quanityPanel.x + 70;
				y				= 354;
			}
			_dataContainer.addChild(_initialQuanity);
			
			_availableQuantity = new TextFieldFormat("100", 0xFFFFFF, 16, "verdana", 30, 40);
			with (_availableQuantity) 
			{
				x 				= _quanityPanel.x + 500;
				y				= 354;
			}
			_dataContainer.addChild(_availableQuantity);

			if (_intent == "purchase") 
			{
				_txt_intent = new TextFieldFormat("Purchase", 0xFFFFFF , 16, "verdana", 30, 40);
				with (_txt_intent) 
				{
					x 			= _quanityPanel.x + 438;
					y			= _quanityPanel.y + 132;
				}
				_dataContainer.addChild(_txt_intent);
				
			}
			else 
			{
				_txt_intent = new TextFieldFormat("Sell", 0xFFFFFF , 16, "verdana", 30, 40);
				with (_txt_intent) 
				{
					x 			= _quanityPanel.x + 438;
					y			= _quanityPanel.y + 132;
				}
				_dataContainer.addChild(_txt_intent);
				
			}
			
			_transactionBtn = new ImgButton("cash");
			with (_transactionBtn) 
			{
				x				= _quanityPanel.x + 400;
				y 				= _quanityPanel.y + 130;
			}
			_dataContainer.addChild(_transactionBtn);	
	
		}
		
		private function setTotalAvailable():void
		{
			if (_intent == "purchase") 
			{
				var totalByCost		:Number = Math.floor( GameData.cash / _tempCommodity.currentPrice );;
				var totalByVolume	:Number;
				
				//test if fuel is the target commodity
				if (_fuel) 
				{
					totalByVolume	= Math.floor( (AirshipData.fuelCapacity - AirshipData.fuelCurrent) / _tempCommodity.volume );
					//figure weight the same way
				}
				else
				{
					totalByVolume	= Math.floor( (AirshipData.cargoCapacity - AirshipData.cargoCurrent) / _tempCommodity.volume );
					//figure weight the same way
				}
				
				if (totalByCost < totalByVolume) 
				{
					_totalAvailble = totalByCost;
				} 
				else 
				{
					_totalAvailble = totalByVolume;
				}
			}
			else
			{
				var tempIndex:uint = MarketData.allCommodities.indexOf(_tempCommodity);
				_totalAvailble = CargoData.cargoQuantities[tempIndex];
			}
			
			_availableQuantity.set_text = _totalAvailble.toString();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									events 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
			
		
		private function addEventHandlers():void
		{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, handleDown, false, 0, true);
			_handle.addEventListener(MouseEvent.MOUSE_UP,	handleUp,   false, 0, true);
			_handle.addEventListener(MouseEvent.MOUSE_OUT,	handleUp,   false, 0, true);
			
			_transactionBtn.addEventListener(MouseEvent.MOUSE_DOWN, transactionDown, false, 0, true);
		}
		
		
		private function handleDown(e:MouseEvent):void 
		{
			_canvas.addEventListener(Event.ENTER_FRAME, updateData, false, 0, true);
			_handle.startDrag(true, _handleContstrain);
		}

		private function handleUp(e:MouseEvent):void 
		{
			_canvas.removeEventListener(Event.ENTER_FRAME, updateData);
			_handle.stopDrag();
		}
		
		private function updateData(e:Event):void 
		{
			var handleRatio:Number = (_handle.x - (_quanityPanel.x + 120)) / _handleContstrain.width;
			
			_quantity = Math.round(_totalAvailble * handleRatio);
			
			_currentQuantity.setData	(_quantity.toString());
			_currentWeight.setData		( (_tempCommodity.weight * _quantity).toFixed(2));
			_currentVolume.setData		( (_tempCommodity.volume * _quantity).toFixed(2));
			
			if (_intent == "purchase") 
			{
				_currentPrice.setData	( (_tempCommodity.currentPrice * _quantity).toFixed(2));
			}
			else
			{
				_currentPrice.setData	( (_tempCommodity.sellPrice * _quantity).toFixed(2));
			}
			
		}
		
		private function transactionDown(e:MouseEvent):void 
		{
			_canvas.removeEventListener(Event.ENTER_FRAME, updateData);
			_handle.stopDrag();
			
			_handle.removeEventListener(MouseEvent.MOUSE_DOWN,	handleDown);
			_handle.removeEventListener(MouseEvent.MOUSE_UP,	handleUp);
			_handle.addEventListener(MouseEvent.MOUSE_OUT,		handleUp);
			_transactionBtn.removeEventListener(MouseEvent.MOUSE_DOWN, transactionDown);
			
			if (_intent == "purchase") 
			{
				if (_fuel) 
				{
					MarketLogic.fuelPurchased(_quantity);
				}
				else
				{
					CargoLogic.addCargo(_tempCommodity, _quantity);
				}
			}
			else
			{
				CargoLogic.removeCargo(_tempCommodity, _quantity);
			}
		}

		public function destroy():void
		{
			with (_dataContainer) 
			{
				removeChild(_commodityName);
				removeChild(_currentPrice);
				removeChild(_currentWeight);
				removeChild(_currentVolume);
				removeChild(_currentQuantity);
			}
			_handleContstrain 	= null;
			_transactionBtn.	destroy();
			_transactionBtn 	= null;
			_tempCommodity 		= null;
			_commodityName 		= null;
			_currentPrice 		= null;
			_currentWeight 		= null;
			_currentVolume 		= null;
			_currentQuantity 	= null;
			_availableQuantity.	destroy();
			_availableQuantity 	= null;
			_initialQuanity.	destroy();
			_initialQuanity		= null;
			_txt_intent.		destroy();
			_txt_intent			= null;
			
			with (_canvas) 
			{
				removeChild(_handle);
				removeChild(_quanityPanel);
				removeChild(_dataContainer);
			}
			_handle				= null;
			_quanityPanel		= null;
			_dataContainer		= null;
			
			this.removeChild(_canvas);
			_canvas				= null;
			
			this.parent.removeChild(this);
		}
	}
}
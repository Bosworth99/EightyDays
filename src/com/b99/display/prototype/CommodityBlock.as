package com.b99.display.prototype 
{
	import com.b99.data.GameData;
	import com.b99.data.prototype.Commodity;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CommodityBlock extends Sprite
	{
		private var _commodity			:Commodity;
		
		private var _intent				:String;
		private var _quantity			:uint;
		
		private var _canvas				:Sprite;
		private var _color				:uint;
		private var _img				:Sprite;
		private var _imgClass			:String;
		
		private var _name				:TextFieldFormat;
		private var _price				:TextFieldFormat;
		
		private var _currentPrice		:Number;
		private var _currentQuantity	:TextFieldFormat;
		private var _cashBtn			:CashButton;
		
		private var _line				:Sprite;
		
		public function CommodityBlock(commodity:Commodity, intent:String, quantity:uint = 0) 
		{
			super();
			
			_commodity 	= commodity;
			_intent		= intent;
			_quantity	= quantity;

			init();
		}
		
		private function init():void
		{
			switch (_commodity.rarity) 
			{
				case "rare":
				{	
					_color = GameData.COLOR_RARE;
					break;
				}
				case "uncommon":
				{	
					_color = GameData.COLOR_UNCOMMON;
					break;
				}
				case "common":
				{	
					_color = GameData.COLOR_COMMON;
					break;
				}
			}

			if (_commodity.img == "null") 
			{
				_imgClass = "GFX_BlankIcon";
			} 
			else 
			{
				_imgClass = _commodity.img;
			}	
				
			switch (_intent) 
			{
				case "buy":
				{
					_currentPrice = _commodity.currentPrice;
					break;
				}
				case "sell":
				{
					_currentPrice = _commodity.sellPrice;
					break;
				}
			}

			assembleDisplayObjects();
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									display
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_line = new GFX_marketLine();
				with (_line ) 
				{
					x = -10;
					y =  -5;
				}
			_canvas.addChild(_line);
			
			var tempObj: Class = getDefinitionByName(_imgClass) as Class;
			_img	= new tempObj;
			with (_img) 
			{
				x	= 0;
				y	= 5;
			}
			_canvas.addChild(_img);
			
			_name 	= new TextFieldFormat(_commodity.name, _color, 16, "verdana", 15, 100);
			with (_name) 
			{
				x	= 54;
				y	= 14;
			}
			_canvas.addChild(_name);
			
			_price = new TextFieldFormat("$ "+_currentPrice.toFixed(2), 0x000000, 14, "verdana");
			with (_price) 
			{
				x = 170;
				y = 16;
			}
			_canvas.addChild(_price);
			
			_cashBtn = new CashButton(_commodity, _intent);
			with (_cashBtn) 
			{
				x = 260;
				y = 10;
			}
			_canvas.addChild(_cashBtn);	
			
			if (_intent == "sell") 
			{
				_currentQuantity 	= new TextFieldFormat("x "+_quantity.toString(), 0x000000, 14, "verdana", 20, 30);
				_currentQuantity.x 	= 54;
				_currentQuantity.y 	= 35;
				_canvas.addChild(_currentQuantity);
			}
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									destroy
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function destroy():void
		{
			_commodity	= null;
		
			if (_currentQuantity) 
			{
				_currentQuantity.destroy();
				_currentQuantity = null;
			}
			
			_canvas.removeChild(_img)
			_img 		= null;
			
			_canvas.removeChild(_line);
			_line 		= null;
			
			_name.destroy();
			_name 		= null;
			
			_price.destroy();
			_price 		= null;
			
			_cashBtn.destroy();
			_cashBtn 	= null;

			this.removeChild(_canvas);	
			_canvas = null;
			
			this.parent.removeChild(this);
			
		}
	}	
}
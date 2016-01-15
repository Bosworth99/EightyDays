package com.b99.display.prototype 
{
	import com.b99.app.GameControl;
	import com.b99.data.GameData;
	import com.b99.data.prototype.*;
	import com.b99.display.composite.ImgButton;
	import com.b99.display.element.*;
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class ComponentBlock extends Sprite
	{
		private var _component		:Component;
		
		private var _canvas			:Sprite;
		private var _base			:CustomRoundRectGrad;
		
		private var _name			:TextFieldFormat;
		private var _bonus1			:TextFieldFormat;
		private var _bonus1_title	:String;
		private var _bonus1_data	:String;
		private var _bonus2			:TextFieldFormat;
		private var _bonus2_title	:String;
		private var _bonus2_data	:String;
		
		private var _color			:uint;
		private var _img			:Sprite;
		private var _imgClass		:String;
		
		private var _intent			:String;
		private var _cashButton		:ImgButton; 
		private var _price			:TextFieldFormat;
		
		private var _id				:String;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
		/**
		 * 
		 * @param	component :Component
		 * @param	intent :String = "view" or "purchase"
		 */
		public function ComponentBlock(component:Component, intent:String = "view") 
		{
			super();
			
			_component 	= component;
			_intent  	= intent;
			_id 		= component.id;
			init();
		}
		
		private function init():void
		{
			switch (_component.rarity) 
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

			switch (_component.type) 
			{
				case "quarters":
				{
					_bonus1_title	= "Crew";
					_bonus1_data	= "+ " +_component.crewCapacity.toString();
					_bonus2_title	= "Passenger";
					_bonus2_data	= "+ " +_component.passengerCapacity.toString();
					break;
				}
				case "cargo":
				{
					_bonus1_title	= "Cargo Capacity";
					_bonus1_data	= "+ " +_component.cargoCapacity.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
				case "balloon":
				{
					_bonus1_title	= "Weight Capacity";
					_bonus1_data	= "+ " +_component.weightCapacity.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
				case "fuel":
				{
					_bonus1_title	= "Fuel Capacity";
					_bonus1_data	= "+ " +_component.fuelCapacity.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
				case "engine":
				{
					_bonus1_title	= "Efficiency";
					_bonus1_data	= "+ " +_component.fuelEfficiency.toString();
					_bonus2_title	= "AirSpeed";
					_bonus2_data	= "+ " +_component.travelSpeed.toString();
					break;
				}
				case "wing":
				{
					_bonus1_title	= "Efficiency";
					_bonus1_data	= "+ " +_component.fuelEfficiency.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
				case "weapon":
				{
					_bonus1_title	= "Attack";
					_bonus1_data	= "+ " +_component.attack.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
				case "armor":
				{
					_bonus1_title	= "Defense";
					_bonus1_data	= "+ " +_component.defense.toString();
					_bonus2_title	= "";
					_bonus2_data	= "";
					break;
				}
			}
			
			if (_component.img == "null") 
			{
				_imgClass = "GFX_BlankIcon";
			} 
			else 
			{
				_imgClass = _component.img;
			}	
				
			assembleDisplayObjects();
			
			if (_intent == "purchase") 
			{
				addEventHandlers();
			}
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									display
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_base	= new CustomRoundRectGrad(	225,
												40, 
												10, 
												"linear", 
												[0xFFFFFF, 0xE2E3C4], 
												[1, 1], 
												[1, 255], 
												270, 
												2, 
												_color, 
												1);
			_canvas.addChild(_base);
			
			var tempObj: Class = getDefinitionByName(_imgClass) as Class
			_img	= new tempObj;
			with (_img) 
			{
				x	= -5;
				y	= -5;
			}
			_canvas.addChild(_img);
			
			_name 	= new TextFieldFormat(_component.name, GameData.COLOR_TEXT, 14, "verdana", 15, 100);
			with (_name) 
			{
				x	= 48;
				y	= 2;
			}
			_canvas.addChild(_name);
			
			_bonus1 = new TextFieldFormat(_bonus1_title + "  " + _bonus1_data, GameData.COLOR_TEXT, 9, "verdana", 20, 60);
			with (_bonus1) 
			{
				x	= 50;
				y	= 22;
			}
			_canvas.addChild(_bonus1);
			
			_bonus2 = new TextFieldFormat(_bonus2_title + "  " + _bonus2_data, GameData.COLOR_TEXT, 9, "verdana", 20, 60);
			with (_bonus2) 
			{
				x	= (_bonus1.width + _bonus1.x) + 5;
				y	= 22;
			}
			_canvas.addChild(_bonus2);
			
			if (_intent == "purchase") 
			{
				_price 	= new TextFieldFormat("$"+_component.buyPrice.toFixed(2),  GameData.COLOR_TEXT, 14, "verdana", 15, 50);
				with (_price) 
				{
					x 	= 140;
					y  	= -22;
				}
				_canvas.addChild(_price);	
					
				_cashButton	= new ImgButton("cash");
				with (_cashButton) 
				{
					x	= 235;
					y 	= 5;
				}
				_canvas.addChild(_cashButton);
			}
			
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									event handlers
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		
		private function addEventHandlers():void
		{
			_cashButton.addEventListener(MouseEvent.MOUSE_DOWN, cashDown, false, 0, true);
		}
		
		private function cashDown(e:MouseEvent):void 
		{
			GameControl.purchaseComponent(_component);
		}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									destroy
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function destroy():void
		{
			_component	= null;
			_base.destroy();
			_base 		= null;
			_name.destroy();
			_name		= null;
			_bonus1.destroy();
			_bonus1		= null;
			_bonus2.destroy();
			_bonus2		= null;

			_canvas.removeChild(_img);
			_img 		= null;
		
			if (_cashButton) 
			{
				_cashButton.removeEventListener(MouseEvent.MOUSE_DOWN, cashDown);
				_cashButton.destroy();
				_cashButton = null;
			}
			
			if (_price)
			{
				_price.destroy();
				_price		= null;
			}
			
			this.removeChild(_canvas);
			_canvas = null;
			
			this.parent.removeChild(this);
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									get n set
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function get id():String { return _id; }
		
	}
}
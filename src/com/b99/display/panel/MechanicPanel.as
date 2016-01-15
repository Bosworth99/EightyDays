package com.b99.display.panel 
{
	import com.b99.app.DisplayControl;
	import com.b99.app.GameControl;
	import com.b99.data.ComponentData;
	import com.b99.data.GameData;
	import com.b99.data.prototype.Component;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import com.b99.display.prototype.ComponentBlock;
	import com.b99.display.prototype.SimpleMessageFlyout;
	import com.b99.logic.ComponentLogic;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class MechanicPanel extends Sprite  implements Ipanel
	{
		private var _canvas				:Sprite;
		private var _back				:Sprite;
		
		private var _frame				:CustomRoundRectGrad;
		
		private var _base				:Sprite;
		private var _mask				:Sprite;
		
		private var _closeButton		:SimpleMessageFlyout;
		
		private var _mechanicTitle		:TextFieldFormat;
		
		//++++++++++++++++++++++ components
		private var _componentCon		:Sprite;
		
		private var _title_quarters		:TextFieldFormat;
		private var _title_cargo		:TextFieldFormat;
		private var _title_fuelTank		:TextFieldFormat;
		private var _title_balloon		:TextFieldFormat;
		private var _title_engine		:TextFieldFormat;
		private var _title_wing			:TextFieldFormat;
		private var _title_weapon		:TextFieldFormat;
		private var _title_armor		:TextFieldFormat;
		
		private var _currentComponents	:Array = new Array();
		private var _notAvailables		:Array = new Array();
		
		private var _componentSpacer	:uint  = 60;
		
		public function MechanicPanel()
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			addEventHandlers();
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
		
			_closeButton = new SimpleMessageFlyout("Close", 70);
			with (_closeButton) 
			{
				x 				= 720;
				y 				= 30;
				buttonMode 		= true;
				mouseEnabled 	= true;
			}
			_canvas.addChild(_closeButton);
			
			_mechanicTitle = new TextFieldFormat("Available Components", GameData.COLOR_TEXT, 20, "verdana", 20, 50);
			with (_mechanicTitle) 
			{
				x = 280;
				y = 50;
			}
			_canvas.addChild(_mechanicTitle);

			//+++++++++++++++ component titles
			
			_componentCon 		= new Sprite();
			_canvas.addChild(_componentCon);
			
			_title_quarters		= new TextFieldFormat("Quarters", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_quarters) 
			{
				x				= 115;
				y				= 90;
			}
			_componentCon.addChild(_title_quarters);
			
			_title_cargo		= new TextFieldFormat("Cargo Hold", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_cargo) 
			{
				x				= 115;
				y				= (_title_quarters.height + _title_quarters.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_cargo);
			
			_title_fuelTank		= new TextFieldFormat("Fuel Tank", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_fuelTank) 
			{
				x				= 115;
				y				= (_title_cargo.height + _title_cargo.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_fuelTank);
			
			_title_balloon		= new TextFieldFormat("Baloon", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_balloon) 
			{
				x				= 485;
				y				= 90;
			}
			_componentCon.addChild(_title_balloon);
			
			_title_engine		= new TextFieldFormat("Engine", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_engine) 
			{
				x				= 485;
				y				= (_title_balloon.height + _title_balloon.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_engine);
			
			_title_wing			= new TextFieldFormat("Wing", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_wing) 
			{
				x				= 485;
				y				= (_title_engine.height + _title_engine.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_wing);
			
			_title_weapon		= new TextFieldFormat("Weapon", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_weapon) 
			{
				x				= 115;
				y				= (_title_fuelTank.height + _title_fuelTank.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_weapon);
			
			_title_armor		= new TextFieldFormat("Armor", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_armor) 
			{
				x				= 485;
				y				= _title_weapon.y;
			}
			_componentCon.addChild(_title_armor);
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									buttons
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
		
		private function addEventHandlers():void
		{
			_closeButton.addEventListener(MouseEvent.MOUSE_DOWN, 	closeDown, 	false, 0, true);
		}
		
			private function closeDown(e:MouseEvent):void 
		{
			_closeButton.removeEventListener(MouseEvent.MOUSE_DOWN, closeDown);
			
			GameControl.removeOverlayPanel();
		}
		
		public function reactivate():void
		{
			addEventHandlers();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									update available compoents
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				
		
		public function updateAvailableComponents():void
		{
			destroyComponents();
			
			for (var i:int = 0; i < ComponentData.availableComponents.length; i++) 
			{
				addComponent( ComponentData.availableComponents[i]);
			}
		}
		
		private function addComponent(component:Component):void
		{
			var anchor:TextFieldFormat;
			var componentBlock:ComponentBlock;
			{
				switch (component.type) 
				{
					case "quarters":
					{
						anchor = _title_quarters as TextFieldFormat;
						break;
					}
					case "cargo":
					{
						anchor = _title_cargo as TextFieldFormat;
						break;
					}
					case "balloon":
					{
						anchor = _title_balloon as TextFieldFormat;
						break;
					}
					case "fuel":
					{
						anchor = _title_fuelTank as TextFieldFormat;
						break;
					}
					case "engine":
					{
						anchor = _title_engine as TextFieldFormat;
						break;
					}
					case "wing":
					{
						anchor = _title_wing as TextFieldFormat;
						break;
					}
					case "weapon":
					{
						anchor = _title_weapon as TextFieldFormat;
						break;
					}
					case "armor":
					{
						anchor = _title_armor as TextFieldFormat;
						break;
					}
				}
				
				if (component.note == "Not Available") 
				{
					var notAvailable:TextFieldFormat = new TextFieldFormat("Not Available", GameData.COLOR_COMMON, 18, "verdana", 20, 50);
					with (notAvailable) 
					{
						x = anchor.x;
						y = anchor.y + anchor.height;
					}
					_componentCon.addChild(notAvailable);
					_notAvailables.push(notAvailable);
				}
				else 
				{
					componentBlock = new ComponentBlock(component, "purchase");
					with (componentBlock) 
					{
						x = anchor.x;
						y = anchor.y + anchor.height;
					}
					_componentCon.addChild(componentBlock);
					_currentComponents.push(componentBlock);
				}
			}
		}
		
		public function removeComponent(id:String):void
		{
			var tempBlock:ComponentBlock
			var tempIndex
			for (var i:int = 0; i < _currentComponents.length; i++) 
			{
				if (ComponentBlock(_currentComponents[i]).id == id) 
				{
					tempBlock = _currentComponents[i];
					tempIndex = i;
				}
			}
			
			var notAvailable:TextFieldFormat = new TextFieldFormat("Sold Out", GameData.COLOR_COMMON, 18, "verdana", 20, 50);
			with (notAvailable) 
			{
				x = tempBlock.x;
				y = tempBlock.y;
			}
			_notAvailables.push(notAvailable);
			
			tempBlock.destroy();
			tempBlock = null;
			
			_currentComponents.splice(tempIndex, 1);
			
			_componentCon.addChild(notAvailable);
		}
			
		
		private function destroyComponents():void
		{
			var i:int;
			for (i = 0; i < _currentComponents.length; i++) 
			{
				var tempBlock:ComponentBlock = _currentComponents[i] as ComponentBlock;
				tempBlock.destroy();
				tempBlock = null;
			}
			_currentComponents.splice(0, _currentComponents.length);
			
			for (i = 0; i < _notAvailables.length; i++) 
			{
				var tempObj:TextFieldFormat = _notAvailables[i] as TextFieldFormat;
				tempObj.destroy();
				tempObj = null;
			}
			_notAvailables.splice(0, _notAvailables.length);
		}
	}
}
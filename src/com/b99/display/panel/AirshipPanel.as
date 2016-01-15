package com.b99.display.panel 
{
	import com.b99.data.AirshipData;
	import com.b99.data.GameData;
	import com.b99.display.composite.DataField;
	import com.b99.display.composite.DualDataField;
	import com.b99.display.element.TextFieldFormat;
	import com.b99.display.prototype.ComponentBlock;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class AirshipPanel extends Sprite implements Ipanel
	{
		private var _canvas						:Sprite;
		private var _base						:Sprite;
		private var _frameTop					:Sprite;
		
		private var _airship					:Sprite;
		
		//++++++++++++++++++++++ data
		private var _dataCon					:Sprite;
		
		private var _airspeed					:DataField;
		private var _airspeed_data				:Number;
		
		private var _efficiency					:DataField;
		private var _efficiency_data			:Number;
		
		private var _weight						:DualDataField;
		private var _weightCurrent_data			:uint;
		private var _weightCapacity_data		:uint;
		
		private var _fuel						:DualDataField;
		private var _fuelCurrent_data			:uint;
		private var _fuelCapacity_data			:uint;
		
		private var _cargo						:DualDataField;
		private var _cargoCurrent_data			:uint;
		private var _cargoCapacity_data			:uint;
		
		private var _crew						:DualDataField;
		private var _crewCurrent_data			:uint;
		private var _crewCapacity_data			:uint;
		
		private var _passenger					:DualDataField;
		private var _passengerCurrent_data		:uint;
		private var _passengerCapacity_data		:uint;
		
		private var _attack						:DataField;
		private var _attack_data				:uint
		
		private var _defense					:DataField;
		private var _defense_data				:uint
		
		//++++++++++++++++++++++ components
		private var _componentCon				:Sprite;
		
		private var _title_quarters				:TextFieldFormat;
		private var _quarters					:ComponentBlock;
		
		private var _title_cargo				:TextFieldFormat;
		private var _cargoHold					:ComponentBlock;
		
		private var _title_fuelTank				:TextFieldFormat;
		private var _fuelTank					:ComponentBlock;
		
		private var _title_baloon				:TextFieldFormat;
		private var _baloon						:ComponentBlock;
		
		private var _title_engine				:TextFieldFormat;
		private var _engine						:ComponentBlock;
		
		private var _title_wing					:TextFieldFormat;
		private var _wing						:ComponentBlock;
		
		private var _title_weapon				:TextFieldFormat;
		private var _weapon						:ComponentBlock;
		
		private var _title_armor				:TextFieldFormat;
		private var _armor						:ComponentBlock;
		
		//++++++++++++++++++++++ misc
		private var _spacer						:uint = 10;
		private var _componentSpacer			:uint = 50;
		
				
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
				
		
		public function AirshipPanel() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
	
				
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								display 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
				
		private function assembleDisplayObjects():void
		{
			_canvas 	= new Sprite();
			this.addChild(_canvas);

			_base 		= new GFX_Panel();
			_canvas.addChild(_base);
			
			_frameTop 	= new GFX_FrameTop()
			_frameTop.y 		= 530;
			_frameTop.scaleY 	= -1;
			_canvas.addChild(_frameTop);
			
			_airship 	= new GFX_Airship();
			with (_airship) 
			{
				x		= _base.width /2;
				y		= 150;
			}
			_canvas.addChild(_airship);
			
			//var txt_name:TextFieldFormat = new TextFieldFormat("Airship Data",0x000000,18,"verdana",20,40);
			//with (txt_name) 
			//{
				//x 		= 80;
				//y		= 50;
			//}
			//_canvas.addChild(txt_name);
			
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									data
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
				
			_dataCon 	= new Sprite();
			with (_dataCon) 
			{
				x 		= 100;
				y		= 380;
			}
			_canvas.addChild(_dataCon);
			
			
			_cargo	= new DualDataField(25, 175, "CARGO:", "", "", GameData.COLOR_TEXT, 75, 105);
			with (_cargo) 
			{
				x 		= 0;
				y		= 0;
			}
			_dataCon.addChild(_cargo);
			
			_weight	= new DualDataField(25, 175, "WEIGHT:", "", "", GameData.COLOR_TEXT, 65, 105);
			with (_weight) 
			{
				x 		= 0;
				y		= (_cargo.y + _cargo.height) + _spacer;
			}
			_dataCon.addChild(_weight);
			
			_fuel	= new DualDataField(25, 120, "FUEL:", "", "", GameData.COLOR_TEXT, 55, 70);
			with (_fuel) 
			{
				x 		= 0;
				y		= (_weight.y + _weight.height) + _spacer;
			}
			//_dataCon.addChild(_fuel);
			
			
			_airspeed	= new DataField(25, 115, "AIRSPEED:", "", GameData.COLOR_TEXT, 75);
			with (_airspeed) 
			{
				x 		= 200;
				y		= 0;
			}
			_dataCon.addChild(_airspeed);
			
			_efficiency	= new DataField(25, 115, "EFFICIENCY:", "", GameData.COLOR_TEXT, 75);
			with (_efficiency) 
			{
				x 		= 200;
				y		= (_airspeed.y + _airspeed.height) + _spacer;
			}
			_dataCon.addChild(_efficiency);
			
	
			_attack		= new DataField(25, 100, "ATTACK:", "", GameData.COLOR_TEXT, 70);
			with (_attack) 
			{
				x		= 350;
				y 		= 0
			}
			_dataCon.addChild(_attack);
			
			_defense	= new DataField(25,  100, "DEFENSE:", "", GameData.COLOR_TEXT, 70);
			with (_defense) 
			{
				x		= 350;
				y 		= (_attack.y + _attack.height) + _spacer;
			}
			_dataCon.addChild(_defense);
			
			_crew	= new DualDataField(25, 150, "CREW:", "", "", GameData.COLOR_TEXT, 80, 100);
			with (_crew) 
			{
				x 		= 515;
				y		= 0;
			}
			_dataCon.addChild(_crew);

			_passenger	= new DualDataField(25, 150, "PASSENGER:", "", "", GameData.COLOR_TEXT, 80, 100);
			with (_passenger) 
			{
				x 		= 515;
				y		= (_crew.y + _crew.height) + _spacer;
			}
			_dataCon.addChild(_passenger);
			
			
			//+++++++++++++++ component titles
			
			_componentCon 		= new Sprite();
			_canvas.addChild(_componentCon);
			
			_title_quarters		= new TextFieldFormat("Quarters", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_quarters) 
			{
				x				= 60;
				y				= 30;
			}
			_componentCon.addChild(_title_quarters);
			
			_title_cargo		= new TextFieldFormat("Cargo Hold", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_cargo) 
			{
				x				= 60
				y				= (_title_quarters.height + _title_quarters.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_cargo);
			
			_title_fuelTank		= new TextFieldFormat("Fuel Tank", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_fuelTank) 
			{
				x				= 60;
				y				= (_title_cargo.height + _title_cargo.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_fuelTank);
			
			_title_baloon		= new TextFieldFormat("Baloon", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_baloon) 
			{
				x				= 580;
				y				= 30;
			}
			_componentCon.addChild(_title_baloon);
			
			_title_engine		= new TextFieldFormat("Engine", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_engine) 
			{
				x				= 580;
				y				= (_title_baloon.height + _title_baloon.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_engine);
			
			_title_wing			= new TextFieldFormat("Wing", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_wing) 
			{
				x				= 580;
				y				= (_title_engine.height + _title_engine.y) + _componentSpacer;
			}
			_componentCon.addChild(_title_wing);
			
			_title_weapon		= new TextFieldFormat("Weapon", GameData.COLOR_TEXT, 12, "verdana", 20, 100);
			with (_title_weapon) 
			{
				x				= 150;
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
//									component upgrades
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function upgradeQuarters():void
		{
			if (_quarters) 
			{
				_quarters.destroy();
				_quarters = null;
			}
			
			_quarters 		= new ComponentBlock(AirshipData.quarters);
			with (_quarters) 
			{
				x			= _title_quarters.x;
				y			= _title_quarters.y + _title_quarters.height;
			}
			_componentCon.addChild(_quarters);
			
		}
		
		public function upgradeCargo():void
		{
			if (_cargoHold) 
			{
				_cargoHold.destroy();
				_cargoHold = null;
			}
			
			_cargoHold 		= new ComponentBlock(AirshipData.cargoHold);
			with (_cargoHold) 
			{
				x			= _title_cargo.x;
				y			= _title_cargo.y + _title_cargo.height;
			}
			_componentCon.addChild(_cargoHold);
			
		}
		
		public function upgradeBalloon():void
		{	
			if (_baloon) 
			{
				_baloon.destroy();
				_baloon = null;
			}
			
			_baloon 		= new ComponentBlock(AirshipData.balloon);
			with (_baloon) 
			{
				x			= _title_baloon.x;
				y			= _title_baloon.y + _title_baloon.height;
			}
			_componentCon.addChild(_baloon);
		}
		
		public function upgradeFuelTank():void
		{
			if (_fuelTank) 
			{
				_fuelTank.destroy();
				_fuelTank = null;
			}
			
			_fuelTank 		= new ComponentBlock(AirshipData.fuelTank);
			with (_fuelTank) 
			{
				x			= _title_fuelTank.x;
				y			= _title_fuelTank.y + _title_fuelTank.height;
			}
			_componentCon.addChild(_fuelTank);
		}

		public function upgradeEngine():void
		{
			if (_engine) 
			{
				_engine.destroy();
				_engine = null;
			}
			
			_engine 		= new ComponentBlock(AirshipData.engine);
			with (_engine) 
			{
				x			= _title_engine.x;
				y			= _title_engine.y + _title_engine.height;
			}
			_componentCon.addChild(_engine);
		}
		
		public function upgradeWing():void
		{
			if (_wing) 
			{
				_wing.destroy();
				_wing = null;
			}
			
			_wing 		= new ComponentBlock(AirshipData.wing);
			with (_wing) 
			{
				x			= _title_wing.x;
				y			= _title_wing.y + _title_wing.height;
			}
			_componentCon.addChild(_wing);
		}

		public function upgradeWeapon():void
		{
			if (_weapon) 
			{
				_weapon.destroy();
				_weapon = null;
			}
			
			_weapon 		= new ComponentBlock(AirshipData.weapon);
			with (_weapon) 
			{
				x			= _title_weapon.x;
				y			= _title_weapon.y + _title_weapon.height;
			}
			_componentCon.addChild(_weapon);
		}
		
		public function upgradeArmor():void
		{
			if (_armor) 
			{
				_armor.destroy();
				_armor = null;
			}
			
			_armor 		= new ComponentBlock(AirshipData.armor);
			with (_armor) 
			{
				x			= _title_armor.x;
				y			= _title_armor.y + _title_armor.height;
			}
			_componentCon.addChild(_armor);
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									get n set
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function set airspeed_data(value:Number):void 
		{
			_airspeed_data = value;
			_airspeed.setData(_airspeed_data.toPrecision(2));
		}
		
		public function set efficiency_data(value:Number):void 
		{
			_efficiency_data = value;
			_efficiency.setData(_efficiency_data.toPrecision(2));
		}
		
		public function set weightCurrent_data(value:uint):void 
		{
			_weightCurrent_data = value;
			_weight.setData1(_weightCurrent_data.toString());
		}
		
		public function set weightCapacity_data(value:uint):void 
		{
			_weightCapacity_data = value;
			_weight.setData2(_weightCapacity_data.toString());
		}
		
		public function set fuelCurrent_data(value:uint):void 
		{
			_fuelCurrent_data = value;
			_fuel.setData1(_fuelCurrent_data.toString());
		}
		
		public function set fuelCapacity_data(value:uint):void 
		{
			_fuelCapacity_data = value;
			_fuel.setData2(_fuelCapacity_data.toString());
		}
		
		public function set cargoCurrent_data(value:uint):void 
		{
			_cargoCurrent_data = value;
			_cargo.setData1(_cargoCurrent_data.toString());
		}
		
		public function set cargoCapacity_data(value:uint):void 
		{
			_cargoCapacity_data = value;
			_cargo.setData2(_cargoCapacity_data.toString());
		}
		
		public function set crewCurrent_data(value:uint):void 
		{
			_crewCurrent_data = value;
			_crew.setData1(_crewCurrent_data.toString());
		}
		
		public function set crewCapacity_data(value:uint):void 
		{
			_crewCapacity_data = value;
			_crew.setData2(_crewCapacity_data.toString());
		}
		
		public function set passengerCurrent_data(value:uint):void 
		{
			_passengerCurrent_data = value;
			_passenger.setData1(_passengerCurrent_data.toString());
		}
		
		public function set passengerCapacity_data(value:uint):void 
		{
			_passengerCapacity_data = value;
			_passenger.setData2(_passengerCapacity_data.toString());
		}
		
		public function set attack_data(value:uint):void 
		{
			_attack_data = value;
			_attack.setData(_attack_data.toString());
		}
		
		public function set defense_data(value:uint):void 
		{
			_defense_data = value;
			_defense.setData(_defense_data.toString());
		}
				
	}
}
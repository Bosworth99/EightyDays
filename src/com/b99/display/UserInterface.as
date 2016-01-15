package com.b99.display 
{
	import com.b99.data.*;
	import com.b99.app.*;
	import com.b99.display.composite.*;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import com.b99.logic.GameLogic;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class UserInterface extends Sprite
	{
		
		private var _canvas				:Sprite;
		private var _panelCon			:Sprite;
		
		private var _gameLog			:GameLog;
		private var _gameLog_data		:String;

		private var _captAvatar			:Sprite;
		private var _avatarFrame		:Sprite;
		private var _avtBack			:Sprite;
		private var _avtMask			:Sprite;
		
		private var _captName			:TextFieldFormat;
		private var _captName_data		:String;
		
		private var _currentCity		:DataField;
		private var _currentCity_data	:String;
		
		private var _totalKM			:DataField;
		private var _totalKM_data		:int;

		private var _totalDays			:DataField;
		private var _totalDays_data		:String;
		
		private var _currentFuel		:DualDataField;
		private var _currentFuel_data	:int;
		private var _capacityFuel_data	:int;
		
		private var _cash				:DataField;
		private var _cash_data			:Number;
		
		private var _fuelPrice			:DataField;
		private var _fuelPrice_data		:Number;
		
		private var _buyFuel			:ImgButton;
		
		private var _openPort			:ImgButton;
		private var _openMap			:ImgButton;
		private var _openAirship		:ImgButton;
		
		private var _currentPanel		:String = "map";

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function UserInterface() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}

		public function firstTurn():void
		{
			addEventHandlers();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas 		= new Sprite();
			this.addChild(_canvas);
			
			_panelCon 		= new Sprite();
			this.addChild(_panelCon);

			_gameLog 		= new GameLog();
			with (_gameLog) 
			{
				x 			= 190;
				y 			= 610;
			}
			_canvas.addChild(_gameLog);
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									upper frame
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
				
			
			_currentCity 	= new DataField(25, 140, "CURRENT:", "", 0x4E5324);
			with (_currentCity) 
			{
				x 			= 144;
				y 			= 16;
			}
			_canvas.addChild(_currentCity);
			
			_totalKM 		= new DataField(25, 150, "TRAVELED:", "", 0x4E5324, 75);
			with (_totalKM) 
			{
				x 			= (_currentCity.width + _currentCity.x) + 14;
				y 			= _currentCity.y;
			}
			_canvas.addChild(_totalKM);
			
			_totalDays 		= new DataField(25, 170, "DAYS:", "", 0x4E5324, 45);
			with (_totalDays) 
			{
				x 			= (_totalKM.width + _totalKM.x) + 14;
				y 			= _totalKM.y;
			}
			_canvas.addChild(_totalDays);
			
			_cash			= new DataField( 25, 160, "CASH:", "", 0x4E5324, 44);
			with (_cash) 
			{
				x 			= (_totalDays.width + _totalDays.x) + 14;
				y 			= _totalDays.y;
			}
			_cash.setData(GameLogic.formatNumber( 1000, 2,".",",","$"));
			_canvas.addChild(_cash);
			
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									lower frame
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
			
			_fuelPrice 		= new DataField(25, 100, "FUEL:", "", 0x4E5324, 40);
			with (_fuelPrice) 
			{
				x 			= 30;
				y 			= 610;
			}
			_canvas.addChild(_fuelPrice);
			
			_buyFuel 		= new ImgButton("cash");
			with (_buyFuel) 
			{
				x 			= 135;
				y 			= 608;
			}
			_canvas.addChild(_buyFuel);
			
			_currentFuel = new DualDataField( 25, 100, "FUEL:","0" ,"0",0x4E5324,40, 60);
			with (_currentFuel) 
			{
				x 			= 30;
				y 			= 645;
			}
			_canvas.addChild(_currentFuel);
			
			//++++++++++++++++++++++++ panel con
			_openMap 		= new ImgButton("map");
			with (_openMap) 
			{
				x 			= 290;
				y 			= 523;
				name 		= "map";
			}
			_panelCon.addChild(_openMap);
			
			_openPort 	= new ImgButton("port");
			with (_openPort) 
			{
				x 			= (_openMap.width + _openMap.x) + 50;
				y 			= 523;
				name 		= "port";
			}
			_panelCon.addChild(_openPort);

			_openAirship 	= new ImgButton("airship");
			with (_openAirship) 
			{
				x 			= (_openPort.width + _openPort.x) + 50;
				y 			= 523;
				name 		= "airship";
			}
			_panelCon.addChild(_openAirship);
			
			
			//++++++++++++++++++++++++++ avatar frame
			_captAvatar = new Sprite();
			with (_captAvatar) 
			{
				x			= 720;
				y			= 490;
				scaleX		= .75;
				scaleY		= .75;
			}
			_canvas.addChild(_captAvatar);
			
			_avtBack = new Sprite();
			with (_avtBack) 
			{
				graphics.beginGradientFill(	"linear", 
											[0x3A3923, 0x84824F], 
											[1, 1],
											[1, 255]);
											
				graphics.drawEllipse(0, 0, 200, 200);
				graphics.endFill();
				x			= 14;
				y 			= 14;
			}
			_captAvatar.addChild(_avtBack);
			
			_avtMask = new Sprite();
			with (_avtMask) 
			{
				graphics.beginFill(0x80FF80);
				graphics.drawEllipse(0, 0, 200, 200);
				graphics.endFill();
				x			= 14;
				y 			= 14;
			}
			_captAvatar.addChild(_avtMask);
			
			_avatarFrame = new GFX_avatarFrame();
			with (_avatarFrame) 
			{
				x			= 0;
				y			= 0;
			}
			_captAvatar.addChild(_avatarFrame);
			
			_captName 	= new TextFieldFormat(CrewData.name_captain, GameData.COLOR_TEXT, 18, "verdana");
			with (_captName) 
			{
				x			= 32;
				y			= 225;
			}
			_captAvatar.addChild(_captName);
			
		}

		public function updateCaptAvatar():void 
		{
			var captainImg:Bitmap = CrewData.img_captain;
			with (captainImg) 
			{
				x 		= 55;
				y 		= 35;
				scaleX = .45;
				scaleY = .45;
			}
			_captAvatar.addChildAt(captainImg, 1);
			captainImg.mask = _avtMask;
			
		}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								event handlers
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		public function addEventHandlers():void
		{
			_buyFuel.addEventListener(MouseEvent.MOUSE_DOWN, purchaseFuel, false, 0, true);
			_panelCon.addEventListener(MouseEvent.MOUSE_DOWN, addPanel, false, 0 , true);
		}
		
		public function removeEventHandlers():void
		{
			_buyFuel.removeEventListener(MouseEvent.MOUSE_DOWN, purchaseFuel);
			_panelCon.removeEventListener(MouseEvent.MOUSE_DOWN, addPanel);
		}
		
		private function addPanel(e:MouseEvent):void 
		{
			var tempName:String = e.target.parent.parent.parent.name;
			if (tempName != _currentPanel) 
			{
				GameControl.addPanel(tempName);
			}
			_currentPanel = tempName;
		}
		
		private function purchaseFuel(e:MouseEvent):void 
		{
			GameControl.purchaseFuel();
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//								get, set
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		public function set targetCity(value:String):void 
		{
			_currentCity_data = value;
			_currentCity.setData(_currentCity_data);
		}
		
		public function set klmTraveled(value:int):void 
		{
			_totalKM_data = value;
			_totalKM.setData(GameLogic.formatNumber( _totalKM_data, 1));
		}
		
		public function set totalDays_data(value:String):void 
		{
			_totalDays_data = value;
			_totalDays.setData(_totalDays_data);
		}
		
		public function set currentFuel_data(value:int):void 
		{
			_currentFuel_data = value;
			_currentFuel.setData1(_currentFuel_data.toString());
		}
		
		public function set capacityFuel_data(value:int):void 
		{
			_capacityFuel_data = value;
			_currentFuel.setData2(_capacityFuel_data.toString());
		}

		public function set cash_data(value:Number):void 
		{
			_cash_data = value;
			_cash.setData(GameLogic.formatNumber( _cash_data, 2,".",",","$"));
		}
		
		public function set fuelPrice_data(value:Number):void 
		{
			_fuelPrice_data = value;
			_fuelPrice.setData(GameLogic.formatNumber( _fuelPrice_data, 2,".",",","$"));
		}
		
		public function set gameLog_data(value:String):void 
		{
			_gameLog_data = value;
			_gameLog.logtext(value);
		}
		
		public function set currentPanel(value:String):void 
		{
			_currentPanel = value;
		}
		
		public function get captAvatar():Sprite { return _captAvatar; }
		
		public function set captName_data(value:String):void 
		{
			_captName_data = value;
			_captName.set_text = _captName_data.toString();
		}
	}
}
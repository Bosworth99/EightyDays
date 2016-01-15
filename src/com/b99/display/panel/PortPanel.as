package com.b99.display.panel 
{
	import adobe.utils.CustomActions;
	import com.b99.app.GameControl;
	import com.b99.data.GameData;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.prototype.SimpleMessageFlyout;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class PortPanel extends Sprite implements Ipanel
	{
		private var _canvas			:Sprite;
		private var _base			:Sprite;
		private var _frameTop		:Sprite;
		
		private var _btnCon			:Sprite;
		private var _openMarket		:Sprite;
		private var _openMechanic	:Sprite;
		private var _openTavern		:Sprite;
		
		private var _simpleMessage	:SimpleMessageFlyout;
		private var _width			:uint;
		
		public function PortPanel() 
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
			_canvas		 		= new Sprite();
			this.addChild(_canvas);

			_base 				= new GFX_TownSquare();
			_canvas.addChild(_base);
			
			_frameTop 			= new GFX_FrameTop()
			_frameTop.y 		= 530;
			_frameTop.scaleY 	= -1;
			_canvas.addChild(_frameTop);
			
			
			_btnCon 			= new Sprite();
			this.addChild(_btnCon);
			
			_openMarket 		= new Sprite();
			with (_openMarket) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRect(0, 0, 345, 300);
				x				= 0;
				y				= 150;
				buttonMode		= true;
				mouseEnabled	= true;
				name			= "market";
			}
			_btnCon.addChild(_openMarket);					
			
			_openMechanic 		= new Sprite();
			with (_openMechanic) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRect(0, 0, 230, 250);
				x				= 365;
				y				= 165;
				buttonMode		= true;
				mouseEnabled	= true;
				name			= "mechanic";
			}
			_btnCon.addChild(_openMechanic);	
			
			_openTavern 		= new Sprite();
			with (_openTavern) 
			{
				graphics.beginFill(0x00FF00, 0);
				graphics.drawRect(0, 0, 230, 270);
				x				= 625;
				y				= 165;
				buttonMode		= true;
				mouseEnabled	= true;
				name			= "tavern";
			}
			//_btnCon.addChild(_openTavern);	
			
		}
		
		public function addEventHandlers():void
		{
			_btnCon.addEventListener(MouseEvent.MOUSE_OVER, over, 	false, 0, true);
			_btnCon.addEventListener(MouseEvent.MOUSE_OUT, 	out, 	false, 0, true);
			_btnCon.addEventListener(MouseEvent.MOUSE_DOWN, down, 	false, 0, true);
		}
		
		public function removeEventHandlers():void
		{
			_btnCon.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_btnCon.removeEventListener(MouseEvent.MOUSE_OUT, 	out);
			_btnCon.removeEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		
		
		private function over(e:MouseEvent):void 
		{
			if (_simpleMessage) 
			{
				_simpleMessage.removeEventListener(Event.ENTER_FRAME, messageUpdate);
				_simpleMessage.destroy();
				_simpleMessage = null;
			}
			var message	:String = e.target.name;
			_width 	= message.length * 14;			
			_simpleMessage 		= new SimpleMessageFlyout( message, _width);

			with (_simpleMessage) 
			{
				if (mouseX < GameData.stageW / 2) 
				{
					x 			= mouseX + 20;
				} 
				else 
				{
					x 			= mouseX - (20 + _width);	
				}
				y				= mouseY - 10; 
				mouseEnabled	= false;
				buttonMode 		= false;	
			}
			
			_canvas.addChild(_simpleMessage);
			
			_simpleMessage.addEventListener(Event.ENTER_FRAME, messageUpdate, false, 0, true);
		}
		
		private function out(e:MouseEvent):void 
		{
			if (_simpleMessage) 
			{
				_simpleMessage.removeEventListener(Event.ENTER_FRAME, messageUpdate);
				_simpleMessage.destroy();
				_simpleMessage = null;
			}
		}
		
		private function down(e:MouseEvent):void 
		{
			if (_simpleMessage) 
			{
				_simpleMessage.removeEventListener(Event.ENTER_FRAME, messageUpdate);
				_simpleMessage.destroy();
				_simpleMessage = null;
			}
			
			GameControl.addOverlayPanel(e.target.name);
		}
		
		private function messageUpdate(e:Event):void 
		{
			if (mouseX < GameData.stageW / 2) 
			{
				_simpleMessage.x 	-= (_simpleMessage.x - (mouseX + 20))  / 15;
			} 
			else 
			{
				_simpleMessage.x	-= (_simpleMessage.x - (mouseX - (20 + _width)))  / 15;
			}	
			_simpleMessage.y		-= (_simpleMessage.y - (mouseY - 10)) / 15; 
		}
	}
}
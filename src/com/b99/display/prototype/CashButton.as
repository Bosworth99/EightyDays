package com.b99.display.prototype
{
	import com.b99.app.GameControl;
	import com.b99.display.element.*;
	import com.b99.display.composite.*;
	import com.b99.data.prototype.Commodity;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CashButton extends Sprite
	{
		
		private var _canvas			:Sprite;
		private var _button			:ImgButton;
		private var _tempCommodity	:Commodity;
		private var _intent			:String;
		
		public function CashButton(target:Commodity, intent:String) 
		{
			super();
			_tempCommodity 	= target;
			_intent 	= intent;
			
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			addEventHandlers();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_button = new ImgButton("cash");
			_canvas.addChild(_button);
		}
		
		private function addEventHandlers():void
		{
			_button.addEventListener(MouseEvent.MOUSE_DOWN, buttonDown, false, 0, true);
		}
		
		public function removeEventHandler():void
		{
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, buttonDown);
		}
		
		private function buttonDown(e:MouseEvent):void 
		{
			switch (_intent) 
			{
				
				case "buy":
				{
					GameControl.purchaseCommodity(_tempCommodity);
					break;
				}
				case "sell":
				{	
					GameControl.sellCommodity(_tempCommodity);
					break;
				}
			}
		}
		
		public function destroy():void
		{
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, buttonDown);
			
			_button.destroy();
			_button 		= null;
			
			_tempCommodity 	= null;
			
			this.removeChild(_canvas);
			_canvas			= null;
			
			this.parent.removeChild(this);
		}
		
	}
}
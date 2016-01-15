package com.b99.display.composite
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import com.b99.display.element.*;
	
	/**
	 * ...
	 * @author Bosworth99
	 */
	public class ImgButton extends Sprite
	{
		private var _canvas			:Sprite = new Sprite();
		private var _up				:Sprite;
		private var _over			:Sprite;
		private var _hit			:CustomRoundRectGrad;

		private var _intent			:String;

		public function ImgButton(intent:String) 
		{
			_intent = intent;
			
			super();
			init();		
		}
		
		private function init():void
		{
			TweenPlugin.activate([GlowFilterPlugin]);
			constructButton();
		}
		
		private function constructButton():void
		{
			
			this.addChild(_canvas);
			
			switch (_intent) 
			{
				case "cash":
				{
					_up 	= new GFX_BuyUp();
					_over 	= new GFX_BuyOver();
					break;
				}
				case "port":
				{
					_up  	= new GFX_PortUp();
					_over 	= new GFX_PortOver();
					break;
				}
				case "map":
				{
					_up  	= new GFX_MapUp();
					_over 	= new GFX_MapOver();
					break;
				}
				case "airship":
				{
					_up  	= new GFX_AirshipUp();
					_over 	= new GFX_AirshipOver();
					break;
				}
				
				case "cash":
				{
					_up  	= new GFX_BuyUp();
					_over 	= new GFX_BuyOver();
					break;
				}

			}
			
			_canvas.addChild(_up);
			
			with (_over) 
			{
				alpha 	= 0;
			}
			_canvas.addChild(_over);
			
			_hit = new CustomRoundRectGrad(_up.width,_up.height,0,"linear",[0x80FF00],[1],[1],90,1,0x80FF00,1);
			with (_hit) 
			{
				x 		= -5;
				y 		= -5;
				alpha 	= 0;
			}
			_canvas.addChild(_hit)
			
			_up.cacheAsBitmap 		= true;
			_over.cacheAsBitmap 	= true;
			_hit.cacheAsBitmap 		= true;
			
			this.buttonMode 		= true;
			this.mouseEnabled 		= true;
			
			addEventHandlers();
			
		}
		
		private function addEventHandlers():void
		{
			_hit.addEventListener(MouseEvent.MOUSE_OVER, 	over, false, 0, true);
			_hit.addEventListener(MouseEvent.MOUSE_OUT, 	out, false, 0, true);
		}
		
		private function over(e:MouseEvent):void 
		{
			TweenLite.to(_over, .2, 	{alpha:1   } );
		}
		private function out(e:MouseEvent):void 
		{
			TweenLite.to(_over, .2, 	{alpha:0   } );
		}
		
		public function destroy():void
		{
			_hit.removeEventListener(MouseEvent.MOUSE_OVER, over);
			_hit.removeEventListener(MouseEvent.MOUSE_OUT, 	out);
			
			_canvas.removeChild(_up);
			_up = null;			

			_canvas.removeChild(_over);
			_over = null;		
			
			_hit.destroy()
			_hit = null;
			
			this.removeChild(_canvas)
			_canvas = null;
			
			this.parent.removeChild(this);
		}
//+++++++++++++++++++++++++++++++  end ++++++++++++++++++++++++++++++++++++++++
	}

}
///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>display>event>StartScreen.as
//
//	extends : Sprite
//	
//	start screen for application 
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.display.events 
{
	import com.b99.app.Main;
	import com.b99.display.prototype.SimpleCustomButton;
	import com.b99.event.GameEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class StartScreen extends Sprite
	{
		
		private var _canvas			:Sprite;
		private var _base			:Sprite;
		private var _title			:Sprite;
		private var _airship		:MovieClip;
		
		private var _btn_start		:SimpleCustomButton;
		private var _btn_highscore	:SimpleCustomButton;
		

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		public function StartScreen() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			trace("StartScreen.init()");
			
			TweenPlugin.activate([BlurFilterPlugin, GlowFilterPlugin]);
			
			assembleDisplayObjects();
			animateIn();
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									display objects
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		private function assembleDisplayObjects():void
		{
			_canvas 	= new Sprite();
			this.addChild(_canvas);
			
			_base 		= new GFX_startScreen();
			_canvas.addChild(_base);
			
			_airship 	= new GFX_start_airship();
			with (_airship) 
			{
				x 		= 625;
				y		= 300;
			}
			_canvas.addChild(_airship);
			
			_title 		= new GFX_title_80d();
			with (_title) 
			{
				x		= 200;
				y		= 200;
			}
			_title.blendMode = BlendMode.HARDLIGHT;
			_canvas.addChild(_title);
			
			_btn_start	= new SimpleCustomButton("large", "dark", "Start");
			with (_btn_start) 
			{
				x		= 100;
				y		= 400;
				scaleX  = 1.25;
				scaleY 	= 1.25;
			}
			_canvas.addChild(_btn_start);

			_btn_highscore	= new SimpleCustomButton("large", "dark", "High Scores");
			with (_btn_highscore) 
			{
				x		= 100;
				y		= 450;
				scaleX  = 1.25;
				scaleY 	= 1.25;
			}
			_canvas.addChild(_btn_highscore);
			
			this.dispatchEvent(new GameEvent(GameEvent.PANEL_ADDED));
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									animation sequences
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		
		private function animateIn():void
		{
			TweenLite.from(_base, 			0.7, { delay:0.1, alpha:0} );
			TweenLite.from(_btn_start, 		0.8, { delay:1.0, alpha:0, blurFilter: { blurX:30, blurY:20, quality:2, remove:true } } );
			TweenLite.from(_btn_highscore, 	0.8, { delay:1.5, alpha:0, blurFilter: { blurX:30, blurY:20, quality:2, remove:true } } );
			TweenLite.from(_title, 			1.0, { delay:0.5, scaleX:.85, scaleY:.75, alpha:0, blurFilter:{blurX:30, blurY:20, quality:2, remove:true}, onComplete:lateAnimateIn} );
			TweenLite.from(_airship, 		3.0, { delay:0.1, x:675, y: 300, alpha:0 } );
			
		}
		
		private function lateAnimateIn():void
		{
			TweenLite.to(_title, 		.5, { glowFilter: { color:0xFFFFFF, alpha:.9, blurX:50, blurY:30 }} );
			animateInComplete();
		}
		
		
		private function animateInComplete():void
		{
			addEventHandlers();
		}
		
		private function animateOut():void
		{
			TweenLite.to(_canvas, .5, {delay:.1, alpha:0, onComplete:animateOutComplete} );
		}
		
		private function animateOutComplete():void
		{
			Main.display.events.removeStartScreen();
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									event handlers 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		private function addEventHandlers():void
		{
			_btn_start.addEventListener(MouseEvent.MOUSE_DOWN, exit, false, 0, true);
		}

		private function removeEventHandlers():void
		{
			_btn_start.removeEventListener(MouseEvent.MOUSE_DOWN, exit);
		}
		
		private function exit(e:MouseEvent):void
		{
			removeEventHandlers();
			animateOut();
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									destroy 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
		
		public function destroy():void 
		{
			_canvas.removeChild(_base);
			this.removeChild(_canvas);
			this.parent.removeChild(this);
			
			this.dispatchEvent(new GameEvent(GameEvent.PANEL_REMOVED));
		}
		
	}
}
package com.b99.util 
{
	import com.b99.display.element.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class MemoryGraph extends Sprite
	{
		private var _canvas		:Sprite;
		private var _base		:CustomRoundRectGrad;
		private var _history	:Array = new Array();
		private var _max		:Number = 0;
		private var _line		:Sprite;
		private var _redLine	:Sprite;
		private var _text		:TextFieldFormat;
		private var _text2		:TextFieldFormat;					
		
		public function MemoryGraph() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			for (var i:int = 0; i <= 100; i++) 
			{
				_history.push(20);
			}
			
			assembleDisplayObjects();
			addEventHandlers();
		}

		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_base	= new CustomRoundRectGrad(200, 75, 10, "linear", [0x000000, 0x575757], [.35, .35], [1, 255], 270, 3,0x000000,1);
			_canvas.addChild(_base);
			
			_redLine	= new Sprite();
			with (_redLine) 
			{
				graphics.lineStyle(2, 0xFF0000);
				graphics.moveTo(0, 0);
				graphics.lineTo(200, 0);
				y 		= 75 - (_max - 20);
			}
			_base.addChild(_redLine);
			
			_line 		= new Sprite();
			_base.addChild(_line);
			
			_text 		= new TextFieldFormat("",0xFFFFFF, 12, "verdana",10,100);
			_text.x		= 2;
			_text.y		= 2;
			_canvas.addChild(_text);
			
			_text2		= new TextFieldFormat("",0xFFFFFF, 12, "verdana",10,100);
			_text2.x	= 100;
			_text2.y	= 4;
			_canvas.addChild(_text2);
			
		}
		
		private function addEventHandlers():void
		{
			this.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		private function update(e:Event):void 
		{
			with (_line) 
			{
				graphics.clear();
				graphics.lineStyle(2, 0xFFFFFF);
				graphics.moveTo(0, 75 - (_history[0] - 20));
				for (var i:int = 1; i < _history.length; i++) 
				{
					graphics.lineTo(i * 2, 75 - (_history[i] - 20));
				}
			}
			
			var currentRam: Number = Number( System.totalMemory / 1024 / 1024 );
			_history.splice(0, 1);
			_history.push( currentRam );
			
			if (currentRam >= _max) 
			{
				_max = currentRam;
			}
			
			_redLine.y = 75 - (_max - 20);
				
			_text.set_text = "RAM: " + currentRam.toFixed(2) + "Mb";
			_text2.set_text = "/ " + _max.toFixed(2) +" max";
			
		}
		
	}
}
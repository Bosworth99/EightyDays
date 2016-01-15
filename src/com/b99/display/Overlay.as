///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>display>overlay.as
//
//	extends : Object
//	
//	Data Controller
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.display 
{

	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Overlay extends Sprite
	{
		
		private var _canvas			:Sprite;
		private var _frame			:Sprite;
		
		public function Overlay() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			assembleDisplayObjects();
		}
		
		private function assembleDisplayObjects():void
		{
			//+++++++++++++++++++++++++++++++ container
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			//+++++++++++++++++++++++++++++++ frame gfx
			_frame = new GFX_Frame();
			_canvas.addChild(_frame);
			
		}	
		
	}
}
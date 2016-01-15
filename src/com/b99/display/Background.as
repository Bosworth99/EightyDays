///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>display>Background.as
//
//	extends : Sprite
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
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
		}
		
		private function assembleDisplayObjects():void
		{
			var background:Sprite = new GFX_Background();
			this.addChild(background);
		}
		
	}
}
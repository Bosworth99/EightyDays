package com.b99.display.panel 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CrewPanel extends Sprite  implements Ipanel
	{
		private var _canvas			:Sprite;
		private var _base			:Sprite;
		
		public function CrewPanel() 
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
			_canvas = new Sprite();
			this.addChild(_canvas);

			_base = new GFX_Panel();
			_canvas.addChild(_base);
			
		}
	}

}
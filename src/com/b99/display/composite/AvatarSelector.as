package com.b99.display.composite 
{
	import com.b99.data.CharacterData;
	import com.b99.data.GameData;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import com.b99.display.prototype.SimpleCustomButton;
	import com.b99.event.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class AvatarSelector extends Sprite
	{
		private var _base			:CustomRoundRectGrad;
		private var _previous		:SimpleCustomButton;
		private var _next			:SimpleCustomButton;
		private var _title			:TextFieldFormat;
		private var _title_text		:String;
		private var _type			:String;
		private var _targetArray	:Array;
		private var _targetIndex	:Number;
		private var _currentIndex	:Number;
		
		public function AvatarSelector(text:String, type:String) 
		{
			super();
			
			_title_text = text;
			_type 		= type;
			init();
		}
		
		private function init():void
		{
			switch (_type) 
			{
				case "body":
					_targetArray = CharacterData.player_Body;
					_targetIndex = 0;
					break;
				case "head":
					_targetArray = CharacterData.player_Head;
					_targetIndex = 1;
					break;
				case "mouth":
					_targetArray = CharacterData.player_Mouth;
					_targetIndex = 2;
					break;
				case "facialHair":
					_targetArray = CharacterData.player_FacialHair;
					_targetIndex = 3;
					break;	
				case "eyes":
					_targetArray = CharacterData.player_Eyes;
					_targetIndex = 4;
					break;		
				case "accessory":
					_targetArray = CharacterData.player_Accessory;
					_targetIndex = 5;
					break;		
				case "eyebrow":
					_targetArray = CharacterData.player_Eyebrow;
					_targetIndex = 6;
					break;	
				case "hair":
					_targetArray = CharacterData.player_Hair;
					_targetIndex = 7;
					break;	
				case "hat":
					_targetArray = CharacterData.player_Hat;
					_targetIndex = 8;
					break;	
			}
			
			_currentIndex = CharacterData.player_captain[_targetIndex];
			
			assembleDisplayObjects();
			addEventHandlers();
		}

		private function assembleDisplayObjects():void
		{
			
			_base = new CustomRoundRectGrad( 	140,
												32, 
												15, 
												"linear", 
												[0xFFFFFF, 0xE2E3C4], 
												[.6, .6], 
												[1, 255], 
												270, 
												2, 
												GameData.COLOR_TEXT, 
												1
											);
			with (_base) 
			{
				x		= 0;
				y		= -4;
			}				
			_base.filters = [ new DropShadowFilter(5, 45, 0x1A180F, .6, 10, 10, 1)];
			this.addChild(_base);
			
			_previous = new SimpleCustomButton("large", "trans", " < ");
			with (_previous) 
			{
				x 		= 0;
				y 		= 0;
				name 	= "previous";
			}
			this.addChild(_previous);
			
			_title  	= new TextFieldFormat( _title_text, 0xFFFFFF, 14, "verdana");
			with (_title) 
			{
				x 		= 30;
				y 		= 2;
			}
			this.addChild(_title);
			
			_next 		= new SimpleCustomButton("large", "trans", " > ");
			with (_next) 
			{
				x 		= 110;
				y 		= 0;
				name	= "next";
			}
			this.addChild(_next);
		}

		private function addEventHandlers():void
		{
			_next.addEventListener(MouseEvent.MOUSE_DOWN, change, false, 0, true);
			_previous.addEventListener(MouseEvent.MOUSE_DOWN, change, false, 0, true);
		}
		
		private function change(e:MouseEvent):void 
		{
			var direction:String = e.target.parent.name;
			
			switch (direction) 
			{
				case "previous":
				
					_currentIndex--;
					
					if (_currentIndex < 0) 
					{
						_currentIndex = _targetArray.length -1;
					}
					break;
					
				case "next":
					
					_currentIndex++;
					
					if (_currentIndex > _targetArray.length -1) 
					{
						_currentIndex = 0;
					}
					break;
			}
			
			CharacterData.player_captain[_targetIndex] = _currentIndex;
			
			this.dispatchEvent(new GameEvent(GameEvent.UPDATE_AVATAR));
		}
		
		public function destroy():void
		{
			this.parent.removeChild(this);
		}
	}
}
package com.b99.display.events 
{
	import com.b99.app.Main;
	import com.b99.data.CrewData;
	import com.b99.data.GameData;
	import com.b99.display.composite.BuildAvatar;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.display.element.TextFieldFormat;
	import com.b99.display.prototype.SimpleCustomButton;
	import com.b99.event.GameEvent;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class Profile extends Sprite
	{
		private var _canvas			:Sprite;
		private var _base			:CustomRoundRectGrad;
		private var _avatar			:BuildAvatar;
		private var _btn_continue	:SimpleCustomButton;
		private var _pageTitle		:TextFieldFormat;
		private var _playerTitle	:TextFieldFormat;
		private var _playerInput	:TextFieldFormat;
		private var _inputBack		:CustomRoundRectGrad;
		
		public function Profile() 
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			trace("BuildProfile.init()");
			
			assembleDisplayObjects();
			animateIn();
			addEventHandlers();
			
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_base = new CustomRoundRectGrad(
												GameData.stageW - 100, 
												GameData.stageH - 100, 
												50, 
												"linear", 
												[0x3A3923, 0x84824F], 
												[.9, .6],
												[1, 255],
												90,
												3,
												GameData.COLOR_TEXT,
												.9
											);
			with (_base) 
			{
				x = 50;
				y = 50;
			}
			_base.filters = [ new DropShadowFilter(2, 90, 0x201F13, .8, 15, 15, 1)];
			_canvas.addChild(_base);
			
			_avatar = new BuildAvatar();
			with (_avatar) 
			{
				x 	= 150;
				y	= (GameData.stageH / 2) - (_avatar.height / 2);
			}
			_canvas.addChild(_avatar);
			
			_btn_continue = new SimpleCustomButton("large", "dark", "Continue");
			with (_btn_continue) 
			{
				x		= GameData.stageW - 200;
				y		= GameData.stageH - 100;
				scaleX  = 1;
				scaleY 	= 1;
			}
			_canvas.addChild(_btn_continue);
			
			_pageTitle 	= new TextFieldFormat("Player Profile", 0xFFFFFF, 24, "verdana", 30, 50);
			with (_pageTitle) 
			{
				x 		= 150;
				y		= 75;
			}
			_canvas.addChild(_pageTitle);
			
			_playerTitle = new TextFieldFormat("Name:", 0xFFFFFF, 16, "verdana", 30, 75);
			with (_playerTitle) 
			{
				x 		= 150;
				y		= _avatar.y + _avatar.height + 20;
			}
			_canvas.addChild(_playerTitle);
			
			_inputBack = new CustomRoundRectGrad(	230,
													30, 
													10, 
													"linear", 
													[0xFFFFFF, 0xE2E3C4], 
													[1, 1], 
													[1, 255], 
													270, 
													2, 
													GameData.COLOR_TEXT, 
													1);
			with (_inputBack) 
			{
				x 		= _playerTitle.x + 75;
				y		= _avatar.y + _avatar.height + 18;
			}
			_canvas.addChild(_inputBack);
			
			_playerInput = new TextFieldFormat(CrewData.name_captain , GameData.COLOR_TEXT, 16, "verdana", 30, 150, true, 20);
			with (_playerInput) 
			{
				x 		= 10;
				y		= 2;
			}
			_inputBack.addChild(_playerInput);
			

			this.dispatchEvent(new GameEvent(GameEvent.PANEL_ADDED));
		}
		
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									animation sequences
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	

		private function animateIn():void
		{
			TweenLite.from(_canvas, 1.0, { delay:0.1, alpha:0} );
		}
		
		private function animateOut():void
		{
			TweenLite.to(_canvas, 1.0, { delay:0.1, alpha:0, onComplete:Main.display.events.removeBuildProfile} );
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									event handlers 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++				

		private function addEventHandlers():void
		{
			_btn_continue.addEventListener(MouseEvent.MOUSE_DOWN, continueDown, false, 0, true);
		}
		
		private function continueDown(e:MouseEvent):void 
		{
			CrewData.name_captain  			= _playerInput.get_text;
			CrewData.img_captain			= _avatar.drawAvatar();
			
			animateOut();
			removeEventHandlers();
		}
		
		private function removeEventHandlers():void
		{
			_btn_continue.removeEventListener(MouseEvent.MOUSE_DOWN, continueDown);
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
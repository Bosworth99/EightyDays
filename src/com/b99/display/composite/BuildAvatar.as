package com.b99.display.composite 
{
	import com.b99.data.CharacterData;
	import com.b99.data.GameData;
	import com.b99.display.element.CustomRoundRectGrad;
	import com.b99.event.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class BuildAvatar extends Sprite
	{
		
		private var _canvas					:Sprite;
		private var _base					:CustomRoundRectGrad;
		
		private var _avatarCon				:Sprite;
		private var _mask					:CustomRoundRectGrad;
		private var _container				:Sprite;
		
		private var _frame					:CustomRoundRectGrad;
		
		private var _selectorCon			:Sprite;
		
		private var _avt_body				:Sprite;
		private var _avt_head				:Sprite;
		private var _avt_mouth				:Sprite;
		private var _avt_facialHair			:Sprite;
		private var _avt_eyes				:Sprite;
		private var _avt_accessory			:Sprite;
		private var _avt_eyebrow			:Sprite;
		private var _avt_hair				:Sprite;
		private var _avt_hat				:Sprite;
		
		private var _body_selector			:AvatarSelector;
		private var _head_selector			:AvatarSelector;
		private var _mouth_selector			:AvatarSelector;
		private var _facialHair_selector	:AvatarSelector;
		private var _eyes_selector			:AvatarSelector;
		private var _accessory_selector		:AvatarSelector;
		private var _eyebrow_selector		:AvatarSelector;
		private var _hair_selector			:AvatarSelector;
		private var _hat_selector			:AvatarSelector;
		
		public function BuildAvatar() 
		{
			super();
			init();
		}
		
		private function init():void
		{
			assembleDisplayObjects();
			buildAvatar();
			addEventHandlers();
		}
		
		private function assembleDisplayObjects():void
		{
			_canvas = new Sprite();
			this.addChild(_canvas);
			
			_container = new Sprite();
			_canvas.addChild(_container);
			
			_avatarCon = new Sprite();
			_container.addChild(_avatarCon);
			
			_base 	= new CustomRoundRectGrad(	300,
												451, 
												25, 
												"linear", 
												[0x3A3923, 0x84824F], 
												[1, 1],
												[1, 255],
												270,
												3,
												GameData.COLOR_TEXT,
												1
											);
			_base.filters = [ new DropShadowFilter(8, 45, 0x1A180F, .6, 15, 15, 1)];
			_avatarCon.addChild(_base);
			
			
											
			_mask 	= new CustomRoundRectGrad(	300,
												451, 
												25, 
												"linear", 
												[0x00FF00], 
												[1],
												[1],
												270,
												3,
												0x00FF00,
												1
											);
			_canvas.addChild(_mask);
			_container.mask = _mask;
			
			_frame 	= new CustomRoundRectGrad(	300,
												451, 
												25, 
												"linear", 
												[0x3A3923, 0x84824F], 
												[0, 0],
												[1, 255],
												270,
												3,
												GameData.COLOR_TEXT,
												1
											);
			_canvas.addChild(_frame);
			
			//+++++++++++++ selectors
			
			_selectorCon = new Sprite();
			with (_selectorCon) 
			{
				x	= 350;
				y	= 10;
			}
			_canvas.addChild(_selectorCon);
			
			_hat_selector = new AvatarSelector("Hat", "hat");
			with (_hat_selector) 
			{
				x 	= 0;
				y	= 0;
			}
			_selectorCon.addChild(_hat_selector);
			
			_hair_selector = new AvatarSelector("Hair", "hair");
			with (_hair_selector) 
			{
				x 	= 0;
				y	= 50;
			}
			_selectorCon.addChild(_hair_selector);
			
			_eyebrow_selector = new AvatarSelector("Eyebrow", "eyebrow");
			with (_eyebrow_selector) 
			{
				x 	= 0;
				y	= 100;
			}
			_selectorCon.addChild(_eyebrow_selector);
			
			_accessory_selector = new AvatarSelector("Accessories", "accessory");
			with (_accessory_selector) 
			{
				x 	= 0;
				y	= 150;
			}
			_selectorCon.addChild(_accessory_selector);
			
			_eyes_selector = new AvatarSelector("Eyes", "eyes");
			with (_eyes_selector) 
			{
				x 	= 0;
				y	= 200;
			}
			_selectorCon.addChild(_eyes_selector);
			
			_facialHair_selector = new AvatarSelector("Facial Hair", "facialHair");
			with (_facialHair_selector) 
			{
				x 	= 0;
				y	= 250;
			}
			_selectorCon.addChild(_facialHair_selector);
			
			_mouth_selector = new AvatarSelector("Mouth", "mouth");
			with (_mouth_selector) 
			{
				x 	= 0;
				y	= 300;
			}
			_selectorCon.addChild(_mouth_selector);
			
			_head_selector = new AvatarSelector("Head", "head");
			with (_head_selector) 
			{
				x 	= 0;
				y	= 350;
			}
			_selectorCon.addChild(_head_selector);
			
			_body_selector = new AvatarSelector("Body", "body");
			with (_body_selector) 
			{
				x 	= 0;
				y	= 400;
			}
			_selectorCon.addChild(_body_selector);
			
		}

		private function addEventHandlers():void
		{
			_body_selector.addEventListener			(GameEvent.UPDATE_AVATAR, updateBody, 		false, 0, true);
			_head_selector.addEventListener			(GameEvent.UPDATE_AVATAR, updateHead, 		false, 0, true);
			_mouth_selector.addEventListener		(GameEvent.UPDATE_AVATAR, updateMouth, 		false, 0, true);
			_facialHair_selector.addEventListener	(GameEvent.UPDATE_AVATAR, updateFacialHair, false, 0, true);
			_eyes_selector.addEventListener			(GameEvent.UPDATE_AVATAR, updateEyes, 		false, 0, true);
			_accessory_selector.addEventListener	(GameEvent.UPDATE_AVATAR, updateAccessory, 	false, 0, true);
			_eyebrow_selector.addEventListener		(GameEvent.UPDATE_AVATAR, updateEyebrow, 	false, 0, true);
			_hair_selector.addEventListener			(GameEvent.UPDATE_AVATAR, updateHair, 		false, 0, true);
			_hat_selector.addEventListener			(GameEvent.UPDATE_AVATAR, updateHat, 		false, 0, true);	
		}
		
		private function buildAvatar():void
		{
			updateBody();
			updateHead();
			updateMouth();
			updateFacialHair();
			updateEyes();
			updateAccessory();
			updateEyebrow();
			updateHair();
			updateHat();
		}
		
		private function updateBody(e:GameEvent = null):void
		{
			if (_avt_body) 
			{
				_avatarCon.removeChild(_avt_body);
				_avt_body = null;
			}
			
			var bodyClass:Object = getDefinitionByName(CharacterData.player_Body[CharacterData.player_captain[0]]);
			_avt_body = new bodyClass();
	
			_avatarCon.addChildAt(_avt_body,1);
		}
		
		private function updateHead(e:GameEvent = null):void
		{
			if (_avt_head) 
			{
				_avatarCon.removeChild(_avt_head);
				_avt_head = null;
			}
			
			var headClass:Object = getDefinitionByName(CharacterData.player_Head[CharacterData.player_captain[1]]);
			_avt_head = new headClass();
	
			_avatarCon.addChildAt(_avt_head,2);
		}
		
		private function updateMouth(e:GameEvent = null):void
		{
			if (_avt_mouth) 
			{
				_avatarCon.removeChild(_avt_mouth);
				_avt_mouth = null;
			}
			
			var mouthClass:Object = getDefinitionByName(CharacterData.player_Mouth[CharacterData.player_captain[2]]);
			_avt_mouth = new mouthClass();
	
			_avatarCon.addChildAt(_avt_mouth,3);
		}
		
		private function updateFacialHair(e:GameEvent = null):void
		{
			if (_avt_facialHair) 
			{
				_avatarCon.removeChild(_avt_facialHair);
				_avt_facialHair = null;
			}
			
			var facialHairClass:Object = getDefinitionByName(CharacterData.player_FacialHair[CharacterData.player_captain[3]]);
			_avt_facialHair = new facialHairClass();
	
			_avatarCon.addChildAt(_avt_facialHair,4);
		}
		
		private function updateEyes(e:GameEvent = null):void
		{
			if (_avt_eyes) 
			{
				_avatarCon.removeChild(_avt_eyes);
				_avt_eyes = null;
			}
			
			var eyeClass:Object = getDefinitionByName(CharacterData.player_Eyes[CharacterData.player_captain[4]]);
			_avt_eyes = new eyeClass();
	
			_avatarCon.addChildAt(_avt_eyes,5);
			
		}
		
		private function updateAccessory(e:GameEvent = null):void
		{
			if (_avt_accessory) 
			{
				_avatarCon.removeChild(_avt_accessory);
				_avt_accessory = null;
			}
			
			var accessClass:Object = getDefinitionByName(CharacterData.player_Accessory[CharacterData.player_captain[5]]);
			_avt_accessory = new accessClass();
	
			_avatarCon.addChildAt(_avt_accessory,6);
		}
		
		private function updateEyebrow(e:GameEvent = null):void
		{
			if (_avt_eyebrow) 
			{
				_avatarCon.removeChild(_avt_eyebrow);
				_avt_eyebrow = null;
			}
			
			var eyebrowClass:Object = getDefinitionByName(CharacterData.player_Eyebrow[CharacterData.player_captain[6]]);
			_avt_eyebrow = new eyebrowClass();
	
			_avatarCon.addChildAt(_avt_eyebrow,7);
		}
		
		
		private function updateHair(e:GameEvent = null):void
		{
			if (_avt_hair) 
			{
				_avatarCon.removeChild(_avt_hair);
				_avt_hair = null;
			}
			
			var hairClass:Object = getDefinitionByName(CharacterData.player_Hair[CharacterData.player_captain[7]]);
			_avt_hair = new hairClass();
	
			_avatarCon.addChildAt(_avt_hair,8);

		}
		
		private function updateHat(e:GameEvent = null):void
		{
			if (_avt_hat) 
			{
				_avatarCon.removeChild(_avt_hat);
				_avt_hat = null;
			}
			
			var hatClass:Object = getDefinitionByName(CharacterData.player_Hat[CharacterData.player_captain[8]]);
			_avt_hat = new hatClass();
	
			_avatarCon.addChildAt(_avt_hat,9);
		}

		public function drawAvatar():Bitmap
		{
			var data:BitmapData = new BitmapData(300, 451);
			data.draw(_avatarCon);
			
			var bitmap:Bitmap = new Bitmap(data, "auto", true );
			return bitmap;
		}
		
	}
}
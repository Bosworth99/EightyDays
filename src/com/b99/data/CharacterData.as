///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>data>CharacterData.as
//
//	extends : Object	
//	data container for npc and player character graphics
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data 
{

	/**
	 * ...
	 * @author bosworth99
	 */
	public class CharacterData extends Object
	{
		public function CharacterData() { };
		
		
		private static var _player_Body			:Array = [	"GFX_avatar_body_0",
															"GFX_avatar_body_1"
														];
														
		private static var _player_Head			:Array = [	"GFX_avatar_head_0",
															"GFX_avatar_head_1",
															"GFX_avatar_head_2"
														];

		private static var _player_Mouth		:Array = [	"GFX_avatar_mouth_0"
														];
														
		private static var _player_FacialHair	:Array = [	"GFX_avatar_empty",
															"GFX_avatar_facialHair_0",
															"GFX_avatar_facialHair_1"
														];												
		
		private static var _player_Eyes			:Array = [	"GFX_avatar_eyes_0",
															"GFX_avatar_eyes_1"
														];		
							
		private static var _player_Accessory	:Array = [	"GFX_avatar_empty",
															"GFX_avatar_accessory_0",
															"GFX_avatar_accessory_1"
														];
														
		private static var _player_Eyebrow		:Array = [	"GFX_avatar_empty",
															"GFX_avatar_eyebrow_0",
															"GFX_avatar_eyebrow_1",
															"GFX_avatar_eyebrow_2"
														];												
														
		private static var _player_Hair			:Array = [	"GFX_avatar_empty",
															"GFX_avatar_Hair_0"
														];												
														
		private static var _player_Hat			:Array = [	"GFX_avatar_empty",
															"GFX_avatar_Hat_0"
														];												
																									
		private static var _player_captain		:Array = [0, 0, 0, 1, 0, 1, 1, 1, 1];
		
		
		//+++++++++++++++++++++++ part arrays
		static public function get player_Body():Array 			{ return _player_Body; }
		static public function get player_Head():Array 			{ return _player_Head; }
		static public function get player_Mouth():Array 		{ return _player_Mouth; }
		static public function get player_FacialHair():Array 	{ return _player_FacialHair; }
		static public function get player_Eyes():Array 			{ return _player_Eyes; }
		static public function get player_Accessory():Array 	{ return _player_Accessory; }
		static public function get player_Eyebrow():Array 		{ return _player_Eyebrow; }
		static public function get player_Hair():Array 			{ return _player_Hair; }
		static public function get player_Hat():Array 			{ return _player_Hat; }
		
		static public function get player_captain():Array 		{ return _player_captain; }
		static public function set player_captain(value:Array):void 
		{
			_player_captain = value;
		}

		
	}
}
///////////////////////////////////////////////////////////////////////////////
//
//	com>jboz>b99>TextFieldFormat.as
//
//	note: build generic text fields, assign formatting at time of instantiation
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.display.element
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	
	public class TextFieldFormat extends Sprite
	{
		//+++++++++++++Fonts+++++++++++++++++++++++++
		//private var _kaufmann			:Font = new Kaufmann();
		private var _verdana			:Font = new Verdana();
		
		//+++++++++++++++++Text format+++++++++++++++
		private var _format_verdana		:TextFormat = new TextFormat();
		private var _format_generic		:TextFormat = new TextFormat();
		
		//++++++++++++++++++Text Fields++++++++++++++
		private var _textFieldFormat	:TextField;
		
		//++++++++++++++++++Strings++++++++++++++++++
		
		private var _text				:String;
		private var _intent				:String;
		
		//++++++++++++++++++numerics+++++++++++++++++
		
		private var _color				:uint;
		private var _size				:uint;
		private var _height				:uint;
		private var _width				:uint;
		private var _input				:Boolean;
		private var _maxChars			:uint;
		
		/**
		* @private
		* create hit states for a generic button
		* 
		* @param text		:string, gathered from xml that define textfield contents
		* @param color		:uint, color of the text	
		* @param size		:uint, font size
		* @param intent		:string, intent of text field = "verdana" "verdana_text" "generic" 
		* @param height		:uint, textfield height
		* @param width		:uint, textfield width
		* @param input		:boolean, textfield editable?
		*/
		
		public function TextFieldFormat(text:String , color:uint, size:uint, intent:String = "generic", height:uint = 20,  width:uint = 30, input:Boolean = false, maxChars:uint = 25) 
		{
			super();
		
			_text 		= text;
			_intent 	= intent;
			_color 		= color;
			_size 		= size;
			_height 	= height;
			_width 		= width;
			_input 		= input;
			_maxChars	= maxChars;

			buildFormats();
			buildTextField();
		}
		/**
		 * @private
		 * assign formats for text fields to use, color and size is passed at time of instantiation, making them flexible
		 * 
		 * @param	_color
		 * @param	_size
		 */
		private function buildFormats():void
		{
			with (_format_generic) { 							color = _color; size = _size;  	align = TextFormatAlign.LEFT };
			with (_format_verdana) { font = _verdana.fontName; 	color = _color; size = _size; 	align = TextFormatAlign.LEFT };
		}
		/**
		 * @private use the _intent switch to define different text fields for differing purposes
		 * 
		 * @param	_text:String =  text to display
		 * @param	_intent:string  = "verdana_title", "verdana_text", "kaufmann"
		 * @param	_height:uint = if the intent is a text, define a height
		 * @param	_width:uint = if the intent is a text, define a width
		 */
		private function buildTextField():void
		{
			_textFieldFormat = new TextField();
			
			switch (_intent) 
			{
				case "generic":
				{
					with (_textFieldFormat) 
					{
						autoSize 			= TextFieldAutoSize.LEFT;
						defaultTextFormat 	= _format_generic;
						text 				= _text;
						
						if (_input)
						{
							maxChars		= _maxChars;
							type 			= TextFieldType.INPUT;
							selectable 		= true;	
						}
						else
						{
							selectable 		= false;	
						}
					}
					break;
				}
				case "verdana":
				{
					with (_textFieldFormat) 
					{
						autoSize 			= TextFieldAutoSize.LEFT;
						defaultTextFormat 	= _format_verdana;
						embedFonts 			= true;
						antiAliasType 		= AntiAliasType.ADVANCED;
						text 				= _text;
						width 				= _width;
						height				= _height;
						
						if (_input)
						{
							maxChars		= _maxChars;
							type 			= TextFieldType.INPUT;
							selectable 		= true;	
						}
						else
						{
							selectable 		= false;	
						}
					}
					break;
				}
				case "verdana_text":
				{
					with (_textFieldFormat) 
					{
						defaultTextFormat 	= _format_verdana;
						embedFonts 			= true;
						antiAliasType 		= AntiAliasType.ADVANCED;
						text 				= _text;
						width 				= _width;
						height				= _height;
						multiline 			= true;
						wordWrap  			= true;
						
						if (_input)
						{
							maxChars		= _maxChars;
							type 			= TextFieldType.INPUT;
							selectable 		= true;	
						}
						else
						{
							selectable 		= false;	
						}
					}
					break;
				}
			}
			
			this.addChild(_textFieldFormat);
			
		}
		
		public function destroy():void
		{
			_verdana = null;
		
			_format_verdana 	= null;
			_format_generic		= null;
			
			this.removeChild(_textFieldFormat);
			_textFieldFormat = null;
			
			this.parent.removeChild(this);
		}
		
		public function set set_text(newText:String):void 
		{
			_textFieldFormat.text = newText;
		}
		public function get get_text():String
		{
			return _textFieldFormat.text;
		}

	}
}
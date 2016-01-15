///////////////////////////////////////////////
//
//	com>b99>display>element>CustomRoundRectGrad.as
//
//	extends sprite, DisplayObject called from mulitiple locations
//	passes parameters to construct simple round square object
// 	addition of gradient fill
//	
//
///////////////////////////////////////////////
package com.b99.display.element 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CustomRoundRectGrad extends Sprite
	{
		private var _generic		:Sprite;
		
		private var _width_px		:uint;
		private var _height_px		:uint;
		private var _ellipse_px		:uint;
		private var _line_px		:uint;
		private var _line_color		:uint;
		private var _grad_type		:String;
		private var _colors			:Array;
		private var _alphas			:Array;
		private var _ratios			:Array;
		private var _grad_rotation	:Number;
		private var _line_alpha		:Number;
		
		/**
		 * @private construct a round rectangle with specified fill and line style
		 *	add mutliple colors to the gradient by extending the array. each array needs synchronous indexes
		 * 
		 * 
		 * @param	width_px		:uint	- width of rect
		 * @param	height_px		:uint	- height of rect
		 * @param 	ellipse_px		:uint 	- diameter of round corners
		 * @param	line_px			:uint	- pixel thickness of line
		 * @param	line_color		:uint	- line color
		 * @param	line_alpha		:Number	- line alpha
		 * @param	grad_type		:String	- type of gradient "linear" or "radial"
		 * @param	colors			:Array	- color values
		 * @param	alphas			:Array	- aplha values
		 * @param	ratios			:Array 	- gradient ratios for each color/alpha
		 * @param	grad_rotation	:uint	- rotation of gradient
		 * 
		 * 
		 */
		
		public function CustomRoundRectGrad(width_px:uint, height_px:uint, ellipse_px:uint, grad_type:String, colors:Array, alphas:Array, ratios:Array, grad_rotation:Number, line_px:uint = 1, line_color:uint = 0x000000, line_alpha:Number = 1) 
		{
			super();
			

			_width_px 		= width_px;
			_height_px 		= height_px;
			_ellipse_px 	= ellipse_px;
			_grad_type 		= grad_type;
			_colors			= colors;
			_alphas			= alphas;
			_ratios			= ratios;
			_grad_rotation 	= grad_rotation;
			_line_px 		= line_px;
			_line_color 	= line_color;
			_line_alpha		= line_alpha;
			
			draw();
		}
		
		private function draw():void
		{
			_generic = new Sprite();
			
			var matrix:Matrix = new Matrix(); 
			matrix.createGradientBox(_width_px, _height_px, deg2rad(_grad_rotation));
			switch (_grad_type) {
				case "linear" :
				{
					_grad_type = GradientType.LINEAR;
					break;
				}
				case "radial" :
				{
					_grad_type = GradientType.RADIAL;
					break;
				}	
			}
			
			with (_generic) 
			{
				graphics.lineStyle(_line_px, _line_color, _line_alpha, false);
				graphics.beginGradientFill(_grad_type, _colors, _alphas, _ratios, matrix);
				graphics.drawRoundRect(0, 0, _width_px, _height_px, _ellipse_px, _ellipse_px);
				graphics.endFill();
			}
			_generic.cacheAsBitmap = true;
			this.addChild(_generic);
		}
		
		private function deg2rad(deg:Number):Number{
			return deg * (Math.PI/180);
		}
		
		public function destroy():void
		{
			this.removeChild(_generic);
			_generic = null;
			
			_alphas.splice(0, _alphas.length);
			_alphas = null;
			
			_colors.splice(0, _colors.length);
			_colors = null;
			
			_ratios.splice(0, _ratios.length);
			_ratios = null;
			
			this.parent.removeChild(this);
		}
	}
}
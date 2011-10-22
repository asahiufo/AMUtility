package org.ahiufomasao.utility.display
{
	import flash.display.Graphics;
	
	/**
	 * <code>GraphicsDrawer</code> クラスは、単純な図形の描画を行います.
	 * <p>
	 * まず描画色等の描画設定を指定して <code>GraphicsDrawer</code> オブジェクトを作成します。
	 * 各描画メソッドを、描画対象の <code>Graphics</code> オブジェクトを渡して呼び出すことで、
	 * 対象の <code>Graphics</code> オブジェクトへ描画設定に従った描画を行います。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class GraphicsDrawer 
	{
		private var _lineColor:uint;   // 線色
		private var _fillColor:uint;   // 塗り色
		private var _lineSize:Number;  // 線幅
		private var _lineDraw:Boolean; // 線を描画するならtrue
		private var _fill:Boolean;     // 塗りつぶすならtrue
		
		/**
		 * 新しい <code>GraphicsDrawer</code> クラスのインスタンスを生成します.
		 * 
		 * @param lineColor 描画される線の色です。
		 * @param fillColor 描画される塗りの色です。
		 * @param lineSize  描画される線の幅です。
		 * @param lineDraw  線を描画する場合は true、しない場合は false を設定します。
		 * @param fill      塗りつぶす場合は true、塗りつぶさない場合は false を設定します。
		 */
		public function GraphicsDrawer(
			lineColor:uint   = 0x000000,
			fillColor:uint   = 0x000000,
			lineSize:Number  = 0,
			lineDraw:Boolean = true,
			fill:Boolean     = true
		)
		{
			reset(lineColor, fillColor, lineSize, lineDraw, fill);
		}
		
		/**
		 * 描画設定を再設定します.
		 * 
		 * @param lineColor 描画される線の色です。
		 * @param fillColor 描画される塗りの色です。
		 * @param lineSize  描画される線の幅です。
		 * @param lineDraw  線を描画する場合は true、しない場合は false を設定します。
		 * @param fill      塗りつぶす場合は true、塗りつぶさない場合は false を設定します。
		 */
		public function reset(
			lineColor:uint   = 0x000000,
			fillColor:uint   = 0x000000,
			lineSize:Number  = 0,
			lineDraw:Boolean = true,
			fill:Boolean     = true
		):void
		{
			_lineColor = lineColor;
			_fillColor = fillColor;
			_lineSize  = lineSize;
			_lineDraw  = lineDraw;
			_fill      = fill;
		}
		
		/**
		 * 線を描画します.
		 * <p>
		 * 始点座標から終点座標へ線を描画します。
		 * </p>
		 * 
		 * @param target 描画対象の <code>Graphics</code> オブジェクトです。
		 * @param x1     始点の <code>x</code> 座標です。
		 * @param y1     始点の <code>y</code> 座標です。
		 * @param x2     終点の <code>x</code> 座標です。
		 * @param y2     終点の <code>y</code> 座標です。
		 * 
		 * @throws ArgumentError <code>target</code> パラメータに <code>null</code> を指定した場合にスローされます。
		 */
		public function drawLine(target:Graphics, x1:Number, y1:Number, x2:Number, y2:Number):void
		{
			if (target == null)
			{
				throw new ArgumentError("target パラメータに null を指定することはできません。");
			}
			
			target.lineStyle(_lineSize, _lineColor); // 線幅、線色
			target.moveTo(x1, y1); // 始点のx、y座標
			target.lineTo(x2, y2); // 終点のx、y座標
		}
		
		/**
		 * 矩形を描画します.
		 * 
		 * @param target 描画対象の <code>Graphics</code> オブジェクトです。
		 * @param x      描画する矩形の左上角の <code>x</code> 座標です。
		 * @param y      描画する矩形の左上角の <code>y</code> 座標です。
		 * @param w      描画する矩形の横幅です。
		 * @param h      描画する矩形の高さです。
		 * 
		 * @throws ArgumentError <code>target</code> パラメータに <code>null</code> を指定した場合にスローされます。
		 */
		public function drawRectangle(target:Graphics, x:Number, y:Number, w:Number, h:Number):void
		{
			if (target == null)
			{
				throw new ArgumentError("target パラメータに null を指定することはできません。");
			}
			
			// 塗り開始
			if (_fill)
			{
				target.beginFill(_fillColor);
			}
			
			// 線を描く場合
			if (_lineDraw)
			{
				target.lineStyle(_lineSize, _lineColor); // 線スタイル設定
			}
			
			target.drawRect(x, y, w, h); // 矩形作成
			
			// 塗り終了
			if (_fill)
			{
				target.endFill();
			}
		}
		
		/**
		 * 円を描画します.
		 * 
		 * @param target 描画対象の <code>Graphics</code> オブジェクトです。
		 * @param x      描画する円の中心の <code>x</code> 座標です。
		 * @param y      描画する円の中心の <code>y</code> 座標です。
		 * @param r      描画する円の半径です。
		 * 
		 * @throws ArgumentError <code>target</code> パラメータに <code>null</code> を指定した場合にスローされます。
		 */
		public function drawCircle(target:Graphics, x:Number, y:Number, r:Number):void
		{
			if (target == null)
			{
				throw new ArgumentError("target パラメータに null を指定することはできません。");
			}
			
			// 塗り開始
			if (_fill)
			{
				target.beginFill(_fillColor);
			}
			
			// 線を描く場合
			if (_lineDraw)
			{
				target.lineStyle(_lineSize, _lineColor); // 線スタイル設定
			}
			
			target.drawCircle(x, y, r); // 円作成
			
			// 塗り終了
			if (_fill)
			{
				target.endFill();
			}
		}
	}
}

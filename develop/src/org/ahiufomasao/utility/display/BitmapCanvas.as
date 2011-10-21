package org.ahiufomasao.utility.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.errors.IllegalOperationError;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * <code>BitmapCanvas</code> クラスは、ビットマップの描画を行ないます.
	 * <p>
	 * <code>BitmapCanvas</code> クラスは、<code>BitmapData</code> をラップしており、一般的な描画処理を提供します。
	 * </p>
	 * <p>
	 * 描画した内容は、 <code>BitmapCanvas</code> オブジェクトを <code>added</code> メソッドにより、
	 * <code>DisplayObjectContainer</code> へ登録することにより表示されるようになります。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class BitmapCanvas
	{
		private var _width:uint;        // 横幅
		private var _height:uint;       // 高さ
		
		private var _smoothing:Boolean; // スムージング
		
		private var _canvas:Bitmap;     // 描画対象ビットマップ
		
		private var _filterForSlowlyClear:ColorMatrixFilter; // ゆっくりクリア用フィルタ
		
		private var _point:Point;       // 汎用ポイント
		private var _rect:Rectangle;    // 汎用矩形
		private var _matrix:Matrix;     // 汎用マトリックス
		
		/**
		 * キャンバスの横幅です.
		 */
		public function get width():uint { return _width; }
		/**
		 * キャンバスの高さです.
		 */
		public function get height():uint { return _height; }
		/**
		 * 描画内容をクリアするスピードです.
		 */
		public function get slowlyClearSpeed():Number { return -Number(_filterForSlowlyClear.matrix[19]); }
		/** @private */
		public function set slowlyClearSpeed(value:Number):void
		{
			_filterForSlowlyClear = new ColorMatrixFilter(
				[1, 0, 0, 0, 0,
				 0, 1, 0, 0, 0,
				 0, 0, 1, 0, 0,
				 0, 0, 0, 1, -value]
			);
		}
		
		/**
		 * 新しい <code>BitmapCanvas</code> クラスのインスタンスを生成します.
		 * 
		 * @param width     キャンバスのピクセル単位の横幅です。
		 * @param height    キャンバスのピクセル単位の高さです。
		 * @param smoothing <code>true</code> を設定するとビットマップが滑らかになります。
		 */
		public function BitmapCanvas(width:uint, height:uint, smoothing:Boolean = false)
		{
			var bitmapData:BitmapData = new BitmapData(width, height);
			_canvas = new Bitmap(bitmapData, "auto", smoothing);
			
			_width     = width;
			_height    = height;
			
			_smoothing = smoothing;
			
			_filterForSlowlyClear = new ColorMatrixFilter(
				[1, 0, 0, 0, 0,
				 0, 1, 0, 0, 0,
				 0, 0, 1, 0, 0,
				 0, 0, 0, 1, -1]
			);
			
			_point     = new Point();
			_rect      = new Rectangle();
			_matrix    = new Matrix();
			
			// 最初に画面内容を消去しておく
			clear();
		}
		
		/**
		 * キャンバスを描画リストに登録します.
		 * 
		 * @param stage キャンバスを登録する <code>DisplayObjectContainer</code> です。
		 * 
		 * @throws IllegalOperationError すでにキャンバスが描画リストに登録されている場合にスローされます。
		 */
		public function added(stage:DisplayObjectContainer):void
		{
			// すでに登録されているなら
			if (_canvas.parent != null)
			{
				// 例外
				throw new IllegalOperationError("すでに描画リストに登録されているキャンバスはリストに登録できません。");
			}
			
			stage.addChild(_canvas);
		}
		
		/**
		 * キャンバスを描画リストから削除します.
		 * 
		 * @throws IllegalOperationError キャンバスが描画リストに登録していない場合にスローされます。
		 */
		public function removed():void
		{
			// 登録されていないなら
			if (_canvas.parent == null)
			{
				// 例外
				throw new IllegalOperationError("描画リストに登録されていないキャンバスをリストから削除できません。");
			}
			
			_canvas.parent.removeChild(_canvas);
		}
		
		/**
		 * キャンバスの座標を設定します.
		 * 
		 * @param x キャンバスの <code>x</code> 座標です。
		 * @param y キャンバスの <code>y</code> 座標です。
		 */
		public function setPosition(x:Number, y:Number):void
		{
			_canvas.x = x;
			_canvas.y = y;
		}
		
		/**
		 * キャンバスを 1 色で塗りつぶします.
		 * 
		 * @param color 塗りつぶす色です。<code>0xAARRGGBB</code> の形式で指定します。
		 */
		public function fill(color:uint):void
		{
			var canvasData:BitmapData = _canvas.bitmapData;
			canvasData.fillRect(canvasData.rect, color);
		}
		
		/**
		 * キャンバスにオブジェクトを描画します.
		 * 
		 * @param drawable  描画するオブジェクトです。<code>BitmapData</code> または <code>DisplayObject</code> オブジェクトを指定します。
		 * @param destPoint オブジェクトを描画する位置です。省略した場合は <code>x</code>、<code>y</code> 座標共に 0 として描画されます。
		 * @param matrix    オブジェクトを描画する際に加える効果変換データです。ただし、描画位置は <code>destPoint</code> パラメータが適用されます。
		 */
		public function draw(drawable:IBitmapDrawable, destPoint:Point = null, matrix:Matrix = null):void
		{
			// 描画位置が省略された場合は0,0
			if (destPoint == null)
			{
				destPoint = _point;
				destPoint.x = 0;
				destPoint.y = 0;
			}
			
			// copyPixelsを使用するパターン
			if (drawable is BitmapData && matrix == null)
			{
				var rect:Rectangle = _rect;
				rect.x      = 0;
				rect.y      = 0;
				rect.width  = BitmapData(drawable).width;
				rect.height = BitmapData(drawable).height;
				_canvas.bitmapData.copyPixels(BitmapData(drawable), rect, destPoint, null, null, true);
			}
			// drawを使用するパターン
			else
			{
				// 効果変換データが作られていない場合作る
				if (matrix == null)
				{
					matrix    = _matrix;
					matrix.a  = 1;
					matrix.b  = 0;
					matrix.c  = 0;
					matrix.d  = 1;
					matrix.tx = 0;
					matrix.ty = 0;
				}
				// 表示位置をリセット
				matrix.translate(-matrix.tx, -matrix.ty);
				// 表示位置の設定
				matrix.translate(destPoint.x, destPoint.y);
				// 描画
				_canvas.bitmapData.draw(drawable, matrix, null, null, null, _smoothing);
			}
		}
		
		/**
		 * 描画内容の消去します.
		 */
		public function clear():void
		{
			var canvasData:BitmapData = _canvas.bitmapData;
			canvasData.fillRect(canvasData.rect, 0x00FFFFFF);
		}
		
		/**
		 * 描画内容を徐々に消去します.
		 * <p>
		 * <code>slowlyClearSpeed</code> プロパティに応じて、消去スピードが変化します。
		 * </p>
		 */
		public function clearSlowly():void
		{
			var canvasData:BitmapData = _canvas.bitmapData;
			_point.x = 0;
			_point.y = 0;
			canvasData.applyFilter(canvasData, canvasData.rect, _point, _filterForSlowlyClear);
		}
		
		/**
		 * 描画の更新を停止します.
		 */
		public function lock():void
		{
			_canvas.bitmapData.lock();
		}
		
		/**
		 * 描画の更新を再開します.
		 */
		public function unlock():void
		{
			_canvas.bitmapData.unlock();
		}
	}
}

package org.ahiufomasao.utility.geom 
{
	import org.ahiufomasao.utility.MathUtility;
	
	/**
	 * <code>Vector2D</code> クラスは、2 次元のベクトルを表現します.
	 * <p>
	 * <code>x</code>、<code>y</code> 軸それぞれの大きさと、ベクトル表現の相互変換機能を提供します。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class Vector2D 
	{
		private var _x:Number; // x軸方向の大きさ
		private var _y:Number; // y軸方向の大きさ
		
		/**
		 * <code>x</code> 軸方向の大きさです.
		 */
		public function get x():Number { return _x; }
		/** @private */
		public function set x(value:Number):void { _x = value; }
		
		/**
		 * <code>y</code> 軸方向の大きさです.
		 */
		public function get y():Number { return _y; }
		/** @private */
		public function set y(value:Number):void { _y = value; }
		
		/**
		 * ベクトルの大きさです.
		 */
		public function get size():Number { return Math.sqrt(_x * _x + _y * _y); }
		/** @private */
		public function set size(value:Number):void
		{
			_x = Math.cos(angle) * value;
			_y = Math.sin(angle) * value;
		}
		
		/**
		 * ベクトルの角度です.
		 * <p>
		 * ベクトルの向きを表す角度です。0 度が右水平方向で、時計回りに角度が 0 ～　360 の範囲で増えます。
		 * </p>
		 */
		public function get angle():Number
		{
			var angle:Number = MathUtility.calculateAngle(Math.atan2(_y, _x));
			angle = angle < 0 ? angle + 360 : angle;
			return angle;
		}
		/** @private */
		public function set angle(value:Number):void
		{
			// ラジアン
			var rad:Number = MathUtility.calculateRadians(value);
			
			_x = size * Math.cos(rad);
			_y = size * Math.sin(rad);
		}
		
		/**
		 * 新しい <code>Vector2D</code> クラスのインスタンスを生成します.
		 * 
		 * @param x <code>x</code> 軸方向の大きさです。
		 * @param y <code>y</code> 軸方向の大きさです。
		 */
		public function Vector2D(x:Number = 0, y:Number = 0) 
		{
			_x = x;
			_y = y;
		}
		
		/**
		 * ベクトルを加算します.
		 * 
		 * @param v 加算するベクトルです。
		 * 
		 * @return 加算後の自分自身です。
		 */
		public function add(v:Vector2D):Vector2D
		{
			_x += v.x;
			_y += v.y;
			return this;
		}
		
		/**
		 * ベクトルを減算します.
		 * 
		 * @param v 減算するベクトルです。
		 * 
		 * @return 減算後の自分自身です。
		 */
		public function subtract(v:Vector2D):Vector2D
		{
			_x -= v.x;
			_y -= v.y;
			return this;
		}
		
		/**
		 * ベクトルを乗算します.
		 * 
		 * @param value 乗算する値です。
		 * 
		 * @return 乗算後の自分自身です。
		 */
		public function multiply(value:Number):Vector2D
		{
			_x *= value;
			_y *= value;
			return this;
		}
		
		/**
		 * ベクトルを除算します.
		 * 
		 * @param value 除算する値です。
		 * 
		 * @return 除算後の自分自身です。
		 */
		public function divide(value:Number):Vector2D
		{
			_x /= value;
			_y /= value;
			return this;
		}
		
		/**
		 * 内積を計算します.
		 * 
		 * @param v 内積計算に用いるもう一方のベクトルです。
		 * 
		 * @return 内積です。
		 */
		public function calculateDotProduct(v:Vector2D):Number
		{
			return (_x * v.x + _y * v.y);
		}
		
		/**
		 * 正規化します.
		 * <p>
		 * ベクトルの長さを <code>thickness</code> 値にするために
		 * <code>x</code> および <code>y</code> プロパティの値を変更します。
		 * </p>
		 * 
		 * @param thickness 目指すベクトルの長さです。
		 * 
		 * @return 正規化後の自分自身です。
		 */
		public function normalize(thickness:Number = 1.0):Vector2D
		{
			if (size == 0)
			{
				_x = 1.0;
				return this;
			}
			
			var scale:Number = thickness / size;
			_x *= scale;
			_y *= scale;
			
			return this;
		}
		
		/**
		 * ベクトル同士の距離を求めます.
		 * 
		 * @param v 距離を求めるもう一方のベクトルです。
		 * 
		 * @return 距離です。
		 */
		public function calculateDistance(v:Vector2D):Number
		{
			return Math.sqrt(calculateDistanceSquared(v));
		}
		
		/**
		 * ベクトル間の直行距離を求めます.
		 * 
		 * @param v 直行距離を求めるもう一方のベクトルです。
		 * 
		 * @return 直行距離です。
		 */
		public function calculateDistanceSquared(v:Vector2D):Number
		{
			var tx:Number = _x - v.x;
			var ty:Number = _y - v.y;
			return (tx * tx + ty * ty);
		}
		
		/**
		 * ベクトルの大きさを指定サイズで切り捨てます.
		 * 
		 * @param max 切り捨てるサイズです。
		 * 
		 * @return 切り捨て後の自分自身です。
		 */
		public function truncate(max:Number):Vector2D
		{
			size = Math.min(size, max);
			return this;
		}
		
		/**
		 * ベクトルを複製します.
		 * 
		 * @return 複製した新しいベクトルオブジェクトです。
		 */
		public function clone():Vector2D
		{
			return new Vector2D(_x, _y);
		}
	}
}

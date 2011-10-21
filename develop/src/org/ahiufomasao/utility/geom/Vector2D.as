package org.ahiufomasao.utility.geom 
{
	import org.ahiufomasao.utility.MathUtil;
	
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
		 * ベクトルの大きさ、角度により、<code>x</code>、<code>y</code>軸の大きさを設定します.
		 * 
		 * @param size  ベクトルの大きさです。  
		 * @param angle ベクトルの向きを表す角度です。0 度が右水平方向で、時計回りに角度は増えます。
		 */
		public function setBy(size:Number, angle:Number):void
		{
			// ラジアン
			var rad:Number = MathUtil.calculateRadians(angle);
			
			_x = size * Math.cos(rad);
			_y = size * Math.sin(rad);
		}
		
		/**
		 * <code>x</code>、<code>y</code>軸の大きさからベクトルの角度を取得します.
		 * 
		 * @return ベクトルの向きを表す角度です。0 度が右水平方向で、時計回りに角度が 0 ～　360 の範囲で増えます。
		 */
		public function getAngle():Number
		{
			var angle:Number = MathUtil.calculateAngle(Math.atan2(_y, _x));
			angle = angle < 0 ? angle + 360 : angle;
			return angle;
		}
		
		/**
		 * <code>x</code>、<code>y</code>軸の大きさからベクトルの大きさを取得します.
		 * 
		 * @return ベクトルの大きさです。
		 */
		public function getSize():Number
		{
			return Math.sqrt(_x * _x + _y * _y);
		}
	}
}

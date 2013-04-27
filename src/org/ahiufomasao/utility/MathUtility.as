package org.ahiufomasao.utility 
{
	
	/**
	 * <code>MathUtility</code> クラスには、
	 * 一定の計算を行うメソッドがあります.
	 * <p>
	 * <code>MathUtility</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class MathUtility 
	{
		/**
		 * 角度からラジアンを計算します.
		 * 
		 * @param angle 計算する角度です。
		 * 
		 * @return 計算結果のラジアンです。
		 */
		public static function calculateRadians(angle:Number):Number
		{
			return angle * Math.PI / 180;
		}
		
		/**
		 * ラジアンから角度を計算します.
		 * 
		 * @param radians 計算するラジアンです。
		 * 
		 * @return 計算結果の角度です。
		 */
		public static function calculateAngle(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		/**
		 * 角度を 0 ～ 360 度表記に変換します.
		 * <p>
		 * 例えば　470° は 110° に変換されます。
		 * -50° は 310° に変換されます。
		 * </p>
		 * 
		 * @param angle 変換前の角度です。
		 * 
		 * @return 変換後の 0 ～ 360 度表記の角度です。
		 */
		public static function convertFrom0To360Angle(angle:Number):Number
		{
			angle %= 360;
			if (angle < 0)
			{
				angle = 360 + angle;
			}
			return angle;
		}
		
		/**
		 * 2 の冪乗の取得
		 * 
		 * @param size サイズ
		 */
		public static function getPowerOf2Size(size:Number):Number
		{
			var i:uint = 0;
			var po2:Number = 0;
			while (size > po2)
			{
				po2 = Math.pow(2, i);
				i++;
			}
			return po2;
		}
	}
}

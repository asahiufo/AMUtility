package org.ahiufomasao.utility 
{
	import flash.geom.Rectangle;
	
	/**
	 * <code>RectangleUtil</code> クラスには、
	 * <code>Rectangle</code> オブジェクトに関するメソッドがあります.
	 * <p>
	 * <code>RectangleUtil</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class RectangleUtility 
	{
		/**
		 * 矩形を原点で横反転させた場合にとるべき矩形の <code>x</code> 座標を計算します.
		 * 
		 * @param rect 計算対象の矩形です。
		 * 
		 * @return 計算結果の矩形の <code>x</code> 座標です。
		 * 
		 * @throws ArgumentError <code>rect</code> パラメータに <code>null</code> が指定された場合にスローされます。
		 */
		public static function calculateReverseX(rect:Rectangle):Number
		{
			if (rect == null)
			{
				throw new ArgumentError("rect パラメータに null を指定することはできません。");
			}
			return (-rect.x - rect.width);
		}
		
		/**
		 * 矩形を原点で縦反転させた場合にとるべき矩形の <code>y</code> 座標を計算します.
		 * 
		 * @param rect 計算対象の矩形です。
		 * 
		 * @return 計算結果の矩形の <code>y</code> 座標です。
		 * 
		 * @throws ArgumentError <code>rect</code> パラメータに <code>null</code> が指定された場合にスローされます。
		 */
		public static function calculateReverseY(rect:Rectangle):Number
		{
			if (rect == null)
			{
				throw new ArgumentError("rect パラメータに null を指定することはできません。");
			}
			return (-rect.y - rect.height);
		}
	}
}

package org.ahiufomasao.utility 
{
	/**
	 * <code>PhysicsUtility</code> クラスには、
	 * 一般的な物理計算を行うメソッドがあります.
	 * <p>
	 * <code>PhysicsUtility</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class PhysicsUtility 
	{
		/**
		 * 垂直運動において、滞空時間、重力加速度から初速算出
		 * 
		 * @param t 滞空時間（ミリ秒）
		 * @param g 重力加速度（Away3D内の距離/ミリ秒^2）
		 * 
		 * @return 初速
		 */
		public static function calculateVByTGWithVerticalDescent(t:uint, g:Number):Number
		{
			return (g * t / 2);
		}
	}
}
package org.ahiufomasao.utility.core 
{
	/**
	 * 擬似 ENUM クラス
	 * @author asahiufo@AM902
	 */
	public class Enum 
	{
		private var _name:String; // ENUM 値の名前
		
		/** ENUM 値の名前 */
		public function get name():String { return _name; }
		
		/**
		 * コンストラクタ.
		 * 
		 * @param name ENUM 値の名前
		 */
		public function Enum(name:String) 
		{
			_name = name;
		}
		
		/**
		 * ENUM のストリング表現を返します.
		 * 
		 * @return ENUM のストリング表現です。
		 */
		public function toString():String
		{
			return ("ENUM::" + _name);
		}
	}
}
package org.ahiufomasao.utility 
{
	/**
	 * <code>Validator</code> クラスには、
	 * 文字列が指定形式であるかを検査するメソッドがあります.
	 * <p>
	 * <code>Validator</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class Validator
	{
		/**
		 * 指定文字列が <code>Boolean</code> 型の値の形式であるかどうか判定します.
		 * 
		 * @param str 判定する文字列です。
		 * 
		 * @return 指定文字列が <code>"true"</code> または <code>"false"</code> である場合 <code>true</code> を返します。
		 */
		public static function validateBoolean(str:String):Boolean
		{
			return (str == "true" || str == "false");
		}
		
		/**
		 * 指定文字列が <code>Number</code> 型の値の形式であるかどうか判定します.
		 * 
		 * @param str 判定する文字列です。
		 * 
		 * @return 指定文字列が <code>Number</code> 型の形式である場合 <code>true</code> を返します。
		 */
		public static function validateNumber(str:String):Boolean
		{
			if (str.length == 0)
			{
				return false;
			}
			return !isNaN(Number(str));
		}
		
		/**
		 * 指定文字列が正の <code>Number</code> 型の値の形式であるかどうか判定します.
		 * 
		 * @param str 判定する文字列です。
		 * 
		 * @return 指定文字列が正の <code>Number</code> 型の形式である場合 <code>true</code> を返します。
		 */
		public static function validatePositiveNumber(str:String):Boolean
		{
			if (!validateNumber(str))
			{
				return false;
			}
			if (Number(str) < 0)
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 指定文字列が <code>int</code> 型の値の形式であるかどうか判定します.
		 * 
		 * @param str 判定する文字列です。
		 * 
		 * @return 指定文字列が <code>int</code> 型の形式である場合 <code>true</code> を返します。
		 */
		public static function validateInt(str:String):Boolean
		{
			var numVal:Number = Number(str);
			var intVal:Number = parseInt(str);
			if (isNaN(numVal) == true || isNaN(intVal) == true)
			{
				return false;
			}
			if (numVal != intVal)
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 指定文字列が <code>uint</code> 型の値の形式であるかどうか判定します.
		 * 
		 * @param str 判定する文字列です。
		 * 
		 * @return 指定文字列が <code>uint</code> 型の形式である場合 <code>true</code> を返します。
		 */
		public static function validateUint(str:String):Boolean
		{
			if (!validateInt(str))
			{
				return false;
			}
			if (parseInt(str) < 0)
			{
				return false;
			}
			return true;
		}
	}
}

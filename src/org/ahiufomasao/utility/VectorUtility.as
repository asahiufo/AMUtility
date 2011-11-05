package org.ahiufomasao.utility 
{
	
	/**
	 * <code>VectorUtility</code> クラスには、
	 * <code>Vector</code> オブジェクトに関するメソッドがあります.
	 * <p>
	 * <code>VectorUtility</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class VectorUtility 
	{
		/**
		 * <code>Vector</code> から指定オブジェクトを除去します.
		 * 
		 * @param list 除去するオブジェクトが登録されているリストです。
		 * @param obj  除去するオブジェクトです。
		 * 
		 * @return 除去に成功した場合、<code>obj</code>パラメータが返され、失敗した場合は <code>null</code> が返されます。
		 */
		public static function removeObjectFrom(list:Vector.<Object>, obj:Object):Object
		{
			var index:int = list.indexOf(obj);
			if (index == -1)
			{
				return null;
			}
			list.splice(index, 1);
			
			return obj;
		}
		
		/**
		 * <code>uint</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForUint(list:Vector.<Vector.<uint>>):Vector.<Vector.<uint>>
		{
			var copyData:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
			
			for each (var rec:Vector.<uint> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
		
		/**
		 * <code>int</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForInt(list:Vector.<Vector.<int>>):Vector.<Vector.<int>>
		{
			var copyData:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
			
			for each (var rec:Vector.<int> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
		
		/**
		 * <code>Boolean</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForBoolean(list:Vector.<Vector.<Boolean>>):Vector.<Vector.<Boolean>>
		{
			var copyData:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
			
			for each (var rec:Vector.<Boolean> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
		
		/**
		 * <code>Number</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForNumber(list:Vector.<Vector.<Number>>):Vector.<Vector.<Number>>
		{
			var copyData:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
			
			for each (var rec:Vector.<Number> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
		
		/**
		 * <code>String</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForString(list:Vector.<Vector.<String>>):Vector.<Vector.<String>>
		{
			var copyData:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			
			for each (var rec:Vector.<String> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
		
		/**
		 * <code>Object</code> 型の値が登録された 2 次元の <code>Vector</code> オブジェクトをコピーし、新しいインスタンスを作成します.
		 * 
		 * @param list コピー対象の <code>Vector</code> オブジェクトです。
		 * 
		 * @return <code>list</code> パラメータと同内容の新しいインスタンスです.
		 */
		public static function copy2DVectorForObject(list:Vector.<Vector.<Object>>):Vector.<Vector.<Object>>
		{
			var copyData:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();
			
			for each (var rec:Vector.<Object> in list)
			{
				copyData.push(rec.concat());
			}
			
			return copyData;
		}
	}
}

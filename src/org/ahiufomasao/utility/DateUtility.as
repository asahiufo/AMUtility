package org.ahiufomasao.utility 
{
	/**
	 * Date クラス用ユーティリティー
	 * 
	 * @author asahiufo@AM902
	 */
	public class DateUtility 
	{
		/** 1 分を表すミリ秒 */
		public static const millisecondsPerMinute:uint = 1000 * 60;
		/** 1時間を表すミリ秒 */
		public static const millisecondsPerHour:uint   = 1000 * 60 * 60;
		/** 1日を表すミリ秒 */
		public static const millisecondsPerDay:uint    = 1000 * 60 * 60 * 24;
		
		/**
		 * 1970 年 1 月 1 日 0 時からのミリ秒数を設定した、新しい Date オブジェクトを作成します。
		 * 
		 * @param millisecond 整数値です。0 は世界時（UTC）の 1 月 1 日 0 時です。
		 * 
		 * @return 新しい Date オブジェクトです。
		 */
		public static function createDateWithMillisecond(millisecond:Number):Date
		{
			var date:Date = new Date();
			date.setTime(millisecond);
			return date;
		}
		
		/**
		 * 日付を表すストリングから、Date オブジェクトを作成します。
		 * 
		 * @param date Date.toString() の出力形式に準じた日付のストリング表現です。
		 * 
		 * @return Date オブジェクトです。
		 */
		public static function createDateByParsing(date:String):Date
		{
			var millisecond:Number = Date.parse(date);
			return createDateWithMillisecond(millisecond);
		}
		
		/**
		 * 指定した日数の加減算を行う.
		 * 
		 * @param date 計算対象の Date オブジェクト。このオブジェクトは当メソッドによって変更されません。
		 * @param d    加減算をする値
		 * 
		 * @return 計算結果の新しい Date オブジェクト
		 */
		public static function addDay(date:Date, d:int):Date
		{
			var retDate:Date = new Date();
			retDate.setTime(date.getTime() + millisecondsPerDay * d);
			return retDate;
		}
		
		/**
		 * 指定した時間数の加減算を行う.
		 * 
		 * @param date 計算対象の Date オブジェクト。このオブジェクトは当メソッドによって変更されません。
		 * @param m    加減算をする値
		 * 
		 * @return 計算結果の新しい Date オブジェクト
		 */
		public static function addHour(date:Date, h:int):Date
		{
			var retDate:Date = new Date();
			retDate.setTime(date.getTime() + millisecondsPerHour * h);
			return retDate;
		}
		
		/**
		 * 指定した分数の加減算を行う.
		 * 
		 * @param date 計算対象の Date オブジェクト。このオブジェクトは当メソッドによって変更されません。
		 * @param m    加減算をする値
		 * 
		 * @return 計算結果の新しい Date オブジェクト
		 */
		public static function addMinute(date:Date, m:int):Date
		{
			var retDate:Date = new Date();
			retDate.setTime(date.getTime() + millisecondsPerMinute * m);
			return retDate;
		}
		
		/**
		 * fromDate から date の減算した際の時間数を求める.
		 * 
		 * @param date     fromDate から減算する Date オブジェクト
		 * @param fromDate 計算対象の Date オブジェクト
		 * 
		 * @return 計算結果の時間数
		 */
		public static function subtractHour(date:Date, fromDate:Date):int
		{
			return Math.floor((fromDate.getTime() - date.getTime()) / millisecondsPerHour);
		}
		
		/**
		 * fromDate から date の減算した際の分数を求める.
		 * 
		 * @param date     fromDate から減算する Date オブジェクト
		 * @param fromDate 計算対象の Date オブジェクト
		 * 
		 * @return 計算結果の分数
		 */
		public static function subtractMinute(date:Date, fromDate:Date):int
		{
			return Math.floor((fromDate.getTime() - date.getTime()) / millisecondsPerMinute);
		}
	}
}
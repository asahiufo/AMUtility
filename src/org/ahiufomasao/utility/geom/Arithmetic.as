package org.ahiufomasao.utility.geom 
{
	
	/**
	 * <code>Arithmetic</code> クラスは、四則演算を一定の値で行います.
	 * <p>
	 * プロパティ <code>additionNumber</code>、<code>subtractionNumber</code>、
	 * <code>multiplicationNumber</code>、<code>divisionNumber</code> はそれぞれ
	 * 足し算、引き算、掛け算、割り算を行うためのプロパティを表します。
	 * 各プロパティへ値を設定し、足し算、引き算、掛け算、割り算を行うメソッド 
	 * <code>add</code>、<code>subtract</code>、<code>multiply</code>、<code>divide</code> を実行することで四則演算を行います。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 * @see #additionNumber
	 * @see #subtractionNumber
	 * @see #multiplicationNumber
	 * @see #divisionNumber
	 * @see #add()
	 * @see #subtract()
	 * @see #multiply()
	 * @see #divide()
	 */
	public class Arithmetic 
	{
		private var _additionNumber:Number;       // 足し算用
		private var _subtractionNumber:Number;    // 引き算用
		private var _multiplicationNumber:Number; // 掛け算用
		private var _divisionNumber:Number;       // 割り算用
		
		/**
		 * <code>add</code> メソッドを呼び出した際に加算される値です.
		 * @default 0
		 * @see #add()
		 */
		public function get additionNumber():Number { return _additionNumber; }
		/** @private */
		public function set additionNumber(value:Number):void { _additionNumber = value; }
		/**
		 * <code>subtract</code> メソッドを呼び出した際に減算される値です.
		 * @default 0
		 * @see #subtract()
		 */
		public function get subtractionNumber():Number { return _subtractionNumber; }
		/** @private */
		public function set subtractionNumber(value:Number):void { _subtractionNumber = value; }
		/**
		 * <code>multiply</code> メソッドを呼び出した際に乗算される値です.
		 * @default 1
		 * @see #multiply()
		 */
		public function get multiplicationNumber():Number { return _multiplicationNumber; }
		/** @private */
		public function set multiplicationNumber(value:Number):void { _multiplicationNumber = value; }
		/**
		 * <code>divide</code> メソッドを呼び出した際に除算される値です.
		 * @default 1
		 * @see #divide()
		 */
		public function get divisionNumber():Number { return _divisionNumber; }
		/** @private */
		public function set divisionNumber(value:Number):void
		{
			if (value == 0)
			{
				throw new ArgumentError("divisionNumber プロパティに 0 を設定することはできません。");
			}
			_divisionNumber = value;
		}
		
		/**
		 * 新しい <code>Arithmetic</code> クラスのインスタンスを生成します.
		 */
		public function Arithmetic() 
		{
			_additionNumber       = 0;
			_subtractionNumber    = 0;
			_multiplicationNumber = 1;
			_divisionNumber       = 1;
		}
		
		/**
		 * <code>value</code> へ <code>additionNumber</code> プロパティの値を加算した結果を返します.
		 * 
		 * @param value 加算する値です。
		 * 
		 * @return 加算結果です。
		 */
		public function add(value:Number):Number
		{
			// TODO: Add 4 and 3 and you have 7. 4足す 3 は 7.
			//       Three added to four makes seven. 4足す 3 は 7.
			return (value + _additionNumber);
		}
		
		/**
		 * <code>value</code> から <code>subtractionNumber</code> プロパティの値を減算した結果を返します.
		 * 
		 * @param value 減算する値です。
		 * 
		 * @return 減算結果です。
		 */
		public function subtract(value:Number):Number
		{
			// TODO: If you subtract two from five you get [have] three.＝Two subtracted from five leaves three. 5から 2 を引くと 3 が残る.
			return (value - _subtractionNumber);
		}
		
		/**
		 * <code>value</code> と <code>multiplicationNumber</code> プロパティの値を乗算した結果を返します.
		 * 
		 * @param value 乗算する値です。
		 * 
		 * @return 乗算結果です。
		 */
		public function multiply(value:Number):Number
		{
			return (value * _multiplicationNumber);
		}
		
		/**
		 * <code>value</code> から <code>divisionNumber</code> プロパティの値を除算した結果を返します.
		 * 
		 * @param value 除算する値です。
		 * 
		 * @return 除算結果です。
		 */
		public function divide(value:Number):Number
		{
			return (value / _divisionNumber);
		}
	}
}

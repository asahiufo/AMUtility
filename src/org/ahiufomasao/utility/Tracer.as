package org.ahiufomasao.utility 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	// TODO: テスト
	// TODO: asdoc
	/**
	 * トレーサー
	 * @author asahiufo/AM902
	 */
	public class Tracer extends TextField 
	{
		/**
		 * コンストラクタ
		 */
		public function Tracer() 
		{
			super();
			
			autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**
		 * 改行を付けて追加出力
		 * 
		 * @param str 出力する文字列
		 */
		public function appendTextLn(str:String):void
		{
			appendText(str + "\r\n");
		}
	}
}
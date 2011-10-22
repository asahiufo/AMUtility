package org.ahiufomasao.utility
{
	
	/**
	 * <code>StringUtil</code> クラスには、
	 * 文字列の形式変換や連結等を行うメソッドがあります.
	 * <p>
	 * <code>StringUtil</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public class StringUtility
	{
		/**
		 * 正の整数を指定桁数分 0 埋めした数値の文字列へ変換します.
		 * <p>
		 * 整数の桁数が指定桁数以上である場合、整数をそのまま文字列へ変換したものが返されます。
		 * </p>
		 * 
		 * @example 変換数値 <code>23</code>、桁 <code>4</code> → 戻り値 <code>"0023"</code>
		 * 
		 * @param num   変換する数値です。
		 * @param place 返される文字列の桁数です。
		 * 
		 * @return 変換後の文字列です。
		 */
		public static function convertFromNumberToZeroString(num:uint, place:uint):String
		{
			var workStr:String = String(num);
			var zeroCount:int  = place - workStr.length;
			
			// 変換する数値桁が 0 埋め桁数以上である場合、そのままの文字列を返す
			if (zeroCount <= 0)
			{
				return workStr;
			}
			
			// 桁不足分 "0" を追加する
			for (var i:uint = 0; i < zeroCount; i++)
			{
				workStr = "0" + workStr;
			}
			
			return workStr;
		}
		
		/**
		 * <code>"true"</code> または <code>"false"</code> の文字列を対応した <code>Boolean</code> 型の値に変換します.
		 * 
		 * @param boolStr <code>"true"</code>、または <code>"false"</code> の文字列です。
		 * 
		 * @return 引数が <code>"true"</code> なら <code>true</code>、<code>"false"</code> なら <code>false</code> です。
		 * 
		 * @throws ArgumentError <code>boolStr</code> パラメータに <code>"true"</code> または <code>"false"</code> 以外を指定した場合にスローされます。
		 */
		public static function convertStringToBoolean(boolStr:String):Boolean
		{
			if (boolStr == "true")
			{
				return true;
			}
			else if (boolStr == "false")
			{
				return false;
			}
			
			throw new ArgumentError("boolStr パラメータには \"true\" または \"false\" しか指定できません。");
		}
		
		/**
		 * 文字列中に含まれるインデントを削除します.
		 * <p>
		 * 各行の先頭の字下げ部分に用いられているインデントの文字を削除します。
		 * </p>
		 * 
		 * @param str        インデントを削除する文字列です。
		 * @param indentChar インデントに使用している削除対象の 1 文字です。
		 * 
		 * @return インデント削除後の文字列です。
		 * 
		 * @throws ArgumentError <code>indentChar</code> パラメータへ 2 文字以上の文字列を指定した場合にスローされます。
		 */
		public static function deleteIndent(str:String, indentChar:String = "\t"):String
		{
			if (indentChar.length != 1)
			{
				throw new ArgumentError("indentChar パラメータには 1 文字だけ指定して下さい。[indentChar=" + indentChar + "]");
			}
			
			// 文字列の先頭のインデントを削除
			var i:uint;
			for (i = 0 ; str.charAt(i) == indentChar; i++) {  }
			str = str.slice(i);
			
			// 先頭以外のインデントを削除
			str = _deleteIndentWithoutTop(str, "\n", indentChar);
			str = _deleteIndentWithoutTop(str, "\r", indentChar);
			
			return str;
		}
		
		/**
		 * @private
		 * 先頭以外のインデントを削除
		 * 
		 * @param str         インデントを削除する文字列です。
		 * @param newLineCode 改行コードです。
		 * @param indentChar  インデントに使用している削除対象の 1 文字です。
		 * 
		 * @return インデント処理後の文字列です。
		 */
		private static function _deleteIndentWithoutTop(str:String, newLineCode:String, indentChar:String):String
		{
			// 先頭以外のインデントを削除
			var pattern:RegExp = new RegExp(newLineCode + indentChar);
			while (str.search(pattern) != -1)
			{
				str = str.replace(pattern, newLineCode);
			}
			return str;
		}
		
		/**
		 * 2 つのパスを連結し、新しいパスを作成します.
		 * <p>
		 * 2 つのパスのパス区切り文字は <code>separator</code> パラメータの区切り文字に置き換えられます。
		 * 1 つ目のパスの終端にパス区切り文字があればそのまま、無ければパス区切り文字を付与して 2 つ目のパスと連結されます。
		 * </p>
		 * 
		 * @example パス 1 <code>".\test\data"</code>、パス 2 <code>"gr.png"</code>、区切り文字 <code>"/"</code> → 戻り値 <code>"./test/data/gr.png"</code>
		 * 
		 * @param path1     1 つ目のパスです。
		 * @param path2     2 つ目のパスです。
		 * @param separator パスの区切り文字です。
		 * 
		 * @return 連結された新しいパスです。
		 * 
		 * @throws ArgumentError <code>separator</code> パラメータへ <code>"/"</code> または <code>"\"</code> 以外の文字を指定した場合にスローされます。
		 */
		public static function combinePath(path1:String, path2:String, separator:String = "/"):String
		{
			var pattern:RegExp;
			// 区切り文字が '/' である場合
			if (separator == "/")
			{
				// '\' → '/' 置換
				pattern = /\\/g;
				path1 = path1.replace(pattern, "/");
				path2 = path2.replace(pattern, "/");
			}
			// 区切り文字が '\' である場合
			else if (separator == "\\")
			{
				// '/' → '\' 置換
				pattern = /\//g;
				path1 = path1.replace(pattern, "\\");
				path2 = path2.replace(pattern, "\\");
			}
			// '/' でも '\' でもない場合例外
			else
			{
				throw ArgumentError("separator パラメータへは \'/\' もしくは \'\\\' しか指定できません。");
			}
			
			if (path1.charAt(path1.length - 1) != separator)
			{
				path1 += separator;
			}
			
			return (path1 + path2);
		}
		
		/**
		 * CSV 形式の文字列を 2 次元の <code>Vector</code> オブジェクトへ変換します.
		 * <p>
		 * 「<code>"</code>」で囲まれた項目内では、CSV データの区切り文字も改行文字も項目のデータとして扱われます。
		 * また、「<code>"</code>」で囲まれた項目内では、「<code>""</code>」という記述が「<code>"</code>」という文字データとして扱われます。
		 * </p>
		 * 
		 * @param CSVData   変換する CSV データです。
		 * @param separator CSV データで使用されている区切り文字です。
		 * 
		 * @return 変換後の 2 次元の <code>Vector</code> オブジェクトです。
		 * 
		 * @throws ArgumentError CSV データ中の「<code>"</code>」が閉じられていない場合にスローされます。
		 */
		public static function convertFromCSVToVector(CSVData:String, separator:String = ","):Vector.<Vector.<String>>
		{
			var list:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			var indexY:uint = 0;
			var nextFlg:Boolean = true;
			var len:uint = CSVData.length;
			
			// 空文字列なら行Vector無しのVectorを返す
			if (CSVData.length == 0)
			{
				return list;
			}
			
			list[indexY] = new Vector.<String>();
			var char:String;
			var data:String = "";
			
			for (var i:uint = 0; i < len; i++)
			{
				char = CSVData.charAt(i);
				
				// 区切り文字、改行を識別子として判断する場合
				if (nextFlg)
				{
					// 区切り文字を見つけた場合
					if (char == separator)
					{
						list[indexY].push(data);
						data = "";
						continue;
					}
					// 改行を見つけた場合
					if (char == "\r" || char == "\n")
					{
						// データの最後であった場合
						if (i == len - 1)
						{
							// 最後の改行は無効にする
							continue;
						}
						// 次の文字がLFである場合
						if (CSVData.charAt(i + 1) == "\n")
						{
							// 処理スキップ
							continue;
						}
						list[indexY].push(data);
						data = "";
						indexY++;
						list[indexY] = new Vector.<String>();
						continue;
					}
					// 「"」を見つけたら、識別子判断を無効にする
					else if (char == "\"")
					{
						nextFlg = false;
						continue;
					}
				}
				// しない場合
				else
				{
					// 「""」を見つけたら、文字「"」とする
					if (char == "\"" && CSVData.charAt(i + 1) == "\"")
					{
						data += "\"";
						i++;
						continue;
					}
					// 閉じ「"」を見つけたら、識別子判断を通常に戻す
					else if (char == "\"" && CSVData.charAt(i + 1) != "\"")
					{
						nextFlg = true;
						continue;
					}
				}
				
				// 文字追加
				data += char;
			}
			
			// 閉じ「"」が見つからないまま処理が終了した場合形式エラー
			if (!nextFlg)
			{
				throw new ArgumentError("CSV データ中の '\"' の整合性が取れていないため、変換できませんでした。");
			}
			
			list[indexY].push(data);
			
			return list;
		}
	}
}

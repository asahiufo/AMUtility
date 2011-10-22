package org.ahiufomasao.utility 
{
	import flash.errors.EOFError;
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	
	/**
	 * <code>Archiver</code> クラスには、
	 * 複数ファイルのデータを独自の形式で圧縮、伸張するメソッドがあります.
	 * <p>
	 * <code>Archiver</code> クラスは完全な静的クラスであるため、
	 * インスタンスを作成する必要はありません。
	 * </p>
	 * <p>
	 * 圧縮したい 1 つ以上のファイルに対し、
	 * 1 ファイルにつき 1 つの <code>ArchiveFileData</code> オブジェクトを作成します。
	 * 作成した複数の <code>ArchiveFileData</code> オブジェクトでリストを作り、
	 * <code>Archiver</code> クラスの <code>compress</code> メソッドへ渡すことで、
	 * アーカイブファイルのバイナリデータが作成されます。
	 * このアーカイブファイルのバイナリデータを <code>Archiver</code> クラスの <code>uncompress</code> メソッドへ渡すことで、
	 * バイナリデータから <code>ArchiveFileData</code> オブジェクトのリストを復元します。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 * @see ArchiveFileData
	 * @see #compress()
	 * @see #uncompress()
	 */
	public class Archiver 
	{
		/**
		 * 1 つ以上のファイルのバイナリデータを 1 つのバイナリデータへまとめ、圧縮します.
		 * 
		 * @param fileDataList 圧縮対象の <code>ArchiveFileData</code> で構成されたリストです。
		 * 
		 * @return 圧縮されたバイナリデータです。
		 * 
		 * @throws ArgumentError <code>fileDataList</code> パラメータに <code>null</code> を指定した場合にスローされます。
		 * @throws ArgumentError <code>fileDataList</code> パラメータに <code>null</code> が含まれるリストを指定した場合にスローされます。
		 * @throws ArgumentError <code>fileDataList</code> パラメータに <code>filePath</code> プロパティが未設定である <code>ArchiveFileData</code> オブジェクトが含まれるリストを指定した場合にスローされます。
		 * @throws ArgumentError <code>fileDataList</code> パラメータに <code>bytes</code> プロパティが未設定である <code>ArchiveFileData</code> オブジェクトが含まれるリストを指定した場合にスローされます。
		 */
		public static function compress(fileDataList:Vector.<ArchiveFileData>):ByteArray
		{
			if (fileDataList == null)
			{
				throw new ArgumentError("fileDataList パラメータに null を指定することはできません。");
			}
			
			var byteArray:ByteArray = new ByteArray();
			
			// 全ファイル処理
			for each (var data:ArchiveFileData in fileDataList)
			{
				// null がリストに含まれている場合エラー
				if (data == null)
				{
					throw new ArgumentError("fileDataList パラメータに null を含めることはできません。");
				}
				// ファイルパスが設定されていない場合エラー
				if (data.filePath == "")
				{
					throw new ArgumentError("ファイルパスが未設定であるデータを fileDataList パラメータに含めることはできません。");
				}
				// バイナリデータが設定されていない場合エラー
				if (data.bytes == null)
				{
					throw new ArgumentError("バイナリデータが未設定であるデータを fileDataList パラメータに含めることはできません。");
				}
				
				// ファイル名の文字数、ファイルの相対パス
				byteArray.writeUTF(data.filePath);
				// ファイルデータのbyte数
				byteArray.writeUnsignedInt(data.bytes.length);
				// ファイルデータ
				byteArray.writeBytes(data.bytes);
			}
			
			// zlib圧縮
			byteArray.compress();
			
			// 出来たバイナリデータの読み取り位置を初期位置に戻す
			byteArray.position = 0;
			
			return byteArray;
		}
		
		/**
		 * <code>compress</code> メソッドで圧縮されたバイナリデータを伸長します.
		 * 
		 * @param archiveData <code>compress</code> メソッドにより作成されたバイナリデータです。
		 * 
		 * @return 伸長結果の <code>ArchiveFileData</code> で構成されたリストです。
		 * 
		 * @throws ArgumentError プロパティ <code>archiveData</code> に <code>null</code> を指定した場合にスローされます。
		 * @throws ArgumentError プロパティ <code>archiveData</code> に形式が不正なアーカイブデータを指定した場合にスローされます。
		 */
		public static function uncompress(archiveData:ByteArray):Vector.<ArchiveFileData>
		{
			if (archiveData == null)
			{
				throw new ArgumentError("archiveData パラメータに null を指定することはできません。");
			}
			
			var list:Vector.<ArchiveFileData> = new Vector.<ArchiveFileData>(); // 伸長したデータ
			var workArchiveData:ByteArray = new ByteArray();                    // アーカイブデータ処理用
			var savePosition:uint = archiveData.position;
			
			// アーカイブデータを処理用領域にコピー
			archiveData.position = 0;
			archiveData.readBytes(workArchiveData);
			archiveData.position = savePosition;
			
			// zlib伸長
			try
			{
				workArchiveData.uncompress();
			}
			catch (e:IOError)
			{
				throw new ArgumentError("archiveData パラメータの形式が不正であるため、伸長に失敗しました。");
			}
			
			var filePath:String;
			var byteArrayLen:uint;
			var byteArray:ByteArray;
			var archiveFileData:ArchiveFileData;
			// アーカイブデータをすべて処理するまでループ
			while (true)
			{
				try
				{
					// ファイル名
					filePath = workArchiveData.readUTF();
					
					// データ
					byteArray = new ByteArray();
					byteArrayLen = workArchiveData.readUnsignedInt();
					workArchiveData.readBytes(byteArray, 0, byteArrayLen);
					
					// 配列に登録
					archiveFileData = new ArchiveFileData();
					archiveFileData.filePath = filePath;
					archiveFileData.bytes    = byteArray;
					list.push(archiveFileData);
					
					// すべて読み終わったら終了
					if (workArchiveData.position == workArchiveData.length)
					{
						break;
					}
					
				}
				catch (e:EOFError)
				{
					throw new ArgumentError("archiveData パラメータの形式が不正であるため、伸長に失敗しました。");
				}
			}
			return list;
		}
	}
}

package org.ahiufomasao.utility.net 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * <code>load</code> メソッドを呼び出した後、データを受信したときに送出されます.
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 * 
	 * @see #load()
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	/**
	 * <code>load</code> メソッドを呼び出した後、ロードが完了した時に送出されます.
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 * 
	 * @see #load()
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * <code>MaterialSwfLoader</code> クラスは、素材を埋め込んだのSWFファイルのロード機能を提供します.
	 * <p>
	 * <code>MaterialSwfLoader</code> クラスは基本的に以下の手順で使用します。
	 * </p>
	 * <ol>
	 * <li><code>MaterialSwfLoader</code> クラスのインスタンス作成</li>
	 * <li><code>load</code> メソッド実行</li>
	 * <li><code>complete</code> プロパティが <code>true</code> になるまで待つ</li>
	 * <li><code>getMaterialClass</code> メソッドから素材クラスを取得</li>
	 * </ol>
	 * 
	 * @author asahiufo/AM902
	 * @see #load()
	 * @see #complete
	 * @see #getMaterialClass()
	 */
	public class MaterialSwfLoader extends ImageLoader
	{
		/**
		 * 新しい <code>MaterialSwfLoader</code> クラスのインスタンスを生成します.
		 * 
		 * @param URL ロード対象ファイルの URL です。
		 */
		public function MaterialSwfLoader(URL:String) 
		{
			super(URL);
		}
		
		/**
		 * <code>data</code> プロパティに埋めこまれているクラスを取得します.
		 * <p>
		 * 主に読み込んだ swf の中からクラスを取得するために使用します。
		 * </p>
		 * 
		 * @param name 取得するクラス名です。
		 * 
		 * @return 指定した名前の <code>Class</code> クラスオブジェクトです。
		 * 
		 * @throws
		 */
		public function getMaterialClass(name:String):Class
		{
			// ロードが完了していない場合
			if (!complete)
			{
				throw new IllegalOperationError("ロードが完了してから実行して下さい。");
			}
			// 指定した名前のクラス名が存在しない場合
			if (!data.loaderInfo.applicationDomain.hasDefinition(name))
			{
				throw new ArgumentError("指定した名前のクラスは存在しません。");
			}
			
			var retObj:Object = data.loaderInfo.applicationDomain.getDefinition(name);
			// 取得したオブジェクトが Class ではない場合
			if (!(retObj is Class))
			{
				throw new ArgumentError("指定した名前のクラスは存在しません。");
			}
			return Class(retObj);
		}
	}
}
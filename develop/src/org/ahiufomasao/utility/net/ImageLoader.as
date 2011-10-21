package org.ahiufomasao.utility.net 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.errors.IllegalOperationError;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
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
	 * <code>ImageLoader</code> クラスは、グラフィックデータのロード機能を提供します.
	 * <p>
	 * コンストラクタで URL を指定した場合、外部ファイルのロードを行います。
	 * <code>ByteArray</code> オブジェクトを指定した場合、バイナリデータから <code>DisplayObject</code> を復元します。
	 * サポートする形式は SWF、JPEG、GIF、PNG です。
	 * </p>
	 * <p>
	 * <code>ImageLoader</code> クラスは基本的に以下の手順で使用します。
	 * </p>
	 * <ol>
	 * <li><code>ImageLoader</code> クラスのインスタンス作成</li>
	 * <li><code>load</code> メソッド実行</li>
	 * <li><code>complete</code> プロパティが <code>true</code> になるまで待つ</li>
	 * <li><code>data</code> プロパティから読み込んだデータを取得</li>
	 * </ol>
	 * 
	 * @author asahiufo/AM902
	 * @see #load()
	 * @see #complete
	 * @see #data
	 */
	public class ImageLoader extends EventDispatcher implements ILoader
	{
		private var _request:URLRequest; // URLリクエスト
		private var _bytes:ByteArray;    // バイナリデータ
		
		private var _loader:Loader;      // ローダー
		private var _bytesLoaded:uint;   // ロード済みバイト数
		private var _bytesTotal:uint;    // 読み込み対象ファイルのサイズ（バイト）
		private var _complete:Boolean;   // ロードが完了しているならtrue
		private var _data:DisplayObject; // 読み込んだデータ
		
		/**
		 * @inheritDoc
		 */
		public function get bytesLoaded():uint { return _bytesLoaded; }
		/**
		 * @inheritDoc
		 */
		public function get bytesTotal():uint { return _bytesTotal; }
		/**
		 * @inheritDoc
		 */
		public function get loading():Boolean
		{
			if (complete)
			{
				return false;
			}
			else if (_loader == null)
			{
				return false;
			}
			return true;
		}
		/**
		 * @inheritDoc
		 */
		public function get complete():Boolean { return _complete; }
		/**
		 * 読み込まれた <code>DisplayObject</code> データです.
		 * <p>
		 * ロードが完了するまでは <code>null</code> です。
		 * </p>
		 */
		public function get data():Object { return _data; }
		
		/**
		 * 新しい <code>ImageLoader</code> クラスのインスタンスを生成します.
		 * 
		 * @param source ロード対象ファイルの URL または、<code>DisplayObject</code> に復元したい <code>ByteArray</code> オブジェクトです。
		 * 
		 * @throws ArgumentError <code>source</code> パラメータにファイルの URL または SWF、JPEG、GIF、PNG のバイナリデータ以外を指定した場合にスローされます。
		 */
		public function ImageLoader(source:Object)
		{
			if (source is String)
			{
				_request = new URLRequest(String(source));
				_bytes   = null;
			}
			else if (source is ByteArray)
			{
				_request = null;
				_bytes   = ByteArray(source);
			}
			else
			{
				throw new ArgumentError("ファイルのURLまたはSWF、JPEG、GIF、PNGのバイナリデータしか指定できません。");
			}
			_loader      = null;
			_bytesLoaded = 0;
			_bytesTotal  = 0;
			_complete    = false;
		}
		
		/**
		 * @inheritDoc
		 * 
		 * @throws IllegalOperationError <code>load</code> メソッドを 2 回以上実行した場合にスローされます。
		 */
		public function load():void
		{
			if (_loader != null)
			{
				throw new IllegalOperationError("ロードは実施済みです。");
			}
			
			var loader:Loader = new Loader();
			var loaderInfo:LoaderInfo = loader.contentLoaderInfo;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			if (_request != null)
			{
				loaderInfo.addEventListener(Event.COMPLETE, _onComplete);
				loader.load(_request);
			}
			else if (_bytes != null)
			{
				loaderInfo.addEventListener(Event.INIT, _onComplete);
				loader.loadBytes(_bytes);
			}
			
			_loader = loader;
		}
		
		/**
		 * @private
		 * プログレスイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onProgress(event:ProgressEvent):void
		{
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			
			dispatchEvent(event);
		}
		
		/**
		 * @private
		 * 読み込み完了イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onComplete(event:Event):void
		{
			_complete = true; // ロード完了
			
			_data = DisplayObject(_loader.content);
			
			var loaderInfo:LoaderInfo = _loader.contentLoaderInfo;
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			if (_request != null)
			{
				loaderInfo.removeEventListener(Event.COMPLETE, _onComplete);
			}
			else if (_bytes != null)
			{
				loaderInfo.removeEventListener(Event.INIT, _onComplete);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * @private
		 * IOエラーイベントハンドラ
		 * 
		 * @param event イベント
		 * 
		 * @throws IOError ファイル読み込み中にIOエラーが発生しました。
		 */
		private function _onIOError(event:IOErrorEvent):void
		{
			throw new IOError("ファイル読み込み中にIOエラーが発生しました。[" + event.toString() + "]");
		}
		
		/**
		 * @private
		 * セキュリティーエラーイベントハンドラ
		 * 
		 * @param event イベント
		 * 
		 * @throws SecurityError ファイル読み込み中にセキュリティーエラーが発生しました。
		 */
		private function _onSecurityError(event:SecurityErrorEvent):void
		{
			throw new SecurityError("ファイル読み込み中にセキュリティーエラーが発生しました。[" + event.toString() + "]");
		}
		
		/**
		 * <code>ImageLoader</code> オブジェクトのプロパティを含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>[ImageLoader source="<em>value</em>" bytesLoaded=<em>value</em> bytesTotal=<em>value</em> complete=<em>value</em> data="<em>value</em>"]</code>
		 * </p>
		 * 
		 * @return <code>ImageLoader</code> オブジェクトのプロパティを含むストリングです。
		 */
		override public function toString():String 
		{
			var source:String;
			if (_request != null)
			{
				source = _request.url;
			}
			else if (_bytes != null)
			{
				source = "[object ByteArray]";
			}
			return ("[ImageLoader source=\"" + source + "\" bytesLoaded=" + _bytesLoaded + " bytesTotal=" + _bytesTotal + " complete=" + _complete + " data=\"" + _data + "\"]");
		}
	}
}

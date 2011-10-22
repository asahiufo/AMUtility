package org.ahiufomasao.utility.net 
{
	import flash.errors.IllegalOperationError;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
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
	 * <code>StringLoader</code> クラスは、文字列やバイナリデータのロード機能を提供します.
	 * <p>
	 * コンストラクタで URL と読み込むデータ形式を指定することで、外部ファイルのロードを行います。
	 * </p>
	 * <p>
	 * <code>StringLoader</code> クラスは基本的に以下の手順で使用します。
	 * </p>
	 * <ol>
	 * <li><code>StringLoader</code> クラスのインスタンス作成</li>
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
	public class StringLoader extends EventDispatcher implements ILoader
	{
		private var _request:URLRequest; // URLリクエスト
		private var _dataFormat:String;  // データフォーマット
		private var _loader:URLLoader;   // ローダー
		private var _bytesLoaded:uint;   // ロード済みバイト数
		private var _bytesTotal:uint;    // 読み込み対象ファイルのサイズ（バイト）
		private var _complete:Boolean;   // ロードが完了しているならtrue
		
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
		 * 読み込まれた文字列または <code>ByteArray</code> または <code>URLVariables</code> データです.
		 * <p>
		 * ロードが完了するまでは <code>null</code> です。
		 * </p>
		 */
		public function get data():Object
		{
			return (_loader == null ? null : _loader.data);
		}
		
		/**
		 * リクエストメソッドです.
		 * <p>
		 * <code>URLRequestMethod.GET</code> または <code>URLRequestMethod.POST</code> を設定します。
		 * </p>
		 * 
		 * @throws ArgumentError <code>URLRequestMethod.GET</code> または <code>URLRequestMethod.POST</code> 以外を指定した場合にスローされます。
		 */
		public function get method():String { return _request.method; }
		/** @private */
		public function set method(value:String):void
		{
			if (value != URLRequestMethod.GET && value != URLRequestMethod.POST)
			{
				throw new ArgumentError("リクエストメソッドには URLRequestMethod.GET または URLRequestMethod.POST 以外指定できません。");
			}
			
			_request.method = value;
		}
		
		/**
		 * 新しい <code>StringLoader</code> クラスのインスタンスを生成します.
		 * 
		 * @param URL        ロード対象ファイルの URL です。
		 * @param dataFormat 読み込むデータのフォーマットです。<code>URLLoaderDataFormat.TEXT</code>、<code>URLLoaderDataFormat.BINARY</code>、<code>URLLoaderDataFormat.VARIABLES</code> のいずれかを指定します。省略した場合、<code>URLLoaderDataFormat.TEXT</code> が設定されます。
		 * 
		 * @throws ArgumentError <code>dataFormat</code> パラメータに <code>URLLoaderDataFormat.TEXT</code> または <code>URLLoaderDataFormat.BINARY</code> または <code>URLLoaderDataFormat.VARIABLES</code> 以外を指定した場合にスローされます。
		 */
		public function StringLoader(URL:String, dataFormat:String = "")
		{
			if (dataFormat == "")
			{
				_dataFormat = URLLoaderDataFormat.TEXT;
			}
			else
			{
				if (dataFormat != URLLoaderDataFormat.TEXT &&
				    dataFormat != URLLoaderDataFormat.BINARY &&
				    dataFormat != URLLoaderDataFormat.VARIABLES)
				{
					throw new ArgumentError("dataFormat パラメータは URLLoaderDataFormat.TEXT、URLLoaderDataFormat.BINARY、URLLoaderDataFormat.VARIABLES のいずれかである必要があります。");
				}
				_dataFormat = dataFormat;
			}
			
			_request     = new URLRequest(URL);
			_loader      = null;
			_bytesLoaded = 0;
			_bytesTotal  = 0;
			_complete    = false;
		}
		
		/**
		 * リクエスト時の送信データを設定します.
		 * 
		 * @param data URL    リクエストで送信されるデータを含むオブジェクトです。<code>URLVariables</code> オブジェクトまたは <code>ByteArray</code> オブジェクトを指定します。
		 * @param contentType 送信データの MIME コンテンツタイプです。省略した場合は設定前の値から変更しません。
		 */
		public function setSendingData(data:Object, contentType:String = ""):void
		{
			_request.data = data;
			if (contentType != "")
			{
				_request.contentType = contentType;
			}
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
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = _dataFormat;
			loader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			loader.addEventListener(Event.COMPLETE, _onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			loader.load(_request);
			
			_loader = loader;
		}
		
		/**
		 * プログレスイベント処理
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
		 * 読み込み完了イベント処理
		 * 
		 * @param event イベント
		 */
		private function _onComplete(event:Event):void
		{
			_complete = true; // ロード完了
			
			var loader:URLLoader = _loader;
			loader.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
			loader.removeEventListener(Event.COMPLETE, _onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			
			dispatchEvent(event);
		}
		
		/**
		 * IOエラーイベント
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
		 * セキュリティーエラーイベント処理
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
		 * <code>StringLoader</code> オブジェクトのプロパティを含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>[StringLoader URL="<em>value</em>" bytesLoaded=<em>value</em> bytesTotal=<em>value</em> complete=<em>value</em> data="<em>value</em>"]</code>
		 * </p>
		 * 
		 * @return <code>StringLoader</code> オブジェクトのプロパティを含むストリングです。
		 */
		override public function toString():String 
		{
			return ("[StringLoader URL=\"" + _request.url + "\" bytesLoaded=" + _bytesLoaded + " bytesTotal=" + _bytesTotal + " complete=" + _complete + " data=\"" + (_loader == null ? "null" : data) + "\"]");
		}
	}
}

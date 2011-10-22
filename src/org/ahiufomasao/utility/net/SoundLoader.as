package org.ahiufomasao.utility.net 
{
	import flash.errors.IllegalOperationError;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
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
	 * <code>SoundLoader</code> クラスは、サウンドデータのロード機能を提供します.
	 * <p>
	 * サポートする形式は MP3 です。
	 * </p>
	 * <p>
	 * <code>SoundLoader</code> クラスは基本的に以下の手順で使用します。
	 * </p>
	 * <ol>
	 * <li><code>SoundLoader</code> クラスのインスタンス作成</li>
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
	public class SoundLoader extends EventDispatcher implements ILoader
	{
		private var _request:URLRequest;   // URLリクエスト
		private var _loader:Sound;         // ローダー
		private var _bytesLoaded:uint;     // ロード済みバイト数
		private var _bytesTotal:uint;      // 読み込み対象ファイルのサイズ（バイト）
		private var _complete:Boolean;     // ロードが完了しているならtrue
		private var _data:Sound;           // ロード済み Sound オブジェクト
		private var _channel:SoundChannel; // サウンドチャンネル
		
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
		 * 読み込まれた <code>Sound</code> データです.
		 * <p>
		 * ロードが完了するまでは <code>null</code> です。
		 * </p>
		 */
		public function get data():Object { return _data; }
		
		/**
		 * 直近で再生を開始したサウンドの <code>SoundTransform</code> オブジェクトです.
		 */
		public function get transform():SoundTransform
		{
			if (_channel == null)
			{
				return null;
			}
			return _channel.soundTransform;
		}
		/** @private */
		public function set transform(value:SoundTransform):void
		{
			if (_channel == null)
			{
				throw new IllegalOperationError("play メソッドを呼び出してから transform プロパティを設定して下さい。");
			}
			_channel.soundTransform = value;
		}
		
		/**
		 * 新しい <code>SoundLoader</code> クラスのインスタンスを生成します.
		 * 
		 * @param URL ロード対象ファイルの URL です。
		 */
		public function SoundLoader(URL:String)
		{
			_request     = new URLRequest(URL);
			_loader      = null;
			_bytesLoaded = 0;
			_bytesTotal  = 0;
			_complete    = false;
			_data        = null;
			_channel     = null;
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
			
			var loader:Sound = new Sound();
			loader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			loader.addEventListener(Event.COMPLETE, _onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			loader.load(_request);
			
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
			
			var loader:Sound = _loader;
			loader.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
			loader.removeEventListener(Event.COMPLETE, _onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			
			_data = loader;
			
			dispatchEvent(event);
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
		 * 読み込んだサウンドを再生します.
		 * 
		 * @param loopNum ループ再生回数です。
		 * 
		 * @return 再生したサウンドの <code>SoundChannel</code> オブジェクトです。
		 * 
		 * @throws IllegalOperationError ロード完了前に実行した場合にスローされます。
		 */
		public function play(loopNum:int = 0):SoundChannel
		{
			if (!_complete)
			{
				throw new IllegalOperationError("ロードが完了してから実行して下さい。");
			}
			_channel = _loader.play(0, loopNum);
			return _channel;
		}
		
		/**
		 * 直近で再生開始したサウンドの再生を停止します.
		 * 
		 * @return サウンドの停止に成功した場合に <code>true</code> が返されます。
		 */
		public function stop():Boolean
		{
			if (_channel == null)
			{
				return false;
			}
			_channel.stop();
			_channel = null;
			return true;
		}
		
		/**
		 * サウンドを再生済みであるかどうかを判定します.
		 * 
		 * @return 再生済みである場合 <code>true</code>、未再生または <code>stop</code> メソッド実行済みである場合 <code>false</code> が返されます。
		 */
		public function isPlay():Boolean
		{
			return (_channel != null);
		}
		
		/**
		 * <code>SoundLoader</code> オブジェクトのプロパティを含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>[SoundLoader URL="<em>value</em>" bytesLoaded=<em>value</em> bytesTotal=<em>value</em> complete=<em>value</em> data="<em>value</em>"]</code>
		 * </p>
		 * 
		 * @return <code>SoundLoader</code> オブジェクトのプロパティを含むストリングです。
		 */
		override public function toString():String 
		{
			return ("[SoundLoader URL=\"" + _request.url + "\" bytesLoaded=" + _bytesLoaded + " bytesTotal=" + _bytesTotal + " complete=" + _complete + " data=\"" + _data + "\"]");
		}
	}
}

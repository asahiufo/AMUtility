package org.ahiufomasao.utility 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import org.ahiufomasao.utility.net.ImageLoader;
	
	/**
	 * <code>createImage</code> メソッドを呼び出した後、
	 * バイナリデータからの <code>DisplayObject</code> 復元が完了したときに送出されます.
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 * 
	 * @see #createImage()
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * <code>ArchiveFileData</code> クラスは、アーカイブファイルに含まれる 1 ファイル分のデータ構造です.
	 * <p>
	 * <code>filePath</code> プロパティへファイルパスを、
	 * <code>bytes</code> プロパティへバイナリデータを設定することで、
	 * アーカイブファイルに含ませる 1 ファイル分のデータを定義します。
	 * </p>
	 * <p>
	 * <code>createString</code> メソッドを呼び出すことで、<code>bytes</code> プロパティへ設定されているバイナリデータを
	 * 指定した文字セットで解釈し、文字列を取得します。
	 * </p>
	 * <p>
	 * <code>createImage</code> メソッドは <code>bytes</code> プロパティへ設定されているバイナリデータが
	 * SWF、GIF、JPEG、PNG 形式のいずれかである場合に、
	 * その形式に則った <code>DisplayObject</code> を復元します。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 * @see #filePath
	 * @see #bytes
	 * @see Archiver#compress()
	 * @see Archiver#uncompress()
	 * @see #createString()
	 * @see #createImage()
	 */
	public class ArchiveFileData extends EventDispatcher
	{
		private var _filePath:String;      // ファイルの相対パス
		private var _bytes:ByteArray;      // ファイルデータ
		private var _imageCreated:Boolean; // バイナリから DisplayObject の復元が完了したなら true
		private var _image:DisplayObject;  // バイナリから復元した DisplayObject
		
		private var _imageCreating:Boolean; // DisplayObject 復元中なら true
		
		/**
		 * データ元となったバイナリファイルのファイルパスです.
		 */
		public function get filePath():String { return _filePath; }
		/** @private */
		public function set filePath(value:String):void { _filePath = value; }
		
		/**
		 * バイナリデータです.
		 */
		public function get bytes():ByteArray { return _bytes; }
		/** @private */
		public function set bytes(value:ByteArray):void { _bytes = value; }
		
		/**
		 * <code>createImage</code> メソッドを実行した際に <code>false</code> が設定され、
		 * <code>DisplayObject</code> の復元が完了したなら <code>true</code> が設定されます.
		 * <p>
		 * <code>true</code> が設定されている状態で <code>image</code> プロパティを参照することで、
		 * 復元された <code>DisplayObject</code> を取得できます。
		 * </p>
		 * 
		 * @default false
		 */
		public function get imageCreated():Boolean { return _imageCreated; }
		
		/**
		 * バイナリデータから復元された <code>DisplayObject</code> です.
		 * <p>
		 * <code>createImage</code> メソッドを実行することで復元された <code>DisplayObject</code> が設定されます。
		 * </p>
		 */
		public function get image():DisplayObject { return _image; }
		
		/**
		 * 新しい <code>ArchiveFileData</code> クラスのインスタンスを生成します.
		 */
		public function ArchiveFileData() 
		{
			super();
			
			_filePath     = "";
			_bytes        = null;
			_imageCreated = false;
			_image        = null;
			
			_imageCreating = false;
		}
		
		/**
		 * バイナリデータを指定文字セットで解釈した文字列を取得します.
		 * <p>
		 * バイナリデータが文字列形式である場合、正常に動作します。
		 * </p>
		 * 
		 * @param charSet 取得するデータの文字セットです。
		 * 
		 * @return バイナリデータを指定文字セットで解釈した文字列です。
		 * 
		 * @throws flash.errors.IllegalOperationError <code>bytes</code> プロパティが設定されていない場合にスローされます。
		 */
		public function createString(charSet:String = "shift_jis"):String
		{
			if (_bytes == null)
			{
				throw new IllegalOperationError("bytes プロパティを設定してから実行して下さい。");
			}
			
			var len:uint = _bytes.length;
			return _bytes.readMultiByte(len, charSet);
		}
		
		/**
		 * バイナリデータから <code>DisplayObject</code> を復元します.
		 * <p>
		 * バイナリデータが SWF、GIF、JPEG、PNG 形式である場合、正常に動作します。
		 * </p>
		 * 
		 * @throws flash.errors.IllegalOperationError <code>bytes</code> プロパティが設定されていない場合にスローされます。
		 * @throws flash.errors.IllegalOperationError <code>DisplayObject</code> 復元処理中に再度呼び出した場合にスローされます。
		 */
		public function createImage():void
		{
			if (_bytes == null)
			{
				throw new IllegalOperationError("bytes プロパティを設定してから実行して下さい。");
			}
			
			if (_imageCreating)
			{
				throw new IllegalOperationError("DisplayObject を復元中です。復元が完了してから再実行して下さい。");
			}
			
			var loader:ImageLoader = new ImageLoader(_bytes);
			loader.addEventListener(Event.COMPLETE, _onComplete);
			loader.load();
			
			_image         = null;
			_imageCreated  = false;
			_imageCreating = true;
		}
		
		/**
		 * @private
		 * ディスプレイオブジェクト復元完了イベント
		 * 
		 * @param event イベント
		 */
		private function _onComplete(event:Event):void
		{
			ImageLoader(event.target).removeEventListener(Event.COMPLETE, _onComplete);
			
			_image         = DisplayObject(ImageLoader(event.target).data);
			_imageCreated  = true;
			_imageCreating = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * <code>ArchiveFileData</code> オブジェクトのプロパティを含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>[ArchiveFileData filePath="<em>value</em>"]</code>
		 * </p>
		 * 
		 * @return <code>ArchiveFileData</code> オブジェクトのプロパティを含むストリングです。
		 */
		public override function toString():String 
		{
			return ("[ArchiveFileData filePath=\"" + _filePath + "\"]"); 
		}
	}
}

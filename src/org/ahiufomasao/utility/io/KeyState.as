package org.ahiufomasao.utility.io 
{
	import flash.errors.IllegalOperationError;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	// TODO: テスト
	// TODO: asdoc
	/**
	 * キー入力状況
	 * 
	 * @author asahiufo/AM902
	 */
	public class KeyState 
	{
		private var _eventDispatcher:IEventDispatcher; // イベントを登録したイベントディスパッチャー
		
		private var _status:Dictionary;     // キーが押されているなら true、そうでないなら false
		private var _sysStatus:Dictionary;  // システム用キー入力状況
		private var _keepStatus:Dictionary; // キー押しっぱなし状況
		
		/**
		 * コンストラクタ
		 */
		public function KeyState() 
		{
			_eventDispatcher = null;
			
			_status     = new Dictionary();
			_sysStatus  = new Dictionary();
			_keepStatus = new Dictionary();
		}
		
		/**
		 * キーイベント登録
		 * 
		 * @param eventDispatcher イベントを登録するイベントディスパッチャー
		 */
		public function addKeyEventListener(eventDispatcher:IEventDispatcher):void
		{
			if (_eventDispatcher != null)
			{
				throw new IllegalOperationError("既にキーイベントが登録されています。");
			}
			
			eventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			eventDispatcher.addEventListener(KeyboardEvent.KEY_UP,   _onKeyUp);
			
			_eventDispatcher = eventDispatcher;
		}
		
		/**
		 * キーイベント除去
		 */
		public function removeKeyEventListener():void
		{
			if (_eventDispatcher == null)
			{
				throw new IllegalOperationError("まだキーイベントが登録されていません。");
			}
			
			_eventDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			_eventDispatcher.removeEventListener(KeyboardEvent.KEY_UP,   _onKeyUp);
			
			_eventDispatcher = null;
		}
		
		/**
		 * キー状況更新（すべての処理の一番最後に実行する）
		 */
		public function update():void
		{
			// 押しっぱなし状況設定
			for (var keyCode:Object in _status)
			{
				_keepStatus[keyCode] = _status;
			}
			
			_sysStatus = new Dictionary();
		}
		
		/**
		 * キーダウンイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onKeyDown(event:KeyboardEvent):void
		{
			_status[event.keyCode]    = true;
			_sysStatus[event.keyCode] = true;
		}
		
		/**
		 * キーアップイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onKeyUp(event:KeyboardEvent):void
		{
			delete _status[event.keyCode];
			delete _sysStatus[event.keyCode];
			delete _keepStatus[event.keyCode];
		}
		
		/**
		 * キー押下判定
		 * 
		 * @param keyCode 判定するキーコード
		 * 
		 * @return 指定キーコードを押下中なら true、押していないなら false
		 */
		public function checkPushed(keyCode:uint):Boolean
		{
			return (_status[keyCode] != undefined);
		}
		
		/**
		 * システム用キー押下判定
		 * 
		 * @param keyCode 判定するキーコード
		 * 
		 * @return キーボードを押しっぱなしにした場合のパターンの押下状況
		 */
		public function checkSystemPushed(keyCode:uint):Boolean
		{
			return (_sysStatus[keyCode] != undefined);
		}
		
		/**
		 * キー押しっぱなし判定
		 * 
		 * @param keyCode 判定するキーコード
		 * 
		 * @return 指定キーコードを押しっぱなしなら true、押したばかりまたは押していない場合 false
		 */
		public function checkPushedKeep(keyCode:uint):Boolean
		{
			return (_keepStatus[keyCode] != undefined);
		}
	}
}
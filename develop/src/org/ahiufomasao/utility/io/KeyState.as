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
		
		private var _states:Dictionary;     // キーが押されているなら true、そうでないなら false
		private var _sysStates:Dictionary;  // システム用キー入力状況
		private var _keepStates:Dictionary; // キー押しっぱなし状況
		
		/**
		 * コンストラクタ
		 */
		public function KeyState() 
		{
			_eventDispatcher = null;
			
			_states     = new Dictionary();
			_sysStates  = new Dictionary();
			_keepStates = new Dictionary();
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
			for (var keyCode:Object in _states)
			{
				_keepStates[keyCode] = _states;
			}
			
			_sysStates = new Dictionary();
		}
		
		/**
		 * キーダウンイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onKeyDown(event:KeyboardEvent):void
		{
			_states[event.keyCode]    = true;
			_sysStates[event.keyCode] = true;
		}
		
		/**
		 * キーアップイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onKeyUp(event:KeyboardEvent):void
		{
			delete _states[event.keyCode];
			delete _sysStates[event.keyCode];
			delete _keepStates[event.keyCode];
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
			return (_states[keyCode] != undefined);
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
			return (_sysStates[keyCode] != undefined);
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
			return (_keepStates[keyCode] != undefined);
		}
	}
}
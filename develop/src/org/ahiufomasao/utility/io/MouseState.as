package org.ahiufomasao.utility.io 
{
	import flash.errors.IllegalOperationError;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	// TODO: テスト
	// TODO: asdoc
	/**
	 * マウス入力状況
	 * 
	 * @author asahiufo/AM902
	 */
	public class MouseState 
	{
		private var _eventDispatcher:IEventDispatcher; // イベントを登録したイベントディスパッチャー
		
		private var _leftButton:Boolean;     // 左マウスボタン
		private var _sysLeftButton:Boolean;  // システム用左マウスボタン
		private var _leftButtonKeep:Boolean; // 左マウスボタンを押しっぱなしなら true
		
		private var _localX:Number; // マウスカーソルのイベントディスパッチャー基準の x 座標
		private var _localY:Number; // マウスカーソルのイベントディスパッチャー基準の y 座標
		private var _stageX:Number; // マウスカーソルのグローバル基準の x 座標
		private var _stageY:Number; // マウスカーソルのグローバル基準の y 座標
		
		/** 左マウスボタン */
		public function get leftButton():Boolean { return _leftButton; }
		/** システム用左マウスボタン */
		public function get systemLeftButton():Boolean { return _sysLeftButton; }
		/** 左マウスボタンを押しっぱなしなら true */
		public function get leftButtonKeep():Boolean { return _leftButtonKeep; }
		/** マウスカーソルのイベントディスパッチャー基準の x 座標 */
		public function get localX():Number { return _localX; }
		/** マウスカーソルのイベントディスパッチャー基準の y 座標 */
		public function get localY():Number { return _localY; }
		/** マウスカーソルのグローバル基準の x 座標 */
		public function get stageX():Number { return _stageX; }
		/** マウスカーソルのグローバル基準の y 座標 */
		public function get stageY():Number { return _stageY; }
		
		/**
		 * コンストラクタ
		 */
		public function MouseState() 
		{
			_eventDispatcher = null;
			
			_leftButton     = false;
			_sysLeftButton  = false;
			_leftButtonKeep = false;
			
			_localX = 0;
			_localY = 0;
			_stageX = 0;
			_stageY = 0;
		}
		
		/**
		 * マウスイベント登録
		 * 
		 * @param eventDispatcher イベントを登録するイベントディスパッチャー
		 */
		public function addMouseEventListener(eventDispatcher:IEventDispatcher):void
		{
			if (_eventDispatcher != null)
			{
				throw new IllegalOperationError("既にマウスイベントが登録されています。");
			}
			
			eventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			eventDispatcher.addEventListener(MouseEvent.MOUSE_UP,   _onMouseUp);
			eventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			
			_eventDispatcher = eventDispatcher;
		}
		
		/**
		 * マウスイベント除去
		 */
		public function removeMouseEventListener():void
		{
			if (_eventDispatcher == null)
			{
				throw new IllegalOperationError("まだマウスイベントが登録されていません。");
			}
			
			_eventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			_eventDispatcher.removeEventListener(MouseEvent.MOUSE_UP,   _onMouseUp);
			_eventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			
			_eventDispatcher = null;
		}
		
		/**
		 * キー状況更新（すべての処理の一番最後に実行する）
		 */
		public function update():void
		{
			// 押しっぱなし状況設定
			_leftButtonKeep = _leftButton;
			
			_sysLeftButton = false;
		}
		
		/**
		 * マウスダウンイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onMouseDown(event:MouseEvent):void
		{
			_leftButton    = true;
			_sysLeftButton = true;
		}
		
		/**
		 * マウスアップイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onMouseUp(event:MouseEvent):void
		{
			_leftButton     = false;
			_sysLeftButton  = false;
			_leftButtonKeep = false;
		}
		
		/**
		 * マウス移動イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onMouseMove(event:MouseEvent):void
		{
			_localX = event.localX;
			_localY = event.localY;
			_stageX = event.stageX;
			_stageY = event.stageY;
		}
	}
}
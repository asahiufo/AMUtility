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
		private var _prevLeftButton:Boolean; // 前フレームの左マウスボタン
		
		private var _localX:Number; // マウスカーソルのイベントディスパッチャー基準の x 座標
		private var _localY:Number; // マウスカーソルのイベントディスパッチャー基準の y 座標
		private var _stageX:Number; // マウスカーソルのグローバル基準の x 座標
		private var _stageY:Number; // マウスカーソルのグローバル基準の y 座標
		
		private var _prevLocalX:Number; // 前フレームのマウスカーソルのイベントディスパッチャー基準の x 座標
		private var _prevLocalY:Number; // 前フレームのマウスカーソルのイベントディスパッチャー基準の y 座標
		private var _prevStageX:Number; // 前フレームのマウスカーソルのグローバル基準の x 座標
		private var _prevStageY:Number; // 前フレームのマウスカーソルのグローバル基準の y 座標
		
		/** 左マウスボタン */
		public function get leftButton():Boolean { return _leftButton; }
		/** システム用左マウスボタン */
		public function get systemLeftButton():Boolean { return _sysLeftButton; }
		/** 左マウスボタンを押しっぱなしなら true */
		public function get leftButtonKeep():Boolean { return _leftButtonKeep; }
		/** 前フレームの左マウスボタン */
		public function get prevLeftButton():Boolean { return _prevLeftButton; }
		
		/** マウスカーソルのイベントディスパッチャー基準の x 座標 */
		public function get localX():Number { return _localX; }
		/** マウスカーソルのイベントディスパッチャー基準の y 座標 */
		public function get localY():Number { return _localY; }
		/** マウスカーソルのグローバル基準の x 座標 */
		public function get stageX():Number { return _stageX; }
		/** マウスカーソルのグローバル基準の y 座標 */
		public function get stageY():Number { return _stageY; }
		
		/** 前フレームのマウスカーソルのイベントディスパッチャー基準の x 座標 */
		public function get prevLocalX():Number { return _prevLocalX; }
		/** 前フレームのマウスカーソルのイベントディスパッチャー基準の y 座標 */
		public function get prevLocalY():Number { return _prevLocalY; }
		/** 前フレームのマウスカーソルのイベントディスパッチャー基準のグローバル x 座標 */
		public function get prevStageX():Number { return _prevStageX; }
		/** 前フレームのマウスカーソルのイベントディスパッチャー基準のグローバル y 座標 */
		public function get prevStageY():Number { return _prevStageY; }
		
		/** マウスカーソルのローカル基準移動量 x 軸 */
		public function get movementQuantityLocalX():Number { return (_localX - _prevLocalX); }
		/** マウスカーソルのローカル基準移動量 y 軸 */
		public function get movementQuantityLocalY():Number { return (_localY - _prevLocalY); }
		/** マウスカーソルのグローバル基準移動量 x 軸 */
		public function get movementQuantityStageX():Number { return (_stageX - _prevStageX); }
		/** マウスカーソルのグローバル基準移動量 y 軸 */
		public function get movementQuantityStageY():Number { return (_stageY - _prevStageY); }
		
		/**
		 * コンストラクタ
		 */
		public function MouseState() 
		{
			_eventDispatcher = null;
			
			_leftButton     = false;
			_sysLeftButton  = false;
			_leftButtonKeep = false;
			_prevLeftButton = false;
			
			_localX = 0;
			_localY = 0;
			_stageX = 0;
			_stageY = 0;
			
			_prevLocalX = 0;
			_prevLocalY = 0;
			_prevStageX = 0;
			_prevStageY = 0;
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
			// 前フレームの状況設定
			_prevLeftButton = _leftButton;
			_prevLocalX = _localX;
			_prevLocalY = _localY;
			_prevStageX = _stageX;
			_prevStageY = _stageY;
			
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
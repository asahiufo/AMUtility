package org.ahiufomasao.utility.events 
{
	import flash.events.Event;
	/**
	 * イベントリスナーコンテナ
	 * 
	 * @author asahiufo@AM902
	 */
	public class EventListenerCarrier 
	{
		private var _listener:Function;
		private var _params:Object;
		
		/**
		 * コンストラクタ
		 * 
		 * @param listener 呼び出すイベントリスナー（event:Event, params:Object, carrier:EventListenerCarrier）
		 * @param params   イベントリスナーに渡す引数リスト
		 */
		public function EventListenerCarrier(listener:Function, params:Object) 
		{
			_listener = listener;
			_params   = params;
		}
		
		/**
		 * 実際に addEventListener に登録するリスナーオブジェクト
		 * 
		 * @param event イベント
		 */
		public function listener(event:Event):void
		{
			if (_listener is Function)
			{
				_listener(event, _params, this);
			}
		}
	}
}
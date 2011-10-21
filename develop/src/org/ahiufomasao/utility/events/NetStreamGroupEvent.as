package org.ahiufomasao.utility.events 
{
	import flash.events.Event;
	
	/**
	 * <code>NetStreamGroupEvent</code> クラスは <code>NetStreamGroup</code>クラス を操作することによって送出されます.
	 * 
	 * @author asahiufo/AM902
	 * @see NetStreamGroup
	 */
	public class NetStreamGroupEvent extends Event 
	{
		/**
		 * <code>NetStreamGroupEvent.INITIALIZE_COMPLETE</code> 定数は、
		 * <code>type</code> プロパティ（<code>initializeComplete</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_CONNECTION</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType initializeComplete
		 */
		public static const INITIALIZE_COMPLETE:String = "initializeComplete";
		/**
		 * <code>NetStreamGroupEvent.HOST_FAR_ID_RECEIVE</code> 定数は、
		 * <code>type</code> プロパティ（<code>hostFarIDReceived</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_GROUP</td></tr>
		 * <tr><td>info.hostFarID</td><td>指定グループに属する、<em>ホスト</em>の FarID です。</td></tr>
		 * </table>
		 * 
		 * @eventType hostFarIDReceived
		 */
		public static const HOST_FAR_ID_RECEIVE:String = "hostFarIDReceived";
		/**
		 * <code>NetStreamGroupEvent.CONNECT_READY_COMPLETE</code> 定数は、
		 * <code>type</code> プロパティ（<code>connectReadyComplete</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.SEND_NET_STREAM</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType connectReadyComplete
		 */
		public static const CONNECT_READY_COMPLETE:String = "connectReadyComplete";
		/**
		 * <code>NetStreamGroupEvent.CONNECTED_FAILURE</code> 定数は、
		 * <code>type</code> プロパティ（<code>connectedFailure</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_CONNECTION</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType connectedFailure
		 */
		public static const CONNECTED_FAILURE:String = "connectedFailure";
		/**
		 * <code>NetStreamGroupEvent.CONNECT_REJECTED</code> 定数は、
		 * <code>type</code> プロパティ（<code>connectRejected</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.RECEIVE_NET_STREAM</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType connectRejected
		 */
		public static const CONNECT_REJECTED:String = "connectRejected";
		/**
		 * <code>NetStreamGroupEvent.CONNECT_COMPLETE</code> 定数は、
		 * <code>type</code> プロパティ（<code>connectComplete</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.SEND_NET_STREAM</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType connectComplete
		 */
		public static const CONNECT_COMPLETE:String = "connectComplete";
		/**
		 * <code>NetStreamGroupEvent.HOST_DISCONNECTED</code> 定数は、
		 * <code>type</code> プロパティ（<code>hostDisconnected</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_CONNECTION</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType hostDisconnected
		 */
		public static const HOST_DISCONNECTED:String = "hostDisconnected";
		/**
		 * <code>NetStreamGroupEvent.GUEST_DISCONNECTED</code> 定数は、
		 * <code>type</code> プロパティ（<code>guestDisconnected</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_CONNECTION</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType guestDisconnected
		 */
		public static const GUEST_DISCONNECTED:String = "guestDisconnected";
		/**
		 * <code>NetStreamGroupEvent.DISCONNECT_COMPLETE</code> 定数は、
		 * <code>type</code> プロパティ（<code>disconnectComplete</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.SEND_NET_STREAM</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType disconnectComplete
		 */
		public static const DISCONNECT_COMPLETE:String = "disconnectComplete";
		/**
		 * <code>NetStreamGroupEvent.TERMINATE_COMPLETE</code> 定数は、
		 * <code>type</code> プロパティ（<code>terminateComplete</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.NET_CONNECTION</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType terminateComplete
		 */
		public static const TERMINATE_COMPLETE:String = "terminateComplete";
		/**
		 * <code>NetStreamGroupEvent.RECEIVE_DATA</code> 定数は、
		 * <code>type</code> プロパティ（<code>receiveData</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>NetStreamGroupEventKind.RECEIVE_NET_STREAM</td></tr>
		 * <tr><td>info.fromFarID</td><td>送信元ノードの FarID です。</td></tr>
		 * <tr><td>info.receiveData</td><td>受信データの <code>Object</code> オブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType receiveData
		 */
		public static const RECEIVE_DATA:String = "receiveData";
		/**
		 * <code>NetStreamGroupEvent.NET_STATUS</code> 定数は、
		 * <code>type</code> プロパティ（<code>netStatus</code> イベントオブジェクト）の値を定義します.
		 * <table class="innertable">
		 * <tr><th>プロパティ</th><th>値</th></tr>
		 * <tr><td>bubbles</td><td><code>false</code></td></tr>
		 * <tr><td>cancelable</td><td><code>false</code> は、キャンセルするデフォルトの動作がないことを示します。</td></tr>
		 * <tr><td>currentTarget</td><td>イベントリスナーで <code>NetStreamGroupEvent</code> オブジェクトをアクティブに処理しているオブジェクトです。</td></tr>
		 * <tr><td>target</td><td>イベントの発生元の <code>NetStreamGroup</code> オブジェクトです。</td></tr>
		 * <tr><td>kind</td><td>発生元オブジェクトの種類です。</td></tr>
		 * <tr><td>info</td><td>オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです。</td></tr>
		 * </table>
		 * 
		 * @eventType netStatus
		 */
		public static const NET_STATUS:String = "netStatus";
		
		private var _kind:NetStreamGroupEventKind; // イベント種類
		private var _info:Object;                  // イベントの情報
		
		/**
		 * イベントの発生の機転となったオブジェクトのの種類を表します.
		 */
		public function get kind():NetStreamGroupEventKind { return _kind; }
		/** @private */
		public function set kind(value:NetStreamGroupEventKind):void { _kind = value; }
		
		/**
		 * オブジェクトのステータスまたはエラー状態を記述するプロパティを持つオブジェクトです.
		 */
		public function get info():Object { return _info; }
		/** @private */
		public function set info(value:Object):void { _info = value; }
		
		/**
		 * イベントリスナーにパラメータとして渡す <code>NetStreamGroupEvent</code> オブジェクトを作成します.
		 * 
		 * @param type       <code>NetStreamGroupEvent.type</code> としてアクセス可能なイベントタイプです。
		 * @param bubbles    <code>NetStreamGroupEvent</code> オブジェクトがイベントフローのバブリング段階で処理されるかどうかを判断します。デフォルト値は <code>false</code> です。
		 * @param cancelable <code>NetStreamGroupEvent</code> オブジェクトがキャンセル可能かどうかを判断します。デフォルト値は <code>false</code> です。
		 */
		public function NetStreamGroupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * <code>NetStreamGroupEvent</code> オブジェクトのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します.
		 * 
		 * @return 元のオブジェクトと同じプロパティ値を含む新しい <code>NetStreamGroupEvent</code> オブジェクトです。
		 */
		public override function clone():Event 
		{ 
			var event:NetStreamGroupEvent = new NetStreamGroupEvent(type, bubbles, cancelable);
			event.kind = _kind;
			event.info = _info;
			return event;
		} 
		
		/**
		 * <code>NetStreamGroupEvent</code> オブジェクトのすべてのプロパティを含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>[NetStreamGroupEvent type=<em>value</em> bubbles=<em>value</em> cancelable=<em>value</em> eventPhase=<em>value</em> kind=<em>value</em> info=<em>value</em>]</code>
		 * </p>
		 * 
		 * @return <code>NetStreamGroupEvent</code> オブジェクトのすべてのプロパティを含むストリングです。
		 */
		public override function toString():String 
		{ 
			return formatToString("NetStreamGroupEvent", "type", "bubbles", "cancelable", "eventPhase", "kind", "info"); 
		}
	}
}
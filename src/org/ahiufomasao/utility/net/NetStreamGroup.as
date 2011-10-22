package org.ahiufomasao.utility.net 
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.ahiufomasao.utility.events.NetStreamGroupEvent;
	import org.ahiufomasao.utility.events.NetStreamGroupEventKind;
	
	/**
	 * <code>initialize</code> メソッドを呼び出した後、初期処理が完了したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.INITIALIZE_COMPLETE
	 * 
	 * @see #initialize()
	 */
	[Event(name="initializeComplete", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>startRequestHostFarID</code> メソッドを呼び出した後、<em>ホスト</em>の FarID を受信する度に送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.HOST_FAR_ID_RECEIVE
	 * 
	 * @see #startRequestHostFarID()
	 */
	[Event(name="hostFarIDReceived", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>listen</code> メソッドを呼び出した後、<em>ゲスト</em>からの接続を受ける準備が完了したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.CONNECT_READY_COMPLETE
	 * 
	 * @see #listen()
	 */
	[Event(name="connectReadyComplete", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>connect</code> メソッドを呼び出した後、<em>ホスト</em>への接続に失敗したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.CONNECTED_FAILURE
	 * 
	 * @see #connect()
	 */
	[Event(name="connectedFailure", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>connect</code> メソッドを呼び出した後、<em>ホスト</em>への接続が、<em>ホスト</em>による接続拒否により失敗したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.CONNECT_REJECTED
	 * 
	 * @see #connect()
	 */
	[Event(name="connectRejected", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>connect</code> メソッドを呼び出した後、<em>ホスト</em>への接続が完了したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.CONNECT_COMPLETE
	 * 
	 * @see #connect()
	 */
	[Event(name="connectComplete", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <em>ホスト</em>が <code>close</code> メソッドを実行、または SWF を終了したことにより切断されたときに、他のノードで送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.HOST_DISCONNECTED
	 * 
	 * @see #close()
	 */
	[Event(name="hostDisconnected", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <em>ゲスト</em>が <code>close</code> メソッドを実行、または SWF を終了したことにより切断されたときに、他のノードで送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.GUEST_DISCONNECTED
	 * 
	 * @see #close()
	 */
	[Event(name="guestDisconnected", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>close</code> メソッドを呼び出した後、他ノードとの切断が完了したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.DISCONNECT_COMPLETE
	 * 
	 * @see #close()
	 */
	[Event(name="disconnectComplete", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>terminate</code> メソッドを呼び出した後、終了処理が完了したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.TERMINATE_COMPLETE
	 * 
	 * @see #terminate()
	 */
	[Event(name="terminateComplete", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * 他ノードの <code>send</code> メソッド呼び出しによって送信されたデータを受信したときに送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.RECEIVE_DATA
	 * 
	 * @see #send()
	 */
	[Event(name="receiveData", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	/**
	 * <code>NetStreamGroup</code> クラスが内包する、
	 * <code>NetConnection</code>、<code>NetStream</code>、<code>NetGroup</code> オブジェクトによって、
	 * <code>flash.events.NetStatusEvent.NET_STATUS</code> イベントが発生する度に送出されます.
	 * 
	 * @eventType org.ahiufomasao.yasume.events.NetStreamGroupEvent.NET_STATUS
	 */
	[Event(name="netStatus", type="org.ahiufomasao.yasume.events.NetStreamGroupEvent")]
	
	// TODO: テスト
	// TODO: asdoc
	/**
	 * <code>NetStreamGroup</code> クラスは、
	 * <code>NetStream</code> クラスによる、<code>NetGroup</code> ライクなコネクションを提供します.
	 * <p>
	 * <code>NetStream</code> クラスによるデータの相互通信は、
	 * 高速ではあるもの、接続するノード同士で受信用、送信用 <code>NetStream</code> を用意する必要があります。
	 * <code>NetGroup</code> クラスによるデータの相互通信は、
	 * 接続先ノードの存在を意識すること無く、簡単に通信環境を構築できる反面、通信速度は低速です。
	 * <code>NetStreamGroup</code> クラスは、これらの 2 つの接続方法の利点を組み合わせた形で相互通信環境の構築を行うことができます。
	 * </p>
	 * <p>
	 * <code>NetStreamGroup</code> クラスを使用するにあたり、初期処理を行う必要があります。
	 * 初期処理を行うには <code>initialize</code> メソッドを実行します。
	 * 初期処理の完了を検知するためには、<code>NetStreamGroupEvent.INITIALIZE_COMPLETE</code> イベントを使用します。
	 * </p>
	 * <p>
	 * <code>NetStreamGroup</code> クラスを同一インスタンスで新たな接続を行う場合は、終了処理を行います。
	 * 終了処理を行うには <code>terminate</code> メソッドを実行します。
	 * 終了処理の完了を検知するためには、<code>NetStreamGroupEvent.TERMINATE_COMPLETE</code> イベントを使用します。
	 * 終了処理が完了した後、初期処理を再実行することが可能となります。
	 * </p>
	 * <p>
	 * <code>NetStreamGroup</code> クラスは、通信を行うノードをそれぞれ、<em>ホスト</em>または<em>ゲスト</em>と位置付けて使用します。
	 * <em>ホスト</em>と位置付けたノードと、<em>ゲスト</em>と位置付けたノードとではではそれぞれ、
	 * <code>NetStreamGroup</code> クラスの使い方が異なります。
	 * </p>
	 * <p>
	 * ノードへ<em>ホスト</em>と位置付けるためには、
	 * 初期処理が完了した <code>NetStreamGroup</code> オブジェクトの <code>listen</code> メソッドを実行します。
	 * <code>listen</code> メソッドの実行後、<code>NetStreamGroupEvent.CONNECT_READY_COMPLETE</code> イベントにより、
	 * 接続準備が完了したことを検知することが出来ます。
	 * <em>ホスト</em>となったノードは、接続準備が完了した状態で、<em>ゲスト</em>となるノードからの接続を待つことになります。
	 * </p>
	 * <p>
	 * ノードへ<em>ゲスト</em>と位置付けるためには、
	 * 初期処理が完了した <code>NetStreamGroup</code> オブジェクトの <code>connect</code> メソッドを実行します。
	 * <code>connect</code> メソッドの実行後、<code>NetStreamGroupEvent.CONNECT_COMPLETE</code> イベントにより、
	 * <em>ホスト</em>への接続が完了したことを検知することが出来ます。
	 * ゲストから<em>ホスト</em>への接続が完了すると、<em>ホスト</em>、<em>ゲスト</em>間でデータを相互に送受信することができるようになります。
	 * </p>
	 * <p>
	 * 現在確立されている接続を切断する場合、<code>close</code> オブジェクトを使用します。
	 * 切断が完了したことは、<code>NetStreamGroupEvent.DISCONNECT_COMPLETE</code> イベントにより検知することが可能です。
	 * 切断後は、新たに <code>listen</code> メソッドや <code>connect</code> メソッドを呼び出すことで、
	 * 自身を新たな<em>ホスト</em>として再設定したり、自身を<em>ゲスト</em>として別の<em>ホスト</em>へ再接続することが出来ます。
	 * </p>
	 * <p>
	 * <code>send</code> メソッドを実行することにより、接続したノードに対してデータを送信することが出来ます。
	 * 受信側は、<code>NetStreamGroupEvent.RECEIVE_DATA</code>　イベントにより、データの受信を検知します。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 * @see #initialize()
	 * @see #terminate()
	 * @see #listen()
	 * @see #connect()
	 * @see #close()
	 * @see #send()
	 */
	public class NetStreamGroup extends EventDispatcher
	{
		private static const _MESSAGE_CODE_REQUEST_HOST_FAR_ID:String = "requestHostFarID";   // ホスト FarID リクエスト用メッセージコード
		private static const _MESSAGE_CODE_RESPONSE_HOST_FAR_ID:String = "responseHostFarID"; // ホスト FarID レスポンス用メッセージコード
		
		private static const _CLIENT_FUNCTION_CREATE_RECEIVE_NET_STREAM:String = "createReceiveNetStream";
		private static const _CLIENT_FUNCTION_RECEIVE:String                   = "receive";
		private static const _CLIENT_FUNCTION_ON_PEER_CONNECT:String           = "onPeerConnect";
		
		private var _netConnection:NetConnection; // NetConnection
		private var _readyComplete:Boolean;       // 接続準備ができている場合 true
		
		private var _netGroup:NetGroup; // ホスト FarID リクエスト用 NetGroup
		
		private var _host:Boolean; // ホストとして使用するなら true
		
		private var _accessPermissionCondition:Function; // アクセス許可条件
		
		private var _connectRequestFarIDs:Dictionary; // 接続要求リクエスト FarID リスト
		private var _eachOtherConnectTimer:Timer;     // 相互接続用タイマー
		
		private var _sendNetStream:NetStream;      // 送信用 NetStream
		private var _receiveNetStreams:Dictionary; // 受信用 NetStream リスト
		
		private var _firstReceiveConnectComplete:Boolean; // 接続が完了した場合 true
		
		private var _streamName:String; // ストリーム名
		private var _hostFarID:String;  // ホスト用 FarID
		
		/**
		 * <em>ホスト</em>として使用している場合 <code>true</code> が、<em>ゲスト</em>として使用している場合 <code>false</code> が設定されます.
		 */
		public function get host():Boolean
		{
			if (!_readyComplete)
			{
				return false;
			}
			return _host;
		}
		
		/**
		 * Stratus サーバーより割り当てられた NearID です.
		 */
		public function get nearID():String
		{
			if (_netConnection == null)
			{
				return "";
			}
			return _netConnection.nearID;
		}
		
		/**
		 * <code>startRequestHostFarID</code> メソッドを呼び出すことにより、<em>ホスト</em>の FarID をリクエスト中である場合 <code>true</code> が設定されます.
		 * <p>
		 * <code>stopRequestHostFarID</code> メソッドでリクエストを終了すると <code>false</code> が設定されます。
		 * </p>
		 * 
		 * @see #startRequestHostFarID()
		 * @see #stopRequestHostFarID()
		 */
		public function get requestingHostFarID():Boolean { return (_sendNetStream == null && _netGroup != null); }
		
		/**
		 * 現在、自身が接続しているグループに参加している他のノードの FarID リストです.
		 */
		public function get farIDs():Vector.<String>
		{
			if (_netConnection == null)
			{
				return null;
			}
			
			var ids:Vector.<String> = new Vector.<String>();
			for each (var sendNetStream:NetStream in _sendNetStream.peerStreams)
			{
				ids.push(sendNetStream.farID);
			}
			
			return ids;
		}
		
		/**
		 * 自身が<em>ゲスト</em>である場合に、接続している<em>ホスト</em>の FarID です.
		 */
		public function get hostFarID():String { return _hostFarID; }
		
		/**
		 * 新しい <code>NetStreamGroup</code> クラスのインスタンスを生成します.
		 */
		public function NetStreamGroup() 
		{
			super();
			
			_netConnection = null;
			_readyComplete = false;
			
			_netGroup = null;
			
			_host = false;
			
			_accessPermissionCondition = null;
			
			_connectRequestFarIDs  = null;
			_eachOtherConnectTimer = null;
			
			_sendNetStream     = null;
			_receiveNetStreams = new Dictionary();
			
			_firstReceiveConnectComplete = false;
			
			_streamName = "";
			_hostFarID  = "";
		}
		
		/**
		 * RTMFP プロトコルを使用するための初期処理を行います.
		 * 
		 * @param stratusURL 利用する Stratus サーバーの URL です。
		 * 
		 * @throws IllegalOperationError 初期処理完了後に終了処理を行わず、再度 <code>initialize</code> メソッドを実行した場合にスローされます。
		 */
		public function initialize(stratusURL:String):void
		{
			// 接続がクローズされていない場合エラー
			if (_netConnection != null)
			{
				throw new IllegalOperationError("終了処理がされていません。");
			}
			
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetConnection);
			_netConnection.connect(stratusURL);
			
			_connectRequestFarIDs = new Dictionary();
			
			_eachOtherConnectTimer = new Timer(1000);
			_eachOtherConnectTimer.addEventListener(TimerEvent.TIMER, _onTimerForEachOtherConnect);
			_eachOtherConnectTimer.start();
		}
		
		/**
		 * @private
		 * NetConnection 用 NetStatus イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onNetStatusForNetConnection(event:NetStatusEvent):void
		{
			var netStreamGroupEvent:NetStreamGroupEvent;
			
			netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.NET_STATUS);
			netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
			netStreamGroupEvent.info = event.info;
			dispatchEvent(netStreamGroupEvent);
			
			var sendMessage:Object;
			var receiveMessage:Object;
			
			switch (event.info.code)
			{
				// 接続が成功した
				case "NetConnection.Connect.Success":
					_readyComplete = true;
					netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.INITIALIZE_COMPLETE);
					netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
					netStreamGroupEvent.info = event.info;
					dispatchEvent(netStreamGroupEvent);
					break;
				
				// 接続に失敗した
				case "NetConnection.Connect.Failed":
					break;
				
				// 接続が閉じられた
				case "NetConnection.Connect.Closed":
					netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.TERMINATE_COMPLETE);
					netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
					netStreamGroupEvent.info = event.info;
					dispatchEvent(netStreamGroupEvent);
					_netConnection.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetConnection);
					break;
					
				// グループへの接続に成功
				case "NetGroup.Connect.Success":
					break;
					
				// グループへの接続が拒否された
				case "NetGroup.Connect.Rejected":
					break;
					
				// グループへの接続に失敗
				case "NetGroup.Connect.Failed":
					break;
					
				// 他クライアントの受信用 NetStream がこの送信用 NetStream に対して接続成功した
				case "NetStream.Connect.Success":
					_connectRequestFarIDs[NetStream(event.info.stream).farID] = true;
					break;
					
				case "NetStream.Connect.Closed":
					// 初回接続が行われていない場合
					if (!_firstReceiveConnectComplete)
					{
						// 接続失敗
						netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.CONNECTED_FAILURE);
						netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
						netStreamGroupEvent.info = event.info;
						dispatchEvent(netStreamGroupEvent);
					}
					// 接続済みである場合
					else
					{
						var closeFarID:String = String(event.info.stream.farID);
						// 未処理クライアントの場合
						if (_receiveNetStreams[closeFarID] != undefined)
						{
							delete _receiveNetStreams[closeFarID];
							// ホストがクローズされた場合
							if (closeFarID == _hostFarID)
							{
								netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.HOST_DISCONNECTED);
								netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
								netStreamGroupEvent.info = event.info;
								dispatchEvent(netStreamGroupEvent);
							}
							// ゲストがクローズされた場合
							else
							{
								netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.GUEST_DISCONNECTED);
								netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_CONNECTION;
								netStreamGroupEvent.info = event.info;
								dispatchEvent(netStreamGroupEvent);
							}
						}
					}
					break;
			}
		}
		
		/**
		 * @private
		 * 相互接続用タイマーイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onTimerForEachOtherConnect(event:TimerEvent):void
		{
			// 送信不可の受信用 NetStream が存在するなら、処理を待つ
			if (_netConnection.unconnectedPeerStreams.length != 0)
			{
				return;
			}
			
			var sendNetStream:NetStream;
			var currentSendNetStream:NetStream;
			
			var farID:String = "";
			// 接続リクエスト中の FarID を 1 つ取得
			for (farID in _connectRequestFarIDs)
			{
				break;
			}
			if (farID == "")
			{
				return;
			}
			
			// 相互接続実行
			if (_receiveNetStreams[farID] == undefined)
			{
				_createReceiveNetStream(farID);
				// ホストの場合
				if (_host)
				{
					// 新規接続ゲストを他のゲストと繋ぐ
					for each (sendNetStream in _sendNetStream.peerStreams)
					{
						if (sendNetStream.farID == farID)
						{
							currentSendNetStream = sendNetStream;
							break;
						}
					}
					if (currentSendNetStream != null)
					{
						// 接続実行
						for each (sendNetStream in _sendNetStream.peerStreams)
						{
							if (sendNetStream.farID != farID)
							{
								currentSendNetStream.dataReliable = true;
								currentSendNetStream.send(_CLIENT_FUNCTION_CREATE_RECEIVE_NET_STREAM, sendNetStream.farID);
								currentSendNetStream.dataReliable = false;
							}
						}
					}
				}
			}
			delete _connectRequestFarIDs[farID];
			
			_firstReceiveConnectComplete = true;
		}
		
		/**
		 * 指定したグループに属する<em>ホスト</em>の FarID のリクエストを開始します.
		 * 
		 * @param groupName ホストが属するグループ名
		 * 
		 * @throws IllegalOperationError 初期処理が完了していない場合にスローされます。
		 * @throws IllegalOperationError 既にコネクションが確立されている場合にスローされます。
		 * @throws IllegalOperationError 既にリクエストを開始している場合にスローされます。
		 */
		public function startRequestHostFarID(groupName:String):void
		{
			if (_netConnection == null)
			{
				throw new IllegalOperationError("初期処理が完了していません。");
			}
			if (requestingHostFarID)
			{
				throw new IllegalOperationError("リクエスト済みです。");
			}
			if (_sendNetStream != null)
			{
				throw new IllegalOperationError("接続済みです。");
			}
			
			var groupSpecifier:GroupSpecifier = new GroupSpecifier(groupName);
			groupSpecifier.postingEnabled       = true;
			groupSpecifier.serverChannelEnabled = true;
			
			_netGroup = new NetGroup(_netConnection, groupSpecifier.toString());
			_netGroup.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetGroup);
		}
		
		/**
		 * @private
		 * NetGroup 用 NetStatus イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onNetStatusForNetGroup(event:NetStatusEvent):void
		{
			var netStreamGroupEvent:NetStreamGroupEvent;
			
			netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.NET_STATUS);
			netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_GROUP;
			netStreamGroupEvent.info = event.info;
			dispatchEvent(netStreamGroupEvent);
			
			var sendMessage:Object;
			var receiveMessage:Object;
			
			switch (event.info.code)
			{
				// 隣人ノードが接続された
				case "NetGroup.Neighbor.Connect":
					if (requestingHostFarID)
					{
						sendMessage = new Object();
						sendMessage.code        = _MESSAGE_CODE_REQUEST_HOST_FAR_ID;
						sendMessage.guestPeerID = nearID;
						_netGroup.post(sendMessage);
					}
					break;
					
				// 隣人ノードが切断された
				case "NetGroup.Neighbor.Disconnec":
					break;
					
				// ポストデータ到着の通知
				case "NetGroup.Posting.Notify":
					receiveMessage = event.info.message;
					// ゲストからホストへの PeerID リクエスト
					if (receiveMessage.code == _MESSAGE_CODE_REQUEST_HOST_FAR_ID)
					{
						// ホストである場合
						if (_host)
						{
							// レスポンスを返す
							sendMessage = new Object();
							sendMessage.code        = _MESSAGE_CODE_RESPONSE_HOST_FAR_ID;
							sendMessage.guestPeerID = receiveMessage.guestPeerID;
							sendMessage.hostPeerID  = nearID;
							_netGroup.post(sendMessage);
						}
					}
					// ホストからゲストへの PeerID レスポンス
					else if (receiveMessage.code == _MESSAGE_CODE_RESPONSE_HOST_FAR_ID)
					{
						// ゲストまたは未接続である場合
						if (!_host)
						{
							// 自分のリクエストに対するレスポンスである場合
							if (nearID == receiveMessage.guestPeerID)
							{
								// ホスト FarID 受信イベント
								netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.HOST_FAR_ID_RECEIVE);
								netStreamGroupEvent.kind = NetStreamGroupEventKind.NET_GROUP;
								var info:Object = new Object();
								info.hostFarID = receiveMessage.hostPeerID;
								netStreamGroupEvent.info = info;
								dispatchEvent(netStreamGroupEvent);
							}
						}
					}
					break;
			}
		}
		
		/**
		 * <em>ホスト</em>の FarID リクエストを停止します.
		 * 
		 * @throws IllegalOperationError 既にコネクションが確立されている場合にスローされます。
		 * @throws IllegalOperationError リクエストを開始されていない場合にスローされます。
		 */
		public function stopRequestHostFarID():void
		{
			if (_sendNetStream != null)
			{
				throw new IllegalOperationError("接続済みです。");
			}
			
			if (_netGroup == null)
			{
				throw new IllegalOperationError("リクエストが開始されていません。");
			}
			_netGroup.close();
			_netGroup.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetGroup);
			_netGroup = null;
		}
		
		/**
		 * <em>ゲスト</em>からの接続を待ち受けます.
		 * <p>
		 * <code>accessPermissionCondition</code> パラメータには、
		 * 引数に接続要求をしているノードの <code>NetStream</code> オブジェクトを、
		 * 戻り値にアクセス許可、拒否を定義したメソッドを指定します。
		 * </p>
		 * @example 次のコードは <code>accessPermissionCondition</code> パラメータへ指定するメソッドの例です。
		 * <listing version="3.0">
		 * private function condition(subscriber:NetStream):Boolean
		 * {
		 *     // 条件判定（アクセス許可するなら true、アクセス拒否するなら false を返す。）
		 * }</listing>
		 * 
		 * @param streamName                接続を待ち受けるストリーム名です。
		 * @param groupName                 ホストを所属させるグループ名です。
		 * @param accessPermissionCondition アクセス許可条件を定義したメソッドです。
		 * 
		 * @throws IllegalOperationError 初期処理が完了していない場合にスローされます。
		 * @throws IllegalOperationError 既にコネクションが確立されている場合にスローされます。
		 * @throws IllegalOperationError ホスト FarID リクエストが開始している場合にスローされます。
		 */
		public function listen(streamName:String, groupName:String = "", accessPermissionCondition:Function = null):void
		{
			if (_netConnection == null)
			{
				throw new IllegalOperationError("初期処理が完了していません。");
			}
			if (_sendNetStream != null)
			{
				throw new IllegalOperationError("接続済みです。");
			}
			
			if (groupName != "")
			{
				if (_netGroup != null)
				{
					throw new IllegalOperationError("ホスト FarID リクエストが停止されていません。");
				}
			}
			
			_accessPermissionCondition = accessPermissionCondition;
			_publish(streamName);
			
			if (groupName != "")
			{
				var groupSpecifier:GroupSpecifier = new GroupSpecifier(groupName);
				groupSpecifier.postingEnabled       = true;
				groupSpecifier.serverChannelEnabled = true;
				
				_netGroup = new NetGroup(_netConnection, groupSpecifier.toString());
				_netGroup.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetGroup);
			}
		}
		
		/**
		 * <em>ホスト</em>へ接続します.
		 * <p>
		 * <code>accessPermissionCondition</code> パラメータには、
		 * 引数に接続要求をしているノードの <code>NetStream</code> オブジェクトを、
		 * 戻り値にアクセス許可、拒否を定義したメソッドを指定します。
		 * </p>
		 * @example 次のコードは <code>accessPermissionCondition</code> パラメータへ指定するメソッドの例です。
		 * <listing version="3.0">
		 * private function condition(subscriber:NetStream):Boolean
		 * {
		 *     // 条件判定（アクセス許可するなら true、アクセス拒否するなら false を返す。）
		 * }</listing>
		 * 
		 * @param streamName                接続する<em>ホスト</em>が接続を待ち受けているストリーム名です。
		 * @param hostFarID                 接続する<em>ホスト</em>の FarID です。
		 * @param accessPermissionCondition アクセス許可条件を定義したメソッドです。
		 * 
		 * @throws IllegalOperationError 初期処理が完了していない場合にスローされます。
		 * @throws IllegalOperationError 既にコネクションが確立されている場合にスローされます。
		 */
		public function connect(streamName:String, hostFarID:String, accessPermissionCondition:Function = null):void
		{
			if (_netConnection == null)
			{
				throw new IllegalOperationError("初期処理が完了していません。");
			}
			if (_sendNetStream != null)
			{
				throw new IllegalOperationError("接続済みです。");
			}
			
			_accessPermissionCondition = accessPermissionCondition;
			_publish(streamName, hostFarID);
		}
		
		/**
		 * @private
		 * パブリッシュ
		 * 
		 * @param streamName ストリーム名
		 * @param hostFarID  ホストの FarID
		 */
		private function _publish(streamName:String, hostFarID:String = ""):void
		{
			if (!_readyComplete)
			{
				throw new IllegalOperationError("接続準備が出来ていません。");
			}
			
			_streamName = streamName;
			
			_host = (hostFarID.length == 0);
			if (!_host)
			{
				_hostFarID = hostFarID;
			}
			
			_sendNetStream = new NetStream(_netConnection, NetStream.DIRECT_CONNECTIONS);
			var client:Object = new Object();
			client[_CLIENT_FUNCTION_ON_PEER_CONNECT] = _onPeerConnect;
			_sendNetStream.client = client;
			_sendNetStream.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForSendNetStream);
			_sendNetStream.publish(streamName);
			
			if (!_host)
			{
				_createReceiveNetStream(_hostFarID);
			}
		}
		
		/**
		 * @private
		 * アクセス制御
		 * 
		 * @param subscriber 接続要求をしているノードの NetStream オブジェクト
		 * 
		 * @return アクセスを許可する場合 true
		 */
		private function _onPeerConnect(subscriber:NetStream):Boolean
		{
			if (_accessPermissionCondition != null)
			{
				return _accessPermissionCondition(subscriber);
			}
			return true;
		}
		
		/**
		 * @private
		 * 送信用 NetStream 用 NetStatus イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onNetStatusForSendNetStream(event:NetStatusEvent):void
		{
			var netStreamGroupEvent:NetStreamGroupEvent;
			
			netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.NET_STATUS);
			netStreamGroupEvent.kind = NetStreamGroupEventKind.SEND_NET_STREAM;
			netStreamGroupEvent.info = event.info;
			dispatchEvent(netStreamGroupEvent);
			
			switch (event.info.code)
			{
				// パブリッシュを開始した
				case "NetStream.Publish.Start":
					if (host)
					{
						netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.CONNECT_READY_COMPLETE);
					}
					else
					{
						netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.CONNECT_COMPLETE);
					}
					netStreamGroupEvent.kind = NetStreamGroupEventKind.SEND_NET_STREAM;
					netStreamGroupEvent.info = event.info;
					dispatchEvent(netStreamGroupEvent);
					break;
					
				// 再生リストがリセットされた
				case "NetStream.Play.Reset":
					break;
					
				// 再生が開始された
				case "NetStream.Play.Start":
					break;
					
				// パブリッシュの終了に成功した
				case "NetStream.Unpublish.Success":
					netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.DISCONNECT_COMPLETE);
					netStreamGroupEvent.kind = NetStreamGroupEventKind.SEND_NET_STREAM;
					netStreamGroupEvent.info = event.info;
					dispatchEvent(netStreamGroupEvent);
					_sendNetStream.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForSendNetStream);
					break;
			}
		}
		
		/**
		 * @private
		 * 受信用 NetStream 生成
		 * 
		 * @param farID 受信対象 FarID
		 */
		private function _createReceiveNetStream(farID:String):void
		{
			var receiveNetStream:NetStream = new NetStream(_netConnection, farID);
			var client:Object = new Object();
			client[_CLIENT_FUNCTION_RECEIVE] = _receive;
			if (!_host)
			{
				client[_CLIENT_FUNCTION_CREATE_RECEIVE_NET_STREAM] = _createReceiveNetStream;
			}
			receiveNetStream.client = client;
			receiveNetStream.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForReceiveNetStream);
			receiveNetStream.play(_streamName);
			
			_receiveNetStreams[farID] = receiveNetStream;
		}
		
		/**
		 * @private
		 * 受信時の処理
		 * 
		 * @param fromFarID 送り元 FarID
		 * @param data      受信データ
		 */
		private function _receive(fromFarID:String, data:Object):void
		{
			var netStreamGroupEvent:NetStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.RECEIVE_DATA);
			netStreamGroupEvent.kind = NetStreamGroupEventKind.RECEIVE_NET_STREAM;
			
			var info:Object  = new Object();
			info.fromFarID   = fromFarID;
			info.receiveData = data;
			netStreamGroupEvent.info = info;
			dispatchEvent(netStreamGroupEvent);
		}
		
		/**
		 * @private
		 * 受信用 NetStream 用 NetStatus イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onNetStatusForReceiveNetStream(event:NetStatusEvent):void
		{
			var netStreamGroupEvent:NetStreamGroupEvent;
			
			netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.NET_STATUS);
			netStreamGroupEvent.kind = NetStreamGroupEventKind.RECEIVE_NET_STREAM;
			netStreamGroupEvent.info = event.info;
			dispatchEvent(netStreamGroupEvent);
			
			switch (event.info.code)
			{
				// 再生リストがリセットされた
				case "NetStream.Play.Reset":
					break;
					
				// 再生が開始された
				case "NetStream.Play.Start":
					break;
					
				// 再生に失敗した
				case "NetStream.Play.Failed":
					netStreamGroupEvent = new NetStreamGroupEvent(NetStreamGroupEvent.CONNECT_REJECTED);
					netStreamGroupEvent.kind = NetStreamGroupEventKind.RECEIVE_NET_STREAM;
					netStreamGroupEvent.info = event.info;
					dispatchEvent(netStreamGroupEvent);
					break;
			}
		}
		
		/**
		 * 他のノードへデータを送信します.
		 * 
		 * @param data         送信するデータを設定した <code>Object</code> オブジェクトです。
		 * @param dataReliable 信頼性のある送信を行う場合に <code>true</code> を指定します。
		 * @param toFarID      送信対象ノードの FarID です。省略すると、すべてのノードを対象とします。
		 * 
		 * @throws IllegalOperationError コネクションが確立されていない場合にスローされます。
		 */
		public function send(data:Object, dataReliable:Boolean = false, toFarID:String = "all"):void
		{
			if (_sendNetStream == null)
			{
				throw new IllegalOperationError("接続されていません。");
			}
			
			if (toFarID == "all")
			{
				_sendNetStream.dataReliable = dataReliable;
				_sendNetStream.send(_CLIENT_FUNCTION_RECEIVE, nearID, data);
				_sendNetStream.dataReliable = false;
			}
			else
			{
				for each (var sendNetStream:NetStream in _sendNetStream.peerStreams)
				{
					if (sendNetStream.farID == toFarID)
					{
						sendNetStream.dataReliable = dataReliable;
						sendNetStream.send(_CLIENT_FUNCTION_RECEIVE, nearID, data);
						sendNetStream.dataReliable = false;
						break;
					}
				}
			}
		}
		
		/**
		 * すべての接続を閉じます.
		 * 
		 * @throws IllegalOperationError コネクションが確立されていない場合にスローされます。
		 */
		public function close():void
		{
			if (_sendNetStream == null)
			{
				throw new IllegalOperationError("接続されていません。");
			}
			
			for each (var receiveNetStream:NetStream in _receiveNetStreams)
			{
				receiveNetStream.close();
				receiveNetStream.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForReceiveNetStream);
			}
			_sendNetStream.close();
			
			if (_netGroup != null)
			{
				_netGroup.close();
				_netGroup.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatusForNetGroup);
				_netGroup = null;
			}
			
			_firstReceiveConnectComplete = false;
			
			_receiveNetStreams = new Dictionary();
			_sendNetStream     = null;
			
			_streamName = "";
			_hostFarID  = "";
			
			_host = false;
		}
		
		/**
		 * 終了処理を行います.
		 * 
		 * @throws IllegalOperationError 初期処理が完了していない場合にスローされます。
		 */
		public function terminate():void
		{
			if (_netConnection == null)
			{
				throw new IllegalOperationError("初期処理が完了していません。");
			}
			
			_netConnection.close();
			
			_netConnection = null;
			_readyComplete = false;
			
			_eachOtherConnectTimer.removeEventListener(TimerEvent.TIMER, _onTimerForEachOtherConnect);
			_eachOtherConnectTimer.stop();
			_eachOtherConnectTimer = null;
			
			_connectRequestFarIDs = null;
		}
	}
}
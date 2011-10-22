package org.ahiufomasao.utility.events 
{
	/**
	 * <code>NetStreamGroupEventKind</code> クラスには、
	 * <code>NetStreamGroupEvent</code> イベントの種類を表す定数があります.
	 * 
	 * @author asahiufo/AM902
	 */
	public class NetStreamGroupEventKind 
	{
		/**
		 * <code>NetConnection</code> オブジェクトが起点となったイベントであることを表します.
		 */
		public static const NET_CONNECTION:NetStreamGroupEventKind = new NetStreamGroupEventKind();
		/**
		 * <code>NetGroup</code> オブジェクトが起点となったイベントであることを表します.
		 */
		public static const NET_GROUP:NetStreamGroupEventKind = new NetStreamGroupEventKind();
		/**
		 * 送信用 <code>NetStream</code> オブジェクトが起点となったイベントであることを表します.
		 */
		public static const SEND_NET_STREAM:NetStreamGroupEventKind = new NetStreamGroupEventKind();
		/**
		 * 受信用 <code>NetStream</code> オブジェクトが起点となったイベントであることを表します.
		 */
		public static const RECEIVE_NET_STREAM:NetStreamGroupEventKind = new NetStreamGroupEventKind();
	}
}
package org.ahiufomasao.utility.net 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * <code>ILoader</code> インターフェイスは、外部データのロードを行うクラスによって実装されます.
	 * <p>
	 * 各種ロード状況を示すプロパティと、読み込まれたデータ、ロードを実行するメソッドを提供します。
	 * </p>
	 * <p>
	 * <code>ILoader</code> インターフェイスを実装した場合、 <code>EventDispatcher</code> クラスの継承等により、 
	 * <code>IEventDispatcher</code> インターフェイスによって提供されるメソッドを実装してください。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 */
	public interface ILoader extends IEventDispatcher
	{
		/**
		 * ロードされたアイテム数またはバイト数です.
		 */
		function get bytesLoaded():uint;
		/**
		 * ロードプロセスが成功した場合にロードされるアイテムまたはバイトの総数です.
		 * <p>
		 * <code>load</code> メソッドが実行されるまでは常に 0 です。
		 * </p>
		 */
		function get bytesTotal():uint;
		/**
		 * <code>true</code> が設定されている場合、現在ロード中であることを表します.
		 * <p>
		 * <code>load</code> メソッド実行前は <code>false</code>、
		 * <code>load</code> メソッド実行後、ロードが完了していない場合は <code>true</code>、
		 * ロードが完了している場合は <code>false</code> がそれぞれ設定されます。
		 * </p>
		 * 
		 * @see #load()
		 */
		function get loading():Boolean;
		/**
		 * ロードが完了したタイミングで <code>true</code> が設定されます.
		 */
		function get complete():Boolean;
		/**
		 * 読み込まれたデータです.
		 * <p>
		 * ロードが完了するまでは <code>null</code> です。
		 * </p>
		 */
		function get data():Object;
		/**
		 * ロードを開始します.
		 */
		function load():void;
		/**
		 * オブジェクトのプロパティを含むストリングを返します.
		 * 
		 * @return オブジェクトのプロパティを含むストリングです。
		 */
		function toString():String;
	}
}

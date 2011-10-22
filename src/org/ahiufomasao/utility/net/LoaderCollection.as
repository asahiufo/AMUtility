package org.ahiufomasao.utility.net 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	/**
	 * <code>loadAll</code> メソッドを呼び出した後、データを受信したときに送出されます.
	 * 
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 * 
	 * @see #loadAll()
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	/**
	 * <code>loadAll</code> メソッドを呼び出した後、ロードが完了した時に送出されます.
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 * 
	 * @see #loadAll()
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * <code>LoaderCollection</code> クラスは、登録された全 <code>ILoader</code> オブジェクトに対し、
	 * 一括でロードを実行したり、ロード完了を検出したりする機能を提供します.
	 * <p>
	 * まず <code>addLoader</code> メソッド、<code>addLoaderCollection</code> メソッドにより <code>ILoader</code> オブジェクトを登録します。
	 * 次に <code>loadAll</code> メソッドを呼び出すことで、登録された <code>ILoader</code> オブジェクトの一括ロードを実行します。
	 * <code>Event.COMPLETE</code> イベントまたは <code>complete</code> プロパティを監視することにより、
	 * 登録された全 <code>ILoader</code> オブジェクトのロードが完了したかどうかを検出できます。
	 * ロード完了後、<code>getLoader</code> メソッドまたは <code>getLoaderCollection</code> メソッドにより
	 * <code>ILoader</code> オブジェクトを取得し、ロードされたデータにアクセスすることができます。
	 * </p>
	 * 
	 * @author asahiufo/AM902
	 * @see ILoader
	 * @see #addLoader()
	 * @see #addLoaderCollection()
	 * @see #complete
	 * @see #getLoader()
	 * @see #getLoaderCollection()
	 */
	public class LoaderCollection extends EventDispatcher
	{
		private var _addedFlg:Boolean;                   // 1つでもローダーを追加したならtrue
		
		private var _loaders:DictionaryVector;           // ローダーリスト
		private var _loaderCollections:DictionaryVector; // ローダーまとまりリスト
		
		private var _length:uint;      // 登録ローダー数
		private var _completeNum:uint; // ロード完了数
		
		/**
		 * <code>ILoader</code> オブジェクト、<code>LoaderCollection</code> オブジェクトの登録数です。
		 */
		public function get length():uint { return _length; }
		
		/**
		 * 登録されている全 <code>ILoader</code> オブジェクトのロードされたアイテム数またはバイト数です.
		 */
		public function get bytesLoaded():uint
		{
			var bytes:uint = 0;
			
			for each (var loader:ILoader in _loaders.vector)
			{
				bytes += loader.bytesLoaded;
			}
			for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
			{
				bytes += loaderCollection.bytesLoaded;
			}
			
			return bytes;
		}
		/**
		 * 登録されている全 <code>ILoader</code> オブジェクトのロードプロセスが成功した場合にロードされるアイテムまたはバイトの総数です.
		 * <p>
		 * <code>loadAll</code> メソッドが実行されるまでは常に 0 です。
		 * </p>
		 */
		public function get bytesTotal():uint
		{
			var bytes:uint = 0;
			
			for each (var loader:ILoader in _loaders.vector)
			{
				bytes += loader.bytesTotal;
			}
			for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
			{
				bytes += loaderCollection.bytesTotal;
			}
			
			return bytes;
		}
		
		/**
		 * ロードが完了したタイミングで <code>true</code> が設定されます.
		 */
		public function get complete():Boolean
		{
			// 1つもローダーを追加していないなら完了としない
			if (!_addedFlg)
			{
				return false;
			}
			
			for each (var loader:ILoader in _loaders.vector)
			{
				if (!loader.complete)
				{
					return false;
				}
			}
			for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
			{
				if (!loaderCollection.complete)
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		 * 新しい <code>LoaderCollection</code> クラスのインスタンスを生成します.
		 */
		public function LoaderCollection() 
		{
			_addedFlg          = false;
			
			_loaders           = new DictionaryVector();
			_loaderCollections = new DictionaryVector();
			
			_length            = 0;
			_completeNum       = 0;
		}
		
		/**
		 * <code>ILoader</code> オブジェクトを登録します.
		 * 
		 * @param loader 登録する <code>ILoader</code> オブジェクトです。
		 * @param key    登録する <code>ILoader</code> オブジェクトへの参照用キーです。
		 * 
		 * @return 登録された <code>ILoader</code> オブジェクトです。
		 */
		public function addLoader(loader:ILoader, key:Object = null):ILoader
		{
			_length++;
			
			if (loader.complete)
			{
				_completeNum++;
			}
			else
			{
				loader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
				loader.addEventListener(Event.COMPLETE, _onComplete);
			}
			_loaders.add(loader, key);
			
			_addedFlg = true;
			
			return loader;
		}
		
		/**
		 * <code>LoaderCollection</code> オブジェクトを登録します.
		 * 
		 * @param loaderCollection 登録する <code>LoaderCollection</code> オブジェクトです。
		 * @param key              登録する <code>LoaderCollection</code> オブジェクトへの参照用キーです。
		 * 
		 * @return 登録された <code>LoaderCollection</code> オブジェクトです。
		 */
		public function addLoaderCollection(loaderCollection:LoaderCollection, key:Object = null):LoaderCollection
		{
			_length++;
			
			if (loaderCollection.complete)
			{
				_completeNum++;
			}
			else
			{
				loaderCollection.addEventListener(ProgressEvent.PROGRESS, _onProgress);
				loaderCollection.addEventListener(Event.COMPLETE, _onComplete);
			}
			_loaderCollections.add(loaderCollection, key);
			
			_addedFlg = true;
			
			return loaderCollection;
		}
		
		/**
		 * 登録されている <code>ILoader</code> オブジェクトを取得します.
		 * 
		 * @param key 取得対象 <code>ILoader</code> オブジェクトの参照用キーです。
		 * 
		 * @return 取得した <code>ILoader</code> オブジェクトです。
		 */
		public function getLoader(key:Object):ILoader
		{
			return ILoader(_loaders.getObj(key));
		}
		
		/**
		 * 登録されている <code>LoaderCollection</code> オブジェクトを取得します.
		 * 
		 * @param key 取得対象 <code>LoaderCollection</code> オブジェクトの参照用キーです。
		 * 
		 * @return 取得した <code>LoaderCollection</code> オブジェクトです。
		 */
		public function getLoaderCollection(key:Object):LoaderCollection
		{
			return LoaderCollection(_loaderCollections.getObj(key));
		}
		
		/**
		 * <code>ILoader</code> オブジェクト登録時に設定された全参照用キーのリストを取得します.
		 * 
		 * @return 参照用キーのリストです。
		 */
		public function getLoadersKeys():Vector.<Object>
		{
			return _loaders.getKeys();
		}
		
		/**
		 * <code>LoaderCollection</code> オブジェクト登録時に設定された全参照用キーのリストを取得します.
		 * 
		 * @return 参照用キーのリストです。
		 */
		public function getLoaderCollectionsKeys():Vector.<Object>
		{
			return _loaderCollections.getKeys();
		}
		
		/**
		 * 登録されている全 <code>ILoader</code> オブジェクトのロードを開始します.
		 */
		public function loadAll():void
		{
			for each (var loader:ILoader in _loaders.vector)
			{
				if (!loader.loading && !loader.complete)
				{
					loader.load();
				}
			}
			for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
			{
				loaderCollection.loadAll();
			}
		}
		
		/**
		 * @private
		 * プログレスイベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * @private
		 * ロード完了イベントハンドラ
		 * 
		 * @param event イベント
		 */
		private function _onComplete(event:Event):void
		{
			_completeNum++;
			
			if (_completeNum == _length)
			{
				dispatchEvent(event);
				
				// 全イベントを削除
				for each (var loader:ILoader in _loaders.vector)
				{
					if (!loader.complete)
					{
						loader.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
						loader.removeEventListener(Event.COMPLETE, _onComplete);
					}
				}
				for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
				{
					if (!loaderCollection.complete)
					{
						loaderCollection.removeEventListener(ProgressEvent.PROGRESS, _onProgress);
						loaderCollection.removeEventListener(Event.COMPLETE, _onComplete);
					}
				}
			}
		}
		
		/**
		 * <code>LoaderCollection</code> オブジェクトのプロパティと、
		 * リストに登録されている <code>ILoader</code> オブジェクトと 
		 * <code>LoaderCollection</code> オブジェクトの文字列表現を含むストリングを返します.
		 * <p>
		 * ストリングは次の形式です。
		 * </p>
		 * <p>
		 * <code>
		 * [LoaderCollection length=<em>value</em> bytesLoaded=<em>value</em> bytesTotal=<em>value</em> complete=<em>value</em>]<br />
		 *  + [StringLoader ・・・<br />
		 *  + [ImageLoader ・・・<br />
		 *  + [SoundLoader ・・・<br />
		 *  + [LoaderCollection ・・・<br />
		 *  :
		 * </code>
		 * </p>
		 * 
		 * @return <code>LoaderCollection</code> オブジェクトのプロパティと、リストに登録されている <code>ILoader</code> オブジェクトと <code>LoaderCollection</code> オブジェクトの文字列表現を含むストリングです.
		 */
		override public function toString():String 
		{
			var retStr:String = "";
			
			retStr += "[LoaderCollection length=" + _length + " bytesLoaded=" + bytesLoaded + " bytesTotal=" + bytesTotal + " complete=" + complete + "]";
			for each (var loader:ILoader in _loaders.vector)
			{
				retStr += "\n + " + loader.toString();
			}
			for each (var loaderCollection:LoaderCollection in _loaderCollections.vector)
			{
				retStr += "\n + " + loaderCollection.toString();
			}
			
			return retStr;
		}
	}
}

import flash.utils.Dictionary;

/**
 * @private
 * 参照用キー有りリスト
 */
class DictionaryVector
{
	private var _vector:Vector.<Object>; // 実オブジェクト登録用
	private var _dictionary:Dictionary;  // 参照用キーと実オブジェクトの紐付け用
	
	/** 実オブジェクトリスト */
	public function get vector():Vector.<Object> { return _vector; }
	
	/**
	 * コンストラクタ
	 */
	public function DictionaryVector()
	{
		_vector     = new Vector.<Object>();
		_dictionary = new Dictionary();
	}
	
	/**
	 * 登録
	 * 
	 * @param obj 登録するオブジェクト
	 * @param key 参照用キー
	 */
	public function add(obj:Object, key:Object = null):void
	{
		if (key == null)
		{
			_vector.push(obj);
		}
		else
		{
			if (_dictionary[key] != undefined)
			{
				throw new ArgumentError("重複したキーでの登録はできません。[キー=" + key.toString() + "]");
			}
			_dictionary[key] = _vector.push(obj) - 1;
		}
	}
	
	/**
	 * オブジェクト取得
	 * 
	 * @param key 取得するオブジェクトのキー
	 * 
	 * @return 取得したオブジェクト
	 */
	public function getObj(key:Object):Object
	{
		if (_dictionary[key] == undefined)
		{
			throw new ArgumentError("指定されたキーは存在しません。[キー=" + key.toString() + "]");
		}
		return _vector[_dictionary[key]];
	}
	
	/**
	 * 登録済みオブジェクトの全参照用キーリスト取得
	 * 
	 * @return 参照用キーリスト
	 */
	public function getKeys():Vector.<Object>
	{
		var list:Vector.<Object> = new Vector.<Object>();
		for (var key:Object in _dictionary)
		{
			list.push(key);
		}
		return list;
	}
}

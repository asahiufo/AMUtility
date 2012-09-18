package org.ahiufomasao.utility.media 
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	/**
	 * <code>SoundWithIntro</code> クラスは、イントロ付きループサウンドの再生を行います.
	 * <p>
	 * 指定されたイントロサウンドを初回のみ再生し、
	 * イントロサウンドの再生完了後にループサウンドをループ再生します。
	 * </p>
	 * 
	 * @author asahiufo@AM902
	 */
	public class SoundWithIntro 
	{
		private var _introSound:Sound; // イントロサウンド
		private var _loopSound:Sound;  // ループサウンド
		
		private var _loops:int; // ループ回数
		
		private var _introSoundChannel:SoundChannel;
		private var _loopSoundChannel:SoundChannel;
		
		/**
		 * 新しい <code>SoundWithIntro</code> クラスのインスタンスを生成します.
		 * 
		 * @param introSound イントロとする <code>Sound</code> オブジェクトです。
		 * @param loopSound  イントロ後にループ再生される <code>Sound</code> オブジェクトです。
		 */
		public function SoundWithIntro(introSound:Sound, loopSound:Sound) 
		{
			_introSound = introSound;
			_loopSound  = loopSound;
			
			_loops = 0;
			
			_introSoundChannel = null;
			_loopSoundChannel  = null;
		}
		
		/**
		 * サウンドの再生を開始します.
		 * 
		 * @param loops ループ再生回数です。
		 * 
		 * @throws IllegalOperationError 既に再生中である場合にスローされます。
		 */
		public function play(loops:int = 0):void
		{
			if (isPlay() == true)
			{
				throw new IllegalOperationError("既に再生中です。");
			}
			_introSoundChannel = _introSound.play(0, 0);
			_introSoundChannel.addEventListener(Event.SOUND_COMPLETE, _onIntroSoundComplete);
			
			_loops = loops;
		}
		
		/**
		 * @private
		 * イントロサウンド再生完了イベント
		 * 
		 * @param event イベント
		 */
		private function _onIntroSoundComplete(event:Event):void
		{
			_introSoundChannel.removeEventListener(Event.SOUND_COMPLETE, _onIntroSoundComplete);
			_loopSoundChannel = _loopSound.play(0, _loops);
		}
		
		/**
		 * 再生開始したサウンドの再生を停止します.
		 * 
		 * @return サウンドの停止に成功した場合に <code>true</code> が返されます。
		 */
		public function stop():Boolean
		{
			if (_introSoundChannel == null && _loopSoundChannel == null)
			{
				return false;
			}
			
			if (_introSoundChannel != null)
			{
				if (_introSoundChannel.hasEventListener(Event.SOUND_COMPLETE) == true)
				{
					_introSoundChannel.removeEventListener(Event.SOUND_COMPLETE, _onIntroSoundComplete);
				}
				_introSoundChannel.stop();
				_introSoundChannel = null;
			}
			
			if (_loopSoundChannel != null)
			{
				_loopSoundChannel.stop();
				_loopSoundChannel = null;
			}
			
			return true;
		}
		
		/**
		 * サウンドを再生済みであるかどうかを判定します.
		 * 
		 * @return 再生済みである場合 <code>true</code>、未再生または <code>stop</code> メソッド実行済みである場合 <code>false</code> が返されます。
		 */
		public function isPlay():Boolean
		{
			return (_introSoundChannel != null);
		}
	}
}
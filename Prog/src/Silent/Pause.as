package Silent
{
	import org.flixel.*;
	import mochi.as3.*;
	//import Silent.RunnerState;
	//import Silent.MainMenu;

	/**
	 * This is the default flixel pause screen.
	 * It can be overridden with your own <code>FlxLayer</code> object.
	 */
	public class Pause extends FlxGroup
	{
		[Embed(source="key_minus.png")] private var ImgKeyMinus:Class;
		[Embed(source="key_plus.png")] private var ImgKeyPlus:Class;
		[Embed(source="key_0.png")] private var ImgKey0:Class;
		[Embed(source = "key_p.png")] private var ImgKeyP:Class;
		[Embed(source = "bgpause2.png")] private var ImgBg:Class;
		
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/en/pauseMenu.png")] private var ImgBgEn:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/pt/pauseMenu.png")] private var ImgBgPt:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/es/pauseMenu.png")] private var ImgBgEs:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/it/pauseMenu.png")] private var ImgBgIt:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/ge/pauseMenu.png")] private var ImgBgGe:Class;
		
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/ge/bgConf.png")] private var ImgBgGeConf:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/pt/bgConf.png")] private var ImgBgPtConf:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/es/bgConf.png")] private var ImgBgEsConf:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/it/bgConf.png")] private var ImgBgItConf:Class;
		[Embed(source = "../../../../../Art/Release/Extras/pauseMenu/en/bgConf.png")] private var ImgBgEnConf:Class;
		
		private const imgArray:Array = [ImgBgEnConf, ImgBgPtConf, ImgBgEsConf, ImgBgItConf, ImgBgGeConf];
		private const languageArray:Array = [ImgBgEn,ImgBgPt,ImgBgEs,ImgBgIt,ImgBgGe];
		
		private var bgPause:FlxSprite;
		
		private var btYes:FlxButton = new FlxButton(0, 0, accept);
		private var btNo:FlxButton = new FlxButton(0, 0, close);
		
		private var asking:Boolean = false;
		private var moching:Boolean = false;
		
		/**
		 * Constructor.
		 */
		public function Pause()
		{
			super();
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
			var w:uint = 192;
			var h:uint = 160;
			
			x = (FlxG.width - w)/2;
			y = (FlxG.height - h) / 2;
			
			trace(FlxG.language);
			bgPause = new FlxSprite(0, 0, languageArray[FlxG.language]);
			add(bgPause, true);
		}
		
		public function createPanel():void {
			
			if (asking) return;
			
			btYes.width = btNo.width = 60;
			btYes.height = btNo.height = 30;
			
			var emptySprite:FlxSprite = new FlxSprite(0, 0);
			emptySprite.createGraphic(60, 30, 0x00ffffff);
			emptySprite.visible = false;
			
			var w:uint = 256;
			var h:uint = 128;
			
			var x:Number = (FlxG.width - w)/2;
			var y:Number = (FlxG.height - h) / 2;
			
			remove(bgPause);
			bgPause = new FlxSprite(x, y, imgArray[FlxG.language]);
			
			btYes.loadGraphic(emptySprite, emptySprite);
			btNo.loadGraphic(emptySprite, emptySprite);
			
			btYes.y = btNo.y = y + 75;
			btYes.x = x + 46;
			btNo.x = x + 140;
			
			add(bgPause, true);
			add(btYes, true);
			add(btNo, true);
			asking = true;
		}
		
		private function accept():void {
			openMochi();
			moching = true;
		}
		
		private function close():void {
			FlxG.pause = false;
		}
		
		public function isAsking():Boolean {
			return asking;
		}
		
		public function isMochi():Boolean {
			return moching;
		}
		
		public function openMochi():void {
			var o:Object = { n: [11, 8, 13, 4, 8, 0, 15, 5, 15, 1, 12, 9, 11, 13, 11, 3], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: RunnerState.scoreGame, onClose:mochiClose,onDisplay:mochiDisplay});
		}
		
		private function mochiClose():void {
			FlxG.pause = false;
			moching = false;
			RunnerState.returnMenu();
		}
		
		private function mochiDisplay():void {
			
		}
		
		public function hideBg(visibleBoolean:Boolean):void {
			bgPause.visible = visibleBoolean;
		}
	}
}
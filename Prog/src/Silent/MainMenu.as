package Silent 
{
	/**
	 * ...
	 * @author ...
	 */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.flixel.*;
	import caurina.transitions.*;
	import mochi.as3.*;
	import flash.ui.Mouse;
	
	public class MainMenu extends FlxState
	{
		[Embed(source = "../../../Audio/Release/twp01fxtitlescreenmouseclickstartgame.mp3")] 	 private var SndStartGame:Class;
		[Embed(source = "../../../Audio/Release/twp01musictitlescreen.mp3")] 	                 private var SndMainMenu:Class;
		
		[Embed(source="../org/flixel/data/beep.mp3")] 											 private var SndBeep:Class;
		
		[Embed(source = "../../../Art/Release/Extras/Flags/english.png")] 	         			 private var FlagEnglish:Class;
		[Embed(source = "../../../Art/Release/Extras/Flags/portuguese.png")] 	         	     private var FlagPortuguese:Class;
		[Embed(source = "../../../Art/Release/Extras/Flags/es.png")] 	         			 	 private var FlagEspanish:Class;
		[Embed(source = "../../../Art/Release/Extras/Flags/it.png")] 	         			 	 private var FlagItalian:Class;
		[Embed(source = "../../../Art/Release/Extras/Flags/de.png")] 	         			 	 private var FlagDeutsch:Class;
		
		[Embed(source = "../../../Art/Release/Extras/Flags/Flag Glow.png")] 	         		 private var FlagGlow:Class;
		
		[Embed(source = "../../../Art/Release/Extras/Main Menu.png")] 	         				 private var ImgMainMenu:Class;
		[Embed(source = "../../../Art/Source/Extras/logo joe.png")] 	             			 private var ImgTextJoe:Class;
		[Embed(source = "../../../Art/Source/Extras/logo silent.png")] 	             		 	 private var ImgTextSilent:Class;
		[Embed(source = "../../../Art/Source/Extras/startgame scores.png")] 	             	 private var ImgBts:Class;
		
		[Embed(source = "../../../Art/Release/Extras/menuBtn/en/scores.png")] 	             	 private var EnScores:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/en/startgame.png")] 	             private var EnStartGame:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/en/endurance.png")] 	             private var EnSurvival:Class;
		
		[Embed(source = "../../../Art/Release/Extras/menuBtn/it/scores.png")] 	             	 private var ItScores:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/it/startgame.png")] 	             private var ItStartGame:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/it/endurance.png")] 	             private var ItSurvival:Class;
		
		[Embed(source = "../../../Art/Release/Extras/menuBtn/pt/scores.png")] 	             	 private var PtScores:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/pt/startgame.png")] 	             private var PtStartGame:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/pt/endurance.png")] 	             private var PtSurvival:Class;
		
		[Embed(source = "../../../Art/Release/Extras/menuBtn/es/scores.png")] 	             	 private var EsScores:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/es/startgame.png")] 	             private var EsStartGame:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/es/endurance.png")] 	             private var EsSurvival:Class;
		
		[Embed(source = "../../../Art/Release/Extras/menuBtn/ge/scores.png")] 	             	 private var GeScores:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/ge/startgame.png")] 	             private var GeStartGame:Class;
		[Embed(source = "../../../Art/Release/Extras/menuBtn/ge/endurance.png")] 	             private var GeSurvival:Class;
		
		
		private var btPlayGame:FlxButton = new FlxButton(500, 286, fadeOut);
		private var btPlaySurvival:FlxButton = new FlxButton(500, 308, fadeOutSurv);
		private var btMochi:FlxButton = new FlxButton(500, 330, showScore);
		
		private var btStart:FlxSprite = new FlxSprite(500, 286, EnStartGame);
		private var btSurvival:FlxSprite = new FlxSprite(500, 308, EnSurvival);
		private var btScore:FlxSprite = new FlxSprite(500, 330, EnScores);
		
		private var bgMain:FlxSprite = new FlxSprite(0, 0, ImgMainMenu);
		private var txtJoe:FlxSprite = new FlxSprite(569, 187, ImgTextJoe);
		private var txtSilent:FlxSprite = new FlxSprite(414, -36, ImgTextSilent);
		private var sprite:FlxSprite = new FlxSprite(0, 0, null);
		
		private const Flags:FlxButton = new FlxButton(8, 3, changeLangague);
		private const flagsArray:Array = [FlagEnglish, FlagPortuguese, FlagEspanish, FlagItalian, FlagDeutsch];
		private const scoresArray:Array = [EnScores, PtScores, EsScores, ItScores, GeScores];
		private const startArray:Array = [EnStartGame, PtStartGame, EsStartGame, ItStartGame, GeStartGame];
		private const survArray:Array = [EnSurvival, PtSurvival, EsSurvival, ItSurvival, GeSurvival];
		
		private var actualFlag:uint = FlxG.language;
		private var flagsSprite:FlxSprite = new FlxSprite(8, 3, flagsArray[0]);
		private const flagGlow:FlxSprite = new FlxSprite(0, 0, FlagGlow);
		
		private var finishedAnim:Boolean = false;
		
		private var fadingOut:Boolean = false;
		private var waitingMochi:Boolean = false;
		
		public function MainMenu() 
		{
			RunnerState.scoreGame = 0;
			MochiServices.connect("ee5e47141702b8b9", FlxG.stage);
		    FlxG.mouse.hide();
			
			btPlayGame.width = 212;
			btPlayGame.height = 19;
			
			Flags.width = 32;
			Flags.height = 32;
			
			btMochi.width = 212;
			btMochi.height = 19;
			
			btPlaySurvival.width = 212;
			btPlaySurvival.height = 19;
			
			add(bgMain);
			
			txtJoe.alpha = 0;
			txtSilent.alpha = 0;
			btStart.alpha = 0;
			btScore.alpha = 0;
			btSurvival.alpha = 0;
			
			add(txtJoe);
			add(txtSilent);
			add(btStart);
			add(btScore);
			add(btSurvival);
			add(flagsSprite);
			
			sprite.createGraphic(32, 32, 0xffffff);
			
			Flags.loadGraphic(sprite, flagGlow);
			add(Flags);
			
			Tweener.addTween(txtJoe, { alpha:1,time:8 } );
			Tweener.addTween(txtJoe, { y:102,time:3,onComplete:finished } );
			Tweener.addTween(txtSilent, { alpha:1,time:8 } );
			Tweener.addTween(txtSilent, { y:24.5, time:3 } );
			Tweener.addTween(btStart, { alpha:1, time:8 } );
			Tweener.addTween(btScore, { alpha:1, time:8 } );
			Tweener.addTween(btSurvival, { alpha:1, time:8 } );
			
			FlxG.stage.addEventListener(MouseEvent.CLICK, mouseDown);
			
			add(btPlayGame);
			add(btPlaySurvival);
			add(btMochi);
			
			sprite.createGraphic(212, 19, 0xffffff);
			
			btPlayGame.loadGraphic(sprite, sprite);
			btPlaySurvival.loadGraphic(sprite, sprite);
			btMochi.loadGraphic(sprite, sprite);
			
			FlxG.playMusic(SndMainMenu, 1);
			FlxG.stage.showDefaultContextMenu = false;
			
			changeLangague(false);
		}
		
		override public function update():void 
		{
			Mouse.show();
			if (FlxG.keys.justPressed("ENTER") && !FlxG.pause && !waitingMochi) {
				fadeOut();
			}
			
			if (btPlayGame.onMouseOver()) {
				if (btStart.blend != "screen") {
					btStart.blend = "screen";
				}
			}else {
				if (btStart.blend != null) {
					btStart.blend = null;
				}
			}
			
			if (btMochi.onMouseOver()) {
				if (btScore.blend != "screen") {
					btScore.blend = "screen";
				}
			}else {
				if (btScore.blend != null) {
					btScore.blend = null;
				}
			}
			
			if (btPlaySurvival.onMouseOver()) {
				if (btSurvival.blend != "screen") {
					btSurvival.blend = "screen";
				}
			}else {
				if (btSurvival.blend != null) {
					btSurvival.blend = null;
				}
			}
			
			super.update();
		}
		
		private function showScore():void {
			FlxG.mouse.show();
			var o:Object = { n: [11, 8, 13, 4, 8, 0, 15, 5, 15, 1, 12, 9, 11, 13, 11, 3], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard( { boardID: boardID, onClose: onClose, onDisplay: onDisplay } );
			btMochi.active = btPlayGame.active = Flags.active = btPlaySurvival.active = false;
			waitingMochi = true;
		}
		
		private function onClose():void {
			btMochi.active = btPlayGame.active = btPlaySurvival.active = Flags.active = true;
			waitingMochi = false;
		}
		
		private function onDisplay():void {
			
		}
		
		private function changeLangague(beep:Boolean = true):void {
			
			if (fadingOut) return;
			if (actualFlag == 5) actualFlag = 0;
			if(beep) FlxG.play(SndBeep, 0.3, false);
			
			flagsSprite.loadGraphic(flagsArray[actualFlag], false);
			
			btStart.loadGraphic(startArray[actualFlag], false, false, startArray[actualFlag].width, startArray[actualFlag].height);
			btScore.loadGraphic(scoresArray[actualFlag], false, false, scoresArray[actualFlag].width, scoresArray[actualFlag].height);
			btSurvival.loadGraphic(survArray[actualFlag], false, false, survArray[actualFlag].width, survArray[actualFlag].height);
			
			btStart.x = 712 - btStart.width;
			btScore.x = 712 - btScore.width;
			btSurvival.x = 712 - btSurvival.width;
			
			btPlayGame.x = btStart.x;
			btPlayGame.y = btStart.y;
			
			btPlayGame.width = btStart.width;
			btPlayGame.height = btStart.height;
			
			btMochi.x = btScore.x;
			btMochi.y = btScore.y;
			
			btMochi.width = btScore.width;
			btMochi.height = btScore.height;
			
			btPlaySurvival.x = btSurvival.x;
			btPlaySurvival.y = btSurvival.y;
			
			btPlaySurvival.width = btPlaySurvival.width;
			btPlaySurvival.height = btPlaySurvival.height;
			
			actualFlag++;
		}
		
		private function fadeOut():void {
			btPlayGame.active = false;
			btMochi.active = false;
			Flags.active = false;
			btPlaySurvival.active = false;
			fadingOut = true;
			FlxG.music.stop();
			FlxG.fade.start(0xff000000, 3, startGame);
			FlxG.play(SndStartGame, 1, false);
			FlxG.mouse.hide();
		}
		
		private function fadeOutSurv():void {
			btPlayGame.active = false;
			btMochi.active = false;
			Flags.active = false;
			btPlaySurvival.active = false;
			fadingOut = true;
			FlxG.music.stop();
			FlxG.fade.start(0xff000000, 3, startSurv);
			FlxG.play(SndStartGame, 1, false);
			FlxG.mouse.hide();
		}
		
		private function finished():void {
			finishedAnim = true;
		}
		
		private function startGame():void {
			FlxG.language = actualFlag - 1;
			FlxG.state = new PlayState();
		}
		
		private function startSurv():void {
			FlxG.language = actualFlag - 1;
			FlxG.state = new EnduState();
		}
		
		private function mouseDown(e:MouseEvent):void {
			if (finishedAnim) return;
			Tweener.removeAllTweens();
			FlxG.flash.stop();
			FlxG.flash.start(0xccffffff, 0.1);
			txtJoe.y = 102;
			txtSilent.y = 24.5;
			txtJoe.alpha = txtSilent.alpha = btStart.alpha = btScore.alpha = btSurvival.alpha = 1;
			finishedAnim = true;
		}
	}

}
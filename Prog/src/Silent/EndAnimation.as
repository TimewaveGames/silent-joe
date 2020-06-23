package Silent
{
	import flash.ui.Mouse;
	import org.flixel.*;
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.utils.setTimeout;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Wolff
	 */
	public class EndAnimation extends FlxState 
	{
		//[Embed(source = "../../../Art/Release/SWFs/end.swf")] 	 			private var SwfEnd:Class;
		[Embed(source = "../../../Art/Release/Extras/Noite Fundo.png")] 	 	private var ImgFundo:Class;
		[Embed(source = "../../../Art/Release/Extras/Noite Lua.png")] 	 		private var ImgLua:Class;
		[Embed(source = "../../../Art/Release/Extras/Noite Plataformas.png")] 	private var ImgPlat:Class;
		[Embed(source = "../../../Art/Release/Extras/Noite Paralax.png")] 	    private var ImgParalax:Class;
		[Embed(source = "../../../Art/Release/SWFs/Joe 120 Correndo.swf")] 		private var SwfJoe:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveStood.png")] 	private var ImgSaveStood:Class;
		[Embed(source = "../../../Audio/Release/twp01musictitlescreen.mp3")] 	private var SndMainMenu:Class;
		private var joe:MovieClip = MovieClip(new SwfJoe());
		private var scoreSend:Number;
		
		public function EndAnimation(score:Number) {
			
			joe.x = -460;
			joe.y = 198;
			addChild(joe);
			
			var fundo:FlxSprite = new FlxSprite(0, 0, ImgFundo);
			add(fundo);
			
			var lua:FlxSprite = new FlxSprite(293, 162, ImgLua);
			add(lua);
			
			var paralax:FlxSprite = new FlxSprite(0, 324, ImgParalax);
			add(paralax);
			
			var plat:FlxSprite = new FlxSprite( -460, 166, ImgPlat);
			//var char:FlxSprite = new FlxSprite( -108, 196, ImgSaveStood);

			add(plat);
			//add(char);
			
			Tweener.addTween(plat, {x:-176,time:7 } );			
			Tweener.addTween(joe, {x:-176,time:7 } );			
			Tweener.addTween(lua, {time:25, y:280, transition:"linear"} );
			setTimeout(fadeOut, 10000);
			FlxG.playMusic(SndMainMenu, 1);
			FlxG.volume = 0;
			Tweener.addTween(FlxG, { volume:1, time:2 } );
			scoreSend = score;
		}
		
		override public function update():void 
		{
			Mouse.show();
			FlxG.mouse.hide();
			super.update();
		}
		
		public function fadeOut():void {
			FlxG.fade.start(0xff000000, 7);
			setTimeout(showMochi,7000);
		}
		
		public function showMochi():void {
			var o:Object = { n: [11, 8, 13, 4, 8, 0, 15, 5, 15, 1, 12, 9, 11, 13, 11, 3], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: scoreSend,onDisplay:onDisplay,onClose:onClose});
		}
		
		public function onDisplay():void {
			
		}
		
		public function onClose():void {
			FlxG.fade.stop();
			FlxG.state = new MainMenu();
		}
	}
	
}
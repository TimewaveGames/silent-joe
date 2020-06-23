package Silent
{
	import flash.events.MouseEvent;
	import org.flixel.FlxState;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import org.flixel.*;
	import Silent.RunnerState;
	
	/**
	 * ...
	 * @author Wolff
	 */
	public class SplashScreen extends FlxState 
	{
		[Embed(source = "../../../Art/Release/Extras/SplashTimeWavePlaceholder.png")] private var Splash:Class;
		[Embed(source = "../../../Art/Source/Extras/Splash Sponsor.png")] private var SplashSpn:Class;
		private var sprite:FlxSprite = new FlxSprite(0, 0, Splash);
		private var event:uint;
		
		public function SplashScreen() {
			event = setTimeout(changeToSpon, 2000);
			add(sprite);
		}
		override public function create():void 
		{
			super.create();
			FlxG.flash.start(0xff000000, 0.5);
		}
		
		override public function update():void 
		{
			if (FlxG.mouse.justPressed()) {
				changeScreen();
			}
			super.update();
		}
		
		private function changeToSpon():void {
			FlxG.fade.start(0xff000000, 1,changeToEnd);
		}
		
		private function changeToEnd():void {
			sprite.loadGraphic(SplashSpn);
			FlxG.fade.stop();
			FlxG.flash.start(0xff000000, 1,end);
		}
		
		private function end():void {
			event = setTimeout(wait, 2000);
		}
		
		private function wait():void {
			FlxG.fade.start(0xff000000, 1, changeScreen);
		}
		
		private function changeScreen():void {
			FlxG.fade.stop();
			FlxG.flash.start(0xff000000, 3);
			clearTimeout(event);
			FlxG.state = new MainMenu();
		}
	}
	
}
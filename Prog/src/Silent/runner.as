package Silent
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import org.flixel.*;
	import org.flixel.data.FlxAnim;

	/**
	 * ...
	 * @author Max Benin
	 */
	
	 //Classe herda dados da classe FlxSprite pois esta possui propriedades interessantes.
	public class runner extends FlxSprite
	{
		[Embed(source = "../../../Art/Release/Animacoes/JoeSpritesheet.png")]               private var ImgRunner:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoejumpstart.mp3")]            private var SndStart:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoedoublejump.mp3")]           private var SndDblJump:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoejumpfall(1-2).mp3")]        private var SndFall1:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoejumpfall(2-2).mp3")]        private var SndFall2:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoespeeddown.mp3")]            private var SndSpeedDown:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoespeedup.mp3")]              private var SndSpeedUp:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoewalljump(1-2).mp3")]        private var SndWall1:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoewalljump(2-2).mp3")]        private var SndWall2:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoehithead.mp3")]              private var SndHitHead:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamemouseclick.mp3")]              private var SndMouseClick:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamerespawn.mp3")]                 private var SndRespawn:Class;
		
		//Estado atual do jogador.
		private var _estadoRunner:uint;
		private var _jumpVelocity:Number;
		private var _walkVelocity:Number;
		private var _timeout:uint;
		private var speedOnDelay:Boolean = false;
		
		public function runner() 
		{
				
			super(0, 955);
			loadGraphic(ImgRunner, true, true, 72, 72);
			
			addAnimation("running", 		[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17], 								 30 , true  );
			addAnimation("jump_ascending", 	[18,19,20,21,22,23,24,25,26],	 					 						 20 , false );
			addAnimation("jump_descending", [27, 28, 29, 30, 31, 32, 33, 34, 35],	 								 	 30 , false );
			addAnimation("dbl_ascending", 	[20,21,22,23,24,25,26],	 					 	 						 	 20 , false );
			addAnimation("dbl_descending", 	[27, 28, 29, 30, 31, 32, 33, 34, 35],	 								 	 30 , false );	
			addAnimation("glide",           [48, 49, 50],                									             20 , false );
			addAnimation("glide_loop",      [50, 51, 52, 53],                									         10 , true  );
			addAnimation("stood",           [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 			 				 30 , false );
			addAnimation("wall_jump",       [54, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 80, 81, 82], 	 20 , false );
			addAnimation("on_wall",         [61], 	 20 , true );
			
			
			
			
			_estadoRunner 		=	RunnerState.RUNNER_RUNNING;	
			_jumpVelocity		= 	400;
			_walkVelocity		= 	400;
			acceleration.x		=	0;
			acceleration.y 		= 	1000;
			maxVelocity.x		= 	_walkVelocity;
			maxVelocity.y 		= 	500;
			drag.x				=   _walkVelocity * 8;
			facing			    = 	RIGHT;
			
			// bounding box
			width    =   40;
			height	=	55;
		}
		
		public function toggleSpeedDelay():void {
			speedOnDelay = !speedOnDelay;
		}
		
		public function getSpeedDelay():Boolean {
			return speedOnDelay;
		}
		
		public function getState():uint {
			return _estadoRunner;
		}
		
		public function setState(estado:uint):void {
			_estadoRunner = estado;
		}
		
		public function getAnim():FlxAnim {
			return _curAnim;
		}

		override public function update() : void 
		{
			acceleration.x = 0;
		
			if (_estadoRunner != RunnerState.RUNNER_ONWALL || _estadoRunner != RunnerState.RUNNER_WALL_JUMPING)
			{
				acceleration.y 		 = 	1000;
			}
			
			if (onFloor)
			{
				_facing = RIGHT;
			}
			
			switch(_estadoRunner)
			{
				
				case RunnerState.RUNNER_RUNNING	:

					play("running");
					acceleration.x 	+=  drag.x;					
					if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE"))
					{
						velocity.y 		= -_jumpVelocity;
						FlxG.play(SndStart, 1, false);
						_estadoRunner 	= RunnerState.RUNNER_JUMPING_ASCENDING;
					}
					
						
					if (onFloor == false)
					{
						_estadoRunner = RunnerState.RUNNER_DBLJUMPING_DESCENDING;
					}
					
				
				break;
				
					
				case RunnerState.RUNNER_JUMPING_ASCENDING :
					
					play("jump_ascending");
					
					switch (_facing) 
					{
						case RIGHT :
							acceleration.x 		+=  drag.x;
						break;
						
						case LEFT  :
							acceleration.x 		-=  drag.x;
						break;
					}
					
					
					
					if (velocity.y > 0 && velocity.y < _jumpVelocity)
					{
						_estadoRunner	= RunnerState.RUNNER_JUMPING_DESCENDING;
					}
					
					if (FlxG.keys.justReleased("X") || FlxG.keys.justReleased("UP") || FlxG.keys.justReleased("W") || FlxG.keys.justReleased("SPACE")) 
					{
						
						velocity.y = -100;
						_estadoRunner	= RunnerState.RUNNER_JUMPING_DESCENDING;
					}
				
					if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE"))
					{
						_estadoRunner = RunnerState.RUNNER_DBLJUMPING_ASCENDING;
						velocity.y 		-=  _jumpVelocity;
					}
					
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_JUMPING_DESCENDING;
					}
				break;
				
				case RunnerState.RUNNER_JUMPING_DESCENDING  :
										
					play("jump_descending");
					
					switch (_facing) 
					{
						case RIGHT :
							acceleration.x 		+=  drag.x;
						break;
						
						case LEFT  :
							acceleration.x 		-=  drag.x;
						break;
					}
															
					if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE"))
					{
						FlxG.play(SndDblJump, 1, false);
						_estadoRunner = RunnerState.RUNNER_DBLJUMPING_ASCENDING;
						velocity.y 		= -_jumpVelocity;
					}
			
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_RUNNING;
					}
					
				break;
				
				case RunnerState.RUNNER_DBLJUMPING_ASCENDING	:
					
					play("dbl_ascending");
					
					switch (_facing) 
					{
						case RIGHT :
							acceleration.x 		+=  drag.x;
						break;
						
						case LEFT  :
							acceleration.x 		-=  drag.x;
						break;
					}
					
					
					if (velocity.y > 0 && velocity.y < _jumpVelocity )
					{
						_estadoRunner	= RunnerState.RUNNER_DBLJUMPING_DESCENDING;
					}
					
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_JUMPING_DESCENDING;
					}
				
				break;
				
				case RunnerState.RUNNER_DBLJUMPING_DESCENDING :
					
					
					play("dbl_descending");
				
					switch (_facing) 
					{
						case RIGHT :
							acceleration.x 		+=  drag.x;
						break;
						
						case LEFT  :
							acceleration.x 		-=  drag.x;
						break;
					}
					
					
					if (FlxG.keys.pressed("UP") || FlxG.keys.pressed("W") || FlxG.keys.pressed("X") || FlxG.keys.pressed("SPACE"))
					{
						_estadoRunner = RunnerState.RUNNER_GLIDING;
						play("glide");
					}
					
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_RUNNING;
					}
				            
				break;
				
				case RunnerState.RUNNER_GLIDING :
					if (finished) {
						play("glide_loop");
					}
					
					switch (_facing) 
					{
						case RIGHT :
							acceleration.x 		+=  drag.x;
						break;
						
						case LEFT  :
							acceleration.x 		-=  drag.x;
						break;
					}
					
					if (FlxG.keys.pressed("X") || FlxG.keys.pressed("W") || FlxG.keys.pressed("UP") || FlxG.keys.pressed("SPACE"))
					{
						acceleration.y 	 = 0;
						velocity.y		 = 100;
					}
					
					if(FlxG.keys.justReleased("X") || FlxG.keys.justReleased("W") || FlxG.keys.justReleased("UP") || FlxG.keys.justReleased("SPACE"))
					{
						acceleration.y 	 = 1000;
						_estadoRunner 	 = RunnerState.RUNNER_DBLJUMPING_DESCENDING;
					}
					
					
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_RUNNING;
					}
					
				break;
				
				case RunnerState.RUNNER_STOOD :
					play("stood");
					if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE"))
					{
						velocity.y 		= -_jumpVelocity;
						_estadoRunner 	= RunnerState.RUNNER_JUMPING_ASCENDING;
					}
				
				break;
				
				case RunnerState.RUNNER_ONWALL :
					
					play("on_wall");
					velocity.y		 = 0;
					acceleration.y   = 0;
				
				if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W") || FlxG.keys.justPressed("SPACE"))
				{
					FlxG.play(SndWall1, 1, false);
					_estadoRunner = RunnerState.RUNNER_WALL_JUMPING;
				}
				
					
				if (onFloor)
				{
					if(Math.round(Math.random()) == 1){
						FlxG.play(SndFall1, 1, false);
					}else {
						FlxG.play(SndFall2, 1, false);
					}
					_estadoRunner = RunnerState.RUNNER_RUNNING;
				}
				
				break;
				
				case RunnerState.RUNNER_WALL_FALLING :

					play("glide");
					acceleration.y 	 = 1000;
					
					if (onFloor)
					{
						if(Math.round(Math.random()) == 1){
							FlxG.play(SndFall1, 1, false);
						}else {
							FlxG.play(SndFall2, 1, false);
						}
						_estadoRunner = RunnerState.RUNNER_RUNNING;
					}
				
				break;
				
				case RunnerState.RUNNER_WALL_JUMPING :
				
					if(_facing == RIGHT){
						velocity.y 		= -_jumpVelocity;
						velocity.x      = -1000;
						_estadoRunner = RunnerState.RUNNER_JUMPING_ASCENDING;
						_facing = LEFT;
						
					}
					else 
					{
						velocity.y 		= -_jumpVelocity;
						velocity.x      = 1000;
						_estadoRunner = RunnerState.RUNNER_JUMPING_ASCENDING;
						_facing = RIGHT;
					}
				
				break;
				
			}
			checkOffset();
			super.update();
 		}
		
	
	
		override public function hitRight(Contact:FlxObject, Velocity:Number) : void
		{
			
			if(!fixed)
			velocity.x = Velocity;
			
			if(FlxG.state is PlayState){
				if (_estadoRunner == RunnerState.RUNNER_JUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_ASCENDING || _estadoRunner == RunnerState.RUNNER_JUMPING_ASCENDING) {
					if (PlayState.getRightTile() >= 96 && PlayState.getRightTile() <= 101 || PlayState.getRightTile() >= 36 && PlayState.getRightTile() <= 38) {
						_estadoRunner = RunnerState.RUNNER_ONWALL;
						_facing = RIGHT;
						clearTimeout(_timeout);
						_timeout = setTimeout(removeWall, 2000);
					}
				}
			}else if (FlxG.state is EnduState) {
				if (_estadoRunner == RunnerState.RUNNER_JUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_ASCENDING || _estadoRunner == RunnerState.RUNNER_JUMPING_ASCENDING) {
					if (EnduState.getRightTile() >= 96 && EnduState.getRightTile() <= 101 || EnduState.getRightTile() >= 36 && EnduState.getRightTile() <= 38) {
						_estadoRunner = RunnerState.RUNNER_ONWALL;
						_facing = RIGHT;
						clearTimeout(_timeout);
						_timeout = setTimeout(removeWall, 2000);
					}
				}
			}

			
			if (_estadoRunner == RunnerState.RUNNER_RUNNING)
			{
				_estadoRunner = RunnerState.RUNNER_STOOD;
				_facing = RIGHT;
			}

		}
		
		
		override public function hitLeft(Contact:FlxObject, Velocity:Number) : void
		{	
			if(!fixed)
			velocity.x = Velocity;
			
			if(FlxG.state is PlayState){
				if (_estadoRunner == RunnerState.RUNNER_JUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_ASCENDING || _estadoRunner == RunnerState.RUNNER_JUMPING_ASCENDING) {
					if (PlayState.getLeftTile() >= 96 && PlayState.getLeftTile() <= 101 || PlayState.getLeftTile() >= 38 && PlayState.getLeftTile() <= 41) {
						_estadoRunner = RunnerState.RUNNER_ONWALL;
						_facing = LEFT;
						clearTimeout(_timeout);
						_timeout = setTimeout(removeWall, 2000);
					}
				}
			}else if (FlxG.state is EnduState) {
				if (_estadoRunner == RunnerState.RUNNER_JUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_DESCENDING || _estadoRunner == RunnerState.RUNNER_DBLJUMPING_ASCENDING || _estadoRunner == RunnerState.RUNNER_JUMPING_ASCENDING) {
					if (EnduState.getLeftTile() >= 96 && EnduState.getLeftTile() <= 101 || EnduState.getLeftTile() >= 38 && EnduState.getLeftTile() <= 41) {
						_estadoRunner = RunnerState.RUNNER_ONWALL;
						_facing = LEFT;
						clearTimeout(_timeout);
						_timeout = setTimeout(removeWall, 2000);
					}
				}
			}
		}
		
		public function getFacing():uint {
			return _facing;
		}
		
		public function setFacing(value:uint):void{
			_facing = value;
		}
		
		private function removeWall():void {
			if (_estadoRunner == RunnerState.RUNNER_ONWALL) {
				_estadoRunner = RunnerState.RUNNER_WALL_FALLING;
			}
		}
		
		public function getFacingTRUE():uint {
			return _facing;
		}
		
		public function checkOffset() :void
		{
			//_curFrame
			switch(_curAnim.name)
			{
				
				case "running" 			:
					
					switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(25, 11);							
						break;
						
						case LEFT  :
							offset = new FlxPoint(25, 11);
						break;
					}
				
				break;
				
				case "jump_ascending"	:
				
					switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(17, 5);
						break;
						
						case LEFT  :
							offset = new FlxPoint(17, 5);
						break;
					}
				
				break;
				
				case "jump_descending"  :
					switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(14, 18);
						break;
						
						case LEFT  :
							offset = new FlxPoint(14,  18);
						break;
					}
				break;
				
				case "dbl_ascending"	:
				switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(17, 5);
						break;
						
						case LEFT  :
							offset = new FlxPoint(17, 5);
						break;
					}
				break;
				
				case "dbl_descending"	:
				switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(14, 18);
						break;
						
						case LEFT  :
							offset = new FlxPoint(14,  18);
						break;
					}
				break;
				
				case "glide"			:
					switch(facing)
						{
							case RIGHT :
								offset = new FlxPoint(25, 14);
							break;
							
							case LEFT  :
								offset = new FlxPoint(15,  14);
							break;
						}
					break;

				break;
				
				case "stood"			:
					
					switch(facing)
						{
							case RIGHT :
								offset = new FlxPoint(33, 11);
							break;
							
							case LEFT  :
								offset = new FlxPoint(33,  11);
							break;
						}
					break;
					
				break;
				
				case "wall_jump"		:
				
					switch(facing)
						{
							case RIGHT :
								offset = new FlxPoint(7, 9);
							break;
							
							case LEFT  :
								offset = new FlxPoint(7,  9);
							break;
						}
					break;
				
				break;
				
				case "on_wall"			:
					
					switch(facing)
					{
						case RIGHT :
							offset = new FlxPoint(17, 3);
						break;
						
						case LEFT  :
							offset = new FlxPoint(17,  3);
						break;
					}
					break;
				
				break;
			}
		}
	}

}
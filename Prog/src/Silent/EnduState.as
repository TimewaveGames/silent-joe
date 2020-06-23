package Silent
{
	/**
	 * ...
	 * @author Max Benin, Gustavo Wolff
	 */
	
	import FGL.GameTracker.*;
	import flash.ui.Mouse;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import mochi.as3.*;
	import org.flixel.*;
	import SWFStats.*;
	import Silent.Assets;
			
	//Esta classe herda a classe FlxState que gerencia estados.
	public class EnduState extends FlxState
	{
		/*[Embed(source = "../../../Art/Source/Tiles/Fundo/Fundo800x450.png")] 		  		private var ImgFundo:Class;
		//[Embed(source = "../../../Art/Release/Extras/Vinheta.png")] 		  		        private var ImgVinheta:Class;
		
		[Embed(source = "../../../Art/Release/Tiles/Paralax 2/Silo1.png")]      	  		private var ImgMedio1:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 2/Silo2.png")]      	  		private var ImgMedio2:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 2/Silo3.png")]      	  		private var ImgMedio3:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 2/Silo4.png")]      	  		private var ImgMedio4:Class;
		
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio1.png")]      	 		private var ImgEntre1:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio2.png")]      	  		private var ImgEntre2:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio3.png")]      	 		private var ImgEntre3:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio4.png")]      	 		private var ImgEntre4:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio5.png")]      	  		private var ImgEntre5:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio6.png")]      	  		private var ImgEntre6:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio7.png")]      	  		private var ImgEntre7:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio8.png")]      	  		private var ImgEntre8:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio9.png")]      	 		private var ImgEntre9:Class;
		[Embed(source = "../../../Art/Release/Tiles/Paralax 1/Predio10.png")]       		private var ImgEntre10:Class;
		
		[Embed(source = "../../../Art/Release/Tiles/checkpoint1.png")] 	  		      	private var ImgCheckPoint:Class;
		[Embed(source = "../../../Art/Release/Tiles/checkpoint2.png")] 	  		      	private var ImgCheckPointOn:Class;
		[Embed(source = "../../../Art/Release/Tiles/savestatepack.png")] 	  		  		private var ImgSavePack:Class;
		[Embed(source = "../../../Art/Release/Tiles/savestatepackhud.png")] 	  	  		private var ImgHudPack:Class;
		[Embed(source = "../../../Art/Release/Tiles/cameraholder.png")] 	  		  		private var ImgCameraHolder:Class;
		
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveRun.png")] 	  		  	private var ImgSaveRun:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveGlide.png")] 	  		  	private var ImgSaveGlide:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveJump.png")] 	  		  	private var ImgSaveJump:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveStood.png")] 	  		  	private var ImgSaveStood:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveWall.png")] 	  		  	private var ImgSaveWall:Class;
		[Embed(source = "../../../Art/Release/Savestates/ImgSaveWallReverse.png")] 	    private var ImgSaveWallReverse:Class;
		
		[Embed(source = "../../../Audio/Release/twp01fxingamerespawn.mp3")]  		  		private var SndRespawn:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamesavestateuse.mp3")] 	  		private var SndSaveUse:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamereachcheckpoint.mp3")]  		private var SndCheckpoint:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamesavestatecollect.mp3")] 		private var SndSaveCollect:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoespeedup.mp3")]       		private var SndSpeedUp:Class;
		[Embed(source = "../../../Audio/Release/twp01fxingamejoespeeddown.mp3")] 	  		private var SndSpeedDown:Class;
		[Embed(source = "../../../Audio/Release/silentgap.mp3")] 	  		                private var SndGap:Class;*/
		
		private static var _runner:runner;
		private static var _mapa:mapa;
		private static var _autoCamera:FlxSprite; //sprite que server como a camera que se move automaticamente
		private static var _charCamera:FlxSprite; //sprite que segue o personagem
		
		private var language:uint = FlxG.language;
		
		private var timerScore:Number = 0;
		private var timerAddTime:Number = 0;
		
		private var _scoreText:FlxText = new FlxText(200, 0, 600, "0"); // texto do score (Canto superior esq)
		private const _vinheta:FlxSprite = new FlxSprite(0, 0); // sprite de efeito de vinheta
		
		private var _cameraHolderLayer:FlxGroup = new FlxGroup(); // layer aonde os camera holders sao colocados para teste de colisao
		private var _checkPointLayer:FlxGroup = new FlxGroup();
		private var _mapLayer:FlxGroup = new FlxGroup();
		private var _creditsLayer:FlxGroup = new FlxGroup();
		
		private const _array:Array = [_cameraHolderLayer, _checkPointLayer, _mapLayer, _creditsLayer];
		
		private var midArray:Array = new Array(); // array que segura todos os FlxSprites de scrolling background
		private const midImgs:Array = [Assets.ImgMedio1, Assets.ImgMedio2, Assets.ImgMedio3, Assets.ImgMedio4]; // array que guarda a referencia das possiveis imagens de fundo
		private const entreImgs:Array = [Assets.ImgEntre1, Assets.ImgEntre2, Assets.ImgEntre2, Assets.ImgEntre3, Assets.ImgEntre4, Assets.ImgEntre5, Assets.ImgEntre6, Assets.ImgEntre7, Assets.ImgEntre8, Assets.ImgEntre9, Assets.ImgEntre10]; // array que guarda a referencia das possiveis imagens de fundo
		
		//array que guarda a posiçao de aonde os textos devem ser criados
		private var posArray:Array;
		private var objetosArray:Array = new Array(); // array que armazena os textos depois de criados para poderem ser deletados
		include "../../../Design/Release/levels/itens.as"; // array importada que diz a posiçao dos camera holders e savestates
		
		// array que guarda a posição dos creditos
		private var creditsArray:Array;
		
		private var checkPoints:Array = new Array(); // array que guarda a posiçao e o score de um checkpoint
		private var flagsArray:Array = new Array(); // array que guarda os savestates do player { x:100, y:100, flagLifes:3, runnerState:state, runnerAcelx:acelx, runnerAcely:}
		private var flagsNumb:uint = 0; // numero de savestates que o player tem
		
		private var waitingCamera:Boolean = false; // boolean que determina se a camera esta esperando um camera holder
		
		private var score:uint = 0; // score atual do jogo
		private var _mapNumber:uint = 0;
		private var gap:Boolean = false;
		public const soundLoop:SoundLoop = new SoundLoop(); // musica que loopa ao fundo do jogo
		
		private const gameTracker:GameTracker = new GameTracker();
		
		//counters
		private var countDeath:uint;
		private var countSave:uint;
		private var countSecsStage:uint;
		private var countSecsTotal:uint;
		
		//Sobrescrevemos a função create() da classe FlxState para criar todos os objetos.
		override public function create() : void 
		{
			FlxG.mouse.hide();
			FlxG.sounds.push(soundLoop);
			
			_mapa   = new mapa(0); // cria o primeiro mapa do jogo
			_runner = new runner(); // coloca o personagem
			
			_autoCamera = new FlxSprite(_runner.x +  200); // determina aonde a autocamera deve começar no jogo
			_charCamera = new FlxSprite(_runner.x, _runner.y); // determina aonde a charcamera deve começar no jogo
			
			_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75; // velocidade inicial da auto camera
			
			//_autoCamera.loadGraphic(ImgHudPack,false);
			
			_autoCamera.visible = _charCamera.visible = false; // torna as cameras nao visiveis para o player
			
			// cria o texto(_scoreText) coloca ele na posiçao correta e determina que ele fique fixo em relaçao a camera
			_scoreText.scrollFactor.x = 0; 
			_scoreText.scrollFactor.y = 0;
			_scoreText.size = 20;
			_scoreText.alignment = "right";
			_scoreText.blend 	 = "overlay";
			
			// cria o texto(_packsText) coloca ele na posiçao correta e determina que ele fique fixo em relaçao a camera
			/*_packsText.scrollFactor.x = 0;
			_packsText.scrollFactor.y = 0;
			_packsText.size = 20;
			_packsText.alignment = "left";
			_packsText.blend = "overlay";
			_packsText.visible = false;*/
			
			// cria a imagem ao lado do _packsText
			/*_hudPack.loadGraphic(ImgHudPack, false, false);
			_hudPack.scrollFactor.x = 0;
			_hudPack.scrollFactor.y = 0;
			_hudPack.visible = false;*/
			
			// cria a vinheta
			/*_vinheta.loadGraphic(ImgVinheta, false, false);
			_vinheta.scrollFactor.x = 0;
			_vinheta.scrollFactor.y = 0;*/
			
			loadLanguage();
			createScroll(); // cria todos os objetos relacionados ao background scroll
			createObjects();// cria todos os objetos coletaveis e checkpoints	
			
			add(_creditsLayer);
			add(_runner);
			add(_mapa);
			add(_checkPointLayer);
			//add(_savePackLayer);
			add(_cameraHolderLayer);
			//add(_saveStateLayer);
			add(_autoCamera);
			add(_charCamera);
			//add(_vinheta);
			//add(_packsText);
			//add(_hudPack);
			add(_scoreText);
		
			FlxG.play(Assets.SndGap, 1, false);
			setTimeout(endGap, 300);
			//setInterval(setScore, 100); // colocar um intervalo para ver quanto deve ser adicionado ao score
			//setInterval(addTime, 1000);
			
			FlxG.follow(_charCamera, 2.5); // começa colocando a visao da camera na autocamera
			
            FlxG.followBounds(0, 0, _mapa.width - 72, _mapa.height - 32); // limita a camera a certa area
			Log.Play();
			Log.CustomMetric("Endurance Started", "Endurance");
			switch (FlxG.language) 
			{
				case 0:
					Log.CustomMetric("EN", "language");
					break;
				case 1:
					Log.CustomMetric("PT", "language");
					break;
				case 2:
					Log.CustomMetric("ES", "language");
					break;
				case 3:
					Log.CustomMetric("IT", "language");
					break;
				case 4:
					Log.CustomMetric("GE", "language");
					break;
				default: Log.CustomMetric("EN", "language");
				
			}
			gameTracker.beginGame();
			super.create();
		}
		
		override public function update() : void 
		{
			
			super.update();
			
			setScoreOnTime();
			addTimeOnTime();
			
			// se Z,Q ou LEFT for clicado salva o player
			/*if (FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("Q") || FlxG.keys.justPressed("LEFT")) {
				save();
			}*/
			
			// load para fim de testes
			/*if (FlxG.keys.justPressed("V")) {
				load();
			}*/
			
			/*if (FlxG.keys.justReleased("N") && _mapNumber > 0) {
				changeStage(false);
				_runner.y = 400;
			}
			
			if (FlxG.keys.justReleased("M") && _mapNumber < 8){
				changeStage(true);
				_runner.y = 400;
			}*/
			
			//if(FlxG.keys.justPressed("B")) FlxG.showBounds = !FlxG.showBounds;
			
			checkDeath(); // faz uma checagem constante para saber se o player caio para fora do mapa
			loadPoints(); // olha se o player atingio algum novo checkpoint
			checkForSpeed(); // checa se o player tocou algum speedboost ou speeddown
			moveCamera(); // move as cameras do jogos
			checkModular(); // olha se outro mapa deve ser carregado
			//showSaves();
			
			_mapa.collide(_runner); // olha se o player colide com o mapa
			//FlxU.overlap(_savePackLayer, _runner, catchSave); // olha se o player colide com algum saveState
			FlxU.overlap(_cameraHolderLayer, _runner, holdCamera); // olha se o player colide com algum camera holder
			
			RunnerState.scoreGame = score;
			_scoreText.text = String(score);
			backMain();
		}
		
		private function setScoreOnTime():void {
			if (timerScore>= 0.1) {
				timerScore = 0;
				setScore();
			}
			timerScore += FlxG.elapsed;
			trace(timerScore);
		}
		
		private function addTimeOnTime():void {
			if (timerAddTime >= 1) {
				timerAddTime = 0;
				addTime();
			}
			timerAddTime += FlxG.elapsed;
		}
		
		private function loadLanguage():void {
			var blendInstru:String = null;
			var alphaInstru:Number = 0.8;
			var blendTexts:String = "subtract";
			posArray = [ { x:900, y:900, text:LanguagePack.PRESS_JUMP[language], stage:0, blend:blendInstru, textSize:35, color:0xffffff,alpha:alphaInstru },
						{ x:4224, y:640 , text:LanguagePack.TWICE_JUMP[language], stage:0, blend:blendInstru, textSize:35, color:0xffffff,alpha:alphaInstru },
						{ x:6400, y:544 , text:LanguagePack.HOLD_GLIDE[language], stage:0, blend:blendInstru, textSize:35, color:0xffffff,alpha:alphaInstru },
						{ x:1472, y:928 , text:LanguagePack.WALL_JUMP[language], stage:3, blend:blendInstru, textSize:35, color:0xffffff,alpha:alphaInstru }];
			
			creditsArray = [ { x:900, y:165, text:LanguagePack.PROGRAMMERS[language], fontSize:20 }, { x:1300, y:120, text:LanguagePack.ART[language], fontSize:20 }, { x:1550, y:165, text:LanguagePack.DESIGN[language], fontSize:20 }, { x:1840, y:120, text:LanguagePack.SPECIAL_THANKS[language], fontSize:20 }, { x:2240, y:165, text:LanguagePack.PRODUCER[language], fontSize:20 } ];
		}
		
		private function addTime():void {
			countSecsStage++;
			countSecsTotal++;
		}
		private function endGap():void {
			gap = true;
		}
		
		private function loadMap(number:uint):void {
			_mapa.kill(); // remove o mapa
			_mapa = new mapa(number); // carrega o novo mapa
			_mapa.collide(_runner); // coloca o teste de colisao
			
            FlxG.followBounds(0, 0, _mapa.width - 72, _mapa.height - 32); // limita a camera a certa area
			
			add(_mapa); // adiciona o mapa
			
			// cria a imagem ao lado do _packsText
			/*_hudPack.kill();
			_hudPack = new FlxSprite(0, 0);
			_hudPack.loadGraphic(ImgHudPack, false, false);
			_hudPack.scrollFactor.x = 0;
			_hudPack.scrollFactor.y = 0;
			_hudPack.visible = false;
			add(_hudPack);
			
			_packsText.kill();
			_packsText = new FlxText(32, 0, 300, "x"+String(flagsNumb));
			_packsText.scrollFactor.x = 0;
			_packsText.scrollFactor.y = 0;
			_packsText.size = 20;
			_packsText.alignment = "left";
			_packsText.blend = "overlay";
			_packsText.visible = false;
			add(_packsText);*/
			
			_scoreText.kill();
			_scoreText = new FlxText(200, 0, 600, String(score));
			_scoreText.scrollFactor.x = 0; 
			_scoreText.scrollFactor.y = 0;
			_scoreText.size = 20;
			_scoreText.alignment = "right";
			_scoreText.blend 	 = "overlay";
			add(_scoreText);
			
			_autoCamera.x = -10; // retorna a camera para o começo
			FlxG.follow(_autoCamera, 2.5); // coloca a visao na auto camera
			_runner.x = 0; // e reseta o x do runner
			_runner.velocity.x = RunnerState.RUNNER_ASPEEDBOOST;
		}
		
		// muda o score do jogo baseado na distancia da tela
		private function setScore():void {
			if (FlxG.pause || waitingCamera || _autoCamera.velocity.x == 0 || _autoCamera.x > _charCamera.x) return; // se o jogo estiver pausado ou estiver em um camera holder pausa o score
			
			//score += Math.round(50 / (1 + Math.ceil(Math.abs(_runner.x - _autoCamera.x)/20)));
			score += 5;
			RunnerState.scoreGame = score;
			_scoreText.text = String(score);
		}
		
		// funçao para remover score
		private function reduceScore(num:int):void {
			if (score - num < 0) {
				num = 0;
			}else {
				score -= num;
			}
			
			if (checkPoints[0].score - num < 0) {
				checkPoints[0].score = 0;
			}else {
				checkPoints[0].score -= num;
			}
			
			RunnerState.scoreGame = score;
			_scoreText.text = String(score);
		}
		
		// funçao para adicionar score
		private function addScore(num:int):void {
			score += num;
			RunnerState.scoreGame = score;
			_scoreText.text = String(score);
		}
		
		// funçao chamada ao se colidir com um saveState
		private function catchSave(Object1:FlxObject, Object2:FlxObject):void {
			if (!(Object1 is runner)) {
				//Log.CustomMetric("Save " + Math.round(Object1.x), "FilmLevel: " + String(_mapNumber));
				Object1.kill();
			}else if (!(Object2 is runner)) {
				//Log.CustomMetric("Save " + Math.round(Object1.x), "FilmLevel: " + String(_mapNumber));
				Object2.kill();
			}
			flagsNumb++;// adiciona um savestate usavel 
			FlxG.play(Assets.SndSaveCollect, 1); // toca o som de pegando savestate
			addScore(700);// da score ao player
			//_packsText.text = "x" + flagsNumb;// autualiza o texto para mostrar quantos savestate o player tem agora
		}
		
		// se a HUD de savestates estiver invisivel essa funçao torna a HUD visivel
		/*private function showSaves():void {
			if (flagsNumb > 0) {
				_packsText.visible = true;
				_hudPack.visible = true;
			}else {
				_packsText.visible = false;
				_hudPack.visible = false;
			}
		}*/
		
		// funçao chamada ao se colidir com um camera holder, faz com que a autocamera pare e espere o player andar
		private function holdCamera(Object1:FlxObject, Object2:FlxObject):void {
			waitingCamera = true;
			_autoCamera.velocity.x = 0;
		}
		
		public function moveCamera():void {
			//se o player passar da autocamera...
			if (waitingCamera && _runner.x + 100 > _autoCamera.x ) {
				waitingCamera = false;
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
				trace("foi");
			}
			
			if (_runner.x + 200 > _autoCamera.x && !waitingCamera) {
				_charCamera.x = _runner.x + 200; // trava a char camera a frente do player
				_charCamera.y = _runner.y + 50;
				_autoCamera.y = _runner.y + 50;
				
				FlxG.followTarget = _charCamera;// e muda a visao da camera para a camera do char
				// se estiver no estado do camera holder espera o player passar da autocamera e libera ela depois disso
			}else {
				_charCamera.y = _runner.y + 50;
				_autoCamera.y = _runner.y + 50;
				FlxG.followTarget = _autoCamera; // se o player nao tiver passado fica focando na autocamera
			}
			
			if (_autoCamera.x < _charCamera.x - 20) {
				_autoCamera.x = _charCamera.x - 20; // se o player tiver passado segura a autocamera proxima a ele para que nao demore para começar a animaçao de perder
			}
			
			// se o player sair do lado esq da tela mata ele
			if (_runner.x < _autoCamera.x - 600 && !FlxG.enduEnd) {
				//reduceScore(150);
				FlxG.enduEnd = true;
				load();
			}
			
			// se a velocidade de queda do player for muito grande compensa um pouco o y da camera para que o player veja o chao
			if(_runner.velocity.y > 650){
				_charCamera.y = _runner.y + _runner.velocity.y / 2; 
			}
			
			if (_autoCamera.x >= _mapa.width - 200) {
				_autoCamera.velocity.x = 0;
			}
		}
		
		//checa constantemente se o player toca em algum tile que afeta a velocidade
		public function checkForSpeed():void {
			// se nao tiver em seu delay e caso toque em um speedup
			if (getBottomTile() >= 30 && getBottomTile() <= 32 && !_runner.getSpeedDelay()) {
				_runner.maxVelocity.x *= 1.25; // aumenta sua velocidade em 25%
				FlxG.followLerp *= 1.25; // aumenta a velocidade da camera em 25% (para que ele ainda consiga ver o que tem afrente)
				_runner.toggleSpeedDelay(); // colocar o player em estado de delay
				setTimeout(_runner.toggleSpeedDelay, 2000); // chama a funçao que vai remover o delay daqui a 0.5 seg
				FlxG.play(Assets.SndSpeedUp, 1); // toca o som de speed up
				//addScore(200); // aumenta o score
				
				// caso ele tenha uma velocidade maior que a do limite ajusta ela
				if (_runner.maxVelocity.x > RunnerState.RUNNER_SPEEDBOOST) _runner.maxVelocity.x = RunnerState.RUNNER_SPEEDBOOST;
				
				// se nao tiver em seu delay e caso toque em um speeddown
			}else if (getBottomTile() >= 33 && getBottomTile() <= 35 && !_runner.getSpeedDelay()) {
				_runner.maxVelocity.x *= 0.75; // diminui a velocidade em 25%
				FlxG.followLerp *= 0.75; // diminui a velocidade da camera em 25% tmb
				_runner.toggleSpeedDelay(); // bota o runner no delay
				setTimeout(_runner.toggleSpeedDelay, 2000); // chama a funçao para remover o delay daqui a 0.5 seg
				FlxG.play(Assets.SndSpeedDown, 1); // toca o som de speed down
				
				// caso ele tenha uma velocidade menor que a do limite ajusta ela
				if (_runner.maxVelocity.x < RunnerState.RUNNER_ASPEEDBOOST) _runner.maxVelocity.x = RunnerState.RUNNER_ASPEEDBOOST;
			}
		}
		
		// olha se o player cai em algum penhasco 
		public function checkDeath():void {
			if (_runner.y > _mapa.height && !FlxG.pause && !FlxG.enduEnd) {
				Log.CustomMetric("X: " + String(Math.round(_runner.x)) + " Y: " + String(Math.round(_runner.y)), " EndDeathLevel: " + String(_mapNumber));
				gameTracker.customMsg("EndDeath", score);
				countDeath++;
				load();
				FlxG.enduEnd = true;
				//reduceScore(150);
			}
		}
		
		// olha se o player passou daquela parte da fase e coloca a nova fase no lugar
		public function checkModular():void {
			if (_runner.x + 37 > _mapa.width && _runner.y < _mapa.height - 200 && _mapNumber == 4) {
				createCredits();
			}
			if (_runner.x + 36 > _mapa.width && _runner.y < _mapa.height - 200  && _mapNumber != 8) {
				Log.LevelAverageMetric("End Average Time", _mapNumber, countSecsStage);
				Log.LevelAverageMetric("End Average Total Time", _mapNumber, countSecsTotal);
				Log.CustomMetric("End Score: " + String(score), "ScoreLevel: " + String(_mapNumber));
				Log.LevelCounterMetric("End Finished", _mapNumber);
				countDeath = countSave = countSecsStage = 0;
				_mapNumber++;
				loadMap(_mapNumber);
				removeObjects();
				createObjects();
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
				waitingCamera = false;
				gameTracker.endLevel(score,"End Level: " + String(_mapNumber));
				gameTracker.beginLevel(score);
			}else if (_runner.x + 36 > _mapa.width && _runner.y < _mapa.height - 200  && _mapNumber == 8) {
				Log.LevelAverageMetric("End Average Time", _mapNumber, countSecsStage);
				Log.LevelAverageMetric("End Average Total Time", _mapNumber, countSecsTotal);
				Log.CustomMetric("End Score: " + String(score), "ScoreLevel: " + String(_mapNumber));
				Log.LevelCounterMetric("End Finished", _mapNumber);
				countDeath = countSave = countSecsStage = 0;
				_mapNumber = 0;
				_charCamera.y = 955;
				loadMap(_mapNumber);
				removeObjects();
				createObjects();
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
				waitingCamera = false;
				_runner.y = 955;
				gameTracker.endLevel(score,"End Level: " + String(_mapNumber));
				gameTracker.beginLevel(score);
			}
		}
		
		public function startEnd():void {
			FlxG.state = new EndAnimation(score);
			FlxG.flash.start(0xff000000, 3);
		}
		
		public function changeStage(next:Boolean):void {
			if (next) {
				_mapNumber++;
				removeObjects();
				createObjects();
				loadMap(_mapNumber);
				waitingCamera = false;
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
			}else {
				_mapNumber--;
				removeObjects();
				createObjects();
				loadMap(_mapNumber);
				waitingCamera = false;
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
			}
		}
		
		public function createCredits():void {
			for (var i:int = 0; i < creditsArray.length; i++) 
			{
				var _newCredit:FlxText = new FlxText(creditsArray[i].x, creditsArray[i].y,500,creditsArray[i].text);
				_newCredit.size = creditsArray[i].fontSize;
				_newCredit.scrollFactor.x = 0.25;
				_newCredit.scrollFactor.y = 0;
				_newCredit.blend = "overlay";
				_creditsLayer.add(_newCredit);
			}
		}
		
		//olha se o player passou por algum checkpoint
		public function loadPoints():void {
			for (var i:int = 0; i < checkPoints.length; ++i) {
				if (_runner.x > checkPoints[i].x && !checkPoints[i].saved) {
					//checkPoints.shift(); // remove o checkpoint que era o primeiro da array
					checkPoints[i].saved = true;
					FlxG.play(Assets.SndCheckpoint, 1); // toca o som
					cleanFlags(); // limpa todos os savestates que o player tinha usado
					checkPoints[i].score = score; // salva o score nessa checkpoint para ser resetado se ele morrer
					checkPoints[i].savePacks = flagsNumb;
					checkPoints[i].img.loadGraphic(Assets.ImgCheckPointOn, false, false);
					_runner.maxVelocity.x = RunnerState.RUNNER_ASPEEDBOOST; // reseta a velocidade se ele tiver alguma
				}
			}
		}
		
		//limpa a imagem de todas os savestates usados e tira eles da array
		public function cleanFlags():void {
		/*	_saveStateLayer.kill();
			_saveStateLayer = new FlxGroup();
			add(_saveStateLayer);
			flagsArray = [];*/
		}
		
		public function removeObjects():void {
			
			cleanFlags();
			
			for (var i:int = 0; i < objetosArray.length; ++i) {
				objetosArray[i].kill();
			}
			
			checkPoints = [];
			objetosArray = [];
			
			_cameraHolderLayer.kill();
			_cameraHolderLayer.reset(0, 0);
			
			//_savePackLayer.kill();
			//_savePackLayer.reset(0, 0);
			
			_checkPointLayer.kill();
			_checkPointLayer.reset(0, 0);
			
			for (i = 0; i < _array.length; ++i) {
				for (var j:int = 0; j < _array[i].members.length; j++) 
				{
					_array[i].remove(_array[i].members[j]);
				}
			}
			
			if(_mapNumber == 6){
				_creditsLayer.kill();
				_creditsLayer.reset(0, 0);
			}
		}
		
		// cria os objetos inicias da fase
		public function createObjects():void {
			// coloca todos os textos daquela fase (exe: X to jump)
			for (var i:int = 0; i < posArray.length; ++i) {
				if (posArray[i].stage != _mapNumber) continue;
				var _newObj:FlxText = new FlxText(posArray[i].x, posArray[i].y, 1400, posArray[i].text);
				_newObj.fixed = true;
				_newObj.size = posArray[i].textSize;
				_newObj.blend = posArray[i].blend;
				_newObj.color = posArray[i].color;
				_newObj.alpha = posArray[i].alpha;
				objetosArray.push(_newObj);
				add(_newObj);
			}
			
			//_savePackLayer = new FlxGroup();
			// olha a array de itens e baseado nela bota os itens diferentes
			for (i = 0; i < stageItens[_mapNumber].length; ++i) {
				switch(stageItens[_mapNumber][i].obj) {
					case 7: // caso seja um checkpoint coloca ele no palco e cria um objeto para se colocar na array dos checkpoints
					    var _newCheckObj:FlxSprite = new FlxSprite(stageItens[_mapNumber][i].x, stageItens[_mapNumber][i].y);
						_newCheckObj.loadGraphic(Assets.ImgCheckPoint, false, false);
						_newCheckObj.fixed = true;
						_checkPointLayer.add(_newCheckObj);
						checkPoints.push( { x:stageItens[_mapNumber][i].x, y:stageItens[_mapNumber][i].y - 10 , score:0 ,savePacks:flagsNumb ,img:_newCheckObj,saved:false } );
						checkPoints[0].score;
					break;
					
					case 2: // caso seja um camera holder coloca ele no palco e no layer aonde e feito os teste de colisao
						 var _newCameraObj:FlxSprite = new FlxSprite(stageItens[_mapNumber][i].x, stageItens[_mapNumber][i].y);
						_newCameraObj.loadGraphic(Assets.ImgCameraHolder, false, false);
						_newCameraObj.fixed = true;
						_newCameraObj.visible = false;
						_cameraHolderLayer.add(_newCameraObj);
					break;
					
					/*case 25: // caso seja um savePack coloca no palco e coloca no layer para fazer testes de colisao
					    var _newSaveObj:FlxSprite = new FlxSprite(stageItens[_mapNumber][i].x, stageItens[_mapNumber][i].y);
						_newSaveObj.loadGraphic(ImgSavePack, false, false);
						_newSaveObj.fixed = true;
						_savePackLayer.add(_newSaveObj);
					break;*/
				}
			}
			
			// coloca os checkpoints pela ordem de sua posiçao X de forma crescente
			/*checkPoints.sortOn("x", Array.NUMERIC);
			add(_savePackLayer);*/

		}

		
		// cria as imagens de fundo como os predios e silos
		public function createScroll():void {
			
			// coloca o fundo fixo do sol
			var _fundo:FlxSprite = new FlxSprite(0,0);
			_fundo.loadGraphic(Assets.ImgFundo,false,false);
			_fundo.scrollFactor.x = 0;
			_fundo.scrollFactor.y = 0;
			add(_fundo);
			
			// cria o primeiro layer de imagems que fica mais ao fundo
			for (var i:int = 0; i < Math.ceil(_mapa.width / 80) + 1; ++i) {
				var _entre:FlxSprite = new FlxSprite((Math.random() * 70 + 70) * i, 296); // colocar eles lado a lado randonizando um pouco a posiçao
				_entre.loadGraphic(entreImgs[Math.floor(Math.random() * midImgs.length)], false, false);
				_entre.scrollFactor.x = 0.02; // coloca um movimento lento para dar ideia de distancia
				_entre.scrollFactor.y = 0;
				midArray.push(_entre); // coloca na array dos objetos de scroll
				add(_entre);
			}
			
			var _lastPos:Number = 0;
			// cria o segundo layer de objetos
			for (i = 0; i < Math.ceil(_mapa.width / 430) + 1; ++i) {
				var _medio:FlxSprite = new FlxSprite((Math.random() * 800) + (500  * i) + _lastPos, 166);
				_medio.loadGraphic(midImgs[Math.floor(Math.random() * midImgs.length)], false, false);
				_medio.scrollFactor.x = 0.1;
				_medio.scrollFactor.y = 0;
				midArray.push(_medio);
				add(_medio);
				_lastPos = _medio.x;
			}
			
		}
		
		// funçoes para ver qual o tipo de tile que o player está tocando
		public static function getBottomTile():uint {
			return _mapa.getTile(Math.round((_mapa.width - (_mapa.width - _runner.x + _runner.width/2 )) / 32), Math.round((_mapa.height - (_mapa.height - (_runner.y + _runner.height + 5))) / 32));
		}
		
		public static function getRightTile():uint {
			return _mapa.getTile(Math.round((_mapa.width - (_mapa.width - _runner.x - _runner.width - 5 )) / 32), Math.round((_mapa.height - (_mapa.height - _runner.y - _runner.height/2 )) / 32));
		}
		
		public static function getLeftTile():uint {
			return _mapa.getTile(Math.round((_mapa.width - (_mapa.width - _runner.x + 45)) / 32), Math.round((_mapa.height - (_mapa.height - _runner.y - _runner.height/2 + 15 )) / 32));
		}
		
		// funçao que salva a posiçao do player
		/*public function save():void {
			if (flagsNumb > 0) {  
				flagsNumb--; // gasta um savestate
				_packsText.text = "x" + flagsNumb; // muda o texto de packs
				_runner.checkOffset(); //checa o offset para ver se está correto antes de salvar o jogo
				var _obj:FlxSprite = createSaveImage(_runner.getAnim().name);
				_obj.facing = _runner.facing;
				_saveStateLayer.add(_obj);
				var _text:FlxText = new FlxText(_runner.x + _runner.width, _runner.y - 20, 50, "3"); // bota o texto que conta quantas vidas aquele savestate tem
				_text.size = 16;
				_saveStateLayer.add(_text);
				// coloca todas as informaçoes na array para ser dado load
				flagsArray.push( { x:_runner.x, y:_runner.y, flagsLife:3, state:_runner.getState(), acelX:_runner.acceleration.x, acelY:_runner.acceleration.y, img:_obj, facing:_runner.getFacing(), offset:_runner.offset, text:_text, vel:_runner.maxVelocity.x, score:score } );
				FlxG.flash.start(0xffffffff, 0.2); // cria um flash na tela
				FlxG.play(SndSaveUse, 1);
				//Log.CustomMetric("X: " + String(Math.round(_runner.x)) + " Y: " + String(Math.round(_runner.y)), " SaveLevel: " + String(_mapNumber));
				Log.LevelCounterMetric("NumberOfSaves", _mapNumber);
				countSave++;
			}
		}*/
		
		/*public function createSaveImage(stateName:String):FlxSprite {
			var _newImg:FlxSprite = new FlxSprite(_runner.x, _runner.y - 5);
			switch(stateName) {
				case "running":
					_newImg.loadGraphic(ImgSaveRun, false, false, 72, 72, false);
				break;
				
				case "jump_ascending":
				case "jump_descending":
				case "dbl_ascending":
				case "dbl_descending":
					_newImg.x -= 13;
					_newImg.loadGraphic(ImgSaveJump, false, _runner.facing!=FlxSprite.RIGHT, 72, 72, false);
				break;
				
				case "glide_loop":
				case "glide":
					_newImg.x -= 16;
					_newImg.loadGraphic(ImgSaveGlide, false, _runner.facing!=FlxSprite.RIGHT, 72, 72, false);
				break;
				
				case "stood":
					_newImg.x -= 32;
					_newImg.y -= 4;
					_newImg.loadGraphic(ImgSaveStood, false, _runner.facing!=FlxSprite.RIGHT, 72, 72, false);
				break;
				
				case "wall_jump":
					_newImg.loadGraphic(ImgSaveJump, false, _runner.facing!=FlxSprite.RIGHT, 72, 72, false);
				break;
				
				case "on_wall":
				if(_runner.facing == FlxSprite.RIGHT){
					_newImg.x -= 3;
					_newImg.loadGraphic(ImgSaveWall, false, false, 72, 72, false);
				}else {
					_newImg.x -= 28;
					_newImg.loadGraphic(ImgSaveWall, false, true, 72, 72, false);
				}
				break;
			}
			_newImg.facing = FlxSprite.LEFT;
			
			return _newImg;
		}*/
		
		//reseta todos os packs da tela se o player deu load em um checkpoint
		/*public function resetPacks():void {
			var numDeaths:Number;
			// se houver algum pack morto...
			if (_savePackLayer.countDead() > 0) {
				numDeaths = _savePackLayer.countDead(); // conta eles
				
				// loopa entre todos os packs mortos e recoloca eles
				for (var i:int = 0; i < _savePackLayer.countDead(); ++i) { 
				_savePackLayer.getFirstDead().reset(_savePackLayer.getFirstDead().x, _savePackLayer.getFirstDead().y);
				}
			}else {
				numDeaths = 0;
			}
		}*/
		
		public static function backMain():void {
			if (RunnerState.mochiEnd) {
				FlxG.state = new MainMenu();
				RunnerState.mochiEnd = false;
			}
		}
		
		// funçao que da load no player
		public function load():void {
			showMochi();
			_runner.kill();
			FlxG.followTarget = null;
			_autoCamera.velocity.x = 0;
			_charCamera.velocity.x = 0;
			_runner.velocity.x = 0;
			// caso nao tenha nenhum savestate (dar load no ultimo checkpoint)
			/*if (flagsArray.length == 0) {
				
				// reseta todas as informaçoes
				_runner.x = checkPoints[0].x;
				_runner.y = checkPoints[0].y;
				_runner.acceleration.x = 0;
				_runner.acceleration.y = 0;
				_runner.setFacing(1);
				_runner.setState(RunnerState.RUNNER_RUNNING);
				_runner.maxVelocity.x = RunnerState.RUNNER_ASPEEDBOOST;
				
				_autoCamera.x = _runner.x;
				_charCamera.x = _runner.x + 100;
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
				waitingCamera = false;
				
				FlxG.follow(_runner, 2.5);
				FlxG.flash.start(0xff000000, 0.2);
				FlxG.play(SndRespawn, 1);
				score = checkPoints[0].score; // carrega o score de quando ele passou pelo checkpoint
				flagsNumb = checkPoints[0].savePacks;
				_packsText.text = "x" + flagsNumb;
				
				resetPacks(); // e reseta os packs a frente dele
				
			}else {
				// caso tenha algum save pack
				// coloca todas as informaçoes daquele savepack
				_runner.x = flagsArray[flagsArray.length - 1].x;
				_runner.y = flagsArray[flagsArray.length - 1].y - 4;
				_runner.acceleration.x = flagsArray[flagsArray.length - 1].acelX;
				_runner.acceleration.y = flagsArray[flagsArray.length - 1].acelY;
				_runner.offset = flagsArray[flagsArray.length - 1].offset;
				_runner.setState(RunnerState.RUNNER_DBLJUMPING_DESCENDING);
				_runner.setFacing(flagsArray[flagsArray.length - 1].facing);
				_runner.maxVelocity.x = flagsArray[flagsArray.length - 1].vel;
				_autoCamera.x = _runner.x;
				_charCamera.x = _runner.x + 100;
				_autoCamera.velocity.x = RunnerState.RUNNER_ASPEEDBOOST * 0.75;
				score = flagsArray[flagsArray.length - 1].score;
				
				flagsArray[flagsArray.length - 1].flagsLife--; // remove uma vida do savepack
				flagsArray[flagsArray.length - 1].text.text = String(flagsArray[flagsArray.length - 1].flagsLife); // muda o texto
				
				waitingCamera = false;
				FlxG.follow(_runner, 2.5); // reseta a camera
				FlxG.flash.start(0xff000000, 0.2); // cria o flash preto indicando morte
				FlxG.play(SndRespawn, 1); // toca o som
				_runner.checkOffset(); // olha se o offset esta correto (evitar bugs)
				
				// caso tenha acabado as vidas do savepack
				if (flagsArray[flagsArray.length - 1].flagsLife == 0) {
					flagsArray[flagsArray.length - 1].img.kill(); //remove a imagem
					flagsArray[flagsArray.length - 1].text.kill(); // remove o texto
					flagswwArray.pop(); // e deleta ele da array
				}
			}*/
		}
		
		public function showMochi():void {
			var o:Object = { n: [0, 3, 8, 10, 13, 1, 9, 2, 2, 2, 11, 12, 11, 2, 1, 11], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard( { boardID: boardID, score:score, onDisplay:onDisplay, onClose:onClose } );
		}
		
		public function onDisplay():void {
			Mouse.show();
		}
		
		public function onClose():void {
			FlxG.fade.stop();
			FlxG.pause = false;
			FlxG.enduEnd = false;
			FlxG.state = new MainMenu();
			RunnerState.scoreGame = 0;
		}
	}
}
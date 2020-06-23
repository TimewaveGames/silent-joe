package  
{
	/**
	 * ...
	 * @author Max Benin
	 */
	
	//Importando os pacotes da flixel
	 import org.flixel.*;
	 import org.flixel.data.FlxPause;
	 import Silent.SplashScreen;
	 
	
	 //Criando o tamanho do arquivo .fla e o background color do mesmo
	 [swf(width = "800", height = "450", backgroundColor = "#000000")]
	 [Frame(factoryClass="Preloader")]
	
	//A classe silenrunner por ser a classe principal do jogo deve herdar a classe FlxGame
	public class silentrunner extends FlxGame
	{
		//Construtor da classe silentrunner
		public function silentrunner() 
		{
			//Super: faz a chamada ao construtor da classe PAI, neste caso FlxGame
			//Cria-se então um palco (área visível) de tamanho 800, 450, o estado que será chamado inicialmente será PlayState 
			//(poderia ser um estado que gerencia menus, lembra muito a regra da finite-state-machine para gerenciar estados de jogo.
			//O último parâmetro é o aspect ratio, neste caso será de 1 pixel de proporção. //penis
			super(800, 450, SplashScreen, 1);
		}
		
	}

}
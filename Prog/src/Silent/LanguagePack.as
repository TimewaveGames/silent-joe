package Silent
{
	/**
	 * ...
	 * @author ...
	 */
	public class LanguagePack
	{
		
		[Embed(source="../org/flixel/data/Thabit.ttf",fontFamily="system",embedAsCFF="false")] public static var fontArabic:String;
		[Embed(source="../org/flixel/data/cinecaption227.ttf",fontFamily="system",embedAsCFF="false")] public static var fontJapanese:String;
		
		//Lingua
		public static const ENGLISH 					   :   uint 	=   0;
		public static const PORT                           :   uint     =   1;
		public static const ESPAN                          :   uint     =   2;
		public static const ITALIAN                        :   uint     =   3;
		public static const DEUTSCH                        :   uint     =   4;
		public static const ARABIC                         :   uint     =   5;
		public static const JAPANESE                       :   uint     =   6;
			
		public static const PRESS_JUMP						:   Array  = ["X to jump","X para pular", "X para saltar", "X per saltare", "X zu springen"];
		public static const TWICE_JUMP						:   Array  = ["twice to doublejump","duas vezes para pulo duplo","dos veces para doble salto","due volte al doppio salto","zweimal um Doppel-Sprung"];
		public static const HOLD_GLIDE						:   Array  = ["hold to glide","segure para planar","mantenga para deslizarse","premuto per planare","halten um gleiten"];
		public static const COLLECT							:   Array  = ["collect the film rolls","colete os rolos de filme","recoge los rollos de película","raccogliere i rotoli di foto","sammeln die Filmrollen"];
		public static const TAKE_PICTURE					:   Array  = ["press Z to quick save", "Z para salvar","Z para guardar","Z per salvare","Z zu speichern"];
		public static const WALL_JUMP					    :   Array  = ["jump onto a ladder to walljump","X para pular da escada","X para saltar de la escalera","X per saltare dalla scaletta","X um direkt von der Leiter"];
		public static const PROGRAMMERS					    :   Array  = ["Programmed by\nGustavo S. Wolff\nMax Benin","Programado por\nGustavo S. Wolff\nMax Benin","Programado por\nGustavo S. Wolff\nMax Benin","Programmato da\nGustavo S. Wolff\nMax Benin","Programmiert von\nGustavo S. Wolff\nMax Benin"];
		public static const ART					            :   Array  = ["Art by\nKOJIIO","Arte por\nKOJIIO","Arte por\nKOJIIO","Grafica di\nKOJIIO","Graphiken von\nKOJIIO"];
		public static const PRODUCER					    :   Array  = ["Produced by\nArthur Allievi","Produzido por\nArthur Allievi","Producido por\nArthur Allievi","Prodotto da\nArthur Allievi","Produziert von\n\nArthur Allievi"];
		public static const DESIGN					        :   Array  = ["Design and\nAudio by\nCaio L.","Design e\nÁudio por\nCaio L.","Diseño y\nAudio por\nCaio Lopez","Design e\nAudio da\nCaio Gobbi","Design und\nAudio von\nCaio L."];
		public static const SPECIAL_THANKS				    :   Array  = ["Special thanks to\nBrizolara\nGevalen\nKleber Seixas", "Agradecimentos para\nBrizolara\nGevalen\nKleber Seixas", "Gracias Especiales a\nBrizolara\nGevalen\nKleber Seixas", "Ringraziamento Speciale a\nBrizolara\nGevalen\nKleber Seixas", "Besonderer Dank\nBrizolara\nGevalen\nKleber Seixas"];
		public static const VOLUME                          :   Array  = ["Volume", "Volume", "Volumen", "Volume", "Lautstärke"];
		
		public static const JOE_WHY_1                         	  :	Array  = ["Joe,\nwhy are you running?","Joe,\npor que você corre?","Joe,\n¿por qué corres?","Joe,\ncorrere perché?","Joe,\nwarum laufen Sie?"];
		public static const JOE_SOMEONE_2                         :	Array  = ["From someone?\nFor something?","De alguém?\nPor algo?","De alguien?\nPara algo?","Da qualcuno?\nPer qualcosa?","Von jemandem?\nFür was?"];
		public static const JOE_BUT_WHAT_3                        :	Array  = ["But, what about your coworkers?","Mas... e os seus colegas de trabalho?","Pero ... y sus compañeros de trabajo?","Ma, che cosa circa i vostri colleghi?","Aber ... und ihre Mitarbeiter?"];
		public static const JOE_AND_WHAT_4                        :	Array  = ["And what will your beloved one think of you?","E o que pensará de você sua amada?","¿Qué pensará ella de ti?","Che cosa pensa lei di te?","Was wird sie von dir denken?"];
		public static const JOE_OH_SORRY_5                        :	Array  = ["Oh.\nI am sorry for that.","Ah.\nMeus pêsames.","Ah.\nLo siento por eso.","Ah.\nMi dispiace per questo.","Oh.\nDafür bin ich leid."];
		public static const JOE_THERE_STILL_7                     :	Array  = ["There is still time to go back...","Ainda há tempo para voltar...","Todavía hay tiempo para volver ...","C'è ancora tempo per tornare ...","Es ist noch Zeit, um zurück zu gehen..."];
		public static const JOE_HAVE_8                            :	Array  = ["Have you considered everything?","Você levou tudo em consideração?","Usted se lo llevaron todo en cuenta?","Avete considerato tutto?","Haben Sie alles bedacht?"];
		public static const JOE_WELL_VICTORY_9                    :	Array  = ["Your decision is disappointing.","Sua decisão é decepcionante.","Su decisión es decepcionante.","La vostra decisione è deludente.","Ihre Entscheidung ist enttäuschend."];
		
		public function LanguagePack(){}
		
	}

}
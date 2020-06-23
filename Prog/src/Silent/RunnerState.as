package Silent
{
	/**
	 * ...
	 * @author Max Benin
	 */
	
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import Silent.MainMenu;
	
	public class RunnerState
	{
		
		// Estados excludentes entre si:
		public static const RUNNER_STOOD					:	uint 	=   0;
		public static const RUNNER_RUNNING					:	uint 	=   1;
		public static const RUNNER_JUMPING_ASCENDING		:	uint 	=  	2;
		public static const RUNNER_JUMPING_DESCENDING		:	uint	=	3;
		public static const RUNNER_DBLJUMPING_ASCENDING		:	uint	=	4;
		public static const RUNNER_DBLJUMPING_DESCENDING	:	uint	=	5;
		public static const RUNNER_GLIDING					:	uint 	=   6;
		public static const RUNNER_ONWALL					:	uint 	=   7;
		public static const RUNNER_WALL_FALLING				:	uint 	=   8;
		public static const RUNNER_WALL_JUMPING				:   uint    =   9;
		
		public static const RUNNER_SPEEDBOOST				:	uint 	=  	640;
		public static const RUNNER_ASPEEDBOOST				:	uint	= 	400;
		
		public static var scoreGame :Number;
		public static var mochiEnd:Boolean = false;
		  
		public function RunnerState() 
		{
		}
		
	}

}
package { 
import org.flixel.FlxPreloader;
//import SWFStats.*;

	public class Preloader extends FlxPreloader { 
		public function Preloader() {
			//Log.View(377, "aac5c3d7-32f2-4e6e-b648-6576af2d43f4", root.loaderInfo.loaderURL);
			//GeoIP.Lookup(checkContry);
			className = "silentrunner";
			super();
		}
		
		/*
		private function checkContry(obj:Object):void {
			//Log.CustomMetric("Country: " + obj.Code + ": " + obj.Name,"Country");
		}*/
	}
}
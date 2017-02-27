package  {
	
	import Config.*;
	
	public class GameLoader 
	{
		private static const CONFIG_FILE:String = "Config_1.0.xml";
		private static var _config:GameConfiguration;
		
		public static function LoadNewGame(loadComplete:Function)
		{
			_config = new GameConfiguration(CONFIG_FILE, loadComplete);
		}

	}
	
}

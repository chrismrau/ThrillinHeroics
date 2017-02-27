package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import Config.*;
	
	public class FireflyGame extends Sprite
	{
		public fuction SelectShip(shipName:String = null):void
		{
			//if(shipName == null)
				//shipName = State.Fleet.PlayerShips[0].Name;
			//GameEngine.State.Fleet.SetCurrent(shipName);
		}
		
		private const CONFIG_FILE:String = "Config_1.0.xml";
		private var _config:GameConfiguration;
		public function FireflyGame(board:Sprite, loadComplete:Function)
		{
			_config = new GameConfiguration(CONFIG_FILE, _state.ConfigureGameState);
		}
	
	}
}
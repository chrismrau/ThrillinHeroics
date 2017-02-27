package
{
	import flash.display.DisplayObject;
	import flash.net.LocalConnection;
	
	import Config.GameConfiguration;
	
	import State.GameState;
	
	public class LocalClient extends LocalConnection implements IConnection
	{
		private var _state:GameState;
		public function GetState():GameState
		{
			return _state;
		}
		
		private var SERVER_PRE:String = "app#Application.GameLibrary.Firefly";
		private var CLIENT_CONN:String = SERVER_PRE + ":FireflyClient";	
		public function MouseClickSector(object:DisplayObject):void
		{
			_clientConn.send(CLIENT_CONN, "MouseClickSector", object.name);
		}
		
		private var _clientConn:LocalConnection;
		
		public function UpdateState(state:GameState):void
		{
			_state = state;
		}
		
		private var SERVER_CONN:String = "FireflyServer";
		public function LocalClient(config:GameConfiguration)
		{
			allowDomain("*");
			allowInsecureDomain("*");
			
			_state = new GameState(config);
			GameState.RegisterAliases();
			
			connect(SERVER_CONN);
			_clientConn = new LocalConnection();			
		}
		
	}
}
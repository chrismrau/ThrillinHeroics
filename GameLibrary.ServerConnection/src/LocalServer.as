package
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import mx.utils.UIDUtil;

	import State.GameState;
	import State.Player;
	
	public class LocalServer extends LocalConnection implements IServer
	{
		private var _status:String = "Idle";
		public function get Status():String { return _status; }
		
		public function MouseClickSector(value:String):void
		{
			dispatchEvent(new MouseClickEvent(ParentClickTypes.MAP, value));
		}
		
		private var _serverName:String;
		private var _serverConn:LocalConnection;
		private var _maxClients:int;
		
		private var _players:Vector.<Player>;
		public function get Players():Vector.<Player> { return _players; }
		
		public function get PlayerCount():int {	return Players.length; }
		
		public function UpdateState(state:GameState):void
		{
			try
			{
				_serverConn.send("localhost:" + _serverName, "UpdateState", state);
			}
			catch(error:StatusEvent)
			{
				trace("Connection refused.");
				trace(error.toString());
			}
		}
		
		private function StatusEventHandler(evt:StatusEvent):void
		{
			switch(evt.level)
			{
				case "status":
					break;
				case "error":
					break;					
			}
		}
		
		
		public function StopListening():void 
		{
			_players = new Vector.<Player>();
			
			var player1:Player = new Player();
			player1.UID = UIDUtil.createUID();
			player1.Name = "Chris";
			Players.push(player1);
			
			var player2:Player = new Player();
			player2.UID = UIDUtil.createUID();
			player2.Name = "Dan";
			Players.push(player2);
		}
		
		private var _clientName:String;
		public function StartListening():void
		{
			try
			{
				allowDomain("*");
				connect(_clientName);
				_status = "Started";
			}
			catch(error:ArgumentError)
			{
				trace("Error connecting Server!");
			}
			
			GameState.RegisterAliases();
			GameSetupState.RegisterAliases();
			
			trace("Server Started!");
		}
		
		private var _connectionName:String;
		public function LocalServer(name:String, maxClients:int)
		{
			_connectionName = name;
			_maxClients = maxClients;
			
			_clientName = _connectionName + "Client";
			_serverName = _connectionName + "Server";
			
			_serverConn = new LocalConnection();
			_serverConn.addEventListener(StatusEvent.STATUS, StatusEventHandler);
		}
		
	}
}
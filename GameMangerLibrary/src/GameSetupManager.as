package
{
	import flash.events.EventDispatcher;
	
	import mx.utils.StringUtil;
	
	import Config.FireflyShipConfig;
	import Config.GameConfiguration;
	import Config.SourceTypes;
	
	import Map.Sector;
	
	import SetupActions.ChooseLeaderAction;
	import SetupActions.ChooseShipAction;
	import SetupActions.PlaceShipAction;
	import SetupActions.SetupAction;
	
	import Ships.FireflyShip;
	
	import Supplies.CrewSupply;
	import State.GameState;
	import State.Player;
	
	public class GameSetupManager extends EventDispatcher
	{
		private var _server:IServer;
		public const SetupState:GameSetupState = new GameSetupState();
		public var _gameState:GameState;
		public var _configuration:GameConfiguration;
		
		[Bindable]
		public var IsNotStarted:Boolean = true;
		[Bindable]
		public var CanPlay:Boolean = true;
		
		[Bindable]
		public function get IsBreakinAtmo():Boolean
		{
			return _configuration.UseBreakinAtmo;
		}
		public function set IsBreakinAtmo(value:Boolean):void
		{
			_configuration.UseBreakinAtmo = value;
		}
		
		[Bindable]
		public function get IsPirates():Boolean
		{
			return _configuration.UsePiratesAndBountyHunters;
		}
		public function set IsPirates(value:Boolean):void
		{
			_configuration.UsePiratesAndBountyHunters = value;
		}
		
		[Bindable]
		public function get IsBlueSun():Boolean
		{
			return _configuration.UseBlueSun;
		}
		public function set IsBlueSun(value:Boolean):void
		{
			_configuration.UseBlueSun = value;
		}
		
		private var _currentAction:SetupAction;
		public function get CurrentActor():Player
		{
			return _currentAction.Actor;
		}
		
		[Bindable]
		public var Configuration:String = "Idle";
		private function UpdateStateString():void
		{
			var result:String = "";
			if(_currentAction != null)
			{
				result += CurrentActor.Name + '\n';
			}
			
			Configuration = StringUtil.trim(result);
		}
		
		public function ShipFromName(name:String):FireflyShip
		{
			var result:FireflyShip;
			for each(var ship:FireflyShip in SetupState.Fleet)
			{
				if(ship.Name == name)
					result = ship;
			}
			
			return result;
		}
			
		public function PlaceShip(ship:FireflyShip, sector:Map.Sector):Boolean
		{
			var action:PlaceShipAction = _currentAction as PlaceShipAction;
			if(null == action || action.Actor.Boat != ship)
				return false;
			
			action.PlaceShip(sector);
			return true;
		}
		
		public function SelectLeader(player:Player, leader:CrewSupply):Boolean
		{
			var action:ChooseLeaderAction = _currentAction as ChooseLeaderAction;
			if(null == action || action.Actor != player) 
				return false;
			
			action.SelectLeader(leader);
			UpdateStateString();
			
			return true;
		}
			
		public function SelectShip(player:Player, ship:FireflyShip):Boolean
		{
			var action:ChooseShipAction = _currentAction as ChooseShipAction;
			if(null == action || action.Actor != player) 
				return false;
			
			action.SelectShip(ship);
			UpdateStateString();
			
			return true;
		}
		
		private static function Shuffle(list:Vector.<Player>):Vector.<Player>
		{
			var result:Vector.<Player>;
			result = new Vector.<Player>();
			for each(var p:Player in list)
				result.push(p);
				
			for(var i:int = result.length - 1; i > 0; i--)
			{
				var pos:int = Math.random() * i;
				var player:Player = result[pos];
				result[pos] = result[i];
				result[i] = player;
			}
			return result;
		}			
		
		private function SetupAvailableShips():void
		{
			for each(var config:FireflyShipConfig in _configuration.Fleet)
			{
				if((SourceTypes.BASE_GAME == config.Source) ||
				   (SourceTypes.PIRATES == config.Source && _configuration.UsePiratesAndBountyHunters) ||
				   (SourceTypes.ARTFUL_DODGER == config.Source && _configuration.UseArtfulDodger))
				{
					SetupState.Fleet.push(new FireflyShip(config));
				}
			}
		}
		
		public function StartServer(name:String):void
		{
			SetupState.SetupStage = SetupStageTypes.WAITING;
			SetupAvailableShips();
			
			_server = new LocalServer(name, SetupState.Fleet.length);
			_server.StartListening();
			
			IsNotStarted = false;
			Configuration = "Server Started...";
		}
		
		private function ConfigureGameState(config:GameConfiguration):void
		{
			_gameState = new GameState(config);
		}
		private const CONFIG_FILE:String = "Config_1.0.xml";
		public function GameSetupManager()
		{
			super();
			_configuration = new GameConfiguration(CONFIG_FILE, ConfigureGameState);
		}
		
	}
}
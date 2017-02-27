package 
{	
	import Actions.FreeFlyAction;
	
	import Cards.DiscardDecks;
	
	import Config.GameConfiguration;
	
	import Ships.BaseShip;
	import Ships.FireflyShip;
	import Ships.ShipCollection;
	
	import State.GameState;
	import State.Player;

	public class FreeFlightEngine extends FlightEngineBase implements IGameEngine
	{		
		public function get FullBurnLimit():int { return 0; }
		
		public function get Fleet():ShipCollection { return CurrentState.Fleet; }
		
		public function get CurrentPlayer():State.Player { return CurrentState.CurrentPlayer; }
		
		public function TokenCount(name:String):int
		{
			return CurrentState.MapSectors[name].TokenCount;
		}
		
		public function RollDie():void
		{
			CurrentAction = CurrentAction.RollDie(CurrentPlayer);
		}
			
		public function ClearCurrentTokens():void
		{
			CurrentState.CurrentPlayer.Boat.Location.ClearTokens();
		}
		
		public function get CurrentShip():BaseShip { return Fleet.Current; }
		public function SelectShip(name:String):BaseShip
		{
			var ship:BaseShip = Fleet.Name2Ship[name];
			if(ship == null) return CurrentShip;
			CurrentAction = CurrentAction.SelectShip(ship);
			
			return ship;
		}
		
		public function get Discards():DiscardDecks { return null; }

		public function NavAllianceNext():void { }
		public function ShuffleAlliance():void { } 
		public function get NavAllianceDrawCount():int { return 0; }

		public function NavBorderNext():void { }
		public function ShuffleBorder():void { }
		public function get NavBorderDrawCount():int { return 0; }

		public function NavRimNext():void { }
		public function ShuffleRim():void { }
		public function get NavRimDrawCount():int { return 0; }

		public function SilverholdNext():void	{ }
		public function get SilverholdDrawCount():int { return 0; }

		public function MeridianNext():void	{ }
		public function get MeridianDrawCount():int { return 0; }

		public function SpaceBazaarNext():void { }
		public function get SpaceBazaarDrawCount():int { return 0; }

		public function PersephoneNext():void { }
		public function get PersephoneDrawCount():int { return 0; }

		public function ReginaNext():void { }
		public function get ReginaDrawCount():int { return 0; }

		public function OsirisNext():void { }
		public function get OsirisDrawCount():int { return 0; }

		public function get NextMessage():String { return "Free Flight"; }
		public function get Header():String { return "Free Flight"; }
		public function get Status():String { return ""; }
		
		public function FreeFlightEngine(config:GameConfiguration, statMgr:StatusManager)
		{
			super(statMgr);
			
			CurrentState = new GameState(config);
			
			var ship:FireflyShip = CurrentState.Fleet.PlayerShips[0];
			CurrentAction = new FreeFlyAction(CurrentState, ship);
		}
		
	}
}
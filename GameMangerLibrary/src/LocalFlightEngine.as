package 
{	
	import Actions.FlyAction;
	import Actions.PlaceShipAction;
	
	import CardDecks.Decks;
	
	import Cards.DiscardDecks;
	
	import Config.GameConfiguration;
	
	import Ships.BaseShip;
	import Ships.ShipCollection;
	
	import State.GameState;
	import State.Player;

	public class LocalFlightEngine extends FlightEngineBase implements IGameEngine
	{		
		private var _cardDecks:Decks;
		
		public function get FullBurnLimit():int
		{
			var action:FlyAction = CurrentAction as FlyAction;
			if(action == null) return 0;
			
			return action.MoveCount;
		}
		
		public function get Fleet():ShipCollection { return CurrentState.Fleet; }
		
		public function get CurrentPlayer():Player { return CurrentState.CurrentPlayer; }
		

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
		
		public function get Discards():DiscardDecks
		{
			return CurrentState.Discards;
		}

		public function NavAllianceNext():void
		{
			_cardDecks.Nav.Alliance.Next();
		}
		public function get NavAllianceDrawCount():int
		{
			return _cardDecks.Nav.Alliance.Draw.length;
		}
		public function ShuffleAlliance():void
		{
			_cardDecks.Nav.Alliance.Shuffle();
		}

		public function ShuffleBorder():void
		{
			_cardDecks.Nav.Border.Shuffle();
		}
		public function NavBorderNext():void
		{
			_cardDecks.Nav.Border.Next();
		}
		public function get NavBorderDrawCount():int
		{
			return _cardDecks.Nav.Border.Draw.length;
		}

		public function ShuffleRim():void
		{
			_cardDecks.Nav.Rim.Shuffle();
		}
		public function NavRimNext():void
		{
			_cardDecks.Nav.Rim.Next();
		}
		public function get NavRimDrawCount():int
		{
			return _cardDecks.Nav.Rim.Draw.length;
		}

		public function get SilverholdDrawCount():int
		{
			return _cardDecks.Supplies.Silverhold.Draw.length;
		}
		public function SilverholdNext():void	
		{
			_cardDecks.Supplies.Silverhold.Next();
		}

		public function get MeridianDrawCount():int
		{
			return _cardDecks.Supplies.Meridian.Draw.length;
		}
		public function MeridianNext():void	
		{
			_cardDecks.Supplies.Meridian.Next();
		}

		public function SpaceBazaarNext():void
		{
			_cardDecks.Supplies.SpaceBazaar.Next();
		}
		public function get SpaceBazaarDrawCount():int
		{
			return _cardDecks.Supplies.SpaceBazaar.Draw.length;
		}

		public function PersephoneNext():void
		{
			_cardDecks.Supplies.Persephone.Next();
		}
		public function get PersephoneDrawCount():int
		{
			return _cardDecks.Supplies.Persephone.Draw.length;
		}

		public function ReginaNext():void
		{
			_cardDecks.Supplies.Regina.Next();
		}
		public function get ReginaDrawCount():int
		{
			return _cardDecks.Supplies.Regina.Draw.length;
		}

		public function OsirisNext():void
		{
			_cardDecks.Supplies.Osiris.Next();
		}
		public function get OsirisDrawCount():int
		{
			return _cardDecks.Supplies.Osiris.Draw.length;
		}

		public function LocalFlightEngine(config:GameConfiguration, statMgr:StatusManager)
		{
			super(statMgr);
			
			CurrentState = new GameState(config);

			_cardDecks = new Decks(config, CurrentState);
			
			CurrentAction = new PlaceShipAction(CurrentState, CurrentState.LastPlayer);
		}
		
	}
}
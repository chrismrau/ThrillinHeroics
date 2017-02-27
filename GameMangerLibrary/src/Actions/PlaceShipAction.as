package Actions
{
	import Map.Sector;
	import Ships.FireflyShip;
	import State.GameState;
	
	public class PlaceShipAction extends FlyAction
	{
		public override function Location(dest:Sector):BaseAction
		{
			if(dest.Vessels.length > 0) return this;

			CurrentState.MoveShipTo(Ship, dest);
			
			var index:Number = CurrentState.Fleet.PlayerShips.indexOf(Ship);
			if(0 == index)
				return new TurnAction(CurrentState, CurrentState.CurrentPlayer);
			else
				return new PlaceShipAction(CurrentState, CurrentState.Fleet.PlayerShips[index-1]);
		}

		public override function get Description():String 
		{ 
			var pn:Number = CurrentState.Fleet.PlayerShips.indexOf(Ship) + 1;
			return "Player " + pn.toString() + " - Place " + Ship.Name;
		}

		public function PlaceShipAction(state:GameState, boat:FireflyShip)
		{
			super(state, boat);
			
			_moveCount = -1;
			CurrentState.Fleet.Current = boat;
		}

	}
}
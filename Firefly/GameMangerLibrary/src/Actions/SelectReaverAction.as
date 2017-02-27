package Actions
{
	import Map.Sector;
	
	import Ships.BaseShip;
	import Ships.ReaverShip;
	import State.GameState;
	
	public class SelectReaverAction extends BaseAction
	{		
		private var _dest:Sector;
		public override function SelectShip(ship:BaseShip):BaseAction
		{
			if(ship is ReaverShip)
			{
				CurrentState.MoveShipTo(ship, _dest);
				
				for each(var reaver:ReaverShip in CurrentState.Fleet.ReaverShips)
				reaver.ShowHighlight = false;
				
				return null;
			}
			return this;
		}
		
		public function SelectReaverAction(state:GameState, dest:Sector)
		{
			super(state);
			_dest = dest;
			
			for each(var ship:ReaverShip in CurrentState.Fleet.ReaverShips)
			ship.ShowHighlight = true;
		}
	}
}
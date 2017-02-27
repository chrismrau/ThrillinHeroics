package Actions
{
	import Ships.*;
	import State.GameState;
	
	public class FreeFlyAction extends FlyAction
	{
		public override function SelectShip(ship:BaseShip):BaseAction
		{
			if(Child == null)
			{
				CurrentState.Fleet.Current = ship;
				if(ship is FireflyShip)
				{
					var boat:FireflyShip = ship as FireflyShip;
					return new FreeFlyAction(CurrentState, boat);
				}
				else if (ship is AllianceCruiserShip)
				{
					return new FreeFlyAction(CurrentState, ship as AllianceCruiserShip);
				}
				else if (ship is ReaverShip)
				{
					return new MoveReaverAction(CurrentState, ship as ReaverShip);
				}
			}
			
			return super.SelectShip(ship);
		}
		
		public function FreeFlyAction(state:GameState, ship:BaseShip)
		{
			super(state, ship);
		}
		
	}
}
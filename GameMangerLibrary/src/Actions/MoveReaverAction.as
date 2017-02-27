package Actions
{	
	import Ships.*;
	import State.GameState;
	
	public class MoveReaverAction extends FlyAction
	{
		private var _reaver:ReaverShip = null;
		
		public function MoveReaverAction(state:GameState, ship:ReaverShip)
		{
			super(state, ship);
			_reaver = ship;
		}
	}
}
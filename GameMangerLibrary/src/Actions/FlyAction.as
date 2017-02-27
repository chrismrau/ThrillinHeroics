package Actions
{
	import Map.Sector;
	import Ships.BaseShip;
	import State.GameState;
	
	public class FlyAction extends BaseAction
	{
		private var _ship:BaseShip = null;
		protected function get Ship():BaseShip { return _ship; }
		
		protected var _moveCount:int = 1;
		public function get MoveCount():int { return _moveCount; }
		
		public override function Location(dest:Sector):BaseAction
		{
			if(Child == null)
			{
				if(!_ship.CanEnter(dest)) return this;
				
				_moveCount--;
				CurrentState.MoveShipTo(_ship, dest);
			}
			
			return super.Location(dest);
		}
		
		public function FlyAction(state:GameState, ship:BaseShip)
		{
			super(state);
			_ship = ship;
		}
		
	}
}
package Actions
{
	import Map.Sector;
	import Ships.FireflyShip;
	import State.GameState;
	
	public class FullBurnAction extends FlyAction
	{
		private var _boat:FireflyShip = null;
		
		public override function Location(dest:Sector):BaseAction
		{
			if(MoveCount <= 0) return this;
			if(!dest.IsAdjacentTo(_boat.Location)) return this;
			
			var result:BaseAction = super.Location(dest);
			
			if(Child == null && _boat.Location != null && _boat.Location.TokenCount > 0)
				Child = new RollForTokens(CurrentState);
		 	
			return result;
		}
		
		public function FullBurnAction(state:GameState, boat:FireflyShip)
		{
			super(state, boat);
			_boat = boat;
			_moveCount = _boat.FullBurnRange;
		}
	}
}
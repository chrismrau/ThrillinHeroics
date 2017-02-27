package Actions
{
	import Map.Sector;
	import Ships.BaseShip;
	import State.GameState;
	import State.Player;
	
	public class BaseAction
	{
		protected var Child:BaseAction = null;
		
		public virtual function SelectShip(ship:BaseShip):BaseAction
		{			
			if(Child != null) Child = Child.SelectShip(ship);
			return this;
		}
			
		public virtual function RollDie(player:Player, useHeroics:Boolean = true):BaseAction
		{
			if(Child != null) Child = Child.RollDie(player, useHeroics);
			return this;
		}
		
		public virtual function Location(value:Sector):BaseAction
		{
			if(Child != null) Child = Child.Location(value);
			return this;
		}
		
		public virtual function get Description():String 
		{
			if(null == Child) return null;
			return Child.Description;
		}


		protected var CurrentState:GameState;

		public function BaseAction(state:GameState)
		{
			CurrentState = state;
		}
		
	}
}
package Actions
{
	import State.GameState;
	import State.Player;
	
	public class RollForTokens extends DieRoll
	{
		public override function RollDie(player:Player, useHeroics:Boolean = true):BaseAction
		{
			super.RollDie(player, useHeroics);
			if(player.TotalDieRoll > player.Boat.Location.TokenCount)
			{
				player.Boat.Location.ClearTokens();
				return null;
			}
			else if(player.LastDieRoll == 6 && useHeroics)
			{
				return this;
			}
			
			return new SelectReaverAction(CurrentState, player.Boat.Location);
		}
		
		public function RollForTokens(state:GameState)
		{
			super(state);
		}
		
	}
}
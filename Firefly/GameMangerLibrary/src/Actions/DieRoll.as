package Actions
{
	import State.GameState;
	import State.Player;
	
	public class DieRoll extends BaseAction
	{
		public override function RollDie(player:Player, useHeroics:Boolean = true):BaseAction
		{
			player.LastDieRoll = (Math.random() * 6) + 1;
			player.TotalDieRoll += player.LastDieRoll;
			
			return null;
		}
		
		public function DieRoll(state:GameState)
		{
			super(state);
			CurrentState.CurrentPlayer.LastDieRoll = 0;
			CurrentState.CurrentPlayer.TotalDieRoll = 0;
		}
		
	}
}
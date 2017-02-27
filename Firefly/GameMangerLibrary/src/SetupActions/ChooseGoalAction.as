package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;

	public class ChooseGoalAction extends SetupAction
	{
		public static function RegisterAliases():void
		{
			registerClassAlias("ChooseGoalActionAlias", ChooseGoalAction);
		}
		
		public override function get IsComplete():Boolean
		{
			return true;
		}
		
		private var _players:Vector.<Player>;
		public override function get Next():SetupAction
		{
			return new PickStartingJobsAction(_players);
		}
		
		public function ChooseGoalAction(players:Vector.<Player>)
		{
			super(players[0]);
			_players = players;
		}
	}
}
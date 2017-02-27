package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;

	public class PickStartingJobsAction extends SetupStepAction
	{
		public static function RegisterAliases():void
		{
			registerClassAlias("PickStartingJobsActionAlias", PickStartingJobsAction);
		}
		
		override public function get IsComplete():Boolean
		{
			return true;
		}
		
		public override function get Next():SetupAction
		{
			return new StartGameAction(Players);
		}
		
		public function PickStartingJobsAction(players:Vector.<Player>, index:int = 0)
		{
			super(players, index);
		}
	}
}
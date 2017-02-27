package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;

	public class StartGameAction extends SetupStepAction
	{		
		public static function RegisterAliases():void
		{
			registerClassAlias("StartGameActionAlias", StartGameAction);
		}
		
		override public function get IsComplete():Boolean { return true; }
		
		public override function get Next():SetupAction
		{
			return null;
		}
		
		public function StartGameAction(players:Vector.<Player>)
		{
			super(players, 0);
		}
	}
}
package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;

	public class SetupStepAction extends SetupAction
	{
		protected var Players:Vector.<Player>;
		protected var Index:int = 0;
		
		public static function RegisterAliases():void
		{
			Player.RegisterAliases();
			registerClassAlias("PlayersVectorAlias", Vector.<Player> as Class);
			
			registerClassAlias("SetupStepActionAlias", SetupStepAction);
		}
		
		public function SetupStepAction(players:Vector.<Player>, index:int)
		{
			super(players[index]);
			
			Players = players;
			Index = index;
		}
	}
}
package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;

	public class SetupAction
	{
		public virtual function get Next():SetupAction { return null; }
		
		private var _actor:Player;
		public function get Actor():Player { return _actor; }
		public function set Actor(actor:Player):void
		{
			_actor = actor;
		}

		public static function RegisterAliases():void
		{
			Player.RegisterAliases();
			
			registerClassAlias("SetupActionAlias", SetupAction);
		}
		
		public virtual function get IsComplete():Boolean
		{
			return false;
		}
		
		public function SetupAction(actor:Player)
		{
			Actor = actor;
		}
	}
}
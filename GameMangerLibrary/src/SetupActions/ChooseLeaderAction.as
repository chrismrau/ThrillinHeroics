package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;
	import Supplies.CrewSupply;

	public class ChooseLeaderAction extends SetupStepAction
	{		
		public static function RegisterAliases():void
		{			
			registerClassAlias("ChooseShipActionAlias", ChooseShipAction);
		}
		
		override public function get IsComplete():Boolean
		{
			return Actor.Boat.Leader != null;
		}

		public function SelectLeader(leader:CrewSupply):void
		{
			Actor.Boat.Leader = leader;
		}
		
		private var _next:ChooseShipAction;
		public override function get Next():SetupAction
		{
			if(Players.length <= Index) 
				return new PlaceShipAction(Players);
			
			if(null == _next)
			    _next = new ChooseShipAction(Players, Index+1);
			
			return _next;
		}
		
		public function ChooseLeaderAction(players:Vector.<Player>, index:int = 0)
		{
			super(players, index);
		}
		
	}
}
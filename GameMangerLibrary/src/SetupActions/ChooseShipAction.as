package SetupActions
{
	import flash.net.registerClassAlias;
	
	import State.Player;
	import Ships.FireflyShip;

	public class ChooseShipAction extends SetupStepAction
	{
		public static function RegisterAliases():void
		{
			registerClassAlias("ChooseShipActionAlias", ChooseShipAction);
		}
		
		override public function get IsComplete():Boolean
		{
			return Actor.Boat != null && Actor.Boat.Leader != null;
		}

		public function SelectShip(ship:FireflyShip):void
		{
			Actor.Boat = ship;
		}
		
		private var _next:ChooseLeaderAction;
		public override function get Next():SetupAction
		{
			if(null == _next)
			    _next = new ChooseLeaderAction(Players, Index);
			
			return _next;
		}
		
		public function ChooseShipAction(players:Vector.<Player>, index:int = 0)
		{
			super(players, index);
		}
		
	}
}
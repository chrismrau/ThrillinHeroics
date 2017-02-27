package SetupActions
{
	import flash.net.registerClassAlias;
	
	import Map.*;
	import State.Player;

	public class PlaceShipAction extends SetupStepAction
	{
		public static function RegisterAliases():void
		{
			registerClassAlias("PlaceShipActionAlias", PlaceShipAction);
		}
		
		public function PlaceShip(sector:Map.Sector):void
		{
			Actor.Boat.Location = sector;
		}
		
		override public function get IsComplete():Boolean
		{
			return Actor.Boat.Location != null;
		}
		
		private var _next:PlaceShipAction;
		public override function get Next():SetupAction
		{			
			if(Players.length <= Index) 
			    return new ChooseGoalAction(Players);
			
			if(null == _next)
				_next = new PlaceShipAction(Players, Index+1);
			
			return _next;
		}
		
		public function PlaceShipAction(players:Vector.<Player>, index:int = 0)
		{
			super(players, index);
			Actor = Players.reverse()[Index];
		}
		
	}
}
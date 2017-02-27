package State
{
	import flash.net.registerClassAlias;
	
	import Ships.FireflyShip;

	public class Player
	{
		public var Name:String;
		public var UID:String;
		
		public var Boat:FireflyShip;
		
		public var IsChoosingAction:Boolean = false;
		
		private var _isActive:Boolean = false;
		public function get IsActive():Boolean { return _isActive; }
		public function set IsActive(value:Boolean):void
		{
			if(value == _isActive) return;
			_isActive = value;
			
			IsChoosingAction = _isActive;
		}

		public var CanBuy:Boolean = false;
		public var CanFly:Boolean = false;
		public var CanWork:Boolean = false;
		public var CanDeal:Boolean = false;
		
		public var LastDieRoll:int = 0;
		public var TotalDieRoll:int = 0;
		
		public static function RegisterAliases():void
		{
			//AllianceCruiserShip.RegisterAliases();
			
			//registerClassAlias("ShipsVectorAlias", Vector.<FireflyShip> as Class);

			registerClassAlias("TurnAlias", Player);
		}
		
		public function Player()
		{
		}

	}
}
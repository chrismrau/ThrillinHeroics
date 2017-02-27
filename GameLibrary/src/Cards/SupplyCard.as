package Cards
{
	import flash.net.registerClassAlias;
	
	import Config.DriveCoreConfiguration;
	import Config.SupplyConfiguration;
	import Config.SupplyType;
	
	import Supplies.BaseSupply;
	import Supplies.CrewSupply;
	import Supplies.GearSupply;
	import Supplies.ShipDriveCore;
	import Supplies.ShipUpgradeSupply;

	public class SupplyCard
	{
		public var Prototype:BaseSupply = null;
		
		public static function RegisterAliases():void
		{
			registerClassAlias("SupplyCardAlias", SupplyCard);
		}

		public function get Name():String { return Prototype.Name; }
		public function get Title():String { return Prototype.Title; }
		public function get Details():String { return Prototype.Description; }
		public function get Cost():int { return Prototype.Cost; }

		public function get IsShipUpgrade():Boolean { return Prototype is ShipUpgradeSupply; }
		public function get IsCrew():Boolean { return Prototype is CrewSupply; }
		public function get IsDriveCore():Boolean { return Prototype is ShipDriveCore; }
		
		public function SupplyCard(config:SupplyConfiguration, planet:String)
		{
			switch(config.Type)
			{
				case SupplyType.SHIP_UPGRADE:
					Prototype = new ShipUpgradeSupply(config, planet);
					break;
				case SupplyType.CREW:
					Prototype = CrewSupply.Create(config, planet);
					break;
				case SupplyType.DRIVE_CORE:
				case SupplyType.DRIVE_UPGRADE:
					Prototype = new ShipDriveCore(config as DriveCoreConfiguration, planet);
					break;
				case SupplyType.GEAR:
				default:
					Prototype = new GearSupply(config, planet);
					break;
			}
		}
	}
}
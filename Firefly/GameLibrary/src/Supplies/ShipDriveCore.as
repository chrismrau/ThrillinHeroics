package Supplies  
{
	import flash.net.registerClassAlias;
	
	import Config.DriveCoreConfiguration;

	public class ShipDriveCore extends BaseSupply
	{
		public var FullBurnCost:int;
		
		public function get Configuration():String
		{
			return Name + " Range: " + FullBurnRange + " Cost: " + FullBurnCost;
		}
		
		public static function RegisterAliases():void
		{
			registerClassAlias("ShipDriveCoreAlias", ShipDriveCore);
		}
		
		public function ShipDriveCore(config:DriveCoreConfiguration, planet:String = PlanetType.YCTtS)
		{
			super(config, planet);
			
			FullBurnRange = config.Range;
			FullBurnCost = config.FullBurnCost;
		}

	}
}
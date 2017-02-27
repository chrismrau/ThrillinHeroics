package Supplies 
{	
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;

	public class ShipUpgradeSupply extends KeywordSupply
	{		
		public static function RegisterAliases():void
		{
			registerClassAlias("ShipUpgradeAlias", ShipUpgradeSupply);
		}
		
		public function ShipUpgradeSupply(config:SupplyConfiguration, planet:String)
		{
			super(config, planet);
		}
	}
}
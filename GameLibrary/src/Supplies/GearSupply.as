package Supplies
{
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;
	import Goods.PayloadTypes;

	public class GearSupply extends SkillSupply
	{		
		public static function RegisterAliases():void
		{			
			registerClassAlias("GearAlias", GearSupply);
		}

		public var MustDispose:Boolean = false;
		public var IsKnife:Boolean = false;

		public function get IsTheBestInTheHouse():Boolean
		{
			return Title.toLowerCase() == "\"the best in the house\"";
		}
		public function get IsArmor():Boolean
		{
			return Title.toLowerCase() == "alliance body armor" ||
				   Title.toLowerCase() == "early\'s combat armor";
		}
		public function get IsCortexUplink():Boolean
		{
			return Title.toLowerCase() == "cortex uplink";
		}

		
		private function ParseSpecialAbilities():void
		{
			switch(Name.toLowerCase())
			{
				case "breaching tool":
					SalvageBonus = PayloadTypes.CONTRA;
					break;
				case "knife":
				case "crow\'s knife":
				case "gentleman\'s dueling sword":
				case "the operative\'s sword":
					IsKnife = true;
					break;
				
			}
		}

		public function GearSupply(config:SupplyConfiguration, planet:String = PlanetType.YCTtS)
		{
			super(config, planet);
				
			MustDispose = config.MustDispose;
			
			ParseSpecialAbilities();
		}
	}
}
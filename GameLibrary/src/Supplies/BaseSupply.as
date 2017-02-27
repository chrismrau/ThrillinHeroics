package Supplies
{
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;

	public class BaseSupply
	{
		public var Source:String;
		
		public var Name:String;
		public var Cost:int;
		public var Title:String;
		public var Description:String;
		public var Planet:String;

		public var FullBurnRange:int = 0;	
		
		public static function RegisterAliases():void
		{
			registerClassAlias("BaseSupplyAlias", BaseSupply);
		}
		
		public function BaseSupply(config:SupplyConfiguration, planet:String = PlanetType.YCTtS)
		{
			Name = config.Name;
			Cost = config.Cost;
			Title = config.Title;
			Description = config.Description;
			
			Planet = planet;
		}
	}
}
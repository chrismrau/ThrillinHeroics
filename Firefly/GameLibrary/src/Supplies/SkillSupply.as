package Supplies
{
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;
	import Goods.PayloadTypes;

	public class SkillSupply extends KeywordSupply
	{
		public var Fight:int = 0;
		public var ShowdownFight:int = 0;

		public var Tech:int = 0;

		private var _negotiate:int = 0;
		public virtual function get Negotiate():int
		{
			return _negotiate;
		}
		public virtual function set Negotiate(value:int):void
		{
			_negotiate = value;
		}

		public var SalvageBonus:PayloadTypes = PayloadTypes.NONE;
		public var IsSolidWithHarken:Boolean = false;
		
		public function get IsMoraleBooser():Boolean { return Title == "Morale Booster"; }

		public static function RegisterAliases():void
		{
			registerClassAlias("SkillSupplyAlias", SkillSupply);
		}
		
		public function SkillSupply(config:SupplyConfiguration, planet:String = PlanetType.YCTtS)
		{
			super(config, planet);
			
			Fight = config.Fight;
			Tech = config.Tech;
			Negotiate = config.Negotiate;
		}

	}
}
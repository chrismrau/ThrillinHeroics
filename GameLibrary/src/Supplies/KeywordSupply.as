package Supplies
{
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;

	public class KeywordSupply extends BaseSupply
	{		
		public var Keywords:Vector.<String> = new Vector.<String>();
		
		public static function RegisterAliases():void
		{
			registerClassAlias("KeywordsVectorAlias", Vector.<String> as Class);
			
			registerClassAlias("KeywordSupplyAlias", KeywordSupply);
		}
		
		public function Contains(word:String):Boolean
		{
			return Keywords.indexOf(word) > -1;
		}
			
		public virtual function get IsFirearm():Boolean { return Contains(KeywordType.FIREARM); }
		public virtual function get IsSniperRifle():Boolean { return Contains(KeywordType.SNIPER_RIFLE); }
		public virtual function get IsExplosives():Boolean { return Contains(KeywordType.EXPLOSIVES); }
		public virtual function get IsHackingRig():Boolean { return Contains(KeywordType.HACKING_RIG); }
		public virtual function get IsFakeId():Boolean { return Contains(KeywordType.FAKE_ID); }
		public virtual function get IsTransport():Boolean { return Contains(KeywordType.TRANSPORT); }
		public virtual function get IsFancyDuds():Boolean { return Contains(KeywordType.FANCY_DUDS); }

		public function KeywordSupply(config:SupplyConfiguration, planet:String = PlanetType.YCTtS)
		{
			super(config, planet);
			
			for each(var kw:String in config.Keywords)
				Keywords.push(kw);
		}
	}
}
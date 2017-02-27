package Supplies
{
	import flash.net.registerClassAlias;
	
	import Config.SupplyConfiguration;
	
	import Goods.PayloadTypes;

	public class CrewSupply extends SkillSupply
	{
		public var Professions:Vector.<String> = new Vector.<String>();
		public var Gear:Vector.<GearSupply> = new Vector.<GearSupply>();
		
		public var IsMoral:Boolean = false;
		public var GearLimit:int = 1;
		public var WantedCount:int = 0;
		public function get IsWanted():Boolean { return 0 < WantedCount; }

		public var GoalBonus:int = 0;
		public var CargoBonus:int = 0;
		public var ContrabandBonus:int = 0;
		public var PiracyBonus:int = 0;
		public var BountyBonus:int = 0;
		
		public var MayUseGearInKosher:Boolean = false;
		public var MayRerollNegotiate:Boolean = false;
		public var MayRerollTech:Boolean = false;
		public var MayRerollFight:Boolean = false;

		public var WillWorkImmoral:Boolean = true;
		
		public function get IsExpendable():Boolean { return Title == "Expendable"; }
		public function get HasComposure():Boolean { return Title == "Composure"; }
		public function get IsGoonSquad():Boolean { return Title == "Goon Squad"; }
		public function get IsWholesaler():Boolean { return Title == "Wholesaler"; }
		public function get HasBlackMarketTies():Boolean { return Title == "Black Market Ties"; }
		public function get IsDeceptive():Boolean { return Title == "Deceptive"; }
		public function get IsKnifeFighter():Boolean { return Title == "Knife Fighter"; }
		public function get IsIntimidating():Boolean { return Title == "Intimidating"; }
		public function get IsHenchman():Boolean { return Title.indexOf("Henchman") > -1; }
		public function get IsAmbassador():Boolean { return Title == "Ambassador"; }
		public function get HasNaturalKnowhow():Boolean { return Title == "Natural Know How"; }
		public function get IsGifted():Boolean { return Title == "Gifted"; }
		public function get IsFirebug():Boolean { return Title == "Firebug"; }
		public function get IsCantankerous():Boolean { return Title == "Cantankerous"; }
		public function get IsUnlucky():Boolean { return Title == "Unlucky"; }
		public function get IsDeadEye():Boolean { return Title == "Dead-Eye"; }
		public function get IsFed():Boolean { return Title == "Fed"; }
		public function get IsTurncoat():Boolean { return Title == "Turncoat"; }
		public function get IsIntelBroker():Boolean { return Title == "Intel Broker"; }
		public function get IsMole():Boolean { return Title == "Mole"; }
		public function get IsHeroWorship():Boolean { return Title == "Hero Worship"; }
		public function get HasJurisdiction():Boolean { return Title == "Jurisdiction"; }
		
		private var IsCop:Function = function(item:String, index:int, vector:Vector.<String>):Boolean
		{
			return item == "Lawman";
		}
		public function get IsLawman():Boolean
		{
			return Professions.some(IsCop);
		}
		
		public function get WillWorkIllegal():Boolean { return !IsLawman; }
		
		private var IsExplosives:Function = function(item:GearSupply, index:int, vector:Vector.<GearSupply>):Boolean
		{
			return item.IsExplosives;
		}

		public override function get Negotiate():int
		{
			var result:int = super.Negotiate;
			if(IsFirebug && Gear.some(IsExplosives))
				++result;
			return result;
		}

		public static function RegisterAliases():void
		{
			GearSupply.RegisterAliases();
			
			registerClassAlias("ProfessionsVectorAlias", Vector.<String> as Class);
			registerClassAlias("GearVectorAlias", Vector.<GearSupply> as Class);
			
			registerClassAlias("CrewAlias", CrewSupply);
		}
		
		private function ParseSpecialAbilities():void
		{
			switch(Title.toLowerCase())
			{
				case "hard burn":
					FullBurnRange = 1;
					break;
				case "dust devil":
					MayRerollFight = true;
					break;
				case "wet work":
					GearLimit = 0;
					break;
				case "two of a kind":
					GearLimit = 2;
					break;
				case "public relations":
					GearLimit = 3;
					break;
				case "cooking the books":
					GoalBonus = 500;
					break;
				case "devout":
				case "secret past":
					WillWorkImmoral = false;
					break;
				case "alliance training":
					IsSolidWithHarken = true;
					break;
				case "shrewd trader":
					CargoBonus = 100;
					break;
				case "facilitator":
					ContrabandBonus = 100;
					break;
				case "salvage pro":
					SalvageBonus = PayloadTypes.CARGO;
					break;
				case "opportunist":
					SalvageBonus = PayloadTypes.CONTRA;
					break;
				case "ambassador":
					MayRerollNegotiate = true;
					break;
				case "natural know how":
					MayRerollTech = true;
					break;
				case "cheap shot":
					MayUseGearInKosher = true;
					break;
				case "dirty leech":
					SalvageBonus = PayloadTypes.FUEL;
					break;
				case "low life vulture":
					SalvageBonus = PayloadTypes.PART;
					break;
				case "bird-doggin\'":
					PiracyBonus = 200;
					break;
				case "fed":
				case "mole":
					BountyBonus = 500;
					break;
				case "posse":
					BountyBonus = 300;
					ShowdownFight = 1;
					break;
			}
		}

		public function CrewSupply(config:SupplyConfiguration, planet:String)
		{
			super(config, planet);
		}

		public static function Create(config:SupplyConfiguration, planet:String = PlanetType.YCTtS):CrewSupply
		{
			var result:CrewSupply = new CrewSupply(config, planet);
			result.IsMoral = config.IsMoral;
			result.WantedCount = config.WantedCount;
				
			for each(var prof:String in config.Profession)
				result.Professions.push(prof);
			
			result.ParseSpecialAbilities();

			return result;
		}

	}
}
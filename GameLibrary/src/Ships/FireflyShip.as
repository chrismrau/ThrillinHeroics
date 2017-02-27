package Ships  
{
	import flash.net.registerClassAlias;
	
	import Config.FireflyShipConfig;
	
	import Goods.Payload;
	import Goods.PayloadTypes;
	
	import Supplies.CrewSupply;
	import Supplies.ShipDriveCore;
	import Supplies.ShipUpgradeSupply;
	import State.Player;
	
	public class FireflyShip extends BaseShip
	{		
		private var _leader:CrewSupply = null;
		public function get Leader():CrewSupply
		{
			return _leader;
		}
		public function set Leader(leader:CrewSupply):void
		{
			if(Leader == null)
			{
				Crew.push(leader);
			}
			else
			{
				var i:int = Crew.indexOf(Leader);
				Crew.splice(i, 1, leader);
			}

			_leader = leader;
		}

		public var Crew:Vector.<CrewSupply> = new Vector.<CrewSupply>();
		public var Credits:Number = 3000;

		public var Source:String;
		public var Class:String;
		public var CanUpgradeCore:Boolean;
		
		public var DriveCore:ShipDriveCore;
		public var Upgrades:Vector.<ShipUpgradeSupply>;
		public var CargoHolds:Vector.<CargoHold>;
		public var Stashes:Vector.<CargoHold>;
		public var MaxCrew:int;
		public var SpecialRules:String;

		public static function RegisterAliases():void
		{
			CrewSupply.RegisterAliases();
			ShipDriveCore.RegisterAliases();
			ShipUpgradeSupply.RegisterAliases();
			CargoHold.RegisterAliases();
			
			registerClassAlias("UpgradesVectorAlias", Vector.<ShipUpgradeSupply> as Class);
			registerClassAlias("CargoHoldVectorAlias", Vector.<CargoHold> as Class);
			registerClassAlias("CrewVectorAlias", Vector.<CrewSupply> as Class);
			
			registerClassAlias("FireflyShipAlias", FireflyShip);
		}
		
		private function GoodCount(type:PayloadTypes):Number
		{
			var result:Number = 0;

			for each(var h:CargoHold in CargoHolds)
				result += h.GoodCount(type);

			for each(var s:CargoHold in Stashes)
				result += s.GoodCount(type);

			return result;
		}

		public function get PartCount():Number
		{
			return GoodCount(PayloadTypes.PART);
		}
		public function get CargoCount():Number
		{
			return GoodCount(PayloadTypes.CARGO);
		}
		public function get ContrabandCount():Number
		{
			return GoodCount(PayloadTypes.CONTRA);
		}
		public function get FuelCount():Number
		{
			return GoodCount(PayloadTypes.FUEL);
		}
		public function get FutitiveCount():Number
		{
			return GoodCount(PayloadTypes.FUGI);
		}
		public function get PassengerCount():Number
		{
			return GoodCount(PayloadTypes.PASS);
		}

		public override function get FullBurnRange():int
		{
			var result:int = DriveCore.FullBurnRange;
			return result;
		}
		
		public function get FullBurnCost():int
		{
			var result:int = DriveCore.FullBurnCost;
			return result;
		}
		
		public function get Configuration():String
		{
			var result:String = 
				"Core: " + DriveCore.Configuration + '\n' +
				"Cargo: " + CargoHolds.length + " Stash: " + Stashes.length + " Crew: " + MaxCrew + '\n' +
				"Upgrades: " + Upgrades.length + '\n' +
				"Special: " + SpecialRules;
			
			return result;
		}
		
		public function AddPayload(p:Payload, count:Number = 1):Number
		{
			for(var i:int = 0; i < count; ++i)
			{
				var hold:CargoHold = null;
				var h:CargoHold;
				for each(h in CargoHolds)
					if(h.CanHold(p)) hold = h;
				
				if(hold == null)
					for each(h in Stashes)
						if(h.CanHold(p)) hold = h;
				
				if(null == hold) return count - i;
				
				hold.AddPayload(p);
			}

			return count;
		}

		public function AddFuel(count:Number = 1):Number
		{
			var p:Payload = new Payload(PayloadTypes.FUEL);
			return AddPayload(p, count);
		}

		public function AddPart(count:Number = 1):void
		{
			
		}

		public function InitializeShip(config:FireflyShipConfig):void
		{	
			DriveCore = new ShipDriveCore(config.DriveCoreConfig);
			CanUpgradeCore = config.CanUpgradeDrive;
			
			Upgrades = new Vector.<ShipUpgradeSupply>(config.UpgradeSlotCount, true);
			
			var i:int;
			CargoHolds = new Vector.<CargoHold>(config.CargoHoldCount, true);
			for(i = 0; i < config.CargoHoldCount; ++i)
				CargoHolds[i] = new CargoHold();
			
			Stashes = new Vector.<CargoHold>(config.StashCount, true);
			for(i = 0; i < config.StashCount; ++i)
				Stashes[i] = new CargoHold();
			
			Leader = config.Leader;
			
			Source = config.Source;
			Class = config.Class;
			MaxCrew = config.MaxCrewCount;
			SpecialRules = config.SpecialRules;
			
			if(ShipClassType.FIREFLY3 == Class || ShipClassType.FIREFLY4 == Class)
			{
				var diff:int = config.Cost - FireflyShipConfig.DefaultCost;
				Credits -= diff;
			}
			
			AddFuel(6);
			AddPart(2);
		}
		
		public function FireflyShip(config:FireflyShipConfig)
		{
			super(config);
			
			InitializeShip(config);
		}

	}
}
package Config  
{
	import Supplies.CrewSupply;

	public class FireflyShipConfig extends BaseConfiguration
	{
		private var _source:String = SourceTypes.BASE_GAME;
		public function get Source():String { return _source; }
	
		public static const DefaultCost:int = 7800;
		private var _cost:int = DefaultCost;
		public function get Cost():int { return _cost; }
		
		private var _upgradeSlotCount:int = 0;
		public function get UpgradeSlotCount():int { return _upgradeSlotCount; }
		
		private var _cargoHoldCount:int = 0;
		public function get CargoHoldCount():int { return _cargoHoldCount; }
		
		private var _stashCount:int = 0;
		public function get StashCount():int { return _stashCount; }
		
		private var _driveCoreConfig:DriveCoreConfiguration
		public function get DriveCoreConfig():DriveCoreConfiguration
		{
			return _driveCoreConfig;
		}
		
		private var _class:String = new String();
		public function get Class():String { return _class; }
		
		private var _maxCrewCount:int = 0;
		public function get MaxCrewCount():int { return _maxCrewCount; }
		
		private var _canUpgradeDrive:Boolean = false;
		public function get CanUpgradeDrive():Boolean { return _canUpgradeDrive; }
		
		private var _specialRules:String = new String();
		public function get SpecialRules():String { return _specialRules; }
		
		private var _colorR:int = 0;
		public function get ColorR():int { return _colorR; }
		
		private var _colorG:int = 0;
		public function get ColorG():int { return _colorG; }
		
		private var _colorB:int = 0;
		public function get ColorB():int { return _colorB; }
		
		private var _leader:CrewSupply = null;
		public function get Leader():CrewSupply { return _leader; }
		public function SetLeader(leader:CrewSupply):void
		{
			_leader = leader;
		}

		public var IsEnabled:Boolean = true;
		
		private function SetupDriveCore(cores:Vector.<DriveCoreConfiguration>):void
		{
			var core_name:String = Fields["Main Drive"];
			var core:DriveCoreConfiguration;
			for each(core in cores)
			if(core.Name == core_name)
				break;
			
			_driveCoreConfig = core;
			
			if("Y" == Fields["Can Upgrade Drive"])
				_canUpgradeDrive = true;
		}
		
		public function FireflyShipConfig(db:DBConfiguration, rowConfig:XML, ship:XML, cores:Vector.<DriveCoreConfiguration>)
		{
			super(db, rowConfig, ship);
			
			_source = Fields["Source"];	
			_cost = Fields["Cost"];
			_class = Fields["Class"];
			_cargoHoldCount = int(Fields["Cargo Holds"]);
			_stashCount = int(Fields["Stash"]);
			_maxCrewCount = int(Fields["Max Crew"]);
			_upgradeSlotCount = int(Fields["Upgrade Slots"]);
			_specialRules = Fields["Special Rules"];
			_colorR = Fields["Color_R"];
			_colorG = Fields["Color_G"];
			_colorB = Fields["Color_B"];
			
			SetupDriveCore(cores);
		}
		
	}
}
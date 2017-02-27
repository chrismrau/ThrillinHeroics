package Config
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import Config.FireflyShipConfig;
	
	import Supplies.CrewSupply;

	public class GameConfiguration
	{		
		public var UseBreakinAtmo:Boolean = true;
		public var UsePiratesAndBountyHunters:Boolean = true;
		public var UseBlueSun:Boolean = true;

		public var UseArtfulDodger:Boolean = true;
		public var UseEsmeralda:Boolean = true;
		public var UseJetwash:Boolean = true;
		
		public var AvailableLeaders:Vector.<CrewSupply> = new Vector.<CrewSupply>();
		public var ConsideredLeader:CrewSupply = null;
		
		public var AvailableBoats:Vector.<FireflyShipConfig> = new Vector.<FireflyShipConfig>();
		public var DriveCores:Vector.<DriveCoreConfiguration> = new Vector.<DriveCoreConfiguration>();
		public var Fleet:Vector.<FireflyShipConfig> = new Vector.<FireflyShipConfig>();
		public var ConsideredBoat:FireflyShipConfig = null;

		public var NavCards:Vector.<NavPrototype> = new Vector.<NavPrototype>();
		public var SupplyCards:Vector.<SupplyConfiguration> = new Vector.<SupplyConfiguration>();
		
        private var _dbConfig:DBConfiguration;
		
		public function ConsiderLeader(leader:CrewSupply):void
		{
			ConsideredLeader = leader;
		}
		public function SelectLeader():void
		{
			var index:Number = AvailableLeaders.indexOf(ConsideredLeader);
			AvailableLeaders.splice(index, 1);
		}

		private function FindBoat(name:String):FireflyShipConfig
		{
			var index:int = 0;
			var result:FireflyShipConfig = AvailableBoats[index];
			while(result.Name != name)
			{
				result = AvailableBoats[++index];
			}
			
			return result;
		}
		
		public function ConsiderBoat(name:String):void
		{
			var boat:FireflyShipConfig = FindBoat(name);
			ConsideredBoat = boat;
		}


		private var _currentPlayer:int = 0;
		public function get CurrentPlayer():String { return Players[_currentPlayer]; }

		private var _players:Vector.<String> = new Vector.<String>();
		public function get Players():Vector.<String>
		{
			return _players;
		}

		public function get IsPlayerListDone():Boolean { return _players.length == PlayerCount; }

		public function AddPlayer(name:String):void
		{
			if(IsPlayerListDone) return;
			var i:int = Math.random() * (_players.length + 1);
			_players.splice(i, 0, name);
		}

		private var _playerCount:int = 0;
		public function get PlayerCount():int { return _playerCount; }
		public function set PlayerCount(value:int):void { _playerCount = value; }
		public function NextPlayer():String
		{
			var current = _currentPlayer + 1;
			_currentPlayer = current % PlayerCount;
			return CurrentPlayer;
		}


		public function SelectBoat():void
		{
			var index:Number = AvailableBoats.indexOf(ConsideredBoat);
			AvailableBoats.splice(index, 1);
			Fleet.push(ConsideredBoat);
			ConsideredBoat.SetLeader(ConsideredLeader);
			ConsideredBoat = null;
			ConsideredLeader = null;
			
			NextPlayer();
			_currentPlayer++;
		}

		public function SelectAllBoats():void
		{
			for each(var config:FireflyShipConfig in AvailableBoats)
				Fleet.push(config);
		}
			
		public function get IsSelectionComplete():Boolean
		{
			return Fleet.length == PlayerCount;
		}
		

		public function InitPlayerSetup():void
		{
			_currentPlayer = 0;

			ConsideredLeader = null;
			ConsideredBoat = null;
		}
		

		public function get MaxPlayerCount():int
		{
			var max:int = 4;
			if(UsePiratesAndBountyHunters) max += 2;
			if(UseArtfulDodger) max++;
			
			return max;
		}
		
		private function AddAvailableShip(rowConfig:XML, ship:XML):void
		{
			var config:FireflyShipConfig = new FireflyShipConfig(_dbConfig, rowConfig, ship, DriveCores);
			
			AvailableBoats.push(config);
		}
		
		private function ConfigureShips(ships:XMLList):void
		{
			var rows:XMLList = ships.Table.Row;
			for(var i:int=1; i<rows.length(); i++)
				AddAvailableShip(rows[0], rows[i]);
		}
		
		public function ConfigureSupplies(supplies:XMLList):void
		{
			var rows:XMLList = supplies.Table.Row;
			for(var i:int = 1; i < rows.length(); i++)
			{
				var config:SupplyConfiguration = new SupplyConfiguration(_dbConfig, rows[0], rows[i]);
				switch(config.Type)
				{
					case SupplyType.LEADER:
						AvailableLeaders.push(CrewSupply.Create(config));
						break;
					case SupplyType.DRIVE_CORE:
						DriveCores.push(new DriveCoreConfiguration(_dbConfig, rows[0], rows[i]));
						break;
					case SupplyType.DRIVE_UPGRADE:
						SupplyCards.push(new DriveCoreConfiguration(_dbConfig, rows[0], rows[i]));
						break;
					default:
						SupplyCards.push(new SupplyConfiguration(_dbConfig, rows[0], rows[i]));
						break;
				}
			}
		}
		
		public function ConfigureNavDecks(navCards:XMLList):void
		{
			var rows:XMLList = navCards.Table.Row;
			for(var i:int = 1; i < rows.length(); i++)
			{
				var card:NavPrototype = new NavPrototype(rows[0], rows[i]);
				if(card.Name.length == 0) continue;
				NavCards.push(new NavPrototype(rows[0], rows[i]));
			}
		}

		private function ConfigureGame(config:XML):void
		{
			_dbConfig = new DBConfiguration(config);
			
			var supplies_xml:XMLList = config.Worksheet.(@Name == "Supplies");
			ConfigureSupplies(supplies_xml);
			
			var ships_xml:XMLList = config.Worksheet.(@Name == "Ships");
			ConfigureShips(ships_xml);
			
			var nav_xml:XMLList = config.Worksheet.(@Name == "Nav Cards");
			ConfigureNavDecks(nav_xml);
			
			trace("***Configuration loaded.");
		}
		
		private const XMLNS_PATTERN:RegExp = new RegExp("xmlns=\"[^\"]*\"", "gi");
		private function RemoveNamespaces(xml:XML):XML
		{
			var result:XML = xml.copy();
			if(xml.hasComplexContent())
			{
				var children:XMLList = result.children();
				for(var i:int = 0; i < children.length(); i++)
				{
					children[i] = RemoveNamespaces(children[i]);
				}
			}
			
			var xml_str:String = result.toXMLString();
			xml_str = xml_str.replace(XMLNS_PATTERN, "");
			result = new XML(xml_str);
			
			return result;
		}
		
		public var IsNetworkGame:Boolean = false;
		
		private var _loadCompleteHandler:Function;
		private function LoadCompleteHandler(evt:Event):void
		{
			var loader:URLLoader = evt.target as URLLoader;
			if(null != loader)
			{
				var xml:XML = new XML(loader.data);
				var cleaned:XML = RemoveNamespaces(xml);
				ConfigureGame(cleaned);
			}
			_loadCompleteHandler(this);
		}
		
		private var _loader:URLLoader;
		private var _request:URLRequest;
		public function InitializeGameFromXML(fileName:String):void
		{
			_request = new URLRequest(fileName);
			_loader.addEventListener(Event.COMPLETE, LoadCompleteHandler);
			_loader.load(_request);
		}
		
		public function GameConfiguration(fileName:String, loadCompleteHandler:Function)
		{			
			_loadCompleteHandler = loadCompleteHandler;
			_loader = new URLLoader();
			InitializeGameFromXML(fileName);
		}
		
	}
}
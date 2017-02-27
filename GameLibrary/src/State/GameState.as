package State  
{	
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	import Cards.DiscardDecks;
	
	import Config.GameConfiguration;
	
	import Map.Sector;
	import Map.SectorNames;
	import Map.SectorRegionType;
	
	import Ships.BaseShip;
	import Ships.FireflyShip;
	import Ships.ShipCollection;
	
	public class GameState
	{	
		public var Fleet:ShipCollection;
		public var ActiveSectors:Vector.<Sector> = new Vector.<Sector>();
		public var Discards:DiscardDecks = new DiscardDecks();
		public var Players:Vector.<Player> = new Vector.<Player>();

		public static function RegisterAliases():void
		{
			ShipCollection.RegisterAliases();
			Player.RegisterAliases();
			DiscardDecks.RegisterAliases();
			
			registerClassAlias("ActiveSectorsAlias", Vector.<Sector> as Class);
			registerClassAlias("GameStateAlias", GameState);
		}
		
		public function NextPlayer():Player
		{
			//TODO: Just update player with new ship???
			//???
			return Players[0];
		}

		private var _currentPlayer:Player = new Player();
		public function get CurrentPlayer():Player { return _currentPlayer; }
		public function set CurrentPlayer(value:Player):void
		{
			if(value == _currentPlayer) return;
			_currentPlayer = value;
		}
		
		public function get LastPlayer():FireflyShip
		{
			var index:Number = Fleet.PlayerShips.length;
			return Fleet.PlayerShips[index - 1];
		}


		public function MoveShipTo(ship:BaseShip, sector:Sector):void
		{
			var old_loc:Sector = ship.Location;
			if(old_loc != null)
			{
				var i:int = old_loc.Vessels.indexOf(ship);
				old_loc.Vessels.splice(i,1);
				if(old_loc.Vessels.length == 0)
				{
					i = ActiveSectors.indexOf(old_loc);
					ActiveSectors.splice(i,1);
				}
			}
			
			ship.Location = sector;
			sector.Vessels.push(ship);
			i = ActiveSectors.indexOf(sector);
			if(i == -1)	ActiveSectors.push(sector);		
		}
		
		public function MoveCurrentTo(sector:Sector):void
		{
			MoveShipTo(Fleet.Current, sector);
		}
		
		///name2SectorObject
		public var MapSectors:Dictionary = new Dictionary();

		private function ConfigureRegion(quadrant:Array, regionName:String):void
		{
			for each(var sectors:Array in quadrant)
				for each(var s_name:String in sectors)
				{
					var sector:Map.Sector = new Sector(s_name, regionName);
					MapSectors[s_name] = sector;
				}
			
		}
		private function ConfigureSectors():void
		{			
			ConfigureRegion(Map.SectorNames.SectorAllianceSpace, Map.SectorRegionType.ALLIANCE);
			ConfigureRegion(Map.SectorNames.SectorBorderSpace, Map.SectorRegionType.BORDER);
			ConfigureRegion(Map.SectorNames.SectorRimSpace, Map.SectorRegionType.RIM);

			for (var key:String in Map.SectorNames.Sectors)
			{
				var sec:Sector = MapSectors[key];
				var adjs:Array = Map.SectorNames.Sectors[key];
				for each(var name:String in adjs)
					sec.AddAdjacent(MapSectors[name]);
			}
		}
		
		public function ConfigureGameState(config:GameConfiguration):void
		{			
			ConfigureSectors();
			Fleet = new ShipCollection(config, MapSectors);
		}
			
		public function GameState(config:GameConfiguration)
		{
			ConfigureGameState(config);
			trace("new GameState Created");
		}
		
	}
}
package Ships  
{
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	import Config.FireflyShipConfig;
	import Config.GameConfiguration;
	import Config.SourceTypes;
	
	import Map.Sector;
	import Map.SectorNames;
	
	public class ShipCollection 
	{
		public var AllianceCruiser:AllianceCruiserShip = new AllianceCruiserShip(null);
		public var ReaverShips:Vector.<ReaverShip> = new Vector.<ReaverShip>();
		public var PlayerShips:Vector.<FireflyShip> = new Vector.<FireflyShip>();
		public var Name2Ship:Dictionary = new Dictionary(true);
		
		public static function RegisterAliases():void
		{
			BaseShip.RegisterAliases();
			FireflyShip.RegisterAliases();
			ReaverShip.RegisterAliases();
			AllianceCruiserShip.RegisterAliases();
			
			registerClassAlias("ShipsVectorAlias", Vector.<FireflyShip> as Class);
			registerClassAlias("ReaverVectorAlias", Vector.<ReaverShip> as Class);
			registerClassAlias("ShipCollectionAlias", ShipCollection);
		}
		
		private var CurrentShipName:String = "";
		private var MapSectors:Dictionary;
		
		private function SetCurrent(name:String):void
		{
			CurrentShipName = name;
		}
		
		public function get Current():BaseShip
		{
			if(CurrentShipName in Name2Ship)
				return Name2Ship[CurrentShipName];
			return null;
		}
		
		public function set Current(ship:BaseShip):void
		{
			SetCurrent(ship.Name);
		}
		
		private function SetupReaver(sector:Sector):void
		{
			var ship:ReaverShip = new ReaverShip(sector);
			ship.Name = "Reaver" + ReaverShips.length.toString();
			sector.Vessels.push(ship);

			Name2Ship[ship.Name] = ship;
			ReaverShips.push(ship);
		}
		
		private function ConfigureEnemyShips(config:GameConfiguration):void
		{
			AllianceCruiser.Location = MapSectors[SectorNames.LONDINIUM];
			AllianceCruiser.Location.Vessels.push(AllianceCruiser);
			AllianceCruiser.Name = "AllianceCruiser";
			Name2Ship[AllianceCruiser.Name] = AllianceCruiser;
			
			if(config.UseBlueSun)
			{
				SetupReaver(MapSectors[SectorNames.REAVER_SPACE_0]);
				SetupReaver(MapSectors[SectorNames.REAVER_SPACE_1]);
				SetupReaver(MapSectors[SectorNames.REAVER_SPACE_2]);
			}
			else
			{
				SetupReaver(MapSectors[SectorNames.REAVER_SPACE]);
			}
		}
		
		private function ConfigureCollection(config:GameConfiguration):void
		{
			ConfigureEnemyShips(config);
			
			for each(var ship:FireflyShipConfig in config.Fleet)
			{
				if((SourceTypes.BASE_GAME == ship.Source) ||
				   (SourceTypes.PIRATES == ship.Source && config.UsePiratesAndBountyHunters) ||
				   (SourceTypes.ARTFUL_DODGER == ship.Source && config.UseArtfulDodger))
				{
					if(ship.IsEnabled)
					{
						var ff:FireflyShip = new FireflyShip(ship);
						PlayerShips.push(ff);
						Name2Ship[ff.Name] = ff;
					}
				}
			}
		}
		
		public function ShipCollection(config:GameConfiguration, mapSectors:Dictionary)
		{			
			MapSectors = mapSectors;
			ConfigureCollection(config);
		}
		
	}
	
}

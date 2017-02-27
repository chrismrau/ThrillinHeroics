package Ships
{
	import flash.net.registerClassAlias;

	import Config.FireflyShipConfig;
	import Map.Sector;
	import Map.SectorRegionType;
	
	public class AllianceCruiserShip extends BaseShip
	{
		public static function RegisterAliases():void
		{			
			registerClassAlias("AllianceCruiserShipAlias", AllianceCruiserShip);
		}

		public override function CanEnter(sector:Sector):Boolean
		{
			return super.CanEnter(sector) && 
				   sector.Region == Map.SectorRegionType.ALLIANCE;
		}

		public function AllianceCruiserShip(config:FireflyShipConfig)
		{
			super(config);
		}
	}
}
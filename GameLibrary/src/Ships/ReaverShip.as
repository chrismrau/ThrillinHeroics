package Ships
{
	import flash.net.registerClassAlias;
	
	import Map.Sector;
	import Map.SectorRegionType;
	
	public class ReaverShip extends BaseShip
	{				
		public static function RegisterAliases():void
		{			
			registerClassAlias("ReaverShipAlias", ReaverShip);
		}
		
		public override function CanEnter(sector:Sector):Boolean
		{
			return super.CanEnter(sector) && 
				   sector.Region != Map.SectorRegionType.ALLIANCE &&
			       !sector.ContainsReaver;
		}

		public override function get NavigableSectors():Vector.<Sector>
		{
			return super.NavigableSectors;
		}
		
		public override function set Location(value:Sector):void
		{
			Location.AddToken();
			super.Location = value;
		}
		
		public var ShowHighlight:Boolean = false;
		
		public function ReaverShip(location:Sector)
		{
			super(null);
			super.Location = location;
		}
	}
}
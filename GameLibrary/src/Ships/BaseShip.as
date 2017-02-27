package Ships
{
	import flash.net.registerClassAlias;
	
	import Config.FireflyShipConfig;
	
	import Map.Sector;
	
	public class BaseShip
	{		
		public static function RegisterAliases():void
		{
			Sector.RegisterAliases();
			
			registerClassAlias("BaseShipAlias", BaseShip);
		}
		
		public virtual function get FullBurnRange():int
		{
			return 1;
		}

		public virtual function CanEnter(sector:Sector):Boolean
		{
			return sector != Location;
		}
			
		public virtual function get NavigableSectors():Vector.<Sector>
		{
			var result:Vector.<Sector> = new Vector.<Sector>();
			if(Location == null) return result;
			
			for each(var sector:Sector in Location.AdjacentSectors)
			{
				if(CanEnter(sector)) result.push(sector);
			}

			return result;
		}

		private var _location:Sector = null;
		public virtual function get Location():Sector { return _location; }
		public virtual function set Location(value:Sector):void
		{
			_location = value;
		}
				
		public var Name:String;
		public var Red:int = 0;
		public var Green:int = 0;
		public var Blue:int = 0;
		public var Offset:int = 0;
		
		public function BaseShip(config:FireflyShipConfig)
		{
			if(config == null) return;
			Name = config.Name;
			Red = config.ColorR;
			Green = config.ColorG;
			Blue = config.ColorB;
		}

	}
}
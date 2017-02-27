package Map
{
	import flash.net.registerClassAlias;
	
	import Ships.BaseShip;
	import Ships.ReaverShip;
	
	public class Sector
	{
		public var Name:String = null;
		public var Region:String = null;
		
		private var _defTokenCount:int = 0;
		public var TokenCount:int = 0;
		
		public var Vessels:Vector.<BaseShip> = new Vector.<BaseShip>();
		
		private var _adjacentSectors:Vector.<Sector> = new Vector.<Sector>();
		public function AddAdjacent(sector:Sector):void
		{
			_adjacentSectors.push(sector);
		}
		public function get AdjacentSectors():Vector.<Sector>
		{
			return _adjacentSectors;
		}
		public function IsAdjacentTo(that:Sector):Boolean
		{
			if(that == null) return true;
			
			var index:int = _adjacentSectors.indexOf(that);
			return index > -1;
		}
		
		public static function RegisterAliases():void
		{
			registerClassAlias("VesselsAlias", Vector.<BaseShip> as Class);
			registerClassAlias("SectorsAlias", Vector.<Sector> as Class);
			
			registerClassAlias("SectorAlias", Sector);
		}
		
		private function IsReaver(item:BaseShip, index:int, vector:Vector.<BaseShip>):Boolean
		{
			return (item is ReaverShip);
		}
		public function get ContainsReaver():Boolean
		{
			return Vessels.some(IsReaver);
		}
			
		public function AddToken():void
		{
			TokenCount++;
		}
		public function ClearTokens():void
		{
			TokenCount = _defTokenCount;
		}
		
		public function Sector(name:String, region:String, defaultTokenCount:int = 0)
		{
			Name = name;
			Region = region;
			
			_defTokenCount = defaultTokenCount;
			ClearTokens();
		}
		
	}
}
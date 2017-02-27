package Map
{
	import flash.net.registerClassAlias;

	public final class SectorRegionType
	{
		public static const ALLIANCE:String = "Alliance";
		public static const BORDER:String = "Border";
		public static const RIM:String = "Rim";

		public static function RegisterAliases():void
		{
			registerClassAlias("SectorRegionTypeAlias", SectorRegionType);
		}

	}
}
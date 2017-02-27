package Supplies
{
	import flash.net.registerClassAlias;

	public final class PlanetType
	{
		public static const SPACE_BAZAAR:String = "Space Bazaar";
		public static const PERSEPHONE:String = "Persephone";
		public static const SILVERHOLD:String = "Silverhold";
		public static const REGINA:String = "Regina";
		public static const OSIRIS:String = "Osiris";
		public static const MERIDIAN:String = "Meridian";
		
		public static const YCTtS:String = "YCTtS";
		
		public static function RegisterAliases():void
		{
			registerClassAlias("PlanteTypeAlias", PlanetType);
		}
	}
}
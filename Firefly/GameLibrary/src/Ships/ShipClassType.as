package Ships
{
	import flash.net.registerClassAlias;

	public final class ShipClassType
	{
		public static const FIREFLY3:String = "Firefly III";
		public static const FIREFLY4:String = "Firefly IV";
		public static const THUNDERBIRD:String = "Thunderbird";
		public static const SALVAGE_SCOW:String = "Salvage Scow";

		public static function RegisterAliases():void
		{
			registerClassAlias("ShipClassTypeAlias", ShipClassType);
		}

	}
}
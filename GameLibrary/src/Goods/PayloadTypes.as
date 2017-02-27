package Goods  
{
	import flash.net.registerClassAlias;

	public final class PayloadTypes
	{
		public static const NONE:PayloadTypes = new PayloadTypes("None");
		
		public static const FUEL:PayloadTypes = new PayloadTypes("Fuel");
		public static const PART:PayloadTypes = new PayloadTypes("Part");
		
		public static const CARGO:PayloadTypes = new PayloadTypes("Cargo");
		public static const CONTRA:PayloadTypes = new PayloadTypes("Contra");
		
		public static const PASS:PayloadTypes = new PayloadTypes("Passenger");
		public static const FUGI:PayloadTypes = new PayloadTypes("Fugitive");
		
		private var _name:String;
		
		public static function registerAliases():void
		{
			registerClassAlias("PayloadTypesAlias", PayloadTypes);
		}
		
		public function PayloadTypes(name:String)
		{
			_name = name;
		}
	}
}
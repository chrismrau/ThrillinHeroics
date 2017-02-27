package Goods  
{
	import flash.net.registerClassAlias;

	public class Payload
	{
		public var Type:PayloadTypes = PayloadTypes.NONE;
		public var Size:int = 0;
		
		public static function RegisterAliases():void
		{
			registerClassAlias("PayloadAlias", Payload);
		}
		
		public function get IsAGood():Boolean
		{
			return Type == PayloadTypes.FUEL ||
				   Type == PayloadTypes.PART ||
				   Type == PayloadTypes.CARGO ||
				   Type == PayloadTypes.CONTRA;
		}
		
		public function Payload(type:PayloadTypes)
		{
			Type = type;
			switch(Type)
			{
				case PayloadTypes.FUEL:
				case PayloadTypes.PART:
					Size = 1;
					break;
				case PayloadTypes.CARGO:
				case PayloadTypes.CONTRA:
				case PayloadTypes.PASS:
				case PayloadTypes.FUGI:
					Size = 2;
					break;
				default: Size = 0; break;
			}
		}

	}
}
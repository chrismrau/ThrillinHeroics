package Ships  
{
	import flash.net.registerClassAlias;
	
	import Goods.Payload;
	import Goods.PayloadTypes;
	
	public class CargoHold
	{
		private const MAX_SLOTS:int = 2;
		
		public var Slots:Vector.<Payload> = new Vector.<Payload>();

		public static function RegisterAliases():void
		{
			Payload.RegisterAliases();
			
			registerClassAlias("SlotsVectorAlias", Vector.<Payload> as Class);
			
			registerClassAlias("CargoHoldAlias", CargoHold);
		}
		
		public function get SlotsAvailable():Number
		{
			var result:Number = MAX_SLOTS;
			for each(var p:Payload in Slots)
				result -= p.Size;
			
			return result;
		}
		
		public function GoodCount(type:PayloadTypes):Number
		{
			var result:Number = 0;
			for each(var p:Payload in Slots)
				if(p.Type == type);
					++result;

			return result;
		}

		public function CanHold(p:Payload):Boolean
		{
			return SlotsAvailable >= p.Size;
		}
			
		public function AddPayload(payload:Payload):void
		{
			if(SlotsAvailable >= payload.Size)
			{
				Slots.push(payload);
			}
		}
		
		public function RemovePayload(type:PayloadTypes):Payload
		{
			var result:Payload = null;
			var newSlots:Vector.<Payload> = new Vector.<Payload>(MAX_SLOTS, true);
			var target:PayloadTypes = type;
			
			for each(var p:Payload in Slots)
			{
				if(p.Type == target)
				{
					target = PayloadTypes.NONE;
					result = p;
				}
				else
				{
					newSlots.push(p);
				}
			}
			
			Slots = newSlots;
			return result;
		}
		
		public function CargoHold()
		{
		}
		
	}
}
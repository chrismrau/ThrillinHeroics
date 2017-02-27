package Config  
{
	public class DriveCoreConfiguration extends SupplyConfiguration
	{
		private var _range:int = 5;
		public function get Range():int { return _range; }
		
		private var _burnCost:int = 1;
		public function get FullBurnCost():int { return _burnCost; }
		
		private function GetValue(node:String, key:String):int
		{
			var result:int = 0;
			var index:int = node.search(key);
			if(index > -1)
			{				
				var key_val:Array = node.split("=");
				if(key_val.length == 2)
					result = int(key_val[1]);
			}
			
			return result;
		}
		
		private const RANGE:String = "Range";
		private const FUEL:String = "Fuel";
		
		private function SetupRange():void
		{
			var spec:String = Fields["Spec"];
			var specs:Array = spec.split(" ");
			
			for each(var node:String in specs)
			{
				if(node.search(RANGE) > -1)
					_range = GetValue(node, RANGE);
				else if(node.search(FUEL) > -1)
					_burnCost = GetValue(node, FUEL);
			}
		}
		
		public function DriveCoreConfiguration(db:DBConfiguration, rowConfig:XML, row:XML)
		{
			super(db, rowConfig, row);
			
			SetupRange();
		}
	}
}
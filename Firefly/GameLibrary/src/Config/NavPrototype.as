package Config
{
	public class NavPrototype extends BaseConfiguration
	{
		public var AllianceCount:int = 0;
		public var BorderCount:int = 0;
		public var BlueSunCount:int = 0;
		public var RimCount:int = 0;
		
		public var Options:Vector.<String> = new Vector.<String>(2, true);
		public var Details:Vector.<String> = new Vector.<String>(2, true);
		public var IsReshuffle:Boolean = false;
		
		public function NavPrototype(rowConfig:XML, row:XML)
		{
			super(null, rowConfig, row);

			AllianceCount = Fields["Alliance"];
			BorderCount = Fields["Border"];
			BlueSunCount = Fields["Border - BS"];
			RimCount = Fields["Rim"];
			
			Options[0] = Fields["Option 1"];
			Details[0] = Fields["Details 1"];
			Options[1] = Fields["Option 2"];
			Details[1] = Fields["Details 2"];
			
			if(Fields["Reshuffle"] == "Y")
				IsReshuffle = true;
		}
	}
}
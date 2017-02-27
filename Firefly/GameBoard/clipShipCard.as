package  {
	
	import flash.display.MovieClip;
	
	import Config.DriveCoreConfiguration;
	import Config.FireflyShipConfig;
	import Supplies.ShipDriveCore;
	
	public class clipShipCard extends MovieClip {		
		
		public function clipShipCard(config:FireflyShipConfig) 
		{
			Seeker.Show(config.Name, this);
			
			var core:ShipDriveCore = new ShipDriveCore(config.DriveCoreConfig);
			MainDrive.Configure(core);
		}
	}
	
}

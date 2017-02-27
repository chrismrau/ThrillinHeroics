package  {
	
	import flash.display.MovieClip;
	
	import Config.DriveCoreConfiguration;
	import Config.FireflyShipConfig;
	import Supplies.ShipDriveCore;
	
	public class clipPlayerSpace extends MovieClip {
		
		public function clipPlayerSpace(config:FireflyShipConfig) 
		{
			UpgradeSlot01.visible = false;
			UpgradeSlot02.visible = false;
			UpgradeSlot03.visible = false;
			
			Crew01.visible = false;
			Crew02.visible = false;
			Crew03.visible = false;
			Crew04.visible = false;
			Crew05.visible = false;
			Crew06.visible = false;
			Crew07.visible = false;
			Crew08.visible = false;
			
			Seeker.Show(config.Name, this);
		}
	}
	
}

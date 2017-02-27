package  {
	
	import flash.display.MovieClip;
	import Supplies.ShipDriveCore;
	
	public class clipDriveCoreCard extends MovieClip {
		
		public function Configure(proto:ShipDriveCore):void
		{
			Range.text = proto.FullBurnRange.toString();
			Name.text = proto.Name;
			Details.text = proto.Description;
			Cost.text = proto.Cost.toString();
			
			Seeker.Show(proto.Name, Picture);
		}
		
		public function clipDriveCoreCard() 
		{
			super();
		}
		
	}
	
}

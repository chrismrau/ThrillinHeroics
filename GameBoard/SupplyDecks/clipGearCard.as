package  {
	
	import flash.display.MovieClip;
	import Supplies.GearSupply;
	
	public class clipGearCard extends MovieClip {
		
		public function Configure(proto:GearSupply)
		{
			Information.Initialize(proto);
			Seeker.Show(proto.Name, Picture);
			Seeker.Show(proto.Planet, Bezel);
			Seeker.Show(proto.Planet, Background);
		}
		
		public function clipGearCard()
		{
			super();
		}
	}
	
}

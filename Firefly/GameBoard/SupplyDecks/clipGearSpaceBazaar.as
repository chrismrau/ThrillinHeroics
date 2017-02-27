package  {
	
	import flash.display.MovieClip;
	
	import Supplies.GearSupply;
		
	public class clipGearSpaceBazaar extends MovieClip {
		
		public function clipGearSpaceBazaar(proto:GearSupply) 
		{
			super();
			
			Information.Initialize(proto);
		}
	}
	
}

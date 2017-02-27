package  {
	
	import flash.display.MovieClip;
	
	import Supplies.ShipUpgradeSupply;	
	import Supplies.BaseSupply;
	
	public class clipShipUpgradeBase extends MovieClip {
		
		public function Initialize(proto:BaseSupply)
		{			
			Name.text = proto.Name;
			Details.text = proto.Description;
			Cost.text = proto.Cost.toString();
			
			Seeker.Show(proto.Name, Picture);
		}
		
		public function clipShipUpgradeBase()
		{
			super();
		}
	}
	
}

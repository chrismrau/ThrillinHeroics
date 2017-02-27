package  {
	
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	import Supplies.GearSupply;
	
	public class clipDeckSilverhold extends clipSuppliesBaseDeck {
				
		protected override function get Current():SupplyCard 
		{ 
			return Engine.Discards.Supplies.Silverhold.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.Silverhold.Pile;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.SilverholdDrawCount;
		}
		
		protected override function DrawNextCard():void
		{
			Engine.SilverholdNext();
			super.DrawNextCard();
		}
		
		public function clipDeckSilverhold()
		{
			super();
						
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
	}
	
}

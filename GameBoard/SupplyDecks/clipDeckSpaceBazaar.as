package  {
	
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	import Supplies.GearSupply;
	
	public class clipDeckSpaceBazaar extends clipSuppliesBaseDeck {
						
		protected override function get Current():SupplyCard 
		{ 
			return Engine.Discards.Supplies.SpaceBazaar.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.SpaceBazaar.Pile;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.SpaceBazaarDrawCount;
		}
		
		protected override function DrawNextCard():void
		{
			Engine.SpaceBazaarNext();
			super.DrawNextCard();
		}
		
		public function clipDeckSpaceBazaar()
		{
			super();
						
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
	}
	
}

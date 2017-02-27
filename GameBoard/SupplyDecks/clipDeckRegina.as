package  {
	
	import flash.display.MovieClip;	
	
	import Cards.SupplyCard;
	import Supplies.GearSupply;
	
	public class clipDeckRegina extends clipSuppliesBaseDeck {
		
		protected override function get Current():SupplyCard
		{ 
			return Engine.Discards.Supplies.Regina.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.Regina.Pile;
		}
		
		protected override function get DrawCount():int 
		{ 
			return Engine.ReginaDrawCount;
		}
		
		protected override function DrawNextCard():void
		{
			Engine.ReginaNext();
			super.DrawNextCard();
		}
		
		public function clipDeckRegina()
		{
			super();
						
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
		
	}
	
}

package  {
	
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	
	public class clipDeckPersephone extends clipSuppliesBaseDeck {
		
		protected override function get Current():SupplyCard 
		{ 
			return Engine.Discards.Supplies.Persephone.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.Persephone.Pile;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.PersephoneDrawCount;
		}
		protected override function DrawNextCard():void
		{
			Engine.PersephoneNext();
			super.DrawNextCard();
		}
		
		public function clipDeckPersephone()
		{
			super();
			
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
	}
	
}

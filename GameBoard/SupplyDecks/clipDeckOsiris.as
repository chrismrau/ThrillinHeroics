package  {
	
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	
	public class clipDeckOsiris extends clipSuppliesBaseDeck {
		
		protected override function get Current():SupplyCard 
		{ 
			return Engine.Discards.Supplies.Osiris.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.Osiris.Pile;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.OsirisDrawCount;
		}
		protected override function DrawNextCard():void
		{
			Engine.OsirisNext();
			super.DrawNextCard();
		}
		
		public function clipDeckOsiris()
		{
			super();
			
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
	}
	
}

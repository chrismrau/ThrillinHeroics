package  {
	
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	
	public class clipDeckMeridian extends clipSuppliesBaseDeck {
				
		protected override function get Current():SupplyCard 
		{ 
			return Engine.Discards.Supplies.Meridian.Last;
		}
		protected override function get Pile():Vector.<SupplyCard>
		{ 
			return Engine.Discards.Supplies.Meridian.Pile;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.MeridianDrawCount;
		}
		protected override function DrawNextCard():void
		{
			Engine.MeridianNext();
			super.DrawNextCard();
		}
		
		public function clipDeckMeridian()
		{
			super();
			
			Initialize(DrawPileTop, DrawPileBottom, DiscardSpot);
		}
	}
	
}

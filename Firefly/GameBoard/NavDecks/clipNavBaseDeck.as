package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	import Cards.NavCard;
	
	public class clipNavBaseDeck extends clipBaseDeck {
		
		protected virtual function get Current():NavCard 
		{ 
			throw new Error("Implementation Required");
		}
				
		protected override function get DrawPileIsVisible():Boolean
		{
			var card:NavCard = Current;
			return (DrawCount > 0) && 
			       (card == null || !(IsReshuffled && card.IsReshuffle));
		}
		
		public function clipNavBaseDeck()
		{
			super();
		}
	}
	
}

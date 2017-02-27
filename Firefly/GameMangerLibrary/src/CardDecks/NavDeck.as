package CardDecks
{
	import Cards.NavCard;
	import Cards.NavDiscardDeck;

	public class NavDeck
	{
		public var Draw:Vector.<NavCard> = new Vector.<NavCard>();
		private var Discards:Cards.NavDiscardDeck;

		public function Next():NavCard
		{
			if(Draw.length == 0) return null;
			
			var card:NavCard = Draw.pop();
			Discards.Pile.push(card);

			return card;
		}

		public function Shuffle(discardReshuffle:Boolean = false):void
		{
			var deck:Vector.<NavCard> = Draw.concat(Discards.Pile);
			Discards.Clear();
			Draw = new Vector.<NavCard>();
				
			for(var i:int = deck.length - 1; i >= 0; i--)
			{
				var pos:int = Math.random() * i;
				var card:NavCard = deck[pos];
				deck[pos] = deck[i];

				if(card.IsReshuffle && discardReshuffle)
					Discards.Pile.push(card);
				else
					Draw.push(card);
			}
		}
			
		public function Add(card:NavCard):void
		{
			Draw.push(card);
		}

		public function NavDeck(discards:Cards.NavDiscardDeck)
		{
			Discards = discards;
		}

	}
}
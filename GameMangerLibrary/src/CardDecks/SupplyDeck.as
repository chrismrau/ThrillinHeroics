package CardDecks
{
	import Cards.SupplyDiscardDeck;
	import Cards.SupplyCard;

	public class SupplyDeck
	{		
		public var Draw:Vector.<SupplyCard> = new Vector.<SupplyCard>();
		private var Discards:Cards.SupplyDiscardDeck;

		public function Next():SupplyCard
		{
			if(Draw.length == 0) return null;
			
			var card:SupplyCard = Draw.pop();
			Discards.Pile.push(card);

			return card;
		}

		public function Shuffle():void
		{
			var deck:Vector.<SupplyCard> = Draw.concat(Discards.Pile);
			Discards.Clear();
			Draw = new Vector.<SupplyCard>();
				
			for(var i:int = deck.length - 1; i >= 0; i--)
			{
				var pos:int = Math.random() * i;
				var card:SupplyCard = deck[pos];
				deck[pos] = deck[i];

				Draw.push(card);
			}
		}
			
		public function Add(card:SupplyCard):void
		{
			Draw.push(card);
		}

		public function SupplyDeck(discards:Cards.SupplyDiscardDeck)
		{
			Discards = discards;
		}
	}
}
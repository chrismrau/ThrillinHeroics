package CardDecks
{
	import Cards.NavDiscardDecks;
	import Cards.NavCard;
	import Config.GameConfiguration;
	import Config.NavPrototype;

	public class NavDecks
	{
		public var Alliance:NavDeck;
		public var Border:NavDeck;
		public var BlueSun:NavDeck;
		public var Rim:NavDeck;

		private function Shuffle():void
		{
			Alliance.Shuffle(true);
			Border.Shuffle(true);
			BlueSun.Shuffle(true);
			Rim.Shuffle(true);
		}

		public function NavDecks(config:GameConfiguration, discards:Cards.NavDiscardDecks)
		{
			Alliance = new NavDeck(discards.Alliance);
			Border = new NavDeck(discards.Border);
			BlueSun = new NavDeck(discards.BlueSun);
			Rim = new NavDeck(discards.Rim);

			for each(var card:NavPrototype in config.NavCards)
			{
				var i:int = 0;
				for(i = 0; i < card.AllianceCount; ++i)
					Alliance.Add(new NavCard(card));
				for(i = 0; i < card.BorderCount; ++i)
					Border.Add(new NavCard(card));
				for(i = 0; i < card.BlueSunCount; ++i)
					BlueSun.Add(new NavCard(card));
				for(i = 0; i < card.RimCount; ++i)
					Rim.Add(new NavCard(card));
			}
			
			Shuffle();
		}
	}
}
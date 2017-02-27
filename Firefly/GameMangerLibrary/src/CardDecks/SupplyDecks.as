package CardDecks
{
	import Cards.SupplyCard;
	import Cards.SupplyDiscardDecks;
	
	import Config.GameConfiguration;
	import Config.SupplyConfiguration;
	
	import Supplies.PlanetType;

	public class SupplyDecks
	{
		public var SpaceBazaar:SupplyDeck;
		public var Persephone:SupplyDeck;
		public var Osiris:SupplyDeck;
		public var Regina:SupplyDeck;
		public var Silverhold:SupplyDeck;
		public var Meridian:SupplyDeck;
		
		private var Decks:Vector.<SupplyDeck> = new Vector.<SupplyDeck>();

		private function Shuffle():void
		{
			for each(var d:SupplyDeck in Decks)
				d.Shuffle();
		}

		public function SupplyDecks(config:GameConfiguration, discards:Cards.SupplyDiscardDecks)
		{
			SpaceBazaar = new SupplyDeck(discards.SpaceBazaar);
			Persephone = new SupplyDeck(discards.Persephone);
			Osiris = new SupplyDeck(discards.Osiris);
			Regina = new SupplyDeck(discards.Regina);
			Silverhold = new SupplyDeck(discards.Silverhold);
			Meridian = new SupplyDeck(discards.Meridian);
			
			Decks.push(SpaceBazaar, Persephone, Osiris, Regina, Silverhold, Meridian);
			
			for each(var supply:SupplyConfiguration in config.SupplyCards)
			{
				var i:int = 0;
				for(i = 0; i < supply.Locations[PlanetType.SPACE_BAZAAR]; ++i)
					SpaceBazaar.Add(new SupplyCard(supply, PlanetType.SPACE_BAZAAR));
				for(i = 0; i < supply.Locations[PlanetType.PERSEPHONE]; ++i)
					Persephone.Add(new SupplyCard(supply, PlanetType.PERSEPHONE));
				for(i = 0; i < supply.Locations[PlanetType.OSIRIS]; ++i)
					Osiris.Add(new SupplyCard(supply, PlanetType.OSIRIS));
				for(i = 0; i < supply.Locations[PlanetType.REGINA]; ++i)
					Regina.Add(new SupplyCard(supply, PlanetType.REGINA));
				for(i = 0; i < supply.Locations[PlanetType.SILVERHOLD]; ++i)
					Silverhold.Add(new SupplyCard(supply, PlanetType.SILVERHOLD));
				for(i = 0; i < supply.Locations[PlanetType.MERIDIAN]; ++i)
					Meridian.Add(new SupplyCard(supply, PlanetType.MERIDIAN));
			}
			
			Shuffle();
		}
	}
}
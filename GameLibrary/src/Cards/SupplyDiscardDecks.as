package Cards
{
	import flash.net.registerClassAlias;

	public class SupplyDiscardDecks
	{
		public var Persephone:SupplyDiscardDeck = new SupplyDiscardDeck();
		public var Osiris:SupplyDiscardDeck = new SupplyDiscardDeck();
		public var Regina:SupplyDiscardDeck = new SupplyDiscardDeck();
		public var SpaceBazaar:SupplyDiscardDeck = new SupplyDiscardDeck();
		public var Silverhold:SupplyDiscardDeck = new SupplyDiscardDeck();
		public var Meridian:SupplyDiscardDeck = new SupplyDiscardDeck();
		
		public static function RegisterAliases():void
		{
			SupplyDiscardDeck.RegisterAliases();
			
			registerClassAlias("SupplyDiscardDecksAlias", SupplyDiscardDecks);
		}

		public function SupplyDiscardDecks()
		{
		}
	}
}
package Cards
{
	import flash.net.registerClassAlias;

	public class DiscardDecks
	{
		public var Nav:NavDiscardDecks = new NavDiscardDecks();
		public var Supplies:SupplyDiscardDecks = new SupplyDiscardDecks();
		
		public static function RegisterAliases():void
		{
			NavDiscardDecks.RegisterAliases();
			SupplyDiscardDecks.RegisterAliases();
			
			registerClassAlias("DiscardDecksAlias", DiscardDecks);
		}

		public function DiscardDecks()
		{
		}
	}
}
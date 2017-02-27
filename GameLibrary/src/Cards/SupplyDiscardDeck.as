package Cards
{
	import flash.net.registerClassAlias;
	
	public class SupplyDiscardDeck
	{
		public var Pile:Vector.<SupplyCard> = new Vector.<SupplyCard>();

		public static function RegisterAliases():void
		{
			SupplyCard.RegisterAliases();
			registerClassAlias("SupplyDiscardsAlias", Vector.<SupplyCard> as Class);
			
			registerClassAlias("SupplyDiscardDeckAlias", SupplyDiscardDeck);
		}

		public function get Count():int { return Pile.length; }

		public function get Last():SupplyCard
		{
			if(0 == Count) return null;
			return Pile[Count-1];
		}
		
		public function Clear():void
		{
			Pile = new Vector.<SupplyCard>();
		}

		public function SupplyDiscardDeck()
		{
		}
	}
}
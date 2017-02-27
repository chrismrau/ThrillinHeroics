package Cards
{
	import flash.net.registerClassAlias;

	public class NavDiscardDeck
	{
		public var Pile:Vector.<NavCard> = new Vector.<NavCard>();
		
		public static function RegisterAliases():void
		{
			NavCard.RegisterAliases();
			registerClassAlias("NavDiscardsAlias", Vector.<NavCard> as Class);
			
			registerClassAlias("NavDiscardDeckAlias", NavDiscardDeck);
		}

		public function get Count():int
		{
			return Pile.length;
		}

		public function get Last():NavCard
		{
			if(0 == Count) return null;
			return Pile[Count-1];
		}
		
		public function Clear():void
		{
			Pile = new Vector.<NavCard>();
		}

		public function NavDiscardDeck()
		{
		}
	}
}
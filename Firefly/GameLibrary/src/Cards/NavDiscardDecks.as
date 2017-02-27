package Cards
{
	import flash.net.registerClassAlias;

	public class NavDiscardDecks
	{
		public var Alliance:NavDiscardDeck = new NavDiscardDeck();
		public var Border:NavDiscardDeck = new NavDiscardDeck();
		public var BlueSun:NavDiscardDeck = new NavDiscardDeck();
		public var Rim:NavDiscardDeck = new NavDiscardDeck();
		
		public static function RegisterAliases():void
		{
			NavDiscardDeck.RegisterAliases();
			
			registerClassAlias("NavDiscardDecksAlias", NavDiscardDecks);
		}

		public function NavDiscardDecks()
		{
		}
	}
}
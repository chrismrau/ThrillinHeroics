package CardDecks
{
	import Config.GameConfiguration;
	
	import State.GameState;

	public class Decks
	{
		public var Nav:NavDecks;
		public var Supplies:SupplyDecks;

		public function Decks(config:GameConfiguration, state:GameState)
		{
			Nav = new NavDecks(config, state.Discards.Nav);
			Supplies = new SupplyDecks(config, state.Discards.Supplies);
		}

	}
}
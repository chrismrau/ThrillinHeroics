package Actions 
{
	import State.GameState;
	import State.Player;
	
	public class TurnAction extends BaseAction
	{
		private var _player:Player;
		
		private var _options:Vector.<String> = new Vector.<String>();
		
		public override function get Description():String
		{
			return _player.Boat.Name + ": Choose Action.";
		}
			
		public function TurnAction(state:GameState, player:Player)
		{
			super(state);
			
			_player = player;
			CurrentState.CurrentPlayer = _player;

			_options.push("Buy", "Fly", "Work", "Deal");
		}
	}
}
package
{
	import State.GameState;
	import State.Player;

	public interface IServer
	{
		function get Players():Vector.<Player>;
		function get PlayerCount():int;
		function get Status():String;
		
		function StartListening():void;
		function StopListening():void;
		function UpdateState(state:GameState):void;
	}
}
package
{
	import flash.display.DisplayObject;
	import State.GameState;
	
	public interface IConnection
	{
		function MouseClickSector(object:DisplayObject):void;
		function GetState():State.GameState;
	}
}
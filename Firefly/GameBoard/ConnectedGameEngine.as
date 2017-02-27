package  {
	
	import Ships.*;
	import State.*;
	import Cards.*;
	import CardDecks.Decks;
	
	public class ConnectedGameEngine implements IGameEngine
	{
		private var _connection:IConnection;
		
		private function get CurrentState():State.GameState
		{
			return _connection.GetState();
		}
		
		public function get NextMessage():String
		{
			return null;
		}
				
		public function SpaceBazaarNext():void {
			throw new Error("Not Implemented");
		}
		public function get SpaceBazaarDrawCount():int {
			throw new Error("Not Implemented");
		}

		public function PersephoneNext():void {
			throw new Error("Not Implemented");
		}
		public function get PersephoneDrawCount():int {
			throw new Error("Not Implemented");
		}

		public function ReginaNext():void {
			throw new Error("Not Implemented");
		}
		public function get ReginaDrawCount():int {
			throw new Error("Not Implemented");
		}

		public function OsirisNext():void {
			throw new Error("Not Implemented");
		}
		public function get OsirisDrawCount():int {
			throw new Error("Not Implemented");
		}
		
		public function get SilverholdDrawCount():int
		{
			throw new Error("Not Implemented");
		}
		public function SilverholdNext():void	
		{
			throw new Error("Not Implemented");
		}
		
		public function get MeridianDrawCount():int
		{
			throw new Error("Not Implemented");
		}
		public function MeridianNext():void	
		{
			throw new Error("Not Implemented");
		}
		
		public function NavRimNext():void
		{
			throw new Error("Not Implemented");
		}
		public function ShuffleRim():void
		{
			throw new Error("Not Implemented");
		}
		public function get NavRimDrawCount():int
		{
			throw new Error("Not Implemented");
		}		
		
		public function NavBorderNext():void
		{
			throw new Error("Not Implemented");
		}
		public function ShuffleBorder():void
		{
			throw new Error("Not Implemented");
		}
		public function get NavBorderDrawCount():int
		{
			throw new Error("Not Implemented");
		}		
		public function NavAllianceNext():void 
		{
			throw new Error("Not Implemented");
		}
		public function ShuffleAlliance():void
		{
			throw new Error("Not Implemented");
		}
				
		public function get NavAllianceDrawCount():int 
		{		
			return 0; 
		}
		
		public function get Discards():DiscardDecks 
		{
			throw new Error("Not Implemented");
		}
		
		public function get FullBurnLimit():int
		{
			throw new Error("Not Implemented");
		}
		
		public function RollDie():void
		{
			throw new Error("Not Implemented");
		}

		public function TokenCount(name:String):int
		{
			return CurrentState.MapSectors[name].TokenCount;
		}
		
		public function ClearCurrentTokens():void
		{
		}
		
		public function SelectSector(name:String):void
		{
	
		}
		
		public function SelectShip(name:String):Ships.BaseShip
		{
			throw new Error("Not Implemented");
		}
		
		public function get Fleet():Ships.ShipCollection { return CurrentState.Fleet; }
		
		public function get CurrentShip():Ships.BaseShip { return CurrentState.Fleet.Current; }
		
		public function get CurrentPlayer():Player { return CurrentState.CurrentPlayer; }
		
		public function ConnectedGameEngine() {
			// constructor code
		}

	}
	
}

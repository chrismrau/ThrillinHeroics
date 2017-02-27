package  {

	import Cards.DiscardDecks;
	import Ships.BaseShip;
	import Ships.ShipCollection;
	import State.Player;
	
	public interface IGameEngine {

		// Interface methods:
		function SelectSector(name:String):void;
		function SelectShip(name:String):BaseShip;
		function ClearCurrentTokens():void;
		function TokenCount(name:String):int;
		function RollDie():void;

		function get Discards():DiscardDecks;
		
		function NavAllianceNext():void;
		function ShuffleAlliance():void;
		function get NavAllianceDrawCount():int;

		function NavBorderNext():void;
		function ShuffleBorder():void;
		function get NavBorderDrawCount():int;

		function NavRimNext():void;
		function ShuffleRim():void;
		function get NavRimDrawCount():int;
		

		function SilverholdNext():void;	
		function get SilverholdDrawCount():int;

		function MeridianNext():void;	
		function get MeridianDrawCount():int;

		function SpaceBazaarNext():void;	
		function get SpaceBazaarDrawCount():int;

		function PersephoneNext():void;	
		function get PersephoneDrawCount():int;

		function ReginaNext():void;	
		function get ReginaDrawCount():int;

		function OsirisNext():void;	
		function get OsirisDrawCount():int;

		function get Fleet():ShipCollection;
		function get CurrentShip():BaseShip;
		function get CurrentPlayer():Player;
		function get FullBurnLimit():int;

	}
	
}

package
{
	import flash.net.registerClassAlias;
	
	import Ships.FireflyShip;	
	import Supplies.CrewSupply;

	public class GameSetupState
	{
		public var SetupStage:String = SetupStageTypes.INITIALIZING;
		
		public var Fleet:Vector.<FireflyShip> = new Vector.<FireflyShip>();
		public var Leaders:Vector.<CrewSupply> = new Vector.<CrewSupply>();
				
		public static function RegisterAliases():void
		{			
			FireflyShip.RegisterAliases();
			registerClassAlias("ShipsVectorAlias", Vector.<FireflyShip> as Class);
			
			registerClassAlias("GameSetupStateAlias", GameSetupState);
		}
		
		public function Setup():void
		{
		}
		
		public function Play():void
		{
			SetupStage = SetupStageTypes.COMPLETE;
		}
		
		public function GameSetupState()
		{
		}
		
	}
}
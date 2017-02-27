package  {
	
	import flash.display.MovieClip;
	
	
	public class clipSkillsTest extends MovieClip {
			
		public function IsNegotiate():void
		{
			gotoAndStop("Negotiate");
		}
		
		public function IsFight():void
		{
			gotoAndStop("Fight");
		}
		
		public function IsTech():void
		{
			gotoAndStop("Tech");
		}
				
		public function Clear():void
		{
			gotoAndStop("None");
		}
				
		public function clipSkillsTest()
		{
			super();
			Clear();
		}
	}
	
}

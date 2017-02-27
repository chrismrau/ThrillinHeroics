package  {
	
	import flash.display.MovieClip;
	
	
	public class clipSkills extends MovieClip {
		
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
		
		public function clipSkills() 
		{
			super();
			Clear();
		}
	}
	
}

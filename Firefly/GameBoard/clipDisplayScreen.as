package  {
	
	import flash.display.MovieClip;
	
	
	public class clipDisplayScreen extends MovieClip {
		
		private var _textString:String = "";
		
		public function get Text():String
		{
			return _textString;
		}
		public function set Text(value:String):void
		{
			_textString = value;
			MainText.text = value;
			MainText.scrollV = MainText.maxScrollV;
		}
		
		public function AppendLine(value:String):void
		{
			Text = Text.concat('\n', value);
		}
		
		public function Append(value:String):void
		{
			Text = Text.concat(value);
		}

		public function clipDisplayScreen() {
			// constructor code
		}
	}
	
}

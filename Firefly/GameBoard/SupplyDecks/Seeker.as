package  {
	
	import flash.display.MovieClip;
	import Supplies.GearSupply;
	import flash.utils.Dictionary;
	
	public class Seeker {
				
		private static const _punct: RegExp = /[!"#\$%&'\(\)\*\+,\-\.:;<=>\?@\[\\\]\^_`\{\|\}~\s]/gi;

		private static var _counts:Dictionary = new Dictionary();
		
		public static function Show(objectName:String, clip:MovieClip):void
		{
			var normal_name:String = objectName;
			while (_punct.test(normal_name))
				normal_name = normal_name.replace(_punct, "");
			
			var search_name = normal_name;
			var count:int = 1;
			if(objectName in _counts)
			{
				count = _counts[objectName] + 1;
				search_name += "0" + count.toString();
			}
			_counts[objectName] = count;
			
			try
			{
				clip.gotoAndStop(search_name);
			}
			catch(ArgumentError)
			{
				search_name = normal_name;
			}
			
			try
			{
				clip.gotoAndStop(search_name);
			}
			catch(ArgumentError)
			{
				clip.gotoAndStop(1);
			}
			
		}
		
	}
	
}

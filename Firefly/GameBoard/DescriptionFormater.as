package  {
	
	import flash.display.MovieClip;
	import flash.text.engine.*;
	
	public class DescriptionFormater {
		
		private static const OPEN_DELIMITER:String = "[";
		private static const CLOSE_DELIMITER:String = "]";
		private static const FONT:FontDescription = new FontDescription("Arial", FontWeight.BOLD);
		private static const TEXT_FORMAT:ElementFormat = new ElementFormat(FONT, 36);
		
		private static function CreateElement(text:String, start:int):ContentElement
		{
			var end:int = text.indexOf(CLOSE_DELIMITER, start);
			var key:String = text.substr(start + 1, end - start - 1);
			var clip:MovieClip;
			
			var format:ElementFormat = TEXT_FORMAT.clone();
			format.alignmentBaseline = TextBaseline.IDEOGRAPHIC_TOP;
			
			switch(key.toUpperCase())
			{
				case "TECH":
					clip = new clipSkills();
					clip.IsTech();
					break;
				case "TECH#6":
					clip = new clipSkillsTest();
					clip.IsTech();
					break;
				case "NEGOTIATE":
					clip = new clipSkills();
					clip.IsNegotiate();
					break;
				case "NEGOTIATE#6":
					clip = new clipSkillsTest();
					clip.IsNegotiate();
					break;
				case "FIGHT":
					clip = new clipSkills();
					clip.IsFight();
					break;
				case "FIGHT#6":
					clip = new clipSkillsTest();
					clip.IsFight();
					break;
				
				case "SHOWDOWN":
					clip = new clipTextShowdown();
					format.alignmentBaseline = TextBaseline.USE_DOMINANT_BASELINE;
					break;
				case "SHOWDOWNS":
					clip = new clipTextShowdown();
					clip.gotoAndStop("Plural");
					format.alignmentBaseline = TextBaseline.USE_DOMINANT_BASELINE;
					break;
				case "SALVAGE OP":
					clip = new clipTextSalvageOp();
					format.alignmentBaseline = TextBaseline.USE_DOMINANT_BASELINE;
					break;
				default:
					clip = new MovieClip();
					break;
			}

			clip.scaleX = 50/clip.height;
			clip.scaleY = 50/clip.height;
			return new GraphicElement(clip, clip.width+10, 15, format);
		}
		
		private static function ParseElement(description:String, color:uint, result:Vector.<ContentElement>):void
		{
			var format:ElementFormat = TEXT_FORMAT.clone();
			format.color = color;
			var text:String = null;
			
			for(var i:int = 0; i < description.length; ++i)
			{
				if(description.charAt(i) == OPEN_DELIMITER)
				{
					if(text != null) result.push(new TextElement(text, format));
					text = null;
					result.push(CreateElement(description, i));
					i = description.indexOf(CLOSE_DELIMITER, i);
				}
				else //Just text
				{
					if(null == text) text = new String();
					text = text.concat(description.charAt(i));
				}
			}
			if(null != text) result.push(new TextElement(text, format));
		}
		
		private static function ParseElements(description:String, color:uint):Vector.<ContentElement>
		{		
			var result:Vector.<ContentElement> = new Vector.<ContentElement>();
			var format:ElementFormat = TEXT_FORMAT.clone();
			format.color = color;
			
			var choices:Array = description.split("-OR-");
			var i:int = 0;
			for(; i < choices.length - 1; ++i)
			{
				ParseElement(choices[i], color, result);
				result.push(new TextElement("\n--- OR ---\n", format));
			}
			ParseElement(choices[i], color, result);
			
			return result;
		}
		
		public static function CreateLines(description:String, width:Number, color:uint = 0):Vector.<TextLine>
		{
			var result:Vector.<TextLine> = new Vector.<TextLine>();
			var content:Vector.<ContentElement> = ParseElements(description, color);			
			var group:GroupElement = new GroupElement(content);
			var block:TextBlock = new TextBlock(group);
			
			var line:TextLine = block.createTextLine(null, width);
			while(null != line)
			{
				result.push(line);
				line = block.createTextLine(line, width);
			}
			
			return result;
		}
	}
	
}

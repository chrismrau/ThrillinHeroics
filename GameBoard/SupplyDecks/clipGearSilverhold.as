package  {
	
	import flash.text.engine.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import Supplies.GearSupply;
	import Supplies.SkillSupply;
	import Supplies.KeywordSupply;
	
	public class clipGearSilverhold extends MovieClip {
		
		public var SkillRows:Vector.<Vector.<clipSkills>> = new Vector.<Vector.<clipSkills>> ();
		public var Keywords:Vector.<TextField> = new Vector.<TextField>();
		
		protected function FormatDescription(description:String):void
		{
			var font:FontDescription = new FontDescription("Arial Bold", "bold");
			var textFormat:ElementFormat = new ElementFormat(font, 36);
			
			var text:TextElement = new TextElement("Hello ", textFormat);
			var fight:clipSkills = new clipSkills();
			fight.IsFight();
			var graphic_format:ElementFormat = new ElementFormat(null, 10);
			var graphic:GraphicElement = new GraphicElement(fight, 10, 10, graphic_format);
			
			var content:Vector.<ContentElement> = new Vector.<ContentElement>()
			content.push(text);
			content.push(graphic);			
			var group:GroupElement = new GroupElement(content);
			
			var block:TextBlock = new TextBlock(group);
			var line:TextLine = block.createTextLine();
			line.x = Description.x;
			line.y = Description.y;
			addChild(line);
		}
		
		protected function SetupSkills(proto:SkillSupply): void
		{
			var i: int = 0;
			var r: int = 0;
			var row: Vector.<clipSkills>;

			if (proto.Fight > 0)
			{
				row = SkillRows[r++];
				for (i = 0; i < proto.Fight; ++i)
					row[i].IsFight();
				for (; i < row.length; ++i) row[i].Clear();
			}

			if (proto.Tech > 0)
			{
				row = SkillRows[r++];
				for (i = 0; i < proto.Tech; ++i)
					row[i].IsTech();
				for (; i < row.length; ++i) row[i].Clear();
			}

			if (proto.Negotiate > 0)
			{
				row = SkillRows[r++];
				for (i = 0; i < proto.Negotiate; ++i)
					row[i].IsNegotiate();
				for (; i < row.length; ++i) row[i].Clear();
			}

			for (; r < SkillRows.length; ++r)
			{
				row = SkillRows[r];
				for (i = 0; i < row.length; ++i)
				{
					row[i].Clear();
				}
			}
		}
		
		protected function SetupKeywords(proto:KeywordSupply): void
		{
			if (proto.Keywords.length > 0)
				Keywords[0].text = proto.Keywords[0];
			else
				Keywords[0].text = "";

			if (proto.Keywords.length > 1)
				Keywords[1].text = proto.Keywords[1];
			else
				Keywords[1].text = "";
		}

		public function Initialize(proto:GearSupply):void
		{			
			Name.text = proto.Name;
			Description.text = "";
			FormatDescription(null);
			Cost.text = proto.Cost.toString();
						
			var row1:Vector.<clipSkills> = new Vector.<clipSkills>();
			row1.push(Skill01);
			row1.push(Skill02);
			row1.push(Skill03);
			SkillRows.push(row1);
			
			var row2:Vector.<clipSkills> = new Vector.<clipSkills>();
			row2.push(Skill04);
			row2.push(Skill05);
			SkillRows.push(row2);
			
			SetupSkills(proto);
			
			Keywords.push(Keyword01);
			Keywords.push(Keyword02);
			SetupKeywords(proto);
		}
				
		public function clipGearSilverhold(proto:GearSupply)
		{			
			super();
			
			Initialize(proto);
		}
		
	}
	
}

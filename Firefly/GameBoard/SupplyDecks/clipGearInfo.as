package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.engine.*;
	import flash.text.FontType;
	import flash.text.FontStyle;

	import Supplies.BaseSupply;
	import Supplies.GearSupply;
	import Supplies.SkillSupply;
	import Supplies.KeywordSupply;

	public class clipGearInfo extends MovieClip
	{
		private var _keywordCount:int = 0;
		protected function SetupKeywords(proto:KeywordSupply): void
		{
			var keywords:Vector.<TextField> = new Vector.<TextField>();
			keywords.push(Keyword01, Keyword02);
			_keywordCount = proto.Keywords.length;
			var i:int = 0;
			for(; i < _keywordCount; ++i)
				keywords[i].text = proto.Keywords[i].toLocaleUpperCase();
			
			for(; i < keywords.length; ++i)
				keywords[i].text = "";
		}
		
		private var _skillsRowCount = 0;
		protected function SetupSkills(proto: SkillSupply): void
		{
			var i:int = 0;
			var c:int = 0;
			var r:int = 0;
			
			var row1:Vector.<clipSkills> = new Vector.<clipSkills>();
			row1.push(Skill01, Skill02, Skill03);
			var row2:Vector.<clipSkills> = new Vector.<clipSkills>();
			row2.push(Skill04, Skill05);
			var rows:Vector.<Vector.<clipSkills>> = new Vector.<Vector.<clipSkills>>();
			rows.push(row1, row2);
			var row:Vector.<clipSkills> = rows[r];

			if (proto.Fight > 0)
			{	
				for (i = 0;i < proto.Fight; ++i)
					row[c++].IsFight();
				
				if(c > 1)
				{
					for (; c < row.length; ++c) row[c].Clear();
					row = rows[++r];
					c = 0;
				}
			}

			if (proto.Tech > 0)
			{
				for (i = 0; i < proto.Tech; ++i)
					row[c++].IsTech();
				
				if(c > 1)
				{
					for (; c < row.length; ++c) row[c].Clear();
					if(r + 1 < rows.length)
					{
						row = rows[++r];
						c = 0;
					}
				}
			}

			if (proto.Negotiate > 0)
			{
				for (i = 0; i < proto.Negotiate; ++i)
					row[c++].IsNegotiate();
				
				for (; c < row.length; ++c) row[c].Clear();
				if(r + 1 < rows.length)
				{
					row = rows[++r];
					c = 0;
				}
			}

			_skillsRowCount = r;
			if(c > 0) ++_skillsRowCount;
			
			for (; r < rows.length; ++r)
			{
				for (; c < row.length; ++c)	row[c].Clear();
			}
		}
				
		private var _top:int = 700;
		private const LINE_SPACE:int = 5;
		private function FormatDescription(description:String):void
		{
			var lines:Vector.<TextLine> =
				DescriptionFormater.CreateLines(description, Name.width);
			
			var left = Skill01.x;
			var top = _top + LINE_SPACE;
			for each(var line:TextLine in lines)
			{
				line.x = left;
				line.y = top + line.height;
				addChild(line);
				
				top += line.height + LINE_SPACE;
			}
		}
		
		public function clipGearInfo()
		{
			super();
		}
		
		private function Layout():void
		{
			if(Name.numLines > 1)
			{
				ExtendedBackground.visible = true;
				Skill01.y = Skill02.y = Skill03.y = Keyword01.y =
					(ExtendedBackground.y + ExtendedBackground.height);
				Skill04.y = Skill05.y = (Skill01.y + Skill01.height);
				Keyword02.y = Keyword01.y + Keyword01.height;
			}
			else
			{
				ExtendedBackground.visible = false;
			}
			
			if(_skillsRowCount > 1)
				_top = Skill04.y + Skill04.height;
			else if(_keywordCount > 1)
				_top = Keyword02.y + Keyword02.height;
			else if(_skillsRowCount > 0)
				_top = Skill01.y + Skill01.height;
			else if(_keywordCount > 0)
				_top = Keyword01.y + Keyword01.height;
			else
				_top = Skill01.y;
		}
		
		public function Initialize(proto:GearSupply):void
		{			
			Name.text = proto.Name;			
			Cost.text = proto.Cost.toString();
								
			SetupSkills(proto);
			SetupKeywords(proto);
			
			Layout();
			FormatDescription(proto.Description);
		}

	}

}
package  {
	
	import flash.display.MovieClip;
	import flash.text.engine.*;
	
	import Supplies.CrewSupply;
	import Supplies.SkillSupply;

	public class clipCrewBase extends MovieClip {
		
		private function InitProfessions():void
		{
			if(Prototype.Professions.length > 0)
			{
				Profession01.visible = true;
				Profession01.NameText.text = Prototype.Professions[0];
				if(Prototype.Professions.length > 1)
				{
					Profession02.visible = true;
					Profession02.NameText.text = Prototype.Professions[1];
				}
				else
				{
					Profession02.visible = false;
				}
			}
			else
			{
				Profession01.visible = false;
				Profession02.visible = false;
			}
		}

		private function InitSkills()
		{
			var skills:Vector.<clipSkills> = new Vector.<clipSkills>();
			skills.push(Skill01, Skill02, Skill03);
			var i:int = 0;
			
			for(; i < Prototype.Fight; ++i)
				skills[i].IsFight();
			for(; i < Prototype.Tech; ++i)
				skills[i].IsTech();
			for(; i < Prototype.Negotiate; ++i)
				skills[i].IsNegotiate();
			for(; i < 3; ++i)
				skills[i].Clear();
		}
		
		private var _top:int;
		private const LINE_SPACE:int = 5;
		private function FormatDescription():void
		{
			var description:String = Prototype.Description;
			var lines:Vector.<TextLine> =
				DescriptionFormater.CreateLines(description, Keyword01.width, 0xFFFFFF);
			
			var left = Keyword01.x;
			var top = _top;
			for each(var line:TextLine in lines)
			{
				line.x = left;
				line.y = top + line.height;
				addChild(line);
				
				top += line.height + LINE_SPACE;
			}
		}
		
		private function InitKeywords()
		{
			var words:Vector.<String> = Prototype.Keywords;
			_top = Title.y + Title.height;
			if(words.length > 0)
			{
				Keyword01.text = words[0];
				_top = Keyword01.y + Keyword01.height;
			}
			else
			{
				Keyword01.text = "";
			}
			if(words.length > 1)
			{
				Keyword02.text = words[1];
				_top = Keyword02.y + Keyword02.height;
			}
			else
			{
				Keyword02.text = "";
			}
		}		
		
		public function set Selected(on:Boolean):void
		{
			Highlight.visible = on;
		}
		
		public function get BaseHeight():Number 
		{
			return Highlight.height * scaleY;
		}
		public function set BaseHeight(h:Number):void
		{
			var s:Number = h/Highlight.height;
			scaleX = s;
			scaleY = s;
		}
		
		private var _proto:CrewSupply = null;
		public function get Prototype():CrewSupply
		{
			return _proto;
		}
		public function set Prototype(proto:CrewSupply):void
		{
			_proto = proto;
			
			Name.text = _proto.Name;
			Cost.text = _proto.Cost.toString();			
			Morality.visible = _proto.IsMoral;
			Title.text = _proto.Title;
			WarrantSymbol.visible = _proto.IsWanted;
			
			InitProfessions();
			InitSkills();
			InitKeywords();
			
			FormatDescription();
			
			Seeker.Show(_proto.Name, Picture);
		}
		
		public function clipCrewBase()
		{
			super();
			
			Gear01.visible = false;
			Gear02.visible = false;
			Gear03.visible = false;
			
			Selected = false;
		}
	}
	
}

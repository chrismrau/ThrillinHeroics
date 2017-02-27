package Config
{
	import flash.utils.Dictionary;

	public class SupplyConfiguration extends BaseConfiguration
	{
		private var _source:String = SourceTypes.BASE_GAME;
		public function get Source():String { return _source; }
		
		private var _cost:int = 0;
		public function get Cost():int { return _cost; }
		
		private var _type:String = SupplyType.GEAR;
		public function get Type():String { return _type; }
		
		private var _title:String = "";
		public function get Title():String { return _title; }
		
		private var _description:String = "";
		public function get Description():String { return _description; }
		
		private var _spec:String = "";
		public function get Spec():String { return _spec; }
		
		private var _fight:int = 0;
		public function get Fight():int { return _fight; }
		
		private var _tech:int = 0;
		public function get Tech():int { return _tech; }
		
		private var _negotiate:int = 0;
		public function get Negotiate():int { return _negotiate; }
		
		private var _isMoral:Boolean;
		public function get IsMoral():Boolean { return _isMoral; }
		
		private var _wantedCount:int;
		public function get WantedCount():int { return _wantedCount; }
		
		private var _professions:Vector.<String> = new Vector.<String>();
		public function get Profession():Vector.<String> { return _professions; }
		
		private var _keywords:Vector.<String> = new Vector.<String>();
		public function get Keywords():Vector.<String> { return _keywords; }
		
		public var _mustDispose:Boolean = false;
		public function get MustDispose():Boolean { return _mustDispose; }
		
		private var _locations:Dictionary = new Dictionary();
		public function get Locations():Dictionary { return _locations; }
		
		private const NUMBERS:RegExp = /\d+/;
		private function SetupSkill(skill:String):int
		{
			var result:int = 0;
			
			var value:String = Fields[skill];
			if(value.search("D") > -1)
				_mustDispose = true;
			
			var numbers:Array = value.match(NUMBERS);
			if(numbers != null && numbers.length > 0)
			{
				result = int(numbers[0]);
			}
			
			return result;
		}

		private function SetupSkills():void
		{
			_fight = SetupSkill("Fight");
			_tech = SetupSkill("Tech");
			_negotiate = SetupSkill("Negotiate");
			
			trace(Name + ": F: " + Fight + " T: " + Tech + " N: " + Negotiate + " D: " + MustDispose);
		}
		
		private function SetupWanted(count:String):int
		{
			var result:int = 0;
			var numbers:Array = count.match(NUMBERS);
			if(numbers != null && numbers.length > 0)
			{
				result = int(numbers[0]);
			}
			
			return result;
		}

		private function SetupLocations():void
		{
			for each(var loc:BaseConfiguration in DB.Planets)
			{
				var name:String = loc.Name;
				var value:String = Fields[name];
				if(value.length > 0)
				{
					var count:int = int(value);
					Locations[name] = count;
				}
			}
		}
			
		private function SetupProfession(name:String):void
		{
			var value:String = Fields[name];
			if(value.length > 0)
				_professions.push(name);
		}
		private function SetupProfessions():void
		{
			for each(var p:BaseConfiguration in DB.Professions)
				SetupProfession(p.Name);
		}

		private function SetupKeyword(name:String):void
		{
			var value:String = Fields[name];
			if(value.length > 0)
				_keywords.push(name);
		}
		private function SetupKeywords():void
		{
			for each(var k:BaseConfiguration in DB.Keywords)
				SetupKeyword(k.Name);
		}

		public function SupplyConfiguration(db:DBConfiguration, rowConfig:XML, row:XML)
		{
			super(db, rowConfig, row);
			if(Name == null || Name.length == 0) return;

			_source = Fields["Source"];	
			_cost = Fields["Cost"];
			_type = Fields["Type"];
			_title = Fields["Title"];
			_description = Fields["Description"];
			_spec = Fields["Spec"];
			
			_isMoral = (Fields["Moral"].length > 0);
			_wantedCount = SetupWanted(Fields["Wanted"]);
			
			SetupLocations();
			SetupSkills();
			SetupProfessions();
			SetupKeywords();
		}

	}
}
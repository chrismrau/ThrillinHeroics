package Cards
{
	import flash.net.registerClassAlias;
	
	import Config.NavPrototype;

	public class NavCard
	{
		public var Name:String;
		
		public var Options:Vector.<String> = new Vector.<String>();
		public var Details:Vector.<String> = new Vector.<String>();
		public var IsReshuffle:Boolean = false;

		public static function RegisterAliases():void
		{
			registerClassAlias("OptionsAlias", Vector.<String> as Class);
			registerClassAlias("DetailsAlias", Vector.<String> as Class);
			
			registerClassAlias("NavCardAlias", NavCard);
		}

		public function get IsCruiser():Boolean
		{
			return (Name.search("Cruiser") > -1);
		}

		public function get IsBigBlack():Boolean
		{
			return Name == ("The Big Black");
		}

		public function NavCard(proto:NavPrototype)
		{
			Name = proto.Name;
			IsReshuffle = proto.IsReshuffle;

			for each(var opt:String in proto.Options)
				Options.push(opt);
			for each(var detail:String in proto.Details)
				Details.push(detail);
				
		}
	}
}
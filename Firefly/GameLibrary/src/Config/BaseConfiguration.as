package Config
{
	import flash.utils.Dictionary;

	public class BaseConfiguration
	{
		private var _db:DBConfiguration;
		protected function get DB():DBConfiguration { return _db; }
		
		private var _name:String = "";
		public function get Name():String { return _name; }
		
		protected var Fields:Dictionary = new Dictionary();
		protected function ReadColumns(rowConfig:XML, row:XML):void
		{
			var col:int = 0;
			
			for(var i:int = 0; i < row.Cell.length(); i++)
			{
				var cell:XML = row.Cell[i];
				if(cell.hasOwnProperty("@Index"))
				{
					var next:int = int(cell.@Index)-1;
					while(col < next)
					{
						var h:String = rowConfig.Cell[col++].Data;
						Fields[h] = "";
					}
				}
				
				var key:String = rowConfig.Cell[col++].Data;
				if(key.length > 0)
				{
					var value:String = cell.Data;
					Fields[key] = value;
				}
			}
			
		}
		
		public function BaseConfiguration(db:DBConfiguration, rowConfig:XML, row:XML)
		{
			_db = db;
			
			ReadColumns(rowConfig, row);
			
			_name = Fields["Name"];
		}

	}
}
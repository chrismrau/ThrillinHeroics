package Config
{
    public class DBConfiguration
    {
        private var _planets:Vector.<BaseConfiguration> = new Vector.<BaseConfiguration>;
        public function get Planets():Vector.<BaseConfiguration> { return _planets; }
		
		private var _professions:Vector.<BaseConfiguration> = new Vector.<BaseConfiguration>;
		public function get Professions():Vector.<BaseConfiguration> { return _professions; }
        
		private var _keywords:Vector.<BaseConfiguration> = new Vector.<BaseConfiguration>;
		public function get Keywords():Vector.<BaseConfiguration> { return _keywords; }
        
        private function SetupPlanets(xml:XMLList):void
        {
            var rows:XMLList = xml.Table.Row;
            for(var i:int = 1; i < rows.length(); i++)
            {
                _planets.push(new BaseConfiguration(null, rows[0], rows[i]));
			}
        }
			
        private function SetupProfessions(xml:XMLList):void
        {
            var rows:XMLList = xml.Table.Row;
            for(var i:int = 1; i < rows.length(); i++)
            {
                _professions.push(new BaseConfiguration(null, rows[0], rows[i]));
			}
        }

        private function SetupKeywords(xml:XMLList):void
        {
            var rows:XMLList = xml.Table.Row;
            for(var i:int = 1; i < rows.length(); i++)
            {
                _keywords.push(new BaseConfiguration(null, rows[0], rows[i]));
			}
        }

        public function DBConfiguration(xml:XML)
        {
            var xml_list:XMLList = xml.Worksheet.(@Name == "Planets");
			SetupPlanets(xml_list);
            xml_list = xml.Worksheet.(@Name == "Professions");
			SetupProfessions(xml_list);
            xml_list = xml.Worksheet.(@Name == "Keywords");
			SetupKeywords(xml_list);
        }
    }
}
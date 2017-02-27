package  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;	
	
	import Map.SectorNames;
	import Ships.*;
	
	public class SetupHelper {
		
		public static const TOKEN_CONAINER_NAME:String = "TokenContainer";
		
		private static var _offset:int = 0;
		private static function AddShip(doc:GameBoard, piece:MovieClip, ship:Ships.BaseShip):void
		{
			piece.name = ship.Name;
			piece.addEventListener(MouseEvent.CLICK, doc.fl_MouseClickHandler_Ship);
			doc.Ship2Sprite[ship] = piece;
			doc.Sprite2Ship[piece] = ship;
			doc.addChild(piece);
			
			if(ship.Location == null)
			{
				piece.x = _offset;
				_offset += piece.width;
			}
			else
			{
				var sector:DisplayObject = doc.getChildByName(ship.Location.Name);
				var loc = doc.CenterOf(sector);
				piece.x = loc.x - (piece.width / 2.0);
				piece.y = loc.y - (piece.width / 2.0);
			}
		}
			
		private static function AddPlayerShips(doc:GameBoard):void
		{
			var ships:Vector.<Ships.FireflyShip> = doc.GameEngine.Fleet.PlayerShips;
			for(var i:int = 0; i < ships.length; i++)
			{
				var ship:Ships.FireflyShip = ships[i];
				var piece:MovieClip;
				switch(ship.Class)
				{					
					case Ships.ShipClassType.THUNDERBIRD:
						piece = new clipShipInterceptor();
						break;
					
					case Ships.ShipClassType.SALVAGE_SCOW:
						piece = new clipShipSSWalden();
						break;
					
					case Ships.ShipClassType.FIREFLY3:
					default:
						piece = new clipShipFirefly();
						piece.scaleX = 0.80;
						piece.scaleY = 0.80;
						piece.transform.colorTransform = new ColorTransform(1,1,1,1, ship.Red, ship.Green, ship.Blue, 1);
						break;
				}
				
			    piece.addEventListener(MouseEvent.RIGHT_CLICK, doc.ShowStatsWindow);
				ship.Offset = (i - (ships.length / 2)) * 15;
				AddShip(doc, piece, ship);
			}
		}
		
		private static function AddAlliance(doc:GameBoard):void
		{
			var cruiser:MovieClip = new clipPieceAlliance();
			AddShip(doc, cruiser, doc.GameEngine.Fleet.AllianceCruiser);
		}
		
		private static function AddReavers(doc:GameBoard):void
		{
			for each(var ship:Ships.BaseShip in doc.GameEngine.Fleet.ReaverShips)
			{
				var reaver:clipPieceReaver = new clipPieceReaver();
				reaver.ReaverHighlight.visible = false;
				AddShip(doc, reaver, ship);
			}
		}
		
		public static function AddShips(doc:GameBoard):void
		{
			_offset = 0;
			AddAlliance(doc);
			AddReavers(doc);
			AddPlayerShips(doc);
		}
		
		public static function SetupMapSectors(doc:GameBoard):void
		{
			for (var name:String in Map.SectorNames.Sectors)
			{
				var sector:MovieClip = doc.getChildByName(name) as MovieClip;
				
				var sub_names:Array = Map.SectorNames.Sectors[name];
				var adjs:Array = new Array();
				for each(var sub:String in sub_names)
				adjs.push(doc.getChildByName(sub));
			
				sector.addEventListener(MouseEvent.CLICK, doc.fl_MouseClickHandler_Sector);
				
				var container:MovieClip = new MovieClip();
				container.name = TOKEN_CONAINER_NAME;
				container.y = sector.height / 2;
				container.x = sector.width / 4;
				sector.addChild(container);
				
				doc.VerseSectors[sector] = adjs;
			}
					
		}

	}
	
}

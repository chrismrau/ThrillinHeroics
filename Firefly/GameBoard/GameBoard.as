package
{
	import fl.controls.TextArea;
	import fl.controls.Button;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.IGraphicsData;
	import flash.utils.Dictionary;
	import flash.filters.GlowFilter;
	import flash.text.TextField;

	import Config.*;
	import Ships.*;
	import Map.SectorNames;
	import Map.Sector;
	import Cards.NavCard;
	import State.*;

	public class GameBoard extends MovieClip
	{
		public function CenterOf(source: DisplayObject): Point
		{
			var x: int = source.x + (source.width / 2);
			var y: int = source.y + (source.height / 2);

			return new Point(x, y);
		}

		public var GameEngine: IGameEngine;
		public var Ship2Sprite: Dictionary = new Dictionary();
		public var Sprite2Ship: Dictionary = new Dictionary();

		private var _flyX: Tween = null;
		private var _flyY: Tween = null;
		//MovieClip -> DisplayObjects
		public var VerseSectors: Dictionary = new Dictionary();

		private var _cards: CardDeckModule;
		private var _dice: DieModule;
		private var _verseMap: VerseMapModule;

		private function UpdateShipPosition(ship: Ships.BaseShip): Boolean
		{
			if (_flyX != null && _flyX.isPlaying) return false;
			if (_flyY != null && _flyY.isPlaying) return false;
			if (ship == null || ship.Location == null) return false;

			var sector: DisplayObject = getChildByName(ship.Location.Name);
			if (sector == null) return false;

			var dest = CenterOf(sector);
			var piece: MovieClip = Ship2Sprite[ship];
			var p: Point = new Point(
				dest.x + ship.Offset,
				dest.y - ship.Offset);

			if (Math.round(p.x) == Math.round(piece.x) &&
				Math.round(p.y) == Math.round(piece.y))
				return true;

			_flyX = new Tween(piece, "x", Strong.easeInOut, piece.x, p.x, 1, true);
			_flyY = new Tween(piece, "y", Strong.easeInOut, piece.y, p.y, 1, true);
			_flyX.start();
			_flyY.start();

			return false;
		}

		private const TOKEN_CONAINER_NAME: String = "TokenContainer";
		private function UpdateTokens(sector: MovieClip)
		{
			var container: MovieClip = MovieClip(sector.getChildByName(TOKEN_CONAINER_NAME));
			var count: int = GameEngine.TokenCount(sector.name);
			if (container.numChildren == count) return;

			container.removeChildren();
			for (var i: int = 0; i < count; ++i)
			{
				var token: clipReaverToken = new clipReaverToken();
				token.x = i * 8;
				token.y = i * 8;
				container.addChild(token);
			}
		}

		private var _subGlowColor: uint = 0xFFFF00; //Yellow
		private var _subGlowFilter: GlowFilter = new flash.filters.GlowFilter(_subGlowColor, 1.0, 55.0, 55.0, 0.5, 1, true, false);
		private function ShowNavLimit(ship: Ships.BaseShip, loc: Sector, limit: Number): void
		{
			if (limit <= 0) return;

			var sectors:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			for each(var sec: Sector in loc.AdjacentSectors)
			{
				if (ship.CanEnter(sec))
				{
					ShowNavLimit(ship, sec, limit - 1);
					var obj: DisplayObject = getChildByName(sec.Name);
					sectors.push(obj);
				}
			}

			for each(var sector: DisplayObject in sectors)
			sector.filters = [_subGlowFilter];
		}

		private var _glowColor: uint = 0x00FF00; //Green 0xFFFF00; //Yellow
		private var _glowFilter: GlowFilter = new flash.filters.GlowFilter(_glowColor, 1.0, 55.0, 55.0, 1, 1, true, false);
		private function ShowNavLimits(ship: Ships.BaseShip): void
		{
			if (ship == null || ship.Location == null) return;
			var sectors:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			for each(var sec: Sector in ship.NavigableSectors)
			{
				ShowNavLimit(ship, sec, GameEngine.FullBurnLimit - 1);
				var obj: DisplayObject = getChildByName(sec.Name);
				sectors.push(obj);
			}

			for each(var sector: DisplayObject in sectors)
			sector.filters = [_glowFilter];
		}

		private function UpdateSectors(): void
		{
			var current_ship: Ships.BaseShip = GameEngine.CurrentShip;

			if (GameEngine.FullBurnLimit > 0)
				ShowNavLimits(GameEngine.CurrentShip);

			for (var sector: * in VerseSectors)
			{
				UpdateTokens(sector);
			}
		}

		private function UpdateCurrentShip(): void
		{
			var player:Player = GameEngine.CurrentPlayer;
			_dice.DoDiceRollDialog(player);
		}

		private function UpdateReaverShips(): void
		{
			for each(var reaver: Ships.ReaverShip in GameEngine.Fleet.ReaverShips)
			{
				UpdateShipPosition(reaver);
				var sprite: clipPieceReaver = Ship2Sprite[reaver] as clipPieceReaver;
				if (reaver.ShowHighlight)
				{
					sprite.ReaverHighlight.visible = true;
					sprite.ReaverHighlight.play();
				}
				else
				{
					sprite.ReaverHighlight.stop();
					sprite.ReaverHighlight.visible = false;
				}
			}

		}

		private function UpdatePlayerBoats(): void
		{
			for each(var boat: FireflyShip in GameEngine.Fleet.PlayerShips)
			UpdateShipPosition(boat);
		}

		private function UpdateDisplayStateBase(e: Event): void
		{
			UpdatePlayerBoats();
			UpdateSectors();
			UpdateReaverShips();
		}

		private function UpdateGameState(e: Event): void
		{
			UpdateDisplayStateBase(e);
			_cards.UpdateCards();

			var status: String = _statusManager.NextMessage;
			while (null != status)
			{
				StatusDisplay.AppendLine(status);
				status = _statusManager.NextMessage;
			}
		}

		public function fl_MouseClickHandler_Sector(event: MouseEvent): void
		{
			for (var s: * in VerseSectors)
				s.filters = null;

			var sector: DisplayObject = DisplayObject(event.target);
			GameEngine.SelectSector(sector.name);
		}

		public function fl_MouseClickHandler_Ship(event: MouseEvent): void
		{
			for (var s: * in VerseSectors)
				s.filters = null;

			var ship: DisplayObject = event.currentTarget as DisplayObject;
			GameEngine.SelectShip(ship.name);
		}

		private function CloseStatsHandler(event: MouseEvent): void
		{
			if (event.target is clipStatsDialog)
			{
				var dialog: clipStatsDialog = clipStatsDialog(event.target);
				dialog.removeEventListener(MouseEvent.CLICK, CloseStatsHandler);
				this.removeChild(dialog);
			}
		}

		public function ShowStatsWindow(event: MouseEvent): void
		{
			var piece: DisplayObject = DisplayObject(event.target);
			var ship: Ships.FireflyShip = Sprite2Ship[piece];

			var dialog: clipStatsDialog = new clipStatsDialog();
			dialog.textShipName.text = ship.Name;
			dialog.textShipClass.text = ship.Class;
			dialog.textCargoHolds.text = ship.CargoHolds.length.toString();
			dialog.textShashHolds.text = ship.Stashes.length.toString();
			dialog.textUpgrades.text = ship.Upgrades.length.toString();
			dialog.textMaxCrew.text = ship.MaxCrew.toString();
			if (ship.CanUpgradeCore)
				dialog.textCanUpgrade.text = "Yes";
			else
				dialog.textCanUpgrade.text = "No";
			dialog.textSpecial.text = ship.SpecialRules;

			dialog.x = piece.x;
			dialog.y = piece.y + piece.height;
			dialog.addEventListener(MouseEvent.CLICK, CloseStatsHandler);

			addChild(dialog);
		}

		public var Configuration: GameConfiguration;

		public function StartNetGame(): void
		{
			MovieClip(this.root).gotoAndPlay(1, "Main");
			GameEngine = new ConnectedGameEngine();

			SetupHelper.SetupMapSectors(this);
			SetupHelper.AddShips(this);

			_dice = new DieModule(this);
			_cards = new CardDeckModule(this);
			_verseMap = new VerseMapModule(this);

			addEventListener(Event.ENTER_FRAME, UpdateGameState);
		}

		private var _statusManager: StatusManager = new StatusManager();

		private function LocalFlight(event: MouseEvent): void
		{
			MovieClip(this.root).gotoAndPlay(1, "Main");
			GameEngine = new LocalFlightEngine(Configuration, _statusManager);

			SetupHelper.SetupMapSectors(this);
			SetupHelper.AddShips(this);

			_dice = new DieModule(this);
			_cards = new CardDeckModule(this);
			_verseMap = new VerseMapModule(this);

			addEventListener(Event.ENTER_FRAME, UpdateGameState);
		}
		private function ConfigureLocalGame(config: GameConfiguration): void
		{
			Configuration = config;
			gotoAndStop("SetupLocal", "Setup");
		}
		public function PlayLocal()
		{
			GameLoader.LoadNewGame(ConfigureLocalGame);
		}

		private function FreeFlight(event: MouseEvent): void
		{
			MovieClip(this.root).gotoAndPlay(1, "Main");

			Configuration.SelectAllBoats();
			GameEngine = new FreeFlightEngine(Configuration, _statusManager);

			SetupHelper.SetupMapSectors(this);
			SetupHelper.AddShips(this);

			_dice = new DieModule(this);
			_verseMap = new VerseMapModule(this);

			SuppliesRegina.visible = false;
			SuppliesOsiris.visible = false;
			SuppliesPersephone.visible = false;
			SuppliesSpaceBazaar.visible = false;
			SuppliesMeridian.visible = false;
			SuppliesSilverhold.visible = false;

			NavAlliance.visible = false;
			NavBorder.visible = false;
			NavRim.visible = false;

			addEventListener(Event.ENTER_FRAME, UpdateDisplayStateBase);
		}
		private function ConfigureFreeFlight(config: GameConfiguration): void
		{
			Configuration = config;
			gotoAndStop("SetupFree", "Setup");
		}
		public function PlayFree()
		{
			GameLoader.LoadNewGame(ConfigureFreeFlight);
		}

		public function GameBoard()
		{}

	}
}
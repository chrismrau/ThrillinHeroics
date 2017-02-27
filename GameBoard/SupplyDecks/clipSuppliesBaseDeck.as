package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import Cards.SupplyCard;
	import Supplies.*;
	
	public class clipSuppliesBaseDeck extends clipBaseDeck {
		
		protected virtual function get Current():SupplyCard 
		{ 
			throw new Error("Implementation Required");
		}
		
		protected virtual function get Pile():Vector.<SupplyCard>
		{ 
			throw new Error("Implementation Required");
		}
		
		private var DiscardSpot:MovieClip;
		private var Discards:Vector.<MovieClip> = new Vector.<MovieClip>();		
				
		protected function ToggleDiscard(event:MouseEvent):void
		{
			var card:DisplayObject = event.currentTarget as DisplayObject;
			if(card.width < BIG_WIDTH) //is small
			{
				card.width = BIG_WIDTH;
				card.height = BIG_HEIGHT;
				setChildIndex(card, getChildIndex(DrawPile)-1);
			}
			else
			{
				card.width = SMALL_WIDTH;
				card.height = SMALL_HEIGHT;
			}
		}
				
		private var _isExpanded = false;
		protected function ShowDiscards(event:MouseEvent):void
		{
			_isExpanded = true;
		}
		protected function HideDiscards(event:MouseEvent):void
		{
			_isExpanded = false;
		}

		private function Expand():void
		{			
			var left:Number = DiscardSpot.width;
			var top:Number = DiscardSpot.y;			
			for each(var card:MovieClip in Discards)
			{
				card.x = left;
				card.y = top;
				
				left += card.width;
				if(x + left + card.width > parent.stage.stageWidth)
				{
					left = DiscardSpot.width;
					top += DiscardSpot.height;
				}
				
				var y_offset = parent.stage.stageHeight - y - card.y - card.height;
				if(y_offset < 0) 
					card.y += y_offset;
				
				card.visible = true;
			}
		}
		
		private function Stack():void
		{
			for each(var card:MovieClip in Discards)
				card.visible = false;
			
			if(Discards.length > 0)
			{
				Discards[Discards.length - 1].visible = true;
				Discards[Discards.length - 1].x = DiscardSpot.x;
				Discards[Discards.length - 1].y = DiscardSpot.y;
			}
		}
		
		protected override function DiscardClick(event:MouseEvent):void
		{
			if(_isExpanded)
				ToggleDiscard(event);
			else
				ShowDiscards(event);
		}

		private function AddDiscard(clip:MovieClip):void
		{
			clip.width = SMALL_WIDTH;
			clip.height = SMALL_HEIGHT;
			clip.addEventListener(MouseEvent.CLICK, DiscardClick);
			addChild(clip);
			setChildIndex(clip, getChildIndex(DrawPile));
			Discards.push(clip);
		}

		private function CreateGearSupply(proto:GearSupply):MovieClip
		{
			var card:clipGearCard = new clipGearCard();
			card.Configure(proto);
			
			return card;
		}
		
		protected override function DrawNextCard():void
		{
			var card:SupplyCard = Current;
			var clip:MovieClip;
			
			if(card.IsCrew)
			{
				var crew:clipCrewBase = new clipCrewBase();
				crew.Prototype = card.Prototype as CrewSupply;
				clip = crew;
			}
			else if(card.IsShipUpgrade)
			{
				clip = new clipShipUpgradeBase();
				clip.Initialize(card.Prototype as ShipUpgradeSupply);
			}
			else if(card.IsDriveCore)
			{
				clip = new clipDriveCoreCard();
				clip.Configure(card.Prototype as ShipDriveCore);
			}
			else
			{
				clip = CreateGearSupply(card.Prototype as GearSupply);
			}
			
			AddDiscard(clip);
		}
		
		public override function Update():void
		{
			super.Update();
			
			if(_isExpanded)	Expand();
			else Stack();
		}
		
		protected override function get DrawPileIsVisible():Boolean
		{
			return (DrawCount > 0);
		}

		protected override function Initialize(drawTop:MovieClip, drawBottom:MovieClip, discard:MovieClip):void
		{
			super.Initialize(drawTop, drawBottom, discard);
			
			DiscardSpot = discard;
			DiscardSpot.addEventListener(MouseEvent.CLICK, HideDiscards);
		}
		
		public function clipSuppliesBaseDeck() 
		{
			super();
		}
		
	}
	
}

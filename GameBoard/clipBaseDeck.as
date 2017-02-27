package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class clipBaseDeck extends MovieClip {
		
		private var _isSmall:Boolean = true;
		protected function get IsSmall():Boolean { return _isSmall; }
		protected var DiscardPile:Vector.<MovieClip> = new Vector.<MovieClip>();

		protected virtual function get DrawCount():int 
		{ 
			throw new Error("Implementation Required");
		}		
		
		protected virtual function get DrawPileIsVisible():Boolean
		{
			return true;
		}
		
		public virtual function Update():void
		{
			ShowDrawPile(DrawPileIsVisible);
			for each(var dis:MovieClip in DiscardPile)
				dis.visible = false;
		}
		
		protected virtual function Reshuffle(event:MouseEvent):void
		{
			_isReshuffled = true;
		}
		
		protected virtual function DrawNextCard():void
		{
			throw new Error("Implementation Required");
		}
		
		protected const SMALL_WIDTH:int = 150;
		protected const SMALL_HEIGHT:int = 212;
		protected function ShrinkDiscards():void
		{
			for each(var dis:MovieClip in DiscardPile)
			{
				dis.width = SMALL_WIDTH;
				dis.height = SMALL_HEIGHT;
			}
			_isSmall = true;
		}
		
		protected const BIG_WIDTH:int = 600;
		protected const BIG_HEIGHT:int = 850;
		protected function GrowDiscards():void
		{
			for each(var dis:MovieClip in DiscardPile)
			{
				dis.width = BIG_WIDTH;
				dis.height = BIG_HEIGHT;
			}
			_isSmall = false;
		}
		
		protected virtual function DiscardClick(event:MouseEvent):void
		{
			if(_isSmall)
				GrowDiscards();
			else
				ShrinkDiscards();
		}
		
		protected function get Engine():IGameEngine
		{
			return (parent as GameBoard).GameEngine;
		}
		
		protected function FormatDetails(details:String):String
		{
			var result:String = "";
			var lines:Array = details.split("--");
			
			for each(var line:String in lines)
			{
				if(line.length > 0)
					result = result.concat("-- ", line, '\n');
			}
			
			return result;
		}
		
		private var _isReshuffled:Boolean = false;
		protected function get IsReshuffled():Boolean { return _isReshuffled; }
		
		protected var DrawPile:MovieClip;
		private var _drawPileBottom:MovieClip;
		private function ShowDrawPile(show:Boolean):void
		{
			DrawPile.visible = show;
			_drawPileBottom.visible = show;
		}

		private function Draw(event:Event):void
		{
			var mc:MovieClip = event.currentTarget as MovieClip;
			if(mc.currentFrame == mc.totalFrames)
			{
				DrawNextCard();
			}
		}
		
		protected function DrawFlip(event:MouseEvent):void
		{
			play();
		}
		
		protected virtual function Initialize(drawTop:MovieClip, drawBottom:MovieClip, discard:MovieClip):void
		{			
			DrawPile = drawTop;
			_drawPileBottom = drawBottom;
			DrawPile.addEventListener(MouseEvent.CLICK, DrawFlip);
			
			for each(var clip:MovieClip in DiscardPile)
				clip.addEventListener(MouseEvent.CLICK, DiscardClick);
			
			addEventListener(Event.ENTER_FRAME, Draw);
		}
		
		public function clipBaseDeck()
		{
			super();
			gotoAndStop(1);
		}
		
	}
	
}

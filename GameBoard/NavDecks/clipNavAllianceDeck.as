package  {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	import Cards.NavCard;
	
	public class clipNavAllianceDeck extends clipNavBaseDeck {
		
		protected override function get Current():NavCard 
		{ 
			return Engine.Discards.Nav.Alliance.Last;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.NavRimDrawCount;
		}
		
		public override function Update():void
		{
			super.Update();
			var card:NavCard = Current; //Engine.Discards.Nav.Alliance.Last;
			if(card == null) return;
			
			DrawPileTop.visible = (Engine.NavAllianceDrawCount > 0);
			DrawPileBottom.visible = (Engine.NavAllianceDrawCount > 0);
			
			if(card.IsBigBlack)
			{
				TheBigBlack.visible = true;
			}
			else if(card.IsCruiser)
			{
				Cruiser.visible = true;
				
				Cruiser.NameText.text = card.Name;
				Cruiser.TitleText.text = card.Options[0];
				Cruiser.DetailText.text = FormatDetails(card.Details[0]);

				Cruiser.MoveCruiserText.visible = card.IsReshuffle;
				Cruiser.ReshuffleText.visible = card.IsReshuffle;
			}
			else
			{
				Options.visible = true;				
				Options.CardNameText.text = card.Name;
				Options.Option1Text.text = card.Options[0];
				Options.Detail1Text.text = FormatDetails(card.Details[0]);
				Options.Option2Text.text = card.Options[1];
				Options.Detail2Text.text = FormatDetails(card.Details[1]);
			}
		}

		protected override function Reshuffle(event:MouseEvent):void
		{
			Engine.ShuffleAlliance();
			super.Reshuffle(event);
		}
		
		protected override function DrawNextCard():void
		{
			Engine.NavAllianceNext();
		}
		
		public function clipNavAllianceDeck() 
		{
			super();
			DiscardPile.push(Cruiser);
			DiscardPile.push(TheBigBlack);
			DiscardPile.push(Options);
			
			Initialize(DrawPileTop, DrawPileBottom, null);
			
			ReshuffleText.addEventListener(MouseEvent.CLICK, Reshuffle);
		}
	}
	
}

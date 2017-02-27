package  {

	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	import Cards.NavCard;
	
	public class clipNavRimDeck extends clipNavBaseDeck {
		
		protected override function get Current():NavCard 
		{ 
			return Engine.Discards.Nav.Rim.Last;
		}
		protected override function get DrawCount():int 
		{ 
			return Engine.NavRimDrawCount;
		}
		
		public override function Update():void
		{
			super.Update();
			var card:NavCard = Current;
			if(card == null) return;
			
			if(card.IsBigBlack)
			{
				TheBigBlack.visible = true;
			}
			else if(card.Name.search(/Dead Ahead/i) > -1)
			{
				DeadAhead.visible = true;				
				DeadAhead.DetailText.text = FormatDetails(card.Details[0]);
			}
			else if(card.Name.search(/on the Hunt/i) > -1)
			{
				OnTheHunt.visible = true;				
				OnTheHunt.DetailText.text = FormatDetails(card.Details[0]);
			}
			else if(card.Name.search(/in Orbit/i) > -1)
			{
				InOrbit.visible = true;				
				InOrbit.DetailText.text = FormatDetails(card.Details[0]);
			}
			else //Options
			{
				Options.visible = true;
				
				Options.CardNameText.text = card.Name;
				Options.Option1Text.text = card.Options[0];
				Options.Detail1Text.text = FormatDetails(card.Details[0]);
				Options.Option2Text.text = card.Options[1];
				Options.Detail2Text.text = FormatDetails(card.Details[1]);

				Options.Logo.visible = !card.IsReshuffle;
				Options.ReshuffleText.visible = card.IsReshuffle;
			}
		}
		
		protected override function Reshuffle(event:MouseEvent):void
		{
			Engine.ShuffleRim();
			super.Reshuffle(event);
		}		
		
		protected override function DrawNextCard():void
		{
			Engine.NavRimNext();
		}
		
		public function clipNavRimDeck() 
		{
			super();
			DiscardPile.push(OnTheHunt);
			DiscardPile.push(DeadAhead);
			DiscardPile.push(TheBigBlack);
			DiscardPile.push(Options);
			DiscardPile.push(InOrbit);
			
			Initialize(DrawPileTop, DrawPileBottom, null);
			
			ReshuffleText.addEventListener(MouseEvent.CLICK, Reshuffle);
		}
	}
	
}

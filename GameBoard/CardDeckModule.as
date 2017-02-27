package  {
	
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import Cards.*;
	
	public class CardDeckModule {
		
		private var _board:GameBoard;
		private var _engine:IGameEngine;
		
		public function UpdateCards():void
		{
			_board.NavAlliance.Update();
			_board.NavBorder.Update();
			_board.NavRim.Update();
			
			_board.SuppliesSpaceBazaar.Update();
			_board.SuppliesMeridian.Update();
			_board.SuppliesSilverhold.Update();
			_board.SuppliesRegina.Update();
			_board.SuppliesOsiris.Update();
			_board.SuppliesPersephone.Update();
		}
		
		public function CardDeckModule(doc:GameBoard) {
			_board = doc;
			_engine = doc.GameEngine;
		}

	}
	
}

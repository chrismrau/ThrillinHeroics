package  {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Ships.FireflyShip;
	import State.Player;
	
	public class DieModule {
			
		private var _board:GameBoard;
		private var _engine:IGameEngine;
		
		private var DieRollDialog:clipDieRollWindow = new clipDieRollWindow();
		function fl_RollDieHandler(event:MouseEvent):void
		{
			_engine.RollDie();

			DieRollDialog.DieRollCloseButton.enabled = true;
		}
		
		private function fl_RollDieCloseHandler(event:MouseEvent):void
		{
			_engine.ClearCurrentTokens();
			
			DieRollDialog.stop();
			DieRollDialog.visible = false;
			DieRollDialog.DieRollCloseButton.enabled = false;
		}
		
		private function UpdateDieFace(number:int):void
		{
			var face:DisplayObject = null;
			for(var i = 0; i <= 6; ++i)
			{
				var is_visible = (i == number);
				switch(i)
				{
					case 1:
						face = DieRollDialog.Die1;
						break;
					case 2:
						face = DieRollDialog.Die2;
						break;
					case 3:
						face = DieRollDialog.Die3;
						break;
					case 4:
						face = DieRollDialog.Die4;
						break;
					case 5:
						face = DieRollDialog.Die5;
						break;
					case 6:
						face = DieRollDialog.Die6;
						break;
					default:
						continue;
				}
				face.visible = is_visible;
			}
		}
		
		private function UpdateDieMessage(player:Player):void
		{
			if(player.LastDieRoll > 0)
			{
				if(player.TotalDieRoll > player.Boat.Location.TokenCount)
					DieRollDialog.StatusText.text = "Sector Clear.";
				else if(player.LastDieRoll == 6)
					DieRollDialog.StatusText.text = "Thrillin' Heroics\nRoll Again";
				else
					DieRollDialog.StatusText.text = "* * *Reavers* * *";
			}
			else
			{
				DieRollDialog.StatusText.text = "Click Die to Roll.";
			}
		}
		
		public function DoDiceRollDialog(player:Player):void
		{
			if(DieRollDialog.visible)
			{
				UpdateDieFace(player.LastDieRoll);
				UpdateDieMessage(player);

				return;	
			}
			else if(player.Boat.Location.TokenCount > 0)
			{
				var sprite:Sprite = _board.Ship2Sprite[player.Boat];
				
				if(sprite.x + DieRollDialog.width < _board.width)
					DieRollDialog.x = sprite.x;
				else
					DieRollDialog.x = sprite.x - DieRollDialog.width;
				
				if(sprite.y + sprite.height + DieRollDialog.height < _board.height)
					DieRollDialog.y = sprite.y + sprite.height;
				else
					DieRollDialog.y = sprite.y - DieRollDialog.height;
				
				DieRollDialog.visible = true;
				DieRollDialog.play();
			}
		}
		
		private function SetupRollDialog():void
		{			
			var button = DieRollDialog.DieRollButton;
			button.addEventListener(MouseEvent.CLICK, fl_RollDieHandler);
			
			button = DieRollDialog.DieRollCloseButton;
			button.enabled = false;
			button.addEventListener(MouseEvent.CLICK, fl_RollDieCloseHandler);
			
			UpdateDieFace(0);
			DieRollDialog.stop();
			DieRollDialog.visible = false;
			
			_board.addChild(DieRollDialog);
			_board.setChildIndex(DieRollDialog, _board.numChildren - 1);
		}
		
		public function DieModule(doc:GameBoard) {
			_board = doc;
			_engine = doc.GameEngine;
		}

	}
	
}

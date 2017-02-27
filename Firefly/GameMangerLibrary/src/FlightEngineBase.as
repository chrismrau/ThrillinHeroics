package
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import Actions.BaseAction;
	
	import State.GameState;

	internal class FlightEngineBase extends EventDispatcher
	{
		private var _state:GameState;
		public function get CurrentState():GameState { return _state; }
		public function set CurrentState(state:GameState):void 
		{ 
			_state = state;
		}
		
		private var _currentAction:BaseAction;
		protected function get CurrentAction():BaseAction
		{
			return _currentAction;
		}

		private var _statusManager:StatusManager;
		
		protected function set CurrentAction(action:BaseAction):void
		{
			_currentAction = action;
			
			_statusManager.UpdateStatus(_currentAction.Description);
		}

		public function SelectSector(name:String):void
		{
			CurrentAction = CurrentAction.Location(CurrentState.MapSectors[name]);
		}
		
		public function FlightEngineBase(statMgr:StatusManager, target:IEventDispatcher=null)
		{
			super(target);
			
			_statusManager = statMgr;
		}

	}
}
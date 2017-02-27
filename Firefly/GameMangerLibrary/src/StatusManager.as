package
{
	public class StatusManager
	{
		private var _mssgQueue:Vector.<String> = new Vector.<String>();
		
		public function get NextMessage():String
		{
			return _mssgQueue.pop();
		}

		public function UpdateStatus(status:String):void
		{
			_mssgQueue.push(status);
		}
		
		public function StatusManager()
		{
		}
	}
}
package main.flex.com.sxm.defferedLogger.core.delegates
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Delegate class which makes call to the remove service and based on the Promise API invokes onFulfilled/onRejected methods.
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class LoggerDelegate
	{
		
		//----------------------------------------------------------------------------------------
		//
		// PRIVATE PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		private var delayDeferred:Deferred;
		
		private var delayTimer:Timer;
		
		private var logCallbackFunction:Function;
		
		
		//----------------------------------------------------------------------------------------
		//
		// CONSTRUCTOR
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Constructor method
		 * 
		 * @param	none
		 * @return	na
		 */
		
		public function LoggerDelegate()
		{
			delayDeferred = new Deferred();
		}
		
		
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC METHODS
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Invokes the webservice to get the weekly weather report and return the Promise reference
		 * 
		 * @param	none
		 * @return	Reference of the weeklyReportDeferred's Promise
		 */
		public function getLogs():Promise
		{
			if(delayTimer == null)
				delayTimer = new Timer(100, 1);
			
			delayTimer.delay = Math.floor(Math.random()*5000);
			delayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onDelayOver );
			delayTimer.start();
			
			return delayDeferred.promise;
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	event	instance of TimerEvent
		 * @return	void
		 */
		private function onDelayOver(event:TimerEvent):void
		{
			delayTimer.stop();
			delayTimer.reset();
			delayTimer.removeEventListener(  TimerEvent.TIMER_COMPLETE, onDelayOver );
			
			delayDeferred.resolve(delayTimer.delay);
		}
	}
}
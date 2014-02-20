package main.flex.com.sxm.defferedLogger.core.models.presentation
{
	import main.flex.com.sxm.defferedLogger.core.delegates.LoggerDelegate;
	import main.flex.com.sxm.defferedLogger.core.models.constants.StringConstants;
	

	/**
	 * Presentation model for the WeatherReport view.
	 * Gets dependency injected for the UI layer, provides data to the view through the injected model, listens to the view events
	 * and delegates the flow to the controller layer 
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class DefferedLoggerPresentationModel extends PresentationModelBase implements IPresentationModel
	{
		//----------------------------------------------------------------------------------------
		//
		// DEPENDENCY INJECTIONS
		//
		//----------------------------------------------------------------------------------------
		
		[Inject]
		public var loggerDelegate:LoggerDelegate;
		
		
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		[Bindable]
		public var loggerLogs:String;
		
		
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
		public function DefferedLoggerPresentationModel()
		{
		
		}
		
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC METHODS
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Sets up the UI layer configuration when added to the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		override public function setup():void
		{
			loggerLogs = StringConstants.EMPTY_STRING;
		}
		
		/**
		 * Cleans up the UI layer configuration when removed from the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		override public function destroy():void
		{
			
		}
		
		/**
		 * Delegates the weekly report data load call to the controller.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function getLogs(args:* = null):void
		{
			loggerDelegate.getLogs()
				.then(onLogRecieved);
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onLogRecieved(args:* = null):void
		{
			loggerLogs += "Slept for " + args + ".\n";
		}
		
		
		/**
		 * Listens to the fault event for weekly report data load and shows the status message.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onWeeklyReportLoadFailure(error:Error = null):void
		{
			loggerLogs = "Error, starting the logger!";
		}
	}
}
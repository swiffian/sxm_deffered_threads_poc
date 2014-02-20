package main.flex.com.sxm.weatherMap.core.models.presentation
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import main.flex.com.sxm.weatherMap.core.delegates.ServiceDelegate;
	import main.flex.com.sxm.weatherMap.core.events.WeatherReportEvent;
	import main.flex.com.sxm.weatherMap.core.models.WeatherReportModel;
	import main.flex.com.sxm.weatherMap.core.models.constants.StringConstants;

	/**
	 * Presentation model for the WeatherReport view.
	 * Gets dependency injected for the UI layer, provides data to the view through the injected model, listens to the view events
	 * and delegates the flow to the controller layer 
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class WeatherReportPresentationModel extends PresentationModelBase implements IPresentationModel
	{
		//----------------------------------------------------------------------------------------
		//
		// DEPENDENCY INJECTIONS
		//
		//----------------------------------------------------------------------------------------
		
		[Inject]
		[Bindable]
		public var weatherReportModel:WeatherReportModel;
		
		[Inject]
		public var serviceDelegate:ServiceDelegate;
		
		
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		[Bindable]
		public var weatherReportLoadInProgress:Boolean;
		
		[Bindable]
		public var reportLoadStatus:String;
		
		
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
		public function WeatherReportPresentationModel()
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
			weatherReportLoadInProgress = false;
			reportLoadStatus = StringConstants.EMPTY_STRING;
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
		public function getWeatherReport():void
		{
			weatherReportLoadInProgress = true;
			reportLoadStatus = "Loading weekly report...";
				
			serviceDelegate.getWeeklyReport()
				.then(onWeeklyReportLoadSuccess, onWeeklyReportLoadFailure)
				.then(serviceDelegate.setDelay)
				.then(onDelayOver)
				.then(serviceDelegate.getMonthlyReport)
				.then(onMonthlyReportLoadSuccess, onMonthlyReportLoadFailure)
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onWeeklyReportLoadSuccess(args:* = null):void
		{
			reportLoadStatus = "Weekly report loaded!";
		}
		
		
		/**
		 * Listens to the fault event for weekly report data load and shows the status message.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onWeeklyReportLoadFailure(error:Error = null):void
		{
			weatherReportLoadInProgress = false;
			reportLoadStatus = "Error, loading weekly weather report!";
			
			reportLoadStatus = "Loading monthly report...";
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	event	instance of TimerEvent
		 * @return	void
		 */
		private function onDelayOver(args:* = null):void
		{
			reportLoadStatus = "Loading monthly report...";
		}
		
				
		/**
		 * Listens to the result event for monthly report data load and updates the ui state.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onMonthlyReportLoadSuccess(args:* = null):void
		{
			weatherReportLoadInProgress = false;
			reportLoadStatus = "Monthly report loaded!";
		}
		
		/**
		 * Listens to the fault event for monthly report data load and shows the status message.
		 * 
		 * @param	none
		 * @return	void
		 */
		public function onMonthlyReportLoadFailure(error:Error = null):void
		{
			weatherReportLoadInProgress = false;
			reportLoadStatus = "Error, loading monthly weather report data";
		}
	}
}
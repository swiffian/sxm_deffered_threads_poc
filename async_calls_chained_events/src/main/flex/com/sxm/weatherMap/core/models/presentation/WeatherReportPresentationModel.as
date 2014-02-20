package main.flex.com.sxm.weatherMap.core.models.presentation
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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
		// PRIVATE PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		private var delayTimer:Timer;
		
		
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
				
			dispatcher.dispatchEvent(new WeatherReportEvent(WeatherReportEvent.LOAD_WEEKLY_REPORT));
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	none
		 * @return	void
		 */
		[EventHandler(event="WeatherReportEvent.WEEKLY_REPORT_LOADED")]
		public function onWeeklyReportLoadSuccess():void
		{
			reportLoadStatus = "Weekly report loaded!";
			
			if(delayTimer == null)
				delayTimer = new Timer(5000, 1);
			
			delayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, getMonthyReport );
			delayTimer.start();
			
		}
		
		/**
		 * Delegates the monthly report data load call to the controller.
		 * 
		 * @param	event	instance of TimerEvent
		 * @return	void
		 */
		private function getMonthyReport(event:TimerEvent):void
		{
			delayTimer.stop();
			delayTimer.reset();
			delayTimer.removeEventListener(  TimerEvent.TIMER_COMPLETE, getMonthyReport );
			
			reportLoadStatus = "Loading monthly report...";
			dispatcher.dispatchEvent(new WeatherReportEvent(WeatherReportEvent.LOAD_MONTHLY_REPORT));
		}
		
		
		/**
		 * Listens to the fault event for weekly report data load and shows the status message.
		 * 
		 * @param	none
		 * @return	void
		 */
		[EventHandler(event="WeatherReportEvent.WEEKLY_REPORT_LOAD_ERROR")]
		public function onWeeklyReportLoadFailure():void
		{
			weatherReportLoadInProgress = false;
			reportLoadStatus = "Error, loading weekly weather report!";
			
			reportLoadStatus = "Loading monthly report...";
			dispatcher.dispatchEvent(new WeatherReportEvent(WeatherReportEvent.LOAD_MONTHLY_REPORT));
		}
		
		/**
		 * Listens to the result event for monthly report data load and updates the ui state.
		 * 
		 * @param	none
		 * @return	void
		 */
		[EventHandler(event="WeatherReportEvent.MONTHLY_REPORT_LOADED")]
		public function onMonthlyReportLoadSuccess():void
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
		[EventHandler(event="WeatherReportEvent.MONTHLY_REPORT_LOAD_ERROR")]
		public function onMonthlyReportLoadFailure():void
		{
			weatherReportLoadInProgress = false;
			reportLoadStatus = "Error, loading monthly weather report data";
		}
	}
}
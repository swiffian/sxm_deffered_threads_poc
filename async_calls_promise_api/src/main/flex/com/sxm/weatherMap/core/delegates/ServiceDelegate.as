package main.flex.com.sxm.weatherMap.core.delegates
{
	import com.codecatalyst.promise.Deferred;
	import com.codecatalyst.promise.Promise;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	import mx.utils.ObjectUtil;
	
	import main.flex.com.sxm.weatherMap.core.events.WeatherReportEvent;
	import main.flex.com.sxm.weatherMap.core.models.WeatherReportModel;
	import main.flex.com.sxm.weatherMap.core.models.constants.ServiceConstants;

	/**
	 * Delegate class which makes call to the remove service and based on the Promise API invokes onFulfilled/onRejected methods.
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class ServiceDelegate
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
		// PRIVATE PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		private var weeklyReportDeferred:Deferred;
		
		private var delayDeferred:Deferred;
		
		private var monthlyReportDeferred:Deferred;
		
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
		
		public function ServiceDelegate()
		{
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
		public function getWeeklyReport():Promise
		{
			weeklyReportDeferred = new Deferred();
			
			weatherReportModel.weeklyWeatherReport = "";
			
			var weatherReportService:WebService = new WebService();
			weatherReportService.wsdl = ServiceConstants.WEATHER_REPORT_SERVICE_URL;
			
			weatherReportService.GetXmlData.addEventListener( ResultEvent.RESULT, onWeeklyReportLoaded);
			weatherReportService.addEventListener( FaultEvent.FAULT, onWeeklyReportLoadError);
			weatherReportService.loadWSDL();
			weatherReportService.GetXmlData();
			
			return weeklyReportDeferred.promise;
		}
		
		/**
		 * Processes the result event of the webservice for loading the weekly weather report
		 * Notifies the application layers about the data load success event.
		 * 
		 * @param	event	instance of the ResultEvent
		 * @return	void
		 */
		private function onWeeklyReportLoaded(event:ResultEvent):void
		{
			weatherReportModel.weeklyWeatherReport = ObjectUtil.toString(event.result);
			weeklyReportDeferred.resolve(weatherReportModel.weeklyWeatherReport);
		}
		
		/**
		 * Processes the fault event of the webservice for loading the weekly weather report
		 * Notifies the application layers about the data load fault event.
		 * @param	event	instance of the ResultEvent
		 * @return	void
		 */
		private function onWeeklyReportLoadError(event:FaultEvent):void
		{
			weeklyReportDeferred.reject( new Error(event.fault.faultString) );
		}
		
		/**
		 * Adds a 5 seconds of delay before the monthly report service is called
		 * 
		 * @param	none
		 * @return	void
		 */
		public function setDelay():Promise
		{
			delayDeferred = new Deferred();
			
			if(delayTimer == null)
				delayTimer = new Timer(5000, 1);
			
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
			
			delayDeferred.resolve(null);
		}
		
		/**
		 * Invokes the webservice to get the monthly weather report and return the Promise reference
		 * 
		 * @param	none
		 * @return	Reference of the monthlyReportDeferred's Promise
		 */
		public function getMonthlyReport():Promise
		{
			monthlyReportDeferred = new Deferred();
			
			weatherReportModel.monthlyWeatherReport = "";
			
			var weatherReportService:WebService = new WebService();
			weatherReportService.wsdl = ServiceConstants.WEATHER_REPORT_SERVICE_URL;
			
			weatherReportService.GetSampleObject.addEventListener( ResultEvent.RESULT, onMonthlyReportLoaded);
			weatherReportService.addEventListener( FaultEvent.FAULT, onMonthlyReportLoadError);
			weatherReportService.loadWSDL();
			weatherReportService.GetSampleObject(5);
			
			return monthlyReportDeferred.promise;
		}
		
		/**
		 * Processes the result event of the webservice for loading the monthly weather report.
		 * Notifies the application layers about the data load success event.
		 * 
		 * 
		 * @param	event	instance of the ResultEvent
		 * @return	void
		 */
		private function onMonthlyReportLoaded(event:ResultEvent):void
		{
			weatherReportModel.monthlyWeatherReport = ObjectUtil.toString(event.result);
			
			monthlyReportDeferred.resolve(weatherReportModel.monthlyWeatherReport);
		}
		
		/**
		 * Processes the fault event of the webservice for loading the monthly weather report
		 * Notifies the application layers about the data load fault event.
		 * 
		 * @param	event	instance of the ResultEvent
		 * @return	void
		 */
		private function onMonthlyReportLoadError(event:FaultEvent):void
		{
			monthlyReportDeferred.reject( new Error(event.fault.faultString) );
		}
	}
}
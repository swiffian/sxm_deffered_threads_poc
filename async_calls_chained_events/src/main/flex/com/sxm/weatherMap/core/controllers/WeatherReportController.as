package main.flex.com.sxm.weatherMap.core.controllers
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	import mx.utils.ObjectUtil;
	
	import main.flex.com.sxm.weatherMap.core.events.WeatherReportEvent;
	import main.flex.com.sxm.weatherMap.core.models.WeatherReportModel;
	import main.flex.com.sxm.weatherMap.core.models.constants.ServiceConstants;

	/**
	 * Main controller class for the application. 
	 * Makes calls to the asynchronous services and notifies the application with the result/fault events.
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class WeatherReportController extends ControllerBase
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
		// CONSTRUCTOR
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Constructor method
		 * 
		 * @param	none
		 * @return	na
		 */
		public function WeatherReportController()
		{
			//Does nothing
		}
		
		
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC METHODS
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Calls the webserice for loading the weekly weather report and delegates the result/fault event
		 * to the result/fault handler methods
		 * 
		 * @param	event	instance of the WeatherReportEvent
		 * @return	void
		 */
		[EventHandler(event="WeatherReportEvent.LOAD_WEEKLY_REPORT")]
		public function loadWeeklyReport(event:WeatherReportEvent):void
		{
			weatherReportModel.weeklyWeatherReport = "";
			
			var weatherReportService:WebService = new WebService();
			weatherReportService.wsdl = ServiceConstants.WEATHER_REPORT_SERVICE_URL;
			
			weatherReportService.GetXmlData.addEventListener( ResultEvent.RESULT, onWeeklyReportLoaded);
			weatherReportService.addEventListener( FaultEvent.FAULT, onWeeklyReportLoadError);
			weatherReportService.loadWSDL();
			weatherReportService.GetXmlData();
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
			
			dispatcher.dispatchEvent( new WeatherReportEvent( WeatherReportEvent.WEEKLY_REPORT_LOADED) );
		}
		
		/**
		 * Processes the fault event of the webservice for loading the weekly weather report
		 * Notifies the application layers about the data load fault event.
		 * @param	event	instance of the ResultEvent
		 * @return	void
		 */
		private function onWeeklyReportLoadError(event:FaultEvent):void
		{
			dispatcher.dispatchEvent( new WeatherReportEvent( WeatherReportEvent.WEEKLY_REPORT_LOAD_ERROR) );
		}
		
		
		/**
		 * Calls the webserice for loading the monthly weather report and delegates the result/fault event
		 * to the result/fault handler methods
		 * 
		 * @param	event	instance of the WeatherReportEvent
		 * @return	void
		 */
		[EventHandler(event="WeatherReportEvent.LOAD_MONTHLY_REPORT")]
		public function loadMonthlyReport(event:WeatherReportEvent):void
		{
			weatherReportModel.monthlyWeatherReport = "";
			
			var weatherReportService:WebService = new WebService();
			weatherReportService.wsdl = ServiceConstants.WEATHER_REPORT_SERVICE_URL;
			
			weatherReportService.GetSampleObject.addEventListener( ResultEvent.RESULT, onMonthlyReportLoaded);
			weatherReportService.addEventListener( FaultEvent.FAULT, onMonthlyReportLoadError);
			weatherReportService.loadWSDL();
			
			var params:Object = new Object();
			params.no = 5;
			weatherReportService.GetSampleObject(5);
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
			
			dispatcher.dispatchEvent( new WeatherReportEvent( WeatherReportEvent.MONTHLY_REPORT_LOADED) );
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
			dispatcher.dispatchEvent( new WeatherReportEvent( WeatherReportEvent.MONTHLY_REPORT_LOAD_ERROR) );
		}
	}
}
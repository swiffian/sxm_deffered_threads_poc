package main.flex.com.sxm.weatherMap.core.events
{
	import flash.events.Event;
	
	/**
	 * Event class for initiating weather report data load and to notify framework about the report data load status/events
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class WeatherReportEvent extends Event
	{
		//----------------------------------------------------------------------------------------
		//
		// EVENT TYPES
		//
		//----------------------------------------------------------------------------------------
		
		public static const LOAD_WEEKLY_REPORT:String 			= "WeatherReportEvent.LOAD_WEEKLY_REPORT";
		public static const WEEKLY_REPORT_LOADED:String 		= "WeatherReportEvent.WEEKLY_REPORT_LOADED";
		public static const WEEKLY_REPORT_LOAD_ERROR:String 	= "WeatherReportEvent.WEEKLY_REPORT_LOAD_ERROR";
		
		public static const LOAD_MONTHLY_REPORT:String 			= "WeatherReportEvent.LOAD_MONTHLY_REPORT";
		public static const MONTHLY_REPORT_LOADED:String 		= "WeatherReportEvent.MONTHLY_REPORT_LOADED";
		public static const MONTHLY_REPORT_LOAD_ERROR:String 	= "WeatherReportEvent.MONTHLY_REPORT_LOAD_ERROR";
		
		
		//----------------------------------------------------------------------------------------
		//
		//	CONSTRUCTOR
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Constructor method
		 * 
		 * @param	type		type of the event
		 * @param	bubbles		flag that controls the event travel upwards
		 * @param	cancelable	flag that controls weather the event is cancellable or not
		 * 
		 */
		public function WeatherReportEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, true, cancelable);
		}
		
		
		//----------------------------------------------------------------------------------------
		//
		//	METHOD OVERRIDES
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Returns a clone of the current event object
		 * 
		 * @param	none
		 * @return	void
		 */
		override public function clone():Event
		{
			return new WeatherReportEvent(type, bubbles, cancelable);
		}
	}
}
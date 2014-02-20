package main.flex.com.sxm.weatherMap.core.models
{
	/**
	 * Model calss for the application.
	 * Defines [Bindable] properties to be mapped to the view layer.
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class WeatherReportModel extends ModelBase
	{	
		//----------------------------------------------------------------------------------------
		//
		// PRIVATE PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		private var _weeklyWeatherReport:String;
		
		private var _monthlyWeatherReport:String;
		
		
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
		public function WeatherReportModel()
		{
			//Does nothing;
		}

		
		
		//----------------------------------------------------------------------------------------
		//
		// GETTER/SETTER METHODS FOR THE PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		[Bindable]
		public function get monthlyWeatherReport():String
		{
			return _monthlyWeatherReport;
		}

		public function set monthlyWeatherReport(value:String):void
		{
			_monthlyWeatherReport = value;
		}

		[Bindable]
		public function get weeklyWeatherReport():String
		{
			return _weeklyWeatherReport;
		}

		public function set weeklyWeatherReport(value:String):void
		{
			_weeklyWeatherReport = value;
		}

	}
}
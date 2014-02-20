package main.flex.com.sxm.weatherMap.core.controllers
{
	import flash.events.IEventDispatcher;

	/**
	 * Base class for the application controllers. 
	 * Provides common set of framwork tools, properties, methods to the inheriting controller.
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	public class ControllerBase
	{
		//----------------------------------------------------------------------------------------
		//
		// DEPENDENCY INJECTIONS
		//
		//----------------------------------------------------------------------------------------
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
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
		public function ControllerBase()
		{
		}
	}
}
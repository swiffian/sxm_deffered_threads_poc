package main.flex.com.sxm.weatherMap.core.models.presentation
{
	import flash.events.IEventDispatcher;

	/**
	 * Bases class for all the presentaion models.
	 * Defines the tools, properties, methods required by all the presentation models. 
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	
	public class PresentationModelBase implements IPresentationModel
	{
		//----------------------------------------------------------------------------------------
		//
		// PUBLIC PROPERTIES
		//
		//----------------------------------------------------------------------------------------
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		//----------------------------------------------------------------------------------------
		//
		//	CONSTRUCTOR
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * Constructor method
		 * 
		 * @param	none
		 * @return	na
		 */
		public function PresentationModelBase()
		{
		}
		
		/**
		 * To be overridden by the implementing class.
		 * The purpose is to set the intial setup for the UI layer when it is added to the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		public function setup():void
		{
			
		}
		
		/**
		 * To be overridden by the implementing class.
		 * The purpose is to clean the UI layer event handlers, data, references when it is removed from the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		public function destroy():void
		{
			
		}
	}
}
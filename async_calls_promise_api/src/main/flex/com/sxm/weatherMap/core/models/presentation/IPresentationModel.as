package main.flex.com.sxm.weatherMap.core.models.presentation
{
	/**
	 * Interface for the presentation models. 
	 * Defines the methods which have to be implemented by all the presentation models
	 * 
	 * @author	Prem Pratap Singh
	 * @version	1.0
	 * @created	19 Feb 2014 
	 */
	
	public interface IPresentationModel
	{
		//----------------------------------------------------------------------------------------
		//
		// CONTRACT METHODS
		//
		//----------------------------------------------------------------------------------------
		
		/**
		 * To be overridden by the implementing class.
		 * The purpose is to set the intial setup for the UI layer when it is added to the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		function setup():void;
		
		/**
		 * To be overridden by the implementing class.
		 * The purpose is to clean the UI layer event handlers, data, references when it is removed from the stage
		 * 
		 * @param	none
		 * @return	void
		 */
		function destroy():void;
	}
}
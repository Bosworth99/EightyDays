///////////////////////////////////////////////////////////////////////////////
//
//	com>b99>utils>DataLoader.as
//
//	extends : EventDispatcher
//	
//	provide loading of all external assets  
//
///////////////////////////////////////////////////////////////////////////////

package com.b99.data.util 
{
	//----------------------- core
	import com.b99.data.GameData;
	import com.b99.event.GameEvent;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.data.XMLLoaderVars;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	//----------------------- greensock
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	
	//----------------------- b99
	import com.b99.app.GameControl;
	
	/**
	 * ...
	 * @author bosworth99
	 */
	public class DataLoader extends EventDispatcher
	{

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									constructor
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++		

		public function DataLoader(target:IEventDispatcher = null) 
		{
			super(target);
			init();
		}
		
		private function init():void
		{
			trace("DataLoader.init()")
		}
		
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									XML 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
		public function loadXML():void
		{
			trace("DataLoader.loadXML()");
			
			var loadVars:LoaderMaxVars= new LoaderMaxVars();
			loadVars.name = "queueXML";
			loadVars.onComplete = XMLcomplete;
			loadVars.onProgress = XMLprogress;
			loadVars.onError	= XMLerror;
			var queueXML:LoaderMax = new LoaderMax(loadVars);
			
			queueXML.append( new XMLLoader("../xml/commodity.xml", 		{ name:"xml_commodity" } ) );
			queueXML.append( new XMLLoader("../xml/component.xml", 		{ name:"xml_component" } ) );
			
			queueXML.load();
		}
		
		private function XMLerror(e:LoaderEvent):void
		{
		    trace("error occured with " + e.target + ": " + e.text);
		}
		private function XMLprogress(e:LoaderEvent):void
		{
			trace("progress: " + e.target.progress);
		}
		private function XMLcomplete(e:LoaderEvent):void
		{
			//set app data
			GameData.commodityXML 	= LoaderMax.getContent("xml_commodity");
			GameData.componentXML	= LoaderMax.getContent("xml_component");
			
			//inform gameControl
			this.dispatchEvent(new GameEvent(GameEvent.XML_LOAD));
		}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//									END 
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++			
		
	}
}
package com.b99.logic 
{
	import com.b99.data.prototype.NPC;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class TravelEventLogic extends Object
	{
		
		public function TravelEventLogic() {}
		
		
		public static function travelEvent():void
		{
			
			//random roll to determine if a travel event occurs
			
			//if successful, secondary roll to determine type of event
			// event type == pirate, merchant, armada
			
			//storm? divine intervention? hooker party?
			
			var encounter:uint = GameLogic.randRange(0, 100);
			var encounterNPC:String;
			
			
			if (encounter > 50) 
			{
				var encounterType:uint = GameLogic.randRange(0, 100);
				
				if(encounterType < 33) 
				{
					encounterNPC = "pirate";
				}
				else if ( encounterType > 33  && encounterType < 66)
				{
					encounterNPC = "merchant";
				}
				else if (encounterType > 67)
				{
					encounterNPC = "armada";
				}
				
				trace( "Encounter! You've encountered a : " + encounterNPC); 
				
			} 
			else 
			{
				
				trace( "on your travels, you encounter nothing!!");
				
			}
			
		}

		private static function buildNPC(type:String):void
		{
			//NPC_Logic.generateNPC(type);
			
			//return npc, run either combat or trade
		}
		
		private static function initiateCombat(npc:NPC):void 
		{
			CombatLogic.initiateCombat("player", npc);	
		}
		
		private static function initiateTrade(npc:NPC):void
		{
			
			
			
		}
		
		
		
	}
}
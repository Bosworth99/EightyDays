package com.b99.logic 
{
	import com.b99.data.prototype.NPC;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class NPC_Logic extends Object
	{
		public function NPC_Logic() { }

		public static function generateNPC(type:String):NPC
		{
			
			/**
			 * assign values based on the airship / personnel current stats
			 * 
			 * type == "pirate" "merchant" "aramada"
			 * 
			 * depending on reputation, these npcs will interact differently
			 * 
			 * if reputation is positive 
			 * 		pirate will always attack
			 * 		merchant will be tradeable or attackable
			 * 		armada will be tradeable or attackable
			 * 
			 * if reputation is negative 
			 * 		pirate will be tradeable or attackable
			 * 		merchant will be tradeable or attackable
			 * 		armada will always attack
			 * 
			 * attacking / defeating pirate will always make reputation increase
			 * attacking / defeating merchant will always make reputation decrease
			 * attacking / defeating armada will always make reputation decrease
			 * 
			 */
			
		}
		
	}
}
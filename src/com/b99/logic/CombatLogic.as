package com.b99.logic 
{
	import com.b99.data.AirshipData;
	import com.b99.data.prototype.NPC;
	/**
	 * ...
	 * @author bosworth99
	 */
	public class CombatLogic extends Object
	{
		private static var _enemy			: NPC;
		private static var _attacker		: String;
		private static var _playerAttack	: Boolean;
		
		public function CombatLogic() { }
		
		
		/**
		 * 
		 * @param	attacker:String = "player" or "npc"
		 * @param	enemy:NPC		= attacking or defending NPC
		 */
		public static function initiateCombat(attacker:String, enemy:NPC):void
		{
			
			/**
			 * pass string, determining whether the player has attacked 
			 * or has been attacked 
			 * 
			 * pass reference to the enemy NPC as determined in the calling class
			 * 
			 */
			
			_enemy 		= enemy; 
			_attacker 	= attacker;
			
			/**
			 * determine attacker
			 * call turn() 
			 */
			
			switch (_attacker) 
			{
				case "player":
				{
					_playerAttack = true;
					break;
				}
				case "npc":
				{
					_playerAttack = false;
					break;
				}
			}
			
			startTurn();
		}

		
		private static function startTurn():void
		{
			/**
			 * check for health, if either is <= 0 
			 * endCombat();
			 * 
			 * 
			 * determine whos attacking, 
			 * call attack()
			 */
			
		}
		
		private static function checkAccuracy():void 
		{	
			
			/**
			 * accuracy = randomRange(100) * battleSense
			 * 
			 * if accuracy < 10 = miss , you missed, endTurn()
			 * 
			 * else accuracy > 90 = crit , you crit assignDamage()
			 * 
			 * else dodge(accuracy); 
			 * 
			 */
		}
		
		private static function checkDodge(accuracy:uint):void 
		{	
			/**
			 * dodge = randomRange(100) * dodge
			 * 	
			 * if dodge > accuracy, dodge successfu, endTurn()
			 * 
			 * else assignDamage(accuracy);
			 */
		}
		
		
		private static function assignDamage(accuracy:uint):void
		{
			/**
			 * damageRange =  weapon value range (10 - 25)
			 * 
			 * 
			 * determine damage as an percentage of a range 
			 * accuracy is the percentage
			 * 
			 * damage = damageRange * (accuracy / 100)  
			 * 
			 * defend(damage)
			 * 
			 */
		}
		
		private static function defend(damage:uint):void
		{
			/**
			 * 
			 * damageTaken = damage / defense 
			 * 
			 * defender.removeHitPoints(damage);
			 * 
			 * 
			 * endTurn()
			 */
		}

		private static function endTurn():void
		{
			
			// flip _playerAttacking
			// startTurn();
			
		}
		
		private static function endCombat():void
		{
			

			
		}
		
	}
}
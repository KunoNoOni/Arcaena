package
{
	import org.flixel.*;
			
	public class Player extends FlxSprite
	{
		
		public var hitPoints:int = 100;
		
		public function Player(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.player,false,false,32,32);
			addAnimation("noArmor",[0],1);
			addAnimation("Armor",[1],1);
		}
		
		override public function update():void
		{					
			if(Registry.world <= 1)
				play("noArmor");
			else
				play("Armor");
			
			if(!Registry.talking)
			{
				if(!Registry.fighting)
				{
					if(FlxG.keys.justPressed("LEFT"))
					{
						//FlxG.play(Registry.walking,.8);
						FlxG.play(Registry.walking3,.5);
						this.x -= 32;
					}
					if(FlxG.keys.justPressed("RIGHT"))
					{
						//FlxG.play(Registry.walking,.8);
						FlxG.play(Registry.walking3,.5);
						this.x += 32;
					}
					if(FlxG.keys.justPressed("UP"))
					{
						//FlxG.play(Registry.walking,.8);
						FlxG.play(Registry.walking3,.5);
						this.y -= 32;
					}
					if(FlxG.keys.justPressed("DOWN"))
					{
						//FlxG.play(Registry.walking,.8);
						FlxG.play(Registry.walking3,.5);
						this.y += 32;
					}
				}
			}

			super.update();
		}
		
		public function fightBoss():void
		{
			if(FlxG.keys.justPressed("ONE") && Registry.playerHasAttack1)
			{
				Registry.playerAttack1 = true;
			}
			if(FlxG.keys.justPressed("TWO") && Registry.playerHasAttack2)
			{
				Registry.playerAttack2 = true;
			}
			if(FlxG.keys.justPressed("THREE") && Registry.playerHasAttack3)
			{
				Registry.playerAttack3 = true;
			}
			if(FlxG.keys.justPressed("FOUR") && Registry.playerHasAttack4)
			{
				Registry.playerAttack4 = true;
			}
			if(FlxG.keys.justPressed("FIVE") && Registry.playerHasAttack5)
			{
				Registry.playerAttack5 = true;
			}
		}
	}
}
package
{
	import org.flixel.*;
			
	public class Bosses extends FlxSprite
	{

		public function Bosses(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.bosses,false,false,32,32);
			addAnimation("Fire",[0],1);
			addAnimation("Water",[2],1);
			addAnimation("Earth",[4],1);
			addAnimation("Air",[6],1);
			addAnimation("Final",[8],1);
		
			if(!Registry.finalLevel)
				this.health = 100;
			else
				this.health = 250;
		}
		
		override public function update():void
		{					
		
			Registry.bossHealth = this.health;
			
			switch(Registry.world)
			{
				case 2:
				{
					if(!Registry.boss4Dead)
						play("Fire");
					break;
				}
				case 3:
				{
					if(!Registry.boss3Dead)
						play("Water");
					break;
				}
				case 4:
				{
					if(!Registry.boss2Dead)
						play("Earth");
					break;
				}
				case 5:
				{
					if(!Registry.boss1Dead)
						play("Air");
					break;
				}
				case 6:
				{	
					play("Final");
					break;
				}
			}
			
			if(this.health <= 0)
			{
				playDeath();
			}
	
			super.update();
		}
		
		public function fightPlayer():void
		{
			switch(Registry.world)
			{
				case 2://fire
				{
					this.y = 96;
					break;
				}
				case 3://water
				{
					this.y = 352;
					break;
				}
				case 4://earth
				{
					this.y = 416;
					break;
				}
				case 5://air
				{
					this.y = 160;
					break;
				}
				case 6://final
				{
					this.y = 96;
					break;
				}
			}
			
		}
		
		private function playDeath():void
		{
			FlxG.play(Registry.bossDeath,1);
			this.kill();
			
			switch(Registry.world)
			{
				case 2://fire
				{
					Registry.boss4Dead = true;
					break;
				}
				case 3://water
				{
					Registry.boss3Dead = true;
					break;
				}
				case 4://earth
				{
					Registry.boss2Dead = true;
					break;
				}
				case 5://air
				{
					Registry.boss1Dead = true;
					break;
				}
				case 6://final
				{
					Registry.boss5Dead = true;
					break;
				}
			}
		}
	}
}
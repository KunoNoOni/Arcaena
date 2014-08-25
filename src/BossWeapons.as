package
{
	import org.flixel.*;
			
	public class BossWeapons extends FlxSprite
	{
		private var rndDamage:int = 0;
		private var minDamage:int = 7;
		private var maxDamage:int = 15;
		private var rnd:int = 0;
		private var min:int = 1;
		private var max:int = 100;
		private var rndChosen:Boolean = false;
		
		public function BossWeapons(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.bosses,false,false,32,32);
			addAnimation("Fire",[1],1);
			addAnimation("Water",[3],1);
			addAnimation("Earth",[5],1);
			addAnimation("Air",[7],1);
			
		}
		
		override public function update():void
		{					
			
			switch(Registry.world)
			{
				case 2:
				{
					play("Fire");
					this.width = 20;
					this.height = 12;
					break;
				}
				case 3:
				{
					play("Water");
					this.width = 14;
					this.height = 14;
					break;
				}
				case 4:
				{
					play("Earth");
					this.width = 12;
					this.height = 13;
					break;
				}
				case 5:
				{
					play("Air");
					this.width = 22;
					this.height = 19;
					break;
				}
				case 6:
				{
					//this boss can use all weapons
					if(!rndChosen)
					{
						rnd = Math.floor(Math.random() * (1 + max - min) + min);
						rndChosen = true;
												
						rndDamage = Math.floor(Math.random() * (1 + maxDamage - minDamage) + minDamage);
						Registry.damage = rndDamage;
						
						if(rnd >= 1 && rnd <=25)
						{
							play("Air");
							FlxG.play(Registry.lightningSnd,.8);
							this.width = 22;
							this.height = 19;
							this.x += 6;
						}
						else if(rnd >= 26 && rnd <=50)
						{
							play("Earth");
							FlxG.play(Registry.earthArrowSnd,.8);
							this.width = 12;
							this.height = 13;
							this.x += 9;
						}
						else if(rnd >= 51 && rnd <=75)
						{
							play("Water");
							FlxG.play(Registry.waterBallSnd,.8);
							this.width = 14;
							this.height = 14;
							this.x += 9;
						}
						else if(rnd >= 76 && rnd <=100)
						{
							play("Fire");
							FlxG.play(Registry.fireWaveSnd,.8);
							this.width = 20;
							this.height = 12;
							this.x += 6;
						}
					}
					break;
				}
			}
			
			this.velocity.y = 50;
			
			
			super.update();
		}
	}
}
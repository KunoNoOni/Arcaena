package
{
	import org.flixel.*;
			
	public class WarpGates extends FlxSprite
	{
		
		
		public function WarpGates(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.warpGates,false,false,32,32);
			addAnimation("start",[0,1,2,3],5);
			addAnimation("arcaena",[4,5,6,7],5);
			addAnimation("fire",[8,9,10,11],5);
			addAnimation("water",[12,13,14,15],5);
			addAnimation("earth",[16,17,18,19],5);
			addAnimation("air",[20,21,22,23],5);
			addAnimation("boss",[24,25,26,27],5);
		}
		
		override public function update():void
		{					
			
			switch(Registry.world)
			{
				case 0:
				{
					play("start");
					break;	
				}
				case 1:
				{
					play("arcaena");
					break;	
				}
				case 2:
				{
					play("fire");
					break;
				}
				case 3:
				{
					play("water");
					break;
				}
				case 4:
				{
					play("earth");
					break;
				}
				case 5:
				{
					play("air");
					break;
				}
				case 6:
				{
					play("boss");
					break;
				}
				
			}
			
			super.update();
		}
	}
}
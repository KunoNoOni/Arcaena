package
{
	import org.flixel.*;
	
	public class PlayersWeapon5 extends FlxSprite
	{
		
		public function PlayersWeapon5(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.fireWave,false,false,20,12);
		}
		
		override public function update():void
		{					
			this.velocity.y += -5;
			
			super.update();
		}
	}
}
package
{
	import org.flixel.*;
	
	public class PlayersWeapon extends FlxSprite
	{
		
		public function PlayersWeapon(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.thoughtBullet,false,false,8,8);
		}
		
		override public function update():void
		{					
			this.velocity.y += -5;
			
			super.update();
		}
	}
}
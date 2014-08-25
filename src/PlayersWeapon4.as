package
{
	import org.flixel.*;
	
	public class PlayersWeapon4 extends FlxSprite
	{
		
		public function PlayersWeapon4(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.waterBall,false,false,14,14);
		}
		
		override public function update():void
		{					
			this.velocity.y += -5;
			
			super.update();
		}
	}
}
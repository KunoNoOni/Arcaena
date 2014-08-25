package
{
	import org.flixel.*;
	
	public class PlayersWeapon2 extends FlxSprite
	{
		
		public function PlayersWeapon2(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.lightning,false,false,20,18);
		}
		
		override public function update():void
		{					
			this.velocity.y += -5;
			
			super.update();
		}
	}
}
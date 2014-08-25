package
{
	import org.flixel.*;
	
	public class PlayersWeapon3 extends FlxSprite
	{
		
		public function PlayersWeapon3(X:Number=0,Y:Number=0)
		{
			super(X*32,Y*32);
			loadGraphic(Registry.earthArrow,false,false,12,13);
		}
		
		override public function update():void
		{					
			this.velocity.y += -5;
			
			super.update();
		}
	}
}
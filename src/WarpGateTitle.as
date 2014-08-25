package
{
	import org.flixel.*;
			
	public class WarpGateTitle extends FlxSprite
	{
		public function WarpGateTitle(X:Number=0,Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Registry.wgt,false,false,128,128);
			addAnimation("warp",[0,1,2,3],5);
			
		}
		
		override public function update():void
		{					
				play("warp");
			
			super.update();
		}
	}
}
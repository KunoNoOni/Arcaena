package
{
	import org.flixel.*;
	
	[SWF(width="512", height="512", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
		
	public class Arcaena extends FlxGame
	{
		public function Arcaena()
		{
			super(256,256,TitleState,2,60,60);
			//forceDebugger = true;
			//FlxG.visualDebug = true;
			//FlxG.debug = true;
		}
	}
}
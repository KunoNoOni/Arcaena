package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
		
	public class Instructions extends FlxState
	{
		[Embed(source="../fonts/FairyDustB.ttf", fontFamily="FairydustB", embedAsCFF="false")] private var fntFairydustB:String;
		
		//Variables got here
		private var instruct:FlxText;
		private var instruct2:FlxText;
		private var instruct3:FlxText;
		private var pressX:FlxText;
		private var wgt:WarpGateTitle;
		private var stars:FlxSprite;
		private var speed:int = -50;
		private var starfield:StarfieldFX;
		
		public function Instructions()
		{
			super();
		}
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			starfield = FlxSpecialFX.starfield();
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200, 2);
			add(stars);
			
			wgt = new WarpGateTitle(64,80);
			add(wgt);
			
			instruct = new FlxText(FlxG.width*0.5-95,FlxG.height*0.5-120, 200, "How to Play");
			instruct.setFormat("FairydustB",40,0xfff200, "center");
			add(instruct);
			
			instruct2 = new FlxText(FlxG.width*0.5-130,FlxG.height*0.5-70, 260, "Use the arrows keys to move the player around the game world.");
			instruct2.setFormat("FairydustB",20,0xfff200, "center");
			add(instruct2);
			
			instruct3 = new FlxText(FlxG.width*0.5-120,FlxG.height*0.5-20, 240, "The numbers 1 thru 5 control\n your attacks. You start with only one"+
				" attack and as you progress you will gain others.");
			instruct3.setFormat("FairydustB",20,0xfff200, "center");
			add(instruct3);
			
			pressX = new FlxText(FlxG.width*0.5-100,FlxG.height-30, 200, "PRESS [x] TO START");
			pressX.setFormat("FairydustB",20,0xfff200, "center");
			add(pressX);
		}
		
		override public function update():void
		{
			if(FlxG.keys.X)
			{
				FlxG.playMusic(Registry.title1,0);
				FlxG.switchState(new Start());	//<--- using new state change code for flixel 2.5		
			}
			super.update();
		}
		
		override public function destroy():void
		{
			starfield = null;
		}
	}
}
package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
		
	public class TitleState extends FlxState
	{
		//Variables got here
		
		[Embed(source="../fonts/FairyDustB.ttf", fontFamily="FairydustB", embedAsCFF="false")] private var fntFairydustB:String;
		
		private var wgt:WarpGateTitle;
		private var stars:FlxSprite;
		private var speed:int = -50;
		private var starfield:StarfieldFX;
		
		public function TitleState()
		{
			super();
		}
		
		override public function create():void
		{
			FlxG.playMusic(Registry.title1,1);
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			starfield = FlxSpecialFX.starfield();
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 200, 2);
			add(stars);
			
			wgt = new WarpGateTitle(64,80);
			add(wgt);
			
			var logo:FlxText = new FlxText(FlxG.width*0.5-100,FlxG.height*0.5-130, 200, "Arcaena");
			logo.setFormat("FairydustB",60,0xfff200, "center");
			add(logo);
			
			var instruct:FlxText = new FlxText(FlxG.width*0.5-200,FlxG.height-35, 400, "PRESS [x] FOR INSTRUCTIONS");
			instruct.setFormat("FairydustB",18,0xfff200, "center");
			add(instruct);
		}
		
		override public function update():void
		{
			if(FlxG.keys.X)
			{
				FlxG.switchState(new Instructions());	//<--- using new state change code for flixel 2.5		
			}
			super.update();
		}
		
		override public function destroy():void
		{
			starfield = null;
		}
	}
}
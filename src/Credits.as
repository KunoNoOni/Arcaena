package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	
	public class Credits extends FlxState
	{
		[Embed(source="../fonts/FairyDustB.ttf", fontFamily="FairydustB", embedAsCFF="false")] private var fntFairydustB:String;
		
		//Variables got here
		private var stars:FlxSprite;
		private var speed:int = -50;
		private var starfield:StarfieldFX;
		private var dialog:Array = new Array("Credits\n\nArcaena\n\nBy KunoNoOni\n\nCreated for\nLudum Dare 30 #LD48" +
			"\n\n\n\n\n\nThanks for playing!\n\n\n\n\n\n\n\n\n\nPress [x] for Title");
		private var dialogText:FlxText;
		private var wgt:WarpGateTitle;
		
		public function Credits()
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
			
			dialogText = new FlxText(FlxG.width*0.5-120,FlxG.height*0.5+100,240,"");
			dialogText.setFormat("FairydustB",30,0xfff200, "center");
			add(dialogText);
			
		}
		
		override public function update():void
		{
			
			dialogText.text = dialog[0];
			dialogText.velocity.y = speed;
			if(FlxU.floor(dialogText.y) <= -695)
				speed = 0;
			
			if(FlxG.keys.X)
			{
				FlxG.playMusic(Registry.title1,0);
				FlxG.switchState(new TitleState());		
			}
			super.update();
		}
		
		override public function destroy():void
		{
			starfield = null;
		}
	}
}
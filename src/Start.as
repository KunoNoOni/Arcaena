package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;

	//import org.flixel.plugin.photonstorm.*;
	
	public class Start extends FlxState
	{
		//Variables go here
		private var map:FlxTilemap;
		private var warpGates:WarpGates;
		private var player:Player;
		private var warpGatePlaced:Boolean = false;
		private var timer:FlxDelay;
		
				
		override public function create():void
		{	
			FlxG.playMusic(Registry.start2,1);
			
			Registry.world = 0;
			
			map = new FlxTilemap;
			map.loadMap(new Registry[Registry.levels[Registry.currLevel]],Registry.buildTile1,32,32,0,0,1,2);
			add(map);

			player = new Player(1,8); //1,8	
			add(player); 
			
			//set the camera and worldbounds
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = 800;
			FlxG.worldBounds.height = 320;
			
			FlxG.camera.setBounds(0, 0, 800, 320);
			FlxG.worldBounds = new FlxRect(0, 0, 800, 320);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			map.setTile(20,4,1);
			timer = new FlxDelay(1000);
		}	
		
		override public function update():void
		{
			
			if(FlxG.keys.justPressed("Q"))
			{
				trace("player.x = "+player.x+" player.y = "+player.y);
			}
			
			if(player.x == 704 && player.y == 256 && !warpGatePlaced)
			{
				placeWarpGate();
			}
			
			if(warpGatePlaced)
			{
				FlxG.overlap(warpGates,player,warp);
			}
			
			super.update();
			
			FlxG.collide(map,player);
			
		}
		
		private function placeWarpGate():void
		{
			FlxG.play(Registry.warpGateOpen2,.8);
			Registry.world = 0;
			warpGates = new WarpGates(20,4);
			add(warpGates);
			warpGatePlaced = true;
		}
		
		private function warp(p:FlxSprite,e:FlxSprite):void
		{
			FlxG.playMusic(Registry.start2,0);
			FlxG.switchState( new WorldOfArcaena);
		}
	}
}

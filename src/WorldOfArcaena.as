package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.*;
	
	public class WorldOfArcaena extends FlxState
	{
		[Embed(source="../fonts/FairyDustB.ttf", fontFamily="FairydustB", embedAsCFF="false")] private var fntFairydustB:String;
		
		//Variables go here
		private var map:FlxTilemap;
		private var warpGates:WarpGates;
		private var player:Player;
		private var dialogBox:FlxSprite;
		private var dialog:Array = new Array("Greetings young one, I am Jourdain High Mage of Arcaena." +
			" An ancient curse was placed on my people long, long ago. Only by defeating the 5 elemental bosses on their own worlds" +
			" can the curse be broken.\n\nPress [x] to continue");
		private var elapsed:Number = 0;
		private var pageIndex:int = 0;
		private var charIndex:int = 0;
		private var displaySpeed:int = .45;
		public var dialogText:FlxText;
		private var displaying:Boolean = false;
		private var stillOn:Boolean = false;
		private var moretalking:Boolean = false;
		private var warpGatePlaced:Boolean = false;
		
				
		override public function create():void
		{	
			
			FlxG.playMusic(Registry.arcaena1,1);
			
			Registry.world = 1;
			
			map = new FlxTilemap;
			map.loadMap(new Registry[Registry.levels1[Registry.currLevel]],Registry.buildTile2,32,32,0,0,1,6);
			add(map);

			player = new Player(3,7);	
			add(player); 
			
			//set the camera and worldbounds
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = 224;
			FlxG.worldBounds.height = 288;
			
			FlxG.camera.setBounds(0, 0, 224, 288);
			FlxG.worldBounds = new FlxRect(0, 0, 224, 288);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			if(Registry.boss1Dead)
			{
				map.setTile(5,7,1);
			}
			if(Registry.boss2Dead)
			{
				map.setTile(1,7,1);
			}
			if(Registry.boss3Dead)
			{
				map.setTile(5,1,1);
			}
			if(Registry.boss4Dead)
			{
				map.setTile(1,1,1);
			}
			if(Registry.boss5Dead)
			{
				map.setTile(3,4,1);
			}
			
			if(Registry.boss1Dead && !Registry.playerDead)
				Registry.dialog++;
			
			FlxG.play(Registry.warping2,.8);
		}	
		
		override public function update():void
		{
			
			if(FlxG.keys.justPressed("Q"))
			{
				trace("player.x = "+player.x+" player.y = "+player.y);
				//trace("moretalking = "+moretalking);
				//trace("Registry.talking = "+Registry.talking);
				//trace("Registry.dialog = "+Registry.dialog);
			}
			
			if(player.x == 32 && player.y == 128)
			{	
				if(!Registry.talking && !stillOn )
				{
					Registry.talking = true;
					displaying = true;
					stillOn = true;
					showDialogBox();
					//trace("Calling first Speak");
					speak(Registry.dialog);
				}
				
				if(Registry.talking)
				{
					if(FlxG.keys.justPressed("X"))
					{
						if(!moretalking)
						{
							//trace("*)&^%*(&%)*(&%(*&%");
							Registry.talking = false;
							displaying = false;
							moretalking = false;
							showDialogBox();
							//trace("Calling second Speak");
							speak(999);
							Registry.dialogSet = 1;
						}
						else
						{
							//trace("talk!")
							Registry.dialog++;
							displaying = true;
							showDialogBox();
							//trace("Calling third Speak");
							speak(Registry.dialog);
						}
					}
					
					if(Registry.dialogSet == 1 && !Registry.warpGatePlaced4 && !Registry.boss1Dead)
					{
						Registry.warpGateOpened = 1;
						placeWarpGate();
					}
					
					if(Registry.boss1Dead && !Registry.warpGatePlaced3 && !Registry.talking && !Registry.boss2Dead)
					{
						Registry.warpGateOpened = 2;
						placeWarpGate();
					}
					
					if(Registry.boss2Dead && !Registry.warpGatePlaced2 && !Registry.talking && !Registry.boss3Dead)
					{
						Registry.warpGateOpened = 3;
						placeWarpGate();
					}
					
					if(Registry.boss3Dead && !Registry.warpGatePlaced1 && !Registry.talking && !Registry.boss4Dead)
					{
						Registry.warpGateOpened = 4;
						placeWarpGate();
					}
					
					if(Registry.boss4Dead && !Registry.warpGatePlaced5 && !Registry.talking && !Registry.boss5Dead)
					{
						Registry.warpGateOpened = 5;
						placeWarpGate();
					}
					
					if(Registry.boss5Dead && !Registry.warpGateHome && !Registry.talking)
					{
						Registry.warpGateOpened = 6;
						placeWarpGate();
					}
				}
			}
			else
			{
				stillOn = false;
			}
			
			if(displaying)
			{
				elapsed += FlxG.elapsed;
				if(elapsed > displaySpeed)
				{
					elapsed = 0;
					charIndex++;
					if(charIndex > dialog[pageIndex].length)
					{
						displaying = false;
					}
					dialogText.text = dialog[pageIndex].substr(0, charIndex);
					FlxG.play(Registry.ChatType,.3);
				}
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
			
			switch(Registry.warpGateOpened)
			{
				case 1:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGatePlaced4 = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(5,7);
					add(warpGates);
					break;
				}
				case 2:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGatePlaced3 = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(1,7);
					add(warpGates);
					break;
				}
				case 3:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGatePlaced2 = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(5,1);
					add(warpGates);
					break;
				}
				case 4:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGatePlaced1 = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(1,1);
					add(warpGates);
					break;
				}
				case 5:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGatePlaced5 = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(3,4);
					add(warpGates);
					break;
				}
				case 6:
				{
					FlxG.play(Registry.warpGateOpen2,.8);
					Registry.warpGateHome = true;
					warpGatePlaced = true;
					warpGates = new WarpGates(3,4);
					add(warpGates);
					break;
				}
			}		
		}
		
		private function warp(p:FlxSprite,e:FlxSprite):void
		{
			if(p.x == 32 && p.y == 32 && Registry.warpGatePlaced1)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new FireWorld);	
			}
			if(p.x == 160 && p.y == 32 && Registry.warpGatePlaced2)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new WaterWorld);	
			}
			if(p.x == 32 && p.y == 224 && Registry.warpGatePlaced3)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new EarthWorld);	
			}
			if(p.x == 160 && p.y == 224 && Registry.warpGatePlaced4)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new AirWorld);	
			}
			if(p.x == 96 && p.y == 128 && Registry.warpGatePlaced5)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new FinalBoss);	
			}
			if(p.x == 96 && p.y == 128 && Registry.warpGateHome)
			{
				FlxG.playMusic(Registry.arcaena1,0);
				FlxG.switchState( new Credits);	
			}
		}
		
		private function speak(dialogNumber:int):void
		{
			//trace("dialogNumber = "+dialogNumber);
			switch(dialogNumber)
			{
				case 0:
				{	
					//trace("setting moretalking to true");
					moretalking = true;
					break;
				}
				case 1:
				{
					//trace("loading new dialog");
					dialog = new Array("You have been chosen to be our champion! I will open a portal to Ith,\nthe world of Air." +
						" After entering you\nwill gain magical armor and the power of thought projection. Use this power\nto defeat the boss!\n" +
						"\nPress [x] to continue");
					elapsed = 0;
					pageIndex = 0;
					charIndex = 0;
					dialogText.kill();
					//trace("setting moretalking to FALSE!");
					moretalking = false;
					break;
				}
				case 2:
				{
					dialog = new Array("You indeed are a champion! The gate to Ith is closed forever!" +
					" Having defeated the elemental of air you have now gained its power. Use it well in Sirath, the elemental world of Earth.\n" +
					"\n\nPress [x] to continue");
					break;
				}
				case 3:
				{
					dialog = new Array("You indeed are a champion! The gate to Sirath is closed forever!" +
						" Having defeated the elemental of earth you have now gained its power. Use it well in Jure, the elemental world of Water.\n" +
						"\n\nPress [x] to continue");
					break;
				}
				case 4:
				{
					dialog = new Array("You indeed are a champion! The gate to Jure is closed forever!" +
						" Having defeated the elemental of water you have now gained its power. Use it well in Ralarth, the elemental world of Fire.\n" +
						"\n\nPress [x] to continue");
					break;
				}
				case 5:
				{
					dialog = new Array("You indeed are a champion! The gate to Ralarth is closed forever!" +
						" Having defeated the elemental of fire you have now gained its power. Use it well in Avrae, where your final challenge\nwill take place.\n" +
						"\n\nPress [x] to continue");
					break;
				}
				case 6:
				{
					dialog = new Array("You indeed are a champion! The gate to Avrae is closed forever!" +
						" You have broken the curse which had imprisioned my people for several millennia! Now we can finally rest!\n" + 
						"Thank you for your help, this gate will take you home. Farewell champion!\n\nPress [x] to continue");
					break;
				}
				case 999:
				{
					//trace("speaking 999");
					break;
				}
			}
			
			if(Registry.talking)
			{
				dialogText = new FlxText(20,165,200,"");
				dialogText.setFormat(null,8,0xfff200, "left");
				add(dialogText);
			}
			else
			{
				dialogText.kill();
			}
		}
		
		private function showDialogBox():void
		{
			if(dialogBox == null)
			{
				dialogBox = new FlxSprite(16,160,Registry.dialogBox);
				add(dialogBox);
			}

			
			if(!moretalking && !Registry.talking)
			{
				dialogBox.kill();
				dialogBox = null;
			}
		}
			
	}
}

package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class EarthWorld extends FlxState
	{
		//Variables go here
		private var map:FlxTilemap;
		private var warpGates:WarpGates;
		private var player:Player;
		private var boss:Bosses;
		private var warpGatePlaced:Boolean = false;
		private var bossPlaced:Boolean = false;
		private var hp:FlxText;
		private var bhp:FlxText;
		private var attackRed1:FlxText;
		private var attackGreen1:FlxText;
		private var attackRed2:FlxText;
		private var attackGreen2:FlxText;//add new attack here
		private var pWeapon:PlayersWeapon;
		private var pWeapon2:PlayersWeapon2;   //<---- add the new weapon
		private var bWeapon:BossWeapons;
		private var timer:FlxDelay;
		private var timer2:FlxDelay;
		private var skipCheck:Boolean = true;
		private var skipCheck2:Boolean = false;
				
		override public function create():void
		{	
			FlxG.playMusic(Registry.earth2,1);
			
			Registry.warpGatePlaced2 = false;
			Registry.whoIsAttacking = 0;
			Registry.waitForPlayerToAttack = true;
			
			Registry.world = 4; //update world
			Registry.playerHasAttack1 = true;
			Registry.playerHasAttack2 = true;  //add new attack
			
			map = new FlxTilemap;
			map.loadMap(new Registry[Registry.levels3[Registry.currLevel]],Registry.buildTile5,32,32,0,0,1,2);
			add(map);

			player = new Player(1,23);	//1,23 <> update player position 8,18
			add(player); 
			
			//set the camera and worldbounds
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = 800;
			FlxG.worldBounds.height = 800;
			
			FlxG.camera.setBounds(0, 0, 800, 800);
			FlxG.worldBounds = new FlxRect(0, 0, 800, 800);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			map.setTile(8,11,1); //update to remove warpgate
					
			hud();
			attackRed();
			attackGreen();
			hp.visible = false;
			bhp.visible = false;
			attackRed1.visible = false;
			attackGreen1.visible = false;
			attackRed2.visible = false;   // add new attack here
			attackGreen2.visible = false;
			
			timer = new FlxDelay(1000);
			timer2 = new FlxDelay(1000);
			
			FlxG.play(Registry.warping2,.8);
			
		}	
		
		override public function update():void
		{
			
			if(FlxG.keys.justPressed("Q"))
			{
				trace("player.x = "+player.x+" player.y = "+player.y);
				trace("Registry.whoIsAttacking = "+Registry.whoIsAttacking);
				trace("Registry.fighting = "+Registry.fighting);	
			}
			
			if(player.x == 256 && player.y == 512 && !bossPlaced) //update positions
			{
				placeBoss();
			}
			
			if(player.x == 256 && player.y == 480 && !Registry.fighting && !Registry.boss2Dead) //update positions and boss
			{
				Registry.fighting = true;
			}
			
			if(Registry.fighting)
			{
				fightBoss();
			}
			
			if(!Registry.fighting)
			{
				hp.visible = false;
				attackRed1.visible = false;
				attackRed2.visible = false; //add attack here
				attackGreen1.visible = false;
				attackGreen2.visible = false;
				bhp.visible = false;
				if(!warpGatePlaced && Registry.boss2Dead)
					placeWarpGate();
			}
			
			if(player.hitPoints <= 0 && !skipCheck2)
			{
				trace("player is dead!");
				FlxG.play(Registry.playerDeath,.8);
				player.kill();
				timer2.start();
				skipCheck2 = true;
			}
			
			if(timer2.hasExpired)
			{
				trace("back to Arcaena!");
				Registry.fighting = false;
				FlxG.playMusic(Registry.earth2,0);
				FlxG.switchState( new WorldOfArcaena);
			}
			
			if(timer.hasExpired && !skipCheck)
			{
				if(Registry.whoIsAttacking == 0 && !Registry.waitForPlayerToAttack)
				{
					player.y = 480; //update position
					Registry.bossAttack = true;
					Registry.whoIsAttacking = 1;
					skipCheck = true;
				}
				else if(Registry.whoIsAttacking == 1 && !Registry.bossAttacked)
				{
					boss.y = 384; //update position
					Registry.whoIsAttacking = 0
					Registry.waitForPlayerToAttack = true;
					skipCheck = true;
				}
				
				if(Registry.bossHealth <= 0)
				{
					Registry.fighting = false;
				}
			}
			
			hp.text = "HP: "+player.hitPoints;
			bhp.text = "HP: "+Registry.bossHealth;
			
			if(warpGatePlaced)
			{
				FlxG.overlap(warpGates,player,warp);
			}
			
			if(Registry.playerAttacked)
			{
				if(pWeapon != null)
					FlxG.overlap(pWeapon,boss,bDamage);
				
				if(pWeapon2 != null)
					FlxG.overlap(pWeapon2,boss,bDamage); //add new check here
			}
			
			if(Registry.bossAttacked)
			{
				FlxG.overlap(bWeapon,player,pDamage);
			}
			
			super.update();
			
			FlxG.collide(map,player);
			
		}
		
		private function placeWarpGate():void
		{
			FlxG.play(Registry.warpGateOpen2,.8);
			warpGates = new WarpGates(8,11); //update position
			add(warpGates);
			warpGatePlaced = true;
		}
		
		private function warp(p:FlxSprite,e:FlxSprite):void
		{
			FlxG.playMusic(Registry.earth2,0);
			FlxG.switchState( new WorldOfArcaena);
		}
		
		private function placeBoss():void
		{
			bossPlaced = true;
			boss = new Bosses(8,12); //update position
			add(boss);
		}
		
		private function fightBoss():void
		{
			hp.visible = true;
			bhp.visible = true;
			
			if(Registry.bossHealth > 0)
			{
				if(Registry.whoIsAttacking == 0 && Registry.waitForPlayerToAttack)
				{
					attackGreen1.visible = true;
					attackGreen2.visible = true;
					player.fightBoss();
				}
				
				if(Registry.whoIsAttacking == 1)
				{
					if(Registry.bossAttack)
					{
						trace("Spawning Boss Weapon");
						boss.fightPlayer();
						bWeapon = new BossWeapons(8,13); //update position
						bWeapon.x += 9; //update offset
						add(bWeapon);
						FlxG.play(Registry.earthArrowSnd,.8);
						Registry.damage = 20; //update damage
						Registry.bossAttack = false;
						Registry.bossAttacked = true;
					}
				}
				
				if(Registry.playerAttack1)
				{
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackRed1.visible = true;
					attackRed2.visible = true;
					trace("Spawning Player Weapon1");
					player.y = 448; //update positon
					pWeapon = new PlayersWeapon(8,14);//update positon
					pWeapon.x += 12;
					add(pWeapon);
					FlxG.play(Registry.thought,.8);
					Registry.damage = 10; 
					Registry.playerAttack1 = false;
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;
				}
				
				if(Registry.playerAttack2)
				{
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackRed1.visible = true;
					attackRed2.visible = true;
					trace("Spawning Player Weapon2");
					player.y = 448;
					pWeapon2 = new PlayersWeapon2(8,14);
					pWeapon2.x += 6;
					add(pWeapon2);
					FlxG.play(Registry.lightningSnd,.8);
					Registry.damage = 25;
					Registry.playerAttack2 = false;
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;   //add new attack check here don't forget to update positons, offset and damage
				}
			}
		}
		
		private function bDamage(p:FlxSprite, e:FlxSprite):void
		{
			trace("boss HIT!");
			FlxG.play(Registry.Hit_Hurt60,.8);
			e.health -= Registry.damage;
			p.kill();
			Registry.bossAttacked = false;
			timer.start();
			skipCheck = false;
		}
		
		private function pDamage(p:FlxSprite, e:FlxSprite):void
		{
			trace("player HIT!");
			FlxG.play(Registry.Hit_Hurt23,.8);
			player.hitPoints -= Registry.damage;
			bWeapon.kill();
			Registry.bossAttacked = false;
			timer.start();
			skipCheck = false;
		}
		
		private function hud():void
		{
			hp = new FlxText(FlxG.width*0.5-153,FlxG.height*.05+200, 100, "HP: "+player.hitPoints);
			hp.setFormat(null,12,0xFFFFFF, "center");
			hp.scrollFactor.x = hp.scrollFactor.y = 0;
			add(hp);
			
			bhp = new FlxText(FlxG.width*0.5-153,FlxG.height*.05, 100, "HP: "+Registry.bossHealth);
			bhp.setFormat(null,12,0xFFFFFF, "center");
			bhp.scrollFactor.x = bhp.scrollFactor.y = 0;
			add(bhp);
		}
		
		private function attackRed():void
		{
			attackRed1 = new FlxText(FlxG.width*0.5-150,FlxG.height*.05+150, 200, "1: Thought Projection");
			attackRed1.setFormat(null,12,0xFF0000, "center");
			attackRed1.scrollFactor.x = attackRed1.scrollFactor.y = 0;
			add(attackRed1);
			
			attackRed2 = new FlxText(FlxG.width*0.5-20,FlxG.height*.05+150, 200, "2: Lightning");
			attackRed2.setFormat(null,12,0xFF0000, "center");
			attackRed2.scrollFactor.x = attackRed2.scrollFactor.y = 0;
			add(attackRed2);
		}
		
		private function attackGreen():void
		{
			attackGreen1 = new FlxText(FlxG.width*0.5-150,FlxG.height*.05+150, 200, "1: Thought Projection");
			attackGreen1.setFormat(null,12,0x00FF00, "center");
			attackGreen1.scrollFactor.x = attackGreen1.scrollFactor.y = 0;
			add(attackGreen1);
			
			attackGreen2 = new FlxText(FlxG.width*0.5-20,FlxG.height*.05+150, 200, "2: Lightning");
			attackGreen2.setFormat(null,12,0x00FF00, "center");
			attackGreen2.scrollFactor.x = attackGreen2.scrollFactor.y = 0;
			add(attackGreen2);
		}

	}
}


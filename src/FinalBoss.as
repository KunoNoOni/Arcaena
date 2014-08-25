package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class FinalBoss extends FlxState
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
		private var attackGreen2:FlxText;
		private var attackRed3:FlxText;
		private var attackGreen3:FlxText;
		private var attackRed4:FlxText;
		private var attackGreen4:FlxText;
		private var attackRed5:FlxText;
		private var attackGreen5:FlxText;//add new attack here
		private var pWeapon:PlayersWeapon;
		private var pWeapon2:PlayersWeapon2;
		private var pWeapon3:PlayersWeapon3;
		private var pWeapon4:PlayersWeapon4;
		private var pWeapon5:PlayersWeapon5;//<---- add the new weapon
		private var bWeapon:BossWeapons;
		private var timer:FlxDelay;
		private var timer2:FlxDelay;
		private var skipCheck:Boolean = true;
		private var skipCheck2:Boolean = false;
				
		override public function create():void
		{	
			FlxG.playMusic(Registry.final2,1);
			
			Registry.warpGatePlaced5 = false;
			Registry.whoIsAttacking = 0;
			Registry.waitForPlayerToAttack = true;
			
			Registry.world = 6; //update world
			Registry.playerHasAttack1 = true;
			Registry.playerHasAttack2 = true;
			Registry.playerHasAttack3 = true;
			Registry.playerHasAttack4 = true;
			Registry.playerHasAttack5 = true;//add new attack
			
			Registry.finalLevel = true;
			
			map = new FlxTilemap;
			map.loadMap(new Registry[Registry.levels6[Registry.currLevel]],Registry.buildTile7,32,32,0,0,1,2); //update map
			add(map);

			player = new Player(1,48);	//1,48 <> update player position 45,8
			add(player); 
			
			//set the camera and worldbounds
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = 1600;
			FlxG.worldBounds.height = 1600;
			
			FlxG.camera.setBounds(0, 0, 1600, 1600);
			FlxG.worldBounds = new FlxRect(0, 0, 1600, 1600);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			map.setTile(47,1,1); //update to remove warpgate
			
			hud();
			attackRed();
			attackGreen();
			hp.visible = false;
			bhp.visible = false;
			attackRed1.visible = false;
			attackRed2.visible = false;
			attackRed3.visible = false;
			attackRed4.visible = false;
			attackRed5.visible = false;
			attackGreen1.visible = false;
			attackGreen2.visible = false;
			attackGreen3.visible = false;
			attackGreen4.visible = false;
			attackGreen5.visible = false;// add new attack here
			
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
			
			if(player.x == 1504 && player.y == 192 && !bossPlaced) //update positions
			{
				placeBoss();
			}
			
			if(player.x == 1504 && player.y == 160 && !Registry.fighting && !Registry.boss5Dead) //update positions and boss
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
				attackRed2.visible = false;
				attackRed3.visible = false;
				attackRed4.visible = false;
				attackRed5.visible = false;
				attackGreen1.visible = false;
				attackGreen2.visible = false;
				attackGreen3.visible = false;
				attackGreen4.visible = false;
				attackGreen5.visible = false;//add attack here
				bhp.visible = false;
				if(!warpGatePlaced && Registry.boss5Dead) //update boss
					placeWarpGate();
			}
			
			if(player.hitPoints <= 0 && !skipCheck2)
			{
				FlxG.play(Registry.playerDeath,.8);
				player.kill();
				timer2.start();
				skipCheck2 = true;
			}
			
			if(timer2.hasExpired)
			{
				Registry.fighting = false;
				FlxG.playMusic(Registry.final2,0);
				FlxG.switchState( new WorldOfArcaena);
			}
			
			if(timer.hasExpired && !skipCheck)
			{
				if(Registry.whoIsAttacking == 0 && !Registry.waitForPlayerToAttack)
				{
					player.y = 160; //update position
					Registry.bossAttack = true;
					Registry.whoIsAttacking = 1;
					skipCheck = true;
				}
				else if(Registry.whoIsAttacking == 1 && !Registry.bossAttacked)
				{
					boss.y = 64; //update position
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
					FlxG.overlap(pWeapon2,boss,bDamage);
				
				if(pWeapon3 != null)
					FlxG.overlap(pWeapon3,boss,bDamage);
				
				if(pWeapon4 != null)
					FlxG.overlap(pWeapon4,boss,bDamage);
				
				if(pWeapon5 != null)
					FlxG.overlap(pWeapon5,boss,bDamage);//add new check here
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
			warpGates = new WarpGates(47,1); //update position
			add(warpGates);
			warpGatePlaced = true;
		}
		
		private function warp(p:FlxSprite,e:FlxSprite):void
		{
			FlxG.playMusic(Registry.final2,0);
			FlxG.switchState( new WorldOfArcaena);
		}
		
		private function placeBoss():void
		{
			bossPlaced = true;
			boss = new Bosses(47,2); //update position
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
					attackGreen3.visible = true;
					attackGreen4.visible = true;
					attackGreen5.visible = true;
					player.fightBoss();
				}
				
				if(Registry.whoIsAttacking == 1)
				{
					if(Registry.bossAttack) //this boss can use all attacks. Damage is random from 7 to 15
					{
						//trace("Spawning Boss Weapon");
						boss.fightPlayer();
						bWeapon = new BossWeapons(47,3); //update position
						add(bWeapon);
						Registry.bossAttack = false;
						Registry.bossAttacked = true;
					}
				}
				
				if(Registry.playerAttack1)
				{
					attackRed1.visible = true;
					attackRed2.visible = true;
					attackRed3.visible = true;
					attackRed4.visible = true;
					attackRed5.visible = true;
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackGreen3.visible = false;
					attackGreen4.visible = false;
					attackGreen5.visible = false;
					//trace("Spawning Player Weapon1");
					player.y = 128; //update positon
					pWeapon = new PlayersWeapon(47,4);//update positon
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
					attackRed1.visible = true;
					attackRed2.visible = true;
					attackRed3.visible = true;
					attackRed4.visible = true;
					attackRed5.visible = true;
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackGreen3.visible = false;
					attackGreen4.visible = false;
					attackGreen5.visible = false;
					//trace("Spawning Player Weapon2");
					player.y = 128; //update position
					pWeapon2 = new PlayersWeapon2(47,4); //update position
					pWeapon2.x += 6;
					add(pWeapon2);
					FlxG.play(Registry.lightningSnd,.8);
					Registry.damage = 25;
					Registry.playerAttack2 = false;
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;   
				} 
				
				if(Registry.playerAttack3)
				{
					attackRed1.visible = true;
					attackRed2.visible = true;
					attackRed3.visible = true;
					attackRed4.visible = true;
					attackRed5.visible = true;
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackGreen3.visible = false;
					attackGreen4.visible = false;
					attackGreen5.visible = false;
					//trace("Spawning Player Weapon3");
					player.y = 128; //update position
					pWeapon3 = new PlayersWeapon3(47,4); //update position
					pWeapon3.x += 10; //update to new weapon
					add(pWeapon3); // update ro new weapon
					FlxG.play(Registry.earthArrowSnd,.8);
					Registry.damage = 30;
					Registry.playerAttack3 = false; //update this after it is copied
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;   
				}
				
				if(Registry.playerAttack4) //update to new weapon
				{
					attackRed1.visible = true;
					attackRed2.visible = true;
					attackRed3.visible = true;
					attackRed4.visible = true;
					attackRed5.visible = true;
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackGreen3.visible = false;
					attackGreen4.visible = false;
					attackGreen5.visible = false;
					//trace("Spawning Player Weapon4");
					player.y = 128; //update position
					pWeapon4 = new PlayersWeapon4(47,4); //update position
					pWeapon4.x += 10; //update to new weapon
					add(pWeapon4); // update ro new weapon
					FlxG.play(Registry.waterBallSnd,.8);
					Registry.damage = 35;
					Registry.playerAttack4 = false; //update this after it is copied
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;   
				}
				
				if(Registry.playerAttack5) //update to new weapon
				{
					attackRed1.visible = true;
					attackRed2.visible = true;
					attackRed3.visible = true;
					attackRed4.visible = true;
					attackRed5.visible = true;
					attackGreen1.visible = false;
					attackGreen2.visible = false;
					attackGreen3.visible = false;
					attackGreen4.visible = false;
					attackGreen5.visible = false;
					//trace("Spawning Player Weapon5");
					player.y = 128; //update position
					pWeapon5 = new PlayersWeapon5(47,4); //update position
					pWeapon5.x += 6; //update to new weapon
					add(pWeapon5); // update ro new weapon
					FlxG.play(Registry.fireWaveSnd,.8);
					Registry.damage = 50;
					Registry.playerAttack5 = false; //update this after it is copied
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;   
				}//add new attack check here don't forget to update positons, offset and damage
			}
		}
		
		private function bDamage(p:FlxSprite, e:FlxSprite):void
		{
			//trace("boss HIT!");
			FlxG.play(Registry.Hit_Hurt60,.8);
			e.health -= Registry.damage;
			p.kill();
			Registry.bossAttacked = false;
			timer.start();
			skipCheck = false;
		}
		
		private function pDamage(p:FlxSprite, e:FlxSprite):void
		{
			//trace("player HIT!");
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
			
			attackRed3 = new FlxText(FlxG.width*0.5-175,FlxG.height*.05+165, 200, "3: Earth Arrow");
			attackRed3.setFormat(null,12,0xFF0000, "center");
			attackRed3.scrollFactor.x = attackRed3.scrollFactor.y = 0;
			add(attackRed3);
			
			attackRed4 = new FlxText(FlxG.width*0.5-70,FlxG.height*.05+165, 200, "4: Water Ball");
			attackRed4.setFormat(null,12,0xFF0000, "center");
			attackRed4.scrollFactor.x = attackRed4.scrollFactor.y = 0;
			add(attackRed4);
			
			attackRed5 = new FlxText(FlxG.width*0.5-183,FlxG.height*.05+180, 200, "5: Fire Wave");
			attackRed5.setFormat(null,12,0xFF0000, "center");
			attackRed5.scrollFactor.x = attackRed5.scrollFactor.y = 0;
			add(attackRed5);
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
			
			attackGreen3 = new FlxText(FlxG.width*0.5-175,FlxG.height*.05+165, 200, "3: Earth Arrow");
			attackGreen3.setFormat(null,12,0x00FF00, "center");
			attackGreen3.scrollFactor.x = attackGreen3.scrollFactor.y = 0;
			add(attackGreen3);
			
			attackGreen4 = new FlxText(FlxG.width*0.5-70,FlxG.height*.05+165, 200, "4: Water Ball");
			attackGreen4.setFormat(null,12,0x00FF00, "center");
			attackGreen4.scrollFactor.x = attackGreen4.scrollFactor.y = 0;
			add(attackGreen4);
			
			attackGreen5 = new FlxText(FlxG.width*0.5-183,FlxG.height*.05+180, 200, "5: Fire Wave");
			attackGreen5.setFormat(null,12,0x00FF00, "center");
			attackGreen5.scrollFactor.x = attackGreen5.scrollFactor.y = 0;
			add(attackGreen5);
		}
	}
}


package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class AirWorld extends FlxState
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
		private var pWeapon:PlayersWeapon;
		private var bWeapon:BossWeapons;
		private var timer:FlxDelay;
		private var timer2:FlxDelay;
		private var skipCheck:Boolean = true;
		private var skipCheck2:Boolean = false;;
				
		override public function create():void
		{	
			FlxG.playMusic(Registry.air2,1);
			
			Registry.warpGatePlaced1 = false;
			
			Registry.world = 5;
			Registry.playerHasAttack1 = true;
			Registry.whoIsAttacking = 0;
			Registry.waitForPlayerToAttack = true;
			
			map = new FlxTilemap;
			map.loadMap(new Registry[Registry.levels2[Registry.currLevel]],Registry.buildTile6,32,32,0,0,1,2);
			add(map);

			player = new Player(1,23); //1,23 14,9
			add(player); 
			
			//set the camera and worldbounds
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = 800;
			FlxG.worldBounds.height = 800;
			
			FlxG.camera.setBounds(0, 0, 800, 800);
			FlxG.worldBounds = new FlxRect(0, 0, 800, 800);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			map.setTile(14,3,1);

			hud();
			attackRed();
			attackGreen();
			hp.visible = false;
			bhp.visible = false;
			attackRed1.visible = false;
			attackGreen1.visible = false;
			
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
				trace("Registry.warpGatePlaced1 = " + Registry.warpGatePlaced1);
			}
			
			if(player.x == 448 && player.y == 256 && !bossPlaced)
			{
				placeBoss();
			}
			
			if(player.x == 448 && player.y == 224 && !Registry.fighting && !Registry.boss1Dead)
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
				attackGreen1.visible = false;
				bhp.visible = false;
				if(!warpGatePlaced && Registry.boss1Dead)
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
				FlxG.playMusic(Registry.air2,0);
				FlxG.switchState( new WorldOfArcaena);
			}
			
			if(timer.hasExpired && !skipCheck)
			{	
				if(Registry.whoIsAttacking == 0 && !Registry.waitForPlayerToAttack)
				{
					player.y = 224;
					Registry.bossAttack = true;
					Registry.whoIsAttacking = 1;
					skipCheck = true;
				}
				else if(Registry.whoIsAttacking == 1 && !Registry.bossAttacked)
				{
					boss.y = 128;
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
				FlxG.overlap(pWeapon,boss,bDamage);
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
			warpGates = new WarpGates(14,3);
			add(warpGates);
			warpGatePlaced = true;
		}
		
		private function warp(p:FlxSprite,e:FlxSprite):void
		{
			FlxG.playMusic(Registry.air2,0);
			FlxG.switchState( new WorldOfArcaena);
		}
		
		private function placeBoss():void
		{
			bossPlaced = true;
			boss = new Bosses(14,4);
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
					player.fightBoss();
				}
				
				if(Registry.whoIsAttacking == 1)
				{
					if(Registry.bossAttack)
					{
						trace("Spawning Boss Weapon");
						boss.fightPlayer();
						bWeapon = new BossWeapons(14,5);
						bWeapon.x += 6;
						add(bWeapon);
						FlxG.play(Registry.lightningSnd,.8);
						Registry.damage = 15;
						Registry.bossAttack = false;
						Registry.bossAttacked = true;
					}
				}
				
				if(Registry.playerAttack1)
				{
					attackGreen1.visible = false;
					attackRed1.visible = true;
					trace("Spawning Player Weapon");
					player.y = 192;
					pWeapon = new PlayersWeapon(14,6);
					pWeapon.x += 12;
					add(pWeapon);
					FlxG.play(Registry.thought,.8);
					Registry.damage = 20;
					Registry.playerAttack1 = false;
					Registry.waitForPlayerToAttack = false;
					Registry.playerAttacked = true;
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
			hp.setFormat(null,12,0x000000, "center");
			hp.scrollFactor.x = hp.scrollFactor.y = 0;
			add(hp);
			
			bhp = new FlxText(FlxG.width*0.5-153,FlxG.height*.05, 100, "HP: "+Registry.bossHealth);
			bhp.setFormat(null,12,0x000000, "center");
			bhp.scrollFactor.x = bhp.scrollFactor.y = 0;
			add(bhp);
		}
		
		private function attackRed():void
		{
			attackRed1 = new FlxText(FlxG.width*0.5-150,FlxG.height*.05+150, 200, "1: Thought Projection");
			attackRed1.setFormat(null,12,0xFF0000, "center");
			attackRed1.scrollFactor.x = attackRed1.scrollFactor.y = 0;
			add(attackRed1);
		}
		
		private function attackGreen():void
		{
			attackGreen1 = new FlxText(FlxG.width*0.5-150,FlxG.height*.05+150, 200, "1: Thought Projection");
			attackGreen1.setFormat(null,12,0x00FF00, "center");
			attackGreen1.scrollFactor.x = attackGreen1.scrollFactor.y = 0;
			add(attackGreen1);
		}
		
	}
}


package
{
	import org.flixel.*;

	public class Registry
	{
		//public static var levelIndex:int = 0;
		public static var levels:Array = ["null","earth"];
		public static var levels1:Array = ["null","WorldOfArcaena"];
		public static var levels2:Array = ["null","AirWorld"];
		public static var levels3:Array = ["null","EarthWorld"];
		public static var levels4:Array = ["null","WaterWorld"];
		public static var levels5:Array = ["null","FireWorld"];
		public static var levels6:Array = ["null","FinalBoss"];
		public static var currLevel:int = 1;
		public static var world:int = 0; //0=start 1=arcaena 2=fire 3=water 4=earth 5=air 6=boss
		public static var warpGateOpened:int = 0;
		public static var talking:Boolean = false;
		public static var dialog:int = 0; //<--- set this for testing
		public static var dialogSet:int = 0;
		public static var warpGatePlaced1:Boolean = false;
		public static var warpGatePlaced2:Boolean = false;
		public static var warpGatePlaced3:Boolean = false;
		public static var warpGatePlaced4:Boolean = false;
		public static var warpGatePlaced5:Boolean = false;
		public static var warpGateHome:Boolean = false;
		public static var fighting:Boolean = false;
		public static var whoIsAttacking:int = 0; //0 = player, 1 = boss
		public static var damage:int = 0;
		public static var bossHealth:int = 0;
		public static var bossAttacked:Boolean = false;
		public static var bossAttack:Boolean = false;
		public static var boss1Dead:Boolean = false; //<--- set this for testing
		public static var boss2Dead:Boolean = false; //<--- set this for testing
		public static var boss3Dead:Boolean = false; //<--- set this for testing
		public static var boss4Dead:Boolean = false; //<--- set this for testing
		public static var boss5Dead:Boolean = false; //<--- set this for testing
		public static var waitForPlayerToAttack:Boolean = true;
		public static var playerAttacked:Boolean = false;
		public static var playerAttack1:Boolean = false;
		public static var playerAttack2:Boolean = false;
		public static var playerAttack3:Boolean = false;
		public static var playerAttack4:Boolean = false;
		public static var playerAttack5:Boolean = false;
		public static var playerHasAttack1:Boolean = false;
		public static var playerHasAttack2:Boolean = false;
		public static var playerHasAttack3:Boolean = false;
		public static var playerHasAttack4:Boolean = false;
		public static var playerHasAttack5:Boolean = false;
		public static var playerDead:Boolean = false;
		public static var finalLevel:Boolean = false;
		public static var finalBossWeapon:int = 0;

		[Embed(source = 'Sprites/buildTile1.png')] static public var buildTile1:Class;
		[Embed(source = 'Sprites/buildTile2.png')] static public var buildTile2:Class;
		[Embed(source = 'Sprites/buildTile3.png')] static public var buildTile3:Class;
		[Embed(source = 'Sprites/buildTile4.png')] static public var buildTile4:Class;
		[Embed(source = 'Sprites/buildTile5.png')] static public var buildTile5:Class;
		[Embed(source = 'Sprites/buildTile6.png')] static public var buildTile6:Class;
		[Embed(source = 'Sprites/buildTile7.png')] static public var buildTile7:Class;
		[Embed(source = 'Sprites/dialogBox.png')] static public var dialogBox:Class;
		[Embed(source = 'Sprites/player.png')] static public var player:Class;
		[Embed(source = 'Sprites/warpGates.png')] static public var warpGates:Class;
		[Embed(source = 'Sprites/bosses.png')] static public var bosses:Class;
		[Embed(source = 'Sprites/thoughtBullet.png')] static public var thoughtBullet:Class;
		[Embed(source = 'Sprites/fireWave.png')] static public var fireWave:Class;
		[Embed(source = 'Sprites/waterBall.png')] static public var waterBall:Class;
		[Embed(source = 'Sprites/earthArrow.png')] static public var earthArrow:Class;
		[Embed(source = 'Sprites/lightning.png')] static public var lightning:Class;
		[Embed(source = 'Sprites/warpGateTitle2.png')] static public var wgt:Class;
					
		[Embed(source = 'Maps/mapCSV_Group1_Map1.csv', mimeType = 'application/octet-stream')] static public var earth:Class;
		[Embed(source = 'Maps/mapCSV_Group2_Map1.csv', mimeType = 'application/octet-stream')] static public var WorldOfArcaena:Class;
		[Embed(source = 'Maps/mapCSV_Group3_Map1.csv', mimeType = 'application/octet-stream')] static public var AirWorld:Class;
		[Embed(source = 'Maps/mapCSV_Group4_Map1.csv', mimeType = 'application/octet-stream')] static public var EarthWorld:Class;
		[Embed(source = 'Maps/mapCSV_Group5_Map1.csv', mimeType = 'application/octet-stream')] static public var WaterWorld:Class;
		[Embed(source = 'Maps/mapCSV_Group6_Map1.csv', mimeType = 'application/octet-stream')] static public var FireWorld:Class;
		[Embed(source = 'Maps/mapCSV_Group7_Map1.csv', mimeType = 'application/octet-stream')] static public var FinalBoss:Class;
		
		[Embed(source = 'sounds/ChatType.mp3')] static public var ChatType:Class;
		[Embed(source = 'sounds/bossDeath.mp3')] static public var bossDeath:Class;
		[Embed(source = 'sounds/earthArrow.mp3')] static public var earthArrowSnd:Class;
		[Embed(source = 'sounds/fireWave.mp3')] static public var fireWaveSnd:Class;
		[Embed(source = 'sounds/Hit_Hurt23.mp3')] static public var Hit_Hurt23:Class;
		[Embed(source = 'sounds/Hit_Hurt60.mp3')] static public var Hit_Hurt60:Class;
		[Embed(source = 'sounds/lightning.mp3')] static public var lightningSnd:Class;
		[Embed(source = 'sounds/playerDeath.mp3')] static public var playerDeath:Class;
		[Embed(source = 'sounds/thought.mp3')] static public var thought:Class;
		[Embed(source = 'sounds/walking3.mp3')] static public var walking3:Class;
		[Embed(source = 'sounds/warpGateOpen2.mp3')] static public var warpGateOpen2:Class;
		[Embed(source = 'sounds/warping2.mp3')] static public var warping2:Class;
		[Embed(source = 'sounds/waterBall.mp3')] static public var waterBallSnd:Class;
		
		//Music
		[Embed(source = 'Music/TheTallDwarf.mp3')] static public var start2:Class;
		[Embed(source = 'Music/ShapeOfBloods.mp3')] static public var arcaena1:Class;
		[Embed(source = 'Music/PearsAndAges.mp3')] static public var air2:Class;
		[Embed(source = 'Music/ALovelyApple.mp3')] static public var earth2:Class;
		[Embed(source = 'Music/OnTheFishsRoad.mp3')] static public var water2:Class;
		[Embed(source = 'Music/ApplesOfAnOrange.mp3')] static public var fire2:Class;		
		[Embed(source = 'Music/ALeprechaunsOceans.mp3')] static public var final2:Class;
		[Embed(source = 'Music/TheBrownBranch.mp3')] static public var title1:Class;
		
		
		//[Embed(source="../assets/celtic-bitty.ttf", fontFamily="Celtic", embedAsCFF="false")] static public var fntCeltic:String;
		
		public function Registry()
		{
		}
	}
}

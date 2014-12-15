package MortalKombatQuest.animation 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import MortalKombatQuest.kernel.Atlas;
	import MortalKombatQuest.kernel.Mechanics;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.buttons.Button;
	import MortalKombatQuest.fighters.FighterIcon;
	
	public class Stairs extends MovieClip 
	{
		private var _bg:Bitmap;
		private var _stairsBigAtlas:Bitmap;
		private var _stairsSmallAtlas:Bitmap;
		private var _stairsPlatform:Sprite;
		private var _fighterIcon:Bitmap;
		
		private var _battonPlay:Button;
		private var _battonBack:Button;
		private var _battonSetting:Button;
			
		public function Stairs() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.TournamentAtlas, 751, 665, 400, 252, true, 0x000000000000, 352, 0, 751, 252, 0, 0).bitmapData);
			_bg.scaleX += 1.05;
			_bg.scaleY += 1.5;
			_bg.smoothing = true;
			this.addChild(_bg);
			
			_stairsPlatform = new Sprite();
			
			/* Инициализация соперников */
			if (Resource.TournamentWin == 0) initTournamentFighters();
			
			/* Иконки соперников */
			for (var i:int = 0; i < Resource.TournamentFighters.length; i++) {
				showIconTournamentFighters(i);
			}
			
			/* Турнирный столб */
			_stairsBigAtlas = new Bitmap(Atlas.AtlasGetBitmap(Resource.TournamentAtlas, 751, 665, 350, 665, true, 0x000000000000, 0, 0, 350, 665, 0, 0).bitmapData);
			_stairsPlatform.addChild(_stairsBigAtlas);
			_stairsPlatform.x = 250; 
			if (Resource.TournamentWin == 0) _stairsPlatform.y = 1100;
			_stairsSmallAtlas = new Bitmap(Atlas.AtlasGetBitmap(Resource.TournamentAtlas, 751, 665, 350, 665, true, 0x000000000000, 0, 0, 350, 577, 0, 0).bitmapData);
			_stairsSmallAtlas.y = -577;
			_stairsPlatform.addChild(_stairsSmallAtlas);
			
			/* Иконка игрока */
			_fighterIcon = new Bitmap(Resource.FIGHTER_ICON.bitmapData);
			_fighterIcon.x = 100; 
			if (Resource.TournamentWin == 0) _fighterIcon.y = 505;
			if (Resource.TournamentWin == 1) _fighterIcon.y = 505;
			if (Resource.TournamentWin == 2) _fighterIcon.y = 405;
			if (Resource.TournamentWin == 3) _fighterIcon.y = 305;
			if (Resource.TournamentWin == 4) _fighterIcon.y = 205;
			if (Resource.TournamentWin == 5) _fighterIcon.y = 105;
			if (Resource.TournamentWin == 6) _fighterIcon.y = 5;
			if (Resource.TournamentWin == 7) _fighterIcon.y = -105;
			if (Resource.TournamentWin == 8) _fighterIcon.y = -205;
			if (Resource.TournamentWin == 9) _fighterIcon.y = -305;
			if (Resource.TournamentWin == 10) _fighterIcon.y = -405;
			if (Resource.TournamentWin == 11) _fighterIcon.y = -505;
			
			_stairsPlatform.addChild(_fighterIcon);
						
			this.addChild(_stairsPlatform);
			
			buttonSettings();
			buttonBack();
			buttonPlay();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		/* Анимация */
		private function onEnterFrame(e:Event):void 
		{
			if (Resource.TournamentWin == 0){
				if (_stairsPlatform.y == -50) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
				else _stairsPlatform.y -= 10;
			}else {
				if (Resource.TournamentWin == 1) { // с 1 на 2
					_stairsPlatform.y = -50
					_stairsPlatform.y += 1;
					if (_fighterIcon.y <= (505 - 100)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 2) { // с 2 на 3
					_stairsPlatform.y = -50
					if (_fighterIcon.y <= (405 - 95)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 3) { // с 3 на 4
					_stairsPlatform.y = -50
					if (_fighterIcon.y <= (305 - 93)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 4) { // с 4 на 5
					_stairsPlatform.y = -50
					if (_fighterIcon.y <= (205 - 90)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 5) { // с 5 на 6
					_stairsPlatform.y = -5; 
					if (_fighterIcon.y <= (105 - 85)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 6) { // с 6 на 7
					_stairsPlatform.y = 97;
					if (_fighterIcon.y <= (5 - 80)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 7) { // с 7 на 8
					_stairsPlatform.y = 194;
					if (_fighterIcon.y <= (-105 - 65)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 8) { // с 8 на 7
					_stairsPlatform.y = 291;
					if (_fighterIcon.y <= (-205 - 60)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 9) { // с 9 на 10
					_stairsPlatform.y = 388;
					if (_fighterIcon.y <= (-305 - 60)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 10) { // с 10 на 11
					_stairsPlatform.y = 485;
					if (_fighterIcon.y <= (-405 - 55)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
				if (Resource.TournamentWin == 11) { // с 11 на 12
					_stairsPlatform.y = 582;
					if (_fighterIcon.y <= (-505 - 52)) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					else _fighterIcon.y -= 2;
				}
			}
		}
		
		/* Инициализация врагов в турнире */
		private function initTournamentFighters():void 
		{
			var posX:int = 174;
			var posY:int = -557;
			Resource.TournamentFighters = [];
			Resource.TournamentFighters[0] = ["SHAOKAHN_MK3U", 174, posY];	posY += 97; 
			Resource.TournamentFighters[1] = ["KINTARO_MK2", 174, posY];	posY += 97;
			Resource.TournamentFighters[2] = ["MOTARO_MK3U", 174, posY];	posY += 97;
			Resource.TournamentFighters[3] = ["GORO_MK1", 174, posY];	posY += 97;
			Resource.TournamentFighters[4] = [randomTournamentFighters(), 174, posY]; posY += 95;
			Resource.TournamentFighters[5] = [randomTournamentFighters(), 174, posY]; posY += 95;
			Resource.TournamentFighters[6] = [randomTournamentFighters(), 174, posY]; posY += 95;
			Resource.TournamentFighters[7] = [randomTournamentFighters(), 174, posY]; posY += 97;
			Resource.TournamentFighters[8] = [randomTournamentFighters(), 174, posY]; posY += 97;
			Resource.TournamentFighters[9] = [randomTournamentFighters(), 174, posY]; posY += 97;
			Resource.TournamentFighters[10] = [randomTournamentFighters(), 174, posY]; posY += 97;
			Resource.TournamentFighters[11] = [randomTournamentFighters(), 174, posY]; posY += 95;
		}
		
		/* Отображение врагов в лестнице */
		private function showIconTournamentFighters(index:int):void
		{
			var fighterIcon:Bitmap;
			if (Resource.TournamentFighters[index][0] == "SHAOKAHN_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 236, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KINTARO_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 489, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "MOTARO_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 236, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "GORO_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 627, 48, 59, 0, 0).bitmapData);
			
			if (Resource.TournamentFighters[index][0] == "KITANA_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "REPTILE_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SONYA_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "JAX_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "NIGHTWOLF_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "JADE_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 240, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SCORPION_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 288, 0, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "RAIN_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KANO_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "MILEENA_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "ERMAC_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SUBZERO_1_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 59, 48, 59, 0, 0).bitmapData);
			
			if (Resource.TournamentFighters[index][0] == "SUBZERO_2_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 240, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "NOOBSAIBOT_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 288, 59, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SEKTOR_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 118, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SINDEL_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 118, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "STRYKER_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 118, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SYREX_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 118, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KUNGLAO_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 118, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KABAL_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 177, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SHEEVA_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 177, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SHANGTSUNG_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 177, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "LIUKANG_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 177, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SMOKE_MK3U") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 177, 48, 59, 0, 0).bitmapData);
			
			if (Resource.TournamentFighters[index][0] == "LIUKANG_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 312, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KUNGLAO_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 312, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "JOHNYCAGE_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 312, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "REPTILE_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 312, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SUBZERO_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 371, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SHANGTSUNG_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 371, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KITANA_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 371, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "JAX_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 371, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "MILEENA_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 430, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "BARAKA_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 430, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SCORPION_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 430, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "RAIDEN_MK2") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 430, 48, 59, 0, 0).bitmapData);
			
			if (Resource.TournamentFighters[index][0] == "JOHNYCAGE_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 568, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "KANO_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 568, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SUBZERO_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 568, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SONYA_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 568, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "RAIDEN_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 627, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "LIUKANG_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 627, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SCORPION_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 627, 48, 59, 0, 0).bitmapData);
			if (Resource.TournamentFighters[index][0] == "SHANGTSUNG_MK1") fighterIcon = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 627, 48, 59, 0, 0).bitmapData);
			
			fighterIcon.x = Resource.TournamentFighters[index][1]; 
			fighterIcon.y = Resource.TournamentFighters[index][2];
			_stairsPlatform.addChild(fighterIcon);
		}
		
		/* Генерация случайных врагов */
		private function randomTournamentFighters():String
		{
			// 44 соперника
			var fighterIndex:String;
			var index:int = Mechanics.RandomIndex();
			if (index >= 0 && index <= 2) fighterIndex = "0";
			if (index > 2 && index <= 4) fighterIndex = "1";
			if (index > 4 && index <= 6) fighterIndex = "2";
			if (index > 6 && index <= 8) fighterIndex = "3";
			if (index > 8 && index <= 10) fighterIndex = "4";
			
			if (fighterIndex == "0") {
				index = Mechanics.RandomIndex();
				if (index == 0 || index == 10) fighterIndex = "01";
				else fighterIndex += index.toString();
			} else {
				if (fighterIndex == "1") {
					index = Mechanics.RandomIndex();
					if (index == 0 || index == 10) fighterIndex = "10";
					else fighterIndex += index.toString()
				}else {
					if (fighterIndex == "2") {
						index = Mechanics.RandomIndex();
						if (index == 0 || index == 10) fighterIndex = "20";
						else fighterIndex += index.toString()
					}else {
						if (fighterIndex == "3") {
							index = Mechanics.RandomIndex();
							if (index == 0 || index == 10) fighterIndex = "30";
							else fighterIndex += index.toString()
						}else {
						
							if (fighterIndex == "4") {
								index = Mechanics.RandomIndex();
								if (index == 0 || index == 10) fighterIndex = "40";
								if (index > 0 && index <= 3) fighterIndex = "41";
								if (index > 3 && index <= 5) fighterIndex = "42";
								if (index > 5 && index <= 8) fighterIndex = "43";
								if (index > 8 && index < 10) fighterIndex = "44";
							}
						}
					}
				}
			}
			
			if (fighterIndex == "01") return "KITANA_MK3U";
			if (fighterIndex == "02") return "REPTILE_MK3U";
			if (fighterIndex == "03") return "SONYA_MK3U";
			if (fighterIndex == "04") return "JAX_MK3U";
			if (fighterIndex == "05") return "NIGHTWOLF_MK3U";
			if (fighterIndex == "06") return "JADE_MK3U";
			if (fighterIndex == "07") return "SCORPION_MK3U";
			if (fighterIndex == "08") return "RAIN_MK3U";
			if (fighterIndex == "09") return "KANO_MK3U";
			if (fighterIndex == "10") return "MILEENA_MK3U";
			if (fighterIndex == "11") return "ERMAC_MK3U";
			if (fighterIndex == "12") return "SUBZERO_1_MK3U";
			if (fighterIndex == "13") return "SUBZERO_2_MK3U";
			if (fighterIndex == "14") return "NOOBSAIBOT_MK3U";
			if (fighterIndex == "15") return "SEKTOR_MK3U";
			if (fighterIndex == "16") return "SINDEL_MK3U";
			if (fighterIndex == "17") return "STRYKER_MK3U";
			if (fighterIndex == "18") return "SYREX_MK3U";
			if (fighterIndex == "19") return "KUNGLAO_MK3U";
			if (fighterIndex == "20") return "KABAL_MK3U";
			if (fighterIndex == "21") return "SHEEVA_MK3U";
			if (fighterIndex == "22") return "SHANGTSUNG_MK3U";
			if (fighterIndex == "23") return "LIUKANG_MK3U";
			if (fighterIndex == "24") return "SMOKE_MK3U";
			if (fighterIndex == "25") return "LIUKANG_MK2";
			if (fighterIndex == "26") return "KUNGLAO_MK2";
			if (fighterIndex == "27") return "JOHNYCAGE_MK2";
			if (fighterIndex == "28") return "REPTILE_MK2";
			if (fighterIndex == "29") return "SUBZERO_MK2";
			if (fighterIndex == "30") return "SHANGTSUNG_MK2";
			if (fighterIndex == "31") return "KITANA_MK2";
			if (fighterIndex == "32") return "JAX_MK2";
			if (fighterIndex == "33") return "MILEENA_MK2";
			if (fighterIndex == "34") return "BARAKA_MK2";
			if (fighterIndex == "35") return "SCORPION_MK2";
			if (fighterIndex == "36") return "RAIDEN_MK2";
			if (fighterIndex == "37") return "JOHNYCAGE_MK1";
			if (fighterIndex == "38") return "KANO_MK1";
			if (fighterIndex == "39") return "SUBZERO_MK1";
			if (fighterIndex == "40") return "SONYA_MK1";
			if (fighterIndex == "41") return "RAIDEN_MK1";
			if (fighterIndex == "42") return "LIUKANG_MK1";
			if (fighterIndex == "43") return "SCORPION_MK1";
			if (fighterIndex == "44") return "SHANGTSUNG_MK1";
			
			return "NOT";
		}
		
		/* КНОПКИ: Назад, Настройки, Играть */
		private function buttonSettings():void
		{
			if (Resource.Language == "eng") _battonSetting = new Button(10, 510, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Settings", 40);
			else _battonSetting = new Button(10, 510, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Настройки", 30);
			_battonSetting.addEventListener(MouseEvent.CLICK, onMouseClickButtonSettings);
			this.addChild(_battonSetting);
		}
		
		private function onMouseClickButtonSettings(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_FALSE_SHOW" }, true));
		}
		
		private function buttonBack():void
		{
			if (Resource.Language == "eng") _battonBack = new Button(10, 555, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Back", 50);
			else _battonBack = new Button(10, 555, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Назад", 40);
			_battonBack.addEventListener(MouseEvent.CLICK, onMouseClickButtonBack);
			this.addChild(_battonBack);
		}
		
		private function onMouseClickButtonBack(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_BACK_IN_SELECT_FIGHTERS" }, true));
		}
		
		private function buttonPlay():void
		{
			if (Resource.Language == "eng")_battonPlay = new Button(640, 555, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Fight", 50);
			else _battonPlay = new Button(640, 555, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Поединок", 30);
			_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
			this.addChild(_battonPlay);
		}
		
		private function onMouseClickButtonPlay(e:Event):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_TOURNAMENT_FIGHT" }, true));
		}
		
	}

}
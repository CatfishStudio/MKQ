package MortalKombatQuest.level 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import flash.events.TimerEvent; 
	
	import MortalKombatQuest.kernel.Atlas;
	import MortalKombatQuest.kernel.Mechanics;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.buttons.Button;
	import MortalKombatQuest.animation.Fighter;
	import MortalKombatQuest.animation.FighterWin;
	import MortalKombatQuest.animation.Blood;
	import MortalKombatQuest.units.Cell;
	import MortalKombatQuest.units.Unit;
	import MortalKombatQuest.windows.GameEnd;
	
	public class Level extends MovieClip 
	{
		/* Фоновая картинка */
		private var _bg:Bitmap; // фоновая картинка уровня
		
		/* Анимация бойцов */
		private var _userFighter:MovieClip; // анимация игрока
		private var _botFighter:MovieClip;	// анимация бота
		
		/* Кнопки и окна */
		private var _battonBack:Button;		// кнопка назад к турнирной лестнице
		private var _battonSetting:Button;	// кнопка настройки
		private var _windowGameEnd:GameEnd;		// окно завершения уровня
		
		
		/* Показатели */
		public var userXP:int = 0;				// жизнь пользователя
		public var userMana:int = 0;			// мана пользователя
		public var userBlock:int = 0;			// блок
		public var botXP:int = 0;				// жизнь бота
		public var botMana:int = 0;				// мана бота
		public var botBlock:int = 0;			// блок
		public var actionPlayer:String = "USER";	// активный игрок для выполнения удара
		private var _gameEnd:Boolean = false;	// флаг завершения уровня
		
		/* индикаторы */
		private var _userLabelXP:Label;
		private var _userLabelMana:Label;
		private var _userIndicatorXP:Shape;
		private var _userIndicatorMana:Shape;
		private var _botLabelXP:Label;
		private var _botLabelMana:Label;
		private var _botIndicatorXP:Shape;
		private var _botIndicatorMana:Shape;
		private var _actionFighter:Label;			// активный игрок: пользователи или бот
		
		/* Обработка объектов игрового поля */
		private var _clickObject:Boolean = false; 	// флаг нажатия на объект 
		public var blockedField:Boolean = false;	// флаг блокировки игрового поля от нажатий
		private var _movingObject:String;			// Направление передвижения объекта на поле (при воздействии пользователя на него)
		private var _unit1:Unit;					// Выбранные объекты для обмена местами
		private var _unit2:Unit;
		
		/* Таймер нанесение удара */
		private var _countTimer:uint = 10; 
		private var _timer:Timer = new Timer(1000, 1);
		
		public function Level() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			/* Фоновая картинка уровня */
			showBackground();
			
			/* инициализация бойцов */
			showUserFighter();
			showBotFighter();
			
			/* инициализация игрового поля */
			showField();
			
			/* инициализация индикаторов */
			showIndicators();
			
			/* Кнопки */
			buttonSettings();
			buttonBack();
			
			/* Таймер */
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            _timer.start(); 
		}
		
		/* фоновая картинка */
		private function showBackground():void
		{
			var levelIndex:String;
			var index:int = Mechanics.RandomIndex();
			if (index >= 0 && index <= 2) levelIndex = "0";
			if (index > 2 && index <= 5) levelIndex = "1";
			if (index > 5 && index <= 8) levelIndex = "2";
			if (index > 8 && index <= 10) levelIndex = "3";
			
			if (levelIndex == "0") {
				index = Mechanics.RandomIndex();
				if (index == 0 || index == 10) levelIndex = "01";
				else levelIndex += index.toString();
			} else {
				if (levelIndex == "1") {
					index = Mechanics.RandomIndex();
					if (index == 0 || index == 10) levelIndex = "10";
					else levelIndex += index.toString()
				}else {
					if (levelIndex == "2") {
						index = Mechanics.RandomIndex();
						if (index == 0 || index == 10) levelIndex = "20";
						else levelIndex += index.toString()
					}else {
						if (levelIndex == "3") {
							index = Mechanics.RandomIndex();
							if (index == 0 || index == 10) levelIndex = "30";
							if (index > 0 && index <= 4) levelIndex = "31";
							if (index > 4 && index <= 7) levelIndex = "32";
							if (index > 7 && index < 10) levelIndex = "33";
						}
					}
				}
			}
			
			if (levelIndex == "01") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 0, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "02") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 253, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "03") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 506, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "04") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 759, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "05") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 1012, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "06") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 1265, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "07") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 1518, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "08") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 1771, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "09") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 2024, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "10") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 2277, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "11") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 0, 2530, 395, 253, 0, 0).bitmapData);
			
			if (levelIndex == "12") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 0, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "13") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 253, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "14") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 506, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "15") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 759, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "16") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 1012, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "17") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 1265, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "18") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 1518, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "19") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 1771, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "20") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 2024, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "21") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 2277, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "22") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 395, 2530, 395, 253, 0, 0).bitmapData);
			
			if (levelIndex == "23") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 0, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "24") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 253, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "25") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 506, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "26") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 759, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "27") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 1012, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "28") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 1265, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "29") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 1518, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "30") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 1771, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "31") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 2024, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "32") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 2277, 395, 253, 0, 0).bitmapData);
			if (levelIndex == "33") _bg = new Bitmap(Atlas.AtlasGetBitmap(Resource.LevelsAtlas, 1185, 2783, 395, 253, true, 0x000000000000, 790, 2530, 395, 253, 0, 0).bitmapData);
			
			
			_bg.scaleX += 1.05;
			_bg.scaleY += 1.5;
			_bg.smoothing = true;
			this.addChild(_bg);
		}
		
		/* Боец пользователя */
		private function showUserFighter():void
		{
			if (Resource.FIGHTER_ID == "KITANA_MK3U") _userFighter = new Fighter( -20, 300, 0, 0, 800, 260, 100, 130, Resource.KitanaMK3U_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "REPTILE_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.ReptileMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "SONYA_MK3U") _userFighter = new Fighter( -20, 300, 0, 0, 800, 260, 100, 130, Resource.SonyaMK3U_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "JAX_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.JaxMK3U_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "NIGHTWOLF_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.NightwolfMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "JADE_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 700, 260, 100, 130, Resource.JadeMK3U_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "SCORPION_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.ScorpionMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "RAIN_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.RainMK3U_Atlas, 8, 100, false); 
			if (Resource.FIGHTER_ID == "KANO_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 600, 280, 100, 140, Resource.KanoMK3U_Atlas, 5, 100, false);
			if (Resource.FIGHTER_ID == "MILEENA_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.MileenaMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "ERMAC_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.ErmacMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "SUBZERO_1_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.Subzero1MK3U_Atlas, 8, 100, false);
			
			if (Resource.FIGHTER_ID == "SUBZERO_2_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 1000, 260, 100, 130, Resource.Subzero2MK3U_Atlas, 9, 100, false);
			if (Resource.FIGHTER_ID == "NOOBSAIBOT_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.NoobsaibotMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "SEKTOR_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 800, 280, 100, 140, Resource.SektorMK3U_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "SINDEL_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.SindelMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "STRYKER_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.StrykerMK3U_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "SYREX_MK3U") _userFighter = new Fighter(-20, 280, 100, 0, 800, 280, 100, 140, Resource.CyrexMK3U_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "KUNGLAO_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 900, 280, 100, 140, Resource.KungLaoMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "KABAL_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 900, 280, 100, 140, Resource.KabalMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "SHEEVA_MK3U") _userFighter = new Fighter(-20, 265, 0, 0, 1000, 300, 100, 150, Resource.SheevaMK3U_Atlas, 9, 100, false);
			if (Resource.FIGHTER_ID == "SHANGTSUNG_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 900, 260, 100, 130, Resource.ShangTsungMK3U_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "LIUKANG_MK3U") _userFighter = new Fighter(-20, 300, 0, 0, 1600, 260, 100, 130, Resource.LiuKangMK3U_Atlas, 15, 100, false);
			if (Resource.FIGHTER_ID == "SMOKE_MK3U") _userFighter = new Fighter(-20, 280, 0, 0, 900, 280, 100, 140, Resource.SmokeMK3U_Atlas, 8, 100, false);
			
			if (Resource.FIGHTER_ID == "MOTARO_MK3U") _userFighter = new Fighter( -150, 180, 0, 0, 2800, 400, 200, 200, Resource.MotaroMK3U_Atlas, 10, 200, false);
			if (Resource.FIGHTER_ID == "SHAOKAHN_MK3U") _userFighter = new Fighter(-20, 240, 0, 0, 700, 320, 100, 160, Resource.ShaoKahnMK3U_Atlas, 6, 100, false);
			
			if (Resource.FIGHTER_ID == "LIUKANG_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.LiuKangMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "KUNGLAO_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 800, 280, 100, 140, Resource.KungLaoMK2_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "JOHNYCAGE_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.JohnnyCageMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "REPTILE_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.ReptileMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "SUBZERO_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 1200, 280, 100, 140, Resource.SubzeroMK2_Atlas, 11, 100, false);
			if (Resource.FIGHTER_ID == "SHANGTSUNG_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.ShangTsungMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "KITANA_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 600, 280, 100, 140, Resource.KitanaMK2_Atlas, 5, 100, false);
			if (Resource.FIGHTER_ID == "JAX_MK2") _userFighter = new Fighter(-20, 260, 0, 0, 700, 300, 100, 150, Resource.JaxMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "MILEENA_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 1200, 280, 100, 140, Resource.MileenaMK2_Atlas, 11, 100, false);
			if (Resource.FIGHTER_ID == "BARAKA_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 900, 280, 100, 140, Resource.BarakaMK2_Atlas, 8, 100, false);
			if (Resource.FIGHTER_ID == "SCORPION_MK2") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.ScorpionMK2_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "RAIDEN_MK2") _userFighter = new Fighter(-20, 260, 0, 0, 1000, 300, 100, 150, Resource.RaidenMK2_Atlas, 9, 100, false);
			
			if (Resource.FIGHTER_ID == "KINTARO_MK2") _userFighter = new Fighter( -50, 260, 0, 0, 1860, 310, 155, 155, Resource.KintaroMK2_Atlas, 11, 155, false);
			
			if (Resource.FIGHTER_ID == "JOHNYCAGE_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 600, 280, 100, 140, Resource.JohnnyCageMK1_Atlas, 5, 100, false);
			if (Resource.FIGHTER_ID == "KANO_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.KanoMK1_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "SUBZERO_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 1200, 280, 100, 140, Resource.SubzeroMK1_Atlas, 11, 100, false);
			if (Resource.FIGHTER_ID == "SONYA_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.SonyaMK1_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "RAIDEN_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 1000, 280, 100, 140, Resource.RaidenMK1_Atlas, 9, 100, false);
			if (Resource.FIGHTER_ID == "LIUKANG_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 800, 280, 100, 140, Resource.LiuKangMK1_Atlas, 7, 100, false);
			if (Resource.FIGHTER_ID == "SCORPION_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 700, 280, 100, 140, Resource.ScorpionMK1_Atlas, 6, 100, false);
			if (Resource.FIGHTER_ID == "SHANGTSUNG_MK1") _userFighter = new Fighter(-20, 280, 0, 0, 600, 280, 100, 140, Resource.ShangTsungMK1_Atlas, 5, 100, false);
			
			if (Resource.FIGHTER_ID == "GORO_MK1") _userFighter = new Fighter( -50, 260, 0, 0, 1050, 320, 150, 160, Resource.GoroMK1_Atlas, 6, 150, false);
						
			this.addChild(_userFighter);
		}
		
		private function showUserWin(fighterWin:String):void // показать победу пользователя
		{
			if (fighterWin == "BARAKA_MK2") _userFighter = new FighterWin( -130, 170, 0, 420, 2000, 610, 200, 190, Resource.BarakaMK2_Atlas, 9, 200);
			if (fighterWin == "SYREX_MK3U") _userFighter = new FighterWin( -20, 260, 0, 420, 600, 580, 100, 160, Resource.CyrexMK3U_Atlas, 5, 100);
			if (fighterWin == "ERMAC_MK3U") _userFighter = new FighterWin( -20, 220, 0, 390, 300, 560, 100, 170, Resource.ErmacMK3U_Atlas, 2, 100);
			if (fighterWin == "GORO_MK1") _userFighter = new FighterWin( -50, 245, 0, 500, 480, 660, 160, 160, Resource.GoroMK1_Atlas, 2, 160);
			if (fighterWin == "JADE_MK3U") _userFighter = new FighterWin(-70, 200, 0, 390, 3000, 590, 200, 200, Resource.JadeMK3U_Atlas, 14, 200);
			if (fighterWin == "JAX_MK3U") _userFighter = new FighterWin( -40, 240, 0, 420, 1250, 580, 125, 160, Resource.JaxMK3U_Atlas, 9, 125);
			if (fighterWin == "JAX_MK2") _userFighter = new FighterWin(-40, 220, 0, 450, 875, 620, 125, 170, Resource.JaxMK2_Atlas, 6, 125);
			if (fighterWin == "JOHNYCAGE_MK2") _userFighter = new FighterWin( -40, 220, 0, 420, 1750, 590, 125, 170, Resource.JohnnyCageMK2_Atlas, 13, 125);
			if (fighterWin == "JOHNYCAGE_MK1") _userFighter = new FighterWin(-20, 280, 0, 420, 1200, 560, 100, 140, Resource.JohnnyCageMK1_Atlas, 11, 100);
			if (fighterWin == "KABAL_MK3U") _userFighter = new FighterWin(-120, 160, 0, 420, 2000, 620, 200, 200, Resource.KabalMK3U_Atlas, 9, 200);
			if (fighterWin == "KANO_MK3U") _userFighter = new FighterWin(-20, 230, 0, 420, 1200, 585, 120, 165, Resource.KanoMK3U_Atlas, 6, 120);
			if (fighterWin == "KANO_MK1") _userFighter = new FighterWin( -40, 240, 0, 420, 600, 580, 120, 160, Resource.KanoMK1_Atlas, 4, 120);
			if (fighterWin == "KINTARO_MK2") _userFighter = new FighterWin( -80, 160, 0, 470, 800, 670, 200, 200, Resource.KintaroMK2_Atlas, 3, 200);
			if (fighterWin == "KITANA_MK3U") _userFighter = new FighterWin( -20, 180, 0, 390, 660, 580, 110, 190, Resource.KitanaMK3U_Atlas, 5, 110);
			if (fighterWin == "KITANA_MK2") _userFighter = new FighterWin( -80, 200, 0, 420, 1920, 600, 160, 180, Resource.KitanaMK2_Atlas, 11, 160);
			if (fighterWin == "KUNGLAO_MK3U") _userFighter = new FighterWin( -10, 290, 0, 420, 1280, 570, 80, 150, Resource.KungLaoMK3U_Atlas, 15, 80);
			if (fighterWin == "KUNGLAO_MK2") _userFighter = new FighterWin( -60, 270, 0, 430, 800, 575, 100, 145, Resource.KungLaoMK2_Atlas, 7, 100);
			if (fighterWin == "LIUKANG_MK3U") _userFighter = new FighterWin( -60, 200, 0, 390, 2100, 570, 140, 180, Resource.LiuKangMK3U_Atlas, 14, 140);
			if (fighterWin == "LIUKANG_MK2") _userFighter = new FighterWin( -40, 220, 0, 420, 1000, 585, 125, 165, Resource.LiuKangMK2_Atlas, 7, 125);
			if (fighterWin == "LIUKANG_MK1") _userFighter = new FighterWin( -40, 230, 0, 420, 1560, 585, 120, 165, Resource.LiuKangMK1_Atlas, 12, 120);
			if (fighterWin == "MILEENA_MK3U") _userFighter = new FighterWin(-80, 190, 0, 390, 725, 575, 145, 185, Resource.MileenaMK3U_Atlas, 5, 145);
			if (fighterWin == "MILEENA_MK2") _userFighter = new FighterWin(-30, 240, 0, 420, 1320, 580, 120, 160, Resource.MileenaMK2_Atlas, 10, 120);
			if (fighterWin == "MOTARO_MK3U") _userFighter = new FighterWin( -150, 180, 0, 600, 1000, 800, 200, 200, Resource.MotaroMK3U_Atlas, 4, 200);
			if (fighterWin == "NIGHTWOLF_MK3U") _userFighter = new FighterWin( -20, 220, 0, 390, 1000, 560, 100, 170, Resource.NightwolfMK3U_Atlas, 9, 100);
			if (fighterWin == "NOOBSAIBOT_MK3U") _userFighter = new FighterWin( -20, 220, 0, 390, 300, 560, 100, 170, Resource.NoobsaibotMK3U_Atlas, 2, 100);
			if (fighterWin == "RAIDEN_MK2") _userFighter = new FighterWin(-40, 220, 0, 450, 1305, 620, 145, 170, Resource.RaidenMK2_Atlas, 8, 145);
			if (fighterWin == "RAIDEN_MK1") _userFighter = new FighterWin(-40, 240, 0, 420, 625, 585, 125, 165, Resource.RaidenMK1_Atlas, 4, 125);
			if (fighterWin == "RAIN_MK3U") _userFighter = new FighterWin(-10, 250, 0, 390, 525, 545, 105, 155, Resource.RainMK3U_Atlas, 4, 105);
			if (fighterWin == "REPTILE_MK3U") _userFighter = new FighterWin(-10, 250, 0, 390, 525, 545, 105, 155, Resource.ReptileMK3U_Atlas, 4, 105);
			if (fighterWin == "REPTILE_MK2") _userFighter = new FighterWin(-20, 230, 0, 420, 400, 587, 100, 165, Resource.ReptileMK2_Atlas, 3, 100);
			if (fighterWin == "SCORPION_MK3U") _userFighter = new FighterWin( -20, 220, 0, 390, 300, 560, 100, 170, Resource.ScorpionMK3U_Atlas, 2, 100);
			if (fighterWin == "SCORPION_MK2") _userFighter = new FighterWin( -20, 220, 0, 420, 300, 590, 100, 170, Resource.ScorpionMK2_Atlas, 2, 100);
			if (fighterWin == "SCORPION_MK1") _userFighter = new FighterWin(-20, 240, 0, 420, 400, 580, 100, 160, Resource.ScorpionMK1_Atlas, 3, 100);
			if (fighterWin == "SEKTOR_MK3U") _userFighter = new FighterWin(-10, 260, 0, 420, 600, 570, 100, 150, Resource.SektorMK3U_Atlas, 5, 100);
			if (fighterWin == "SHANGTSUNG_MK3U") _userFighter = new FighterWin(-20, 230, 0, 390, 800, 555, 100, 165, Resource.ShangTsungMK3U_Atlas, 7, 100);
			if (fighterWin == "SHANGTSUNG_MK2") _userFighter = new FighterWin(-10, 280, 0, 420, 500, 560, 100, 140, Resource.ShangTsungMK2_Atlas, 4, 100);
			if (fighterWin == "SHANGTSUNG_MK1") _userFighter = new FighterWin(-20, 220, 0, 420, 300, 585, 100, 165, Resource.ShangTsungMK1_Atlas, 2, 100);
			if (fighterWin == "SHAOKAHN_MK3U") _userFighter = new FighterWin(-20, 240, 0, 510, 300, 670, 100, 160, Resource.ShaoKahnMK3U_Atlas, 2, 100);
			if (fighterWin == "SHEEVA_MK3U") _userFighter = new FighterWin(-20, 190, 0, 450, 2100, 635, 150, 185, Resource.SheevaMK3U_Atlas, 13, 150);
			if (fighterWin == "SINDEL_MK3U") _userFighter = new FighterWin(-20, 220, 0, 390, 700, 550, 100, 160, Resource.SindelMK3U_Atlas, 6, 100);
			if (fighterWin == "SMOKE_MK3U") _userFighter = new FighterWin(-20, 260, 0, 420, 600, 570, 100, 150, Resource.SmokeMK3U_Atlas, 5, 100);
			if (fighterWin == "SONYA_MK3U") _userFighter = new FighterWin(-60, 290, 0, 390, 880, 525, 110, 135, Resource.SonyaMK3U_Atlas, 7, 110);
			if (fighterWin == "SONYA_MK1") _userFighter = new FighterWin(-20, 260, 0, 420, 880, 570, 110, 150, Resource.SonyaMK1_Atlas, 7, 110);
			if (fighterWin == "STRYKER_MK3U") _userFighter = new FighterWin(-20, 130, 0, 420, 2200, 635, 100, 215, Resource.StrykerMK3U_Atlas, 21, 100);
			if (fighterWin == "SUBZERO_1_MK3U") _userFighter = new FighterWin( -20, 220, 0, 390, 300, 560, 100, 170, Resource.Subzero1MK3U_Atlas, 2, 100);
			
			
			this.addChild(_userFighter);
		}
		
		private function showUserLose(fighterLose:String):void // показать проигрыш пользователя
		{
			if (fighterLose == "BARAKA_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 2000, 610, 100, 140, Resource.BarakaMK2_Atlas, 6, 100, false);
			if (fighterLose == "SYREX_MK3U") _userFighter = new Fighter( -20, 280, 0, 280, 800, 580, 100, 140, Resource.CyrexMK3U_Atlas, 7, 100, false);
			if (fighterLose == "ERMAC_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 800, 560, 100, 130, Resource.ErmacMK3U_Atlas, 7, 100, false);
			if (fighterLose == "GORO_MK1") _userFighter = new FighterWin( -50, 220, 0, 320, 1140, 660, 190, 180, Resource.GoroMK1_Atlas, 5, 190);
			if (fighterLose == "JADE_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 900, 590, 100, 130, Resource.JadeMK3U_Atlas, 8, 100, false);
			if (fighterLose == "JAX_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 1100, 580, 100, 140, Resource.JaxMK3U_Atlas, 10, 100, false);
			if (fighterLose == "JAX_MK2") _userFighter = new Fighter(-20, 260, 0, 300, 700, 620, 100, 150, Resource.JaxMK2_Atlas, 6, 100, false);
			if (fighterLose == "JOHNYCAGE_MK2") _userFighter = new Fighter( -20, 280, 0, 280, 700, 590, 100, 140, Resource.JohnnyCageMK2_Atlas, 6, 100, false);
			if (fighterLose == "JOHNYCAGE_MK1") _userFighter = new Fighter(-20, 280, 0, 280, 700, 560, 100, 140, Resource.JohnnyCageMK1_Atlas, 6, 100, false);
			if (fighterLose == "KABAL_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 800, 620, 100, 140, Resource.KabalMK3U_Atlas, 7, 100, false);
			if (fighterLose == "KANO_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 700, 585, 100, 140, Resource.KanoMK3U_Atlas, 6, 100, false);
			if (fighterLose == "KANO_MK1") _userFighter = new Fighter(-20, 280, 0, 280, 700, 580, 100, 140, Resource.KanoMK1_Atlas, 6, 100, false);
			if (fighterLose == "KINTARO_MK2") _userFighter = new FighterWin( -50, 260, 0, 310, 1200, 670, 200, 160, Resource.KintaroMK2_Atlas, 5, 200);
			if (fighterLose == "KITANA_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 900, 580, 100, 130, Resource.KitanaMK3U_Atlas, 8, 100, false);
			if (fighterLose == "KITANA_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 700, 600, 100, 140, Resource.KitanaMK2_Atlas, 6, 100, false);
			if (fighterLose == "KUNGLAO_MK3U") _userFighter = new Fighter( -20, 280, 0, 280, 900, 570, 100, 140, Resource.KungLaoMK3U_Atlas, 8, 100, false);
			if (fighterLose == "KUNGLAO_MK2") _userFighter = new Fighter( -20, 260, 0, 280, 700, 575, 100, 150, Resource.KungLaoMK2_Atlas, 6, 100, false);
			if (fighterLose == "LIUKANG_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 900, 570, 100, 130, Resource.LiuKangMK3U_Atlas, 8, 100, false);
			if (fighterLose == "LIUKANG_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 700, 585, 100, 140, Resource.LiuKangMK2_Atlas, 6, 100, false);
			if (fighterLose == "LIUKANG_MK1") _userFighter = new Fighter( -20, 280, 0, 280, 700, 585, 100, 140, Resource.LiuKangMK1_Atlas, 6, 100, false);
			if (fighterLose == "MILEENA_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 900, 575, 100, 130, Resource.MileenaMK3U_Atlas, 8, 100, false);
			if (fighterLose == "MILEENA_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 700, 580, 100, 140, Resource.MileenaMK2_Atlas, 6, 100, false);
			if (fighterLose == "MOTARO_MK3U") _userFighter = new FighterWin( -150, 180, 0, 400, 1600, 800, 200, 200, Resource.MotaroMK3U_Atlas, 7, 200);
			if (fighterLose == "NIGHTWOLF_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 900, 560, 100, 130, Resource.NightwolfMK3U_Atlas, 8, 100, false);
			if (fighterLose == "NOOBSAIBOT_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 800, 560, 100, 130, Resource.NoobsaibotMK3U_Atlas, 7, 100, false);
			if (fighterLose == "RAIDEN_MK2") _userFighter = new Fighter(-20, 260, 0, 300, 700, 620, 100, 150, Resource.RaidenMK2_Atlas, 6, 100, false);
			if (fighterLose == "RAIDEN_MK1") _userFighter = new Fighter(-20, 280, 0, 280, 700, 585, 100, 140, Resource.RaidenMK1_Atlas, 6, 100, false);
			if (fighterLose == "RAIN_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 800, 545, 100, 130, Resource.RainMK3U_Atlas, 7, 100, false); 
			if (fighterLose == "REPTILE_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 800, 545, 100, 130, Resource.ReptileMK3U_Atlas, 7, 100, false); 
			if (fighterLose == "REPTILE_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 700, 587, 100, 140, Resource.ReptileMK2_Atlas, 6, 100, false);
			if (fighterLose == "SCORPION_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 800, 560, 100, 130, Resource.ScorpionMK3U_Atlas, 7, 100, false);
			if (fighterLose == "SCORPION_MK2") _userFighter = new Fighter( -20, 280, 0, 280, 700, 590, 100, 140, Resource.ScorpionMK2_Atlas, 6, 100, false);
			if (fighterLose == "SCORPION_MK1") _userFighter = new Fighter(-20, 280, 0, 280, 700, 580, 100, 140, Resource.ScorpionMK1_Atlas, 6, 100, false);
			if (fighterLose == "SEKTOR_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 800, 570, 100, 140, Resource.SektorMK3U_Atlas, 7, 100, false);
			if (fighterLose == "SHANGTSUNG_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 900, 555, 100, 130, Resource.ShangTsungMK3U_Atlas, 8, 100, false);
			if (fighterLose == "SHANGTSUNG_MK2") _userFighter = new Fighter(-20, 280, 0, 280, 700, 560, 100, 140, Resource.ShangTsungMK2_Atlas, 6, 100, false);
			if (fighterLose == "SHANGTSUNG_MK1") _userFighter = new FighterWin(-20, 280, 0, 280, 700, 585, 140, 140, Resource.ShangTsungMK1_Atlas, 4, 140);
			if (fighterLose == "SHAOKAHN_MK3U") _userFighter = new FighterWin(-50, 190, 0, 320, 1500, 670, 150, 190, Resource.ShaoKahnMK3U_Atlas, 9, 150);
			if (fighterLose == "SHEEVA_MK3U") _userFighter = new Fighter(-20, 260, 0, 300, 800, 635, 100, 150, Resource.SheevaMK3U_Atlas, 7, 100, false);
			if (fighterLose == "SINDEL_MK3U") _userFighter = new Fighter(-20, 300, 0, 260, 900, 550, 100, 130, Resource.SindelMK3U_Atlas, 8, 100, false);
			if (fighterLose == "SMOKE_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 800, 570, 100, 140, Resource.SmokeMK3U_Atlas, 7, 100, false);
			if (fighterLose == "SONYA_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 700, 525, 100, 130, Resource.SonyaMK3U_Atlas, 6, 100, false);
			if (fighterLose == "SONYA_MK1") _userFighter = new Fighter(-20, 280, 0, 280, 700, 570, 100, 140, Resource.SonyaMK1_Atlas, 6, 100, false);
			if (fighterLose == "STRYKER_MK3U") _userFighter = new Fighter(-20, 280, 0, 280, 800, 635, 100, 140, Resource.StrykerMK3U_Atlas, 7, 100, false);
			if (fighterLose == "SUBZERO_1_MK3U") _userFighter = new Fighter( -20, 300, 0, 260, 800, 560, 100, 130, Resource.Subzero1MK3U_Atlas, 7, 100, false);
			
			this.addChild(_userFighter);
		}
		
		/* Бот компьютера */
		private function showBotFighter():void
		{
			Resource.BOT_ID = Resource.TournamentFighters[11 - Resource.TournamentWin][0];
			Resource.BOT_LEVEL = Resource.DEFAULT_LEVEL;
			Resource.BOT_HIP_POINTS = Resource.DEFAULT_HIP_POINTS;
			Resource.BOT_MANA = Resource.DEFAULT_MANA;	
			Resource.BOT_POWER = Resource.DEFAULT_POWER;
			Resource.BOT_DEFENSE = Resource.DEFAULT_DEFENSE;
			Resource.BOT_SLEIGHT = Resource.DEFAULT_SLEIGHT;
			Resource.BOT_INTELLECT = Resource.DEFAULT_INTELLECT;
			Resource.BOT_LEADERSHIP = Resource.DEFAULT_LEADERSHIP;
		
			
			if (Resource.BOT_ID == "KITANA_MK3U") {
				_botFighter = new Fighter(620, 300, 700, 130, 800, 260, 100, 130, Resource.KitanaMK3U_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Kitana";
			}
			if (Resource.BOT_ID == "REPTILE_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.ReptileMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Reptile";
			}
			if (Resource.BOT_ID == "SONYA_MK3U") {
				_botFighter = new Fighter( 620, 300, 700, 130, 800, 260, 100, 130, Resource.SonyaMK3U_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Sonya";
			}
			if (Resource.BOT_ID == "JAX_MK3U") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.JaxMK3U_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Jax";
			}
			if (Resource.BOT_ID == "NIGHTWOLF_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.NightwolfMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Nightwolf";
			}
			if (Resource.BOT_ID == "JADE_MK3U") {
				_botFighter = new Fighter(620, 300, 600, 130, 700, 260, 100, 130, Resource.JadeMK3U_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Jade";
			}
			if (Resource.BOT_ID == "SCORPION_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.ScorpionMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Scorpion";
			}
			if (Resource.BOT_ID == "RAIN_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.RainMK3U_Atlas, 8, 100, true); 
				Resource.BOT_NAME = "Rain";
			}
			if (Resource.BOT_ID == "KANO_MK3U") {
				_botFighter = new Fighter(620, 280, 500, 140, 600, 280, 100, 140, Resource.KanoMK3U_Atlas, 5, 100, true);
				Resource.BOT_NAME = "Kano";
			}
			if (Resource.BOT_ID == "MILEENA_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.MileenaMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Mileena";
			}
			if (Resource.BOT_ID == "ERMAC_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.ErmacMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Ermac";
			}
			if (Resource.BOT_ID == "SUBZERO_1_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.Subzero1MK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Sub-Zero";
			}
			
			if (Resource.BOT_ID == "SUBZERO_2_MK3U") {
				_botFighter = new Fighter(620, 300, 900, 130, 1000, 260, 100, 130, Resource.Subzero2MK3U_Atlas, 9, 100, true);
				Resource.BOT_NAME = "Sub-Zero";
			}
			if (Resource.BOT_ID == "NOOBSAIBOT_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.NoobsaibotMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Noob Saibot";
			}
			if (Resource.BOT_ID == "SEKTOR_MK3U") {
				_botFighter = new Fighter(620, 280, 700, 140, 800, 280, 100, 140, Resource.SektorMK3U_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Sektor";
			}
			if (Resource.BOT_ID == "SINDEL_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.SindelMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Sindel";
			}
			if (Resource.BOT_ID == "STRYKER_MK3U") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.StrykerMK3U_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Stryker";
			}
			if (Resource.BOT_ID == "SYREX_MK3U") {
				_botFighter = new Fighter(620, 280, 600, 140, 800, 280, 100, 140, Resource.CyrexMK3U_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Syrex";
			}
			if (Resource.BOT_ID == "KUNGLAO_MK3U") {
				_botFighter = new Fighter(620, 280, 800, 140, 900, 280, 100, 140, Resource.KungLaoMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Kung Lao";
			}
			if (Resource.BOT_ID == "KABAL_MK3U") {
				_botFighter = new Fighter(620, 280, 800, 140, 900, 280, 100, 140, Resource.KabalMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Kabal";
			}
			if (Resource.BOT_ID == "SHEEVA_MK3U") {
				_botFighter = new Fighter(620, 265, 900, 150, 1000, 300, 100, 150, Resource.SheevaMK3U_Atlas, 9, 100, true);
				Resource.BOT_NAME = "Sheeva";
			}
			if (Resource.BOT_ID == "SHANGTSUNG_MK3U") {
				_botFighter = new Fighter(620, 300, 800, 130, 900, 260, 100, 130, Resource.ShangTsungMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Shang Tsung";
			}
			if (Resource.BOT_ID == "LIUKANG_MK3U") {
				_botFighter = new Fighter(620, 300, 1500, 130, 1600, 260, 100, 130, Resource.LiuKangMK3U_Atlas, 15, 100, true);
				Resource.BOT_NAME = "Liu Kang";
			}
			if (Resource.BOT_ID == "SMOKE_MK3U") {
				_botFighter = new Fighter(620, 280, 800, 140, 900, 280, 100, 140, Resource.SmokeMK3U_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Smoke";
			}
			
			if (Resource.BOT_ID == "MOTARO_MK3U") {
				_botFighter = new Fighter( 620, 180, 2600, 200, 2800, 400, 200, 200, Resource.MotaroMK3U_Atlas, 10, 200, true);
				Resource.BOT_NAME = "Motaro";
			}
			if (Resource.BOT_ID == "SHAOKAHN_MK3U") {
				_botFighter = new Fighter(620, 240, 600, 160, 700, 320, 100, 160, Resource.ShaoKahnMK3U_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Shao Kahn";
			}
			
			if (Resource.BOT_ID == "LIUKANG_MK2") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.LiuKangMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Liu Kang";
			}
			if (Resource.BOT_ID == "KUNGLAO_MK2") {
				_botFighter = new Fighter(620, 280, 700, 140, 800, 280, 100, 140, Resource.KungLaoMK2_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Kung Lao";
			}
			if (Resource.BOT_ID == "JOHNYCAGE_MK2") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.JohnnyCageMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Johnny Cage";
			}
			if (Resource.BOT_ID == "REPTILE_MK2") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.ReptileMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Reptile";
			}
			if (Resource.BOT_ID == "SUBZERO_MK2") {
				_botFighter = new Fighter(620, 280, 1100, 140, 1200, 280, 100, 140, Resource.SubzeroMK2_Atlas, 11, 100, true);
				Resource.BOT_NAME = "Sub-Zero";
			}
			if (Resource.BOT_ID == "SHANGTSUNG_MK2") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.ShangTsungMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Shang Tsung";
			}
			if (Resource.BOT_ID == "KITANA_MK2") {
				_botFighter = new Fighter(620, 280, 500, 140, 600, 280, 100, 140, Resource.KitanaMK2_Atlas, 5, 100, true);
				Resource.BOT_NAME = "Kitana";
			}
			if (Resource.BOT_ID == "JAX_MK2") {
				_botFighter = new Fighter(620, 260, 600, 150, 700, 300, 100, 150, Resource.JaxMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Jax";
			}
			if (Resource.BOT_ID == "MILEENA_MK2") {
				_botFighter = new Fighter(620, 280, 1100, 140, 1200, 280, 100, 140, Resource.MileenaMK2_Atlas, 11, 100, true);
				Resource.BOT_NAME = "Mileena";
			}
			if (Resource.BOT_ID == "BARAKA_MK2") {
				_botFighter = new Fighter(620, 280, 800, 140, 900, 280, 100, 140, Resource.BarakaMK2_Atlas, 8, 100, true);
				Resource.BOT_NAME = "Baraka";
			}
			if (Resource.BOT_ID == "SCORPION_MK2") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.ScorpionMK2_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Scorpion";
			}
			if (Resource.BOT_ID == "RAIDEN_MK2") {
				_botFighter = new Fighter(620, 260, 900, 150, 1000, 300, 100, 150, Resource.RaidenMK2_Atlas, 9, 100, true);
				Resource.BOT_NAME = "Raiden";
			}
			
			if (Resource.BOT_ID == "KINTARO_MK2") {
				_botFighter = new Fighter(620, 260, 1705, 155, 1860, 310, 155, 155, Resource.KintaroMK2_Atlas, 11, 155, true);
				Resource.BOT_NAME = "Kintaro";
			}
			
			if (Resource.BOT_ID == "JOHNYCAGE_MK1") {
				_botFighter = new Fighter(620, 280, 500, 140, 600, 280, 100, 140, Resource.JohnnyCageMK1_Atlas, 5, 100, true);
				Resource.BOT_NAME = "Johnny Cage";
			}
			if (Resource.BOT_ID == "KANO_MK1") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.KanoMK1_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Kano";
			}
			if (Resource.BOT_ID == "SUBZERO_MK1") {
				_botFighter = new Fighter(620, 280, 1100, 140, 1200, 280, 100, 140, Resource.SubzeroMK1_Atlas, 11, 100, true);
				Resource.BOT_NAME = "Sub-Zero";
			}
			if (Resource.BOT_ID == "SONYA_MK1") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.SonyaMK1_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Sonya";
			}
			if (Resource.BOT_ID == "RAIDEN_MK1") {
				_botFighter = new Fighter(620, 280, 900, 140, 1000, 280, 100, 140, Resource.RaidenMK1_Atlas, 9, 100, true);
				Resource.BOT_NAME = "Raiden";
			}
			if (Resource.BOT_ID == "LIUKANG_MK1") {
				_botFighter = new Fighter(620, 280, 700, 140, 800, 280, 100, 140, Resource.LiuKangMK1_Atlas, 7, 100, true);
				Resource.BOT_NAME = "Liu Kang";
			}
			if (Resource.BOT_ID == "SCORPION_MK1") {
				_botFighter = new Fighter(620, 280, 600, 140, 700, 280, 100, 140, Resource.ScorpionMK1_Atlas, 6, 100, true);
				Resource.BOT_NAME = "Scorpion";
			}
			if (Resource.BOT_ID == "SHANGTSUNG_MK1") {
				_botFighter = new Fighter(620, 280, 500, 140, 600, 280, 100, 140, Resource.ShangTsungMK1_Atlas, 5, 100, true);
				Resource.BOT_NAME = "Shang Tsung";
			}
			
			if (Resource.BOT_ID == "GORO_MK1") {
				_botFighter = new Fighter(620, 260, 900, 160, 1050, 320, 150, 160, Resource.GoroMK1_Atlas, 6, 150, true);
				Resource.BOT_NAME = "Goro";
			}
			
			
			this.addChild(_botFighter);
		}
		
		private function showBotWin(fighterWin:String):void // показать победу пользователя
		{
			
			this.addChild(_botFighter);
		}
		
		private function showBotLose(fighterLose:String):void // показать проигрыш пользователя
		{
			
			this.addChild(_botFighter);
		}
		
		
		/* ИГРОВОЕ ПОЛЕ ============================================================================================= */
		private function showField():void
		{
			//trace(Resource.FilesXML[0].LevelNumber);
			var indexLevel:int = Mechanics.RandomIndex() - 1;
			if (indexLevel < 0 || indexLevel >= Resource.FilesXML.length) indexLevel = 0;
			
			Resource.MatrixCell = Mechanics.CreateCellVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			Resource.MatrixUnit = Mechanics.CreateUnitVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			
			/* Создаем игровое поле (i - столбец; j - строка) */
			var index:int = 0;
			for (var iCell:uint = 0; iCell < Resource.COLUMNS; iCell++) {
				for (var jCell:uint = 0; jCell < Resource.ROWS; jCell++) {
					
					if (Resource.FilesXML[indexLevel].cell[index].cellType == "CELL_TYPE_CLEAR") {
						/* клетка */
						(Resource.MatrixCell[iCell][jCell] as Cell).x = 165 + (Resource.CELL_WIDTH * iCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).y = 70 + (Resource.CELL_HEIGHT * jCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_CLEAR";
						this.addChild(Resource.MatrixCell[iCell][jCell]);
					}else {
						/* клетка */
						(Resource.MatrixCell[iCell][jCell] as Cell).x = 165 + (Resource.CELL_WIDTH * iCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).y = 70 + (Resource.CELL_HEIGHT * jCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_DROP";
					}
					
					index++;
				}
			}
			
			/* Размещаем объекты игрового поля (i - столбец; j - строка) */
			index = 0;
			for (var iUnit:uint = 0; iUnit < Resource.COLUMNS; iUnit++) {
				for (var jUnit:uint = 0; jUnit < Resource.ROWS; jUnit++) {
					if (Resource.FilesXML[indexLevel].cell[index].cellType != "CELL_TYPE_DROP" && Resource.FilesXML[indexLevel].cell[index].cellObject != "HIT_0") {
						/* объект */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).x = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posX = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posY = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).unitType = Resource.FilesXML[indexLevel].cell[index].cellObject;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_CLEAR";
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).HitShow();
						/*события */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.CLICK, onMouseUnitClick);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_DOWN, onMouseUnitDown);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_UP, onMouseUnitUp);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_MOVE, onMouseUnitMove);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_OUT, onMouseUnitOut);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_OVER, onMouseUnitOver);
						this.addChild(Resource.MatrixUnit[iUnit][jUnit]);
					}else {
						/* объект HIT_0 */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).x = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posX = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posY = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).unitType = "HIT_0"; //Resource.FilesXML[indexLevel].cell[index].cellObject;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_DROP";
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).HitShow();
					}
					
					index++;
				}
			}
		}
		
		/* События объектов игрового поля */
		public function onMouseUnitClick(e:MouseEvent):void
		{
			// при нажатии
			trace("ПОЗИЦИЯ(i-колонка):" + (e.target as Unit).posColumnI.toString() + "  ПОЗИЦИЯ(j-строка):" + (e.target as Unit).posRowJ.toString());
			trace("ПОЗИЦИЯ(X):" + (e.target as Unit).x.toString() + "  ПОЗИЦИЯ(Y):" + (e.target as Unit).y.toString());
			trace("ПОЗИЦИЯ(posX):" + (e.target as Unit).posX.toString() + "  ПОЗИЦИЯ(posY):" + (e.target as Unit).posY.toString());
			trace("ИМЯ:" + (e.target as Unit).unitType);
		}
		
		public function onMouseUnitDown(e:MouseEvent):void
		{
			_clickObject = true; // флаг - объект нажат
		}
		
		public function onMouseUnitUp(e:MouseEvent):void
		{
			_clickObject = false; // флаг - объект не нажат
		}
		
		public function onMouseUnitOut(e:MouseEvent):void
		{
			_clickObject = false;
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		public function onMouseUnitOver(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		/* Обмен местами кристалов на поле (Ход искуственного интеллекта)*/
		public function onUnitMoveAI(unit1PosColI:int, unit1PosRowJ:int, unit2PosColI:int, unit2PosRowJ:int, movingObject:String):void
		{
			blockedField = true; // блокируем игровое поле
			_movingObject = movingObject;
			_unit1 = (Resource.MatrixUnit[unit1PosColI][unit1PosRowJ] as Unit);
			_unit2 = (Resource.MatrixUnit[unit2PosColI][unit2PosRowJ] as Unit);
			Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
			this.addEventListener(Event.ENTER_FRAME, AnimationExchange);
			this.play();
		}
		
		/* Обмен местами кристалов на поле */
		public function onMouseUnitMove(e:MouseEvent):void
		{
			/* i - столбец; j - строка */
			if(blockedField == false){	// Игровое поле разблокировано
				if (_clickObject) {		// объект нажат
					/* Смещение по горизонтале вправо */
					if (e.localX > 65 && e.localY < 65 && e.localY > 5) {
						if ((e.target as Unit).posColumnI < Resource.COLUMNS - 1) {
							/* Если не пустота*/
							if ((e.target as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[(e.target as Unit).posColumnI + 1][(e.target as Unit).posRowJ] as Unit).unitType != "HIT_0") {
								blockedField = true; // блокируем игровое поле
								_movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
								_unit1 = (e.target as Unit);
								_unit2 = (Resource.MatrixUnit[(e.target as Unit).posColumnI + 1][(e.target as Unit).posRowJ] as Unit);
								Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
								this.addEventListener(Event.ENTER_FRAME, AnimationExchange);
								this.play();
							}
						}
						trace("Смещение по горизонтале вправо X > 45 и Y < 45");
						_clickObject = false;
					}
					
					/* Смещение по горизонтале влево */
					if (e.localX < 5 && e.localY > 5 && e.localY < 65) {
						if ((e.target as Unit).posColumnI > 0) {
							/* Если не преграда (Камень) */
							if ((e.target as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[(e.target as Unit).posColumnI - 1][(e.target as Unit).posRowJ] as Unit).unitType != "HIT_0") {
								blockedField = true; // блокируем игровое поле
								_movingObject = "Left:I-1";	// Обмен местами по горизонтали с объектом стоящим слева
								_unit1 = (e.target as Unit);
								_unit2 = (Resource.MatrixUnit[(e.target as Unit).posColumnI - 1][(e.target as Unit).posRowJ] as Unit);
								Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
								this.addEventListener(Event.ENTER_FRAME, AnimationExchange);
								this.play();
							}
						}
						trace("Смещение по горизонтале влево X < 5 и Y > 5");
						_clickObject = false;
					}
					
					/* Смещение по вертикале вверх */
					if (e.localY < 5 && e.localX > 5 && e.localX < 65) {
						if ((e.target as Unit).posRowJ > 0) {
							/* Если не преграда (Камень) */
							if ((e.target as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[(e.target as Unit).posColumnI][(e.target as Unit).posRowJ - 1] as Unit).unitType != "HIT_0") {
								blockedField = true; // блокируем игровое поле
								_movingObject = "Up:J-1";	// Обмен местами по вертикале с объектом стоящим сверху
								_unit1 = (e.target as Unit);
								_unit2 = (Resource.MatrixUnit[(e.target as Unit).posColumnI][(e.target as Unit).posRowJ - 1] as Unit);
								Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
								this.addEventListener(Event.ENTER_FRAME, AnimationExchange);
								this.play();
							}
						}
						trace("Смещение по вертикале вверх Y < 5 и X > 5");
						_clickObject = false;
					}
					
					/* Смещение по вертикале вниз */
					if (e.localY > 65 && e.localX < 65 && e.localX > 5) {
						if ((e.target as Unit).posRowJ < Resource.ROWS - 1) { // 9
							/* Если не преграда (Камень) */
							if ((e.target as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[(e.target as Unit).posColumnI][(e.target as Unit).posRowJ + 1] as Unit).unitType != "HIT_0") {
								blockedField = true; // блокируем игровое поле
								_movingObject = "Down:J+1";	// Обмен местами по вертикале с объектом стоящим снизу
								_unit1 = (e.target as Unit);
								_unit2 = (Resource.MatrixUnit[(e.target as Unit).posColumnI][(e.target as Unit).posRowJ + 1] as Unit);
								Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
								this.addEventListener(Event.ENTER_FRAME, AnimationExchange);
								this.play();
							}
						}
						trace("Смещение по вертикале вниз Y > 45 и X < 45");
						_clickObject = false;
					}
				}
			}
		}
		
		/* Анимация спуска объектов */
		public function AnimationMoveDown(e:Event):void 
		{
			timerStop(); // останавливаем таймер отсчета времени на удар
			
			var endMove:Boolean = true;
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				for (var j:int = Resource.ROWS - 1; j >= 0; j--) {	/* j - строки (обработка снизу вверх) */
					if ((Resource.MatrixUnit[i][j] as Unit).posY > (Resource.MatrixUnit[i][j] as Unit).y) {
						(Resource.MatrixUnit[i][j] as Unit).y += 10;
						endMove = false;
					} else (Resource.MatrixUnit[i][j] as Unit).y = (Resource.MatrixUnit[i][j] as Unit).posY;
				}
			}
			
			if (endMove) {
				this.stop();
				this.removeEventListener(Event.ENTER_FRAME, AnimationMoveDown);
				/* Вызываем функцию проверки новых групп на поле */
				if (Mechanics.CheckField()) Mechanics.SimplyRemove(this);
				else {
					if(_gameEnd == false){
						if(Mechanics.CheckCombinations()){ // проверка возможных комбинаций
							timerRun(); // запускаем таймер отсчета времени на удар
							Exchange(); // смена игроков (пользователь на бота, бот на пользователя)
						}else {
							/* Вызываем функцию спуска (комбинации на поле были перестроены) */
							this.addEventListener(Event.ENTER_FRAME, this.AnimationMoveDown);
							this.play();
						}
					}else this.addChild(_windowGameEnd); // БОЙ ЗАВЕРШЕН!!!
				}
			}
		}
		
		/* Анимация обмена местами между двумя объектами на поле, после воздействия на них пользователем */
		private function AnimationExchange(e:Event):void 
		{
			/* Анимация пеемещания кристалов */
			if (_movingObject !="") {
				if (_movingObject == "Right:I+1") { // Смещение по горизонтале вправо
					_unit1.x += 10; // вправо
					_unit2.x -= 10; // влево
					if (_unit1.x >= _unit2.posX) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationExchange);
						_unit1.posX = _unit1.x;
						_unit2.posX = _unit2.x;
						if (Mechanics.CheckField() == false) {	// Группа не определена возвращаем на исходную позицию
							_movingObject = "Left:I-1";	// Обмен местами по горизонтали с объектом стоящим справа
							Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
							this.addEventListener(Event.ENTER_FRAME, AnimationBackExchange);
							this.play();
						} else Mechanics.SimplyRemove(this);	// обработка удаления помеченных объектов
						return;
					}
				}
				if (_movingObject == "Left:I-1") { // Смещение по горизонтале влево
					_unit1.x -= 10;
					_unit2.x += 10;
					trace("UNIT1:" + _unit1.x.toString() + "  UNIT2:" + _unit2.posX.toString());
					if (_unit1.x <= _unit2.posX) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationExchange);
						_unit1.posX = _unit1.x;
						_unit2.posX = _unit2.x;
						if (Mechanics.CheckField() == false) {	// Группа не определена возвращаем на исходную позицию
							_movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
							Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
							this.addEventListener(Event.ENTER_FRAME, AnimationBackExchange);
							this.play();
						} else Mechanics.SimplyRemove(this);	// обработка удаления помеченных объектов
						return;
					}
				}
				if (_movingObject == "Up:J-1") { // Смещение по вертикале вверх
					_unit1.y -= 10; // вправо
					_unit2.y += 10; // влево
					if (_unit1.y <= _unit2.posY) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationExchange);
						_unit1.posY = _unit1.y;
						_unit2.posY = _unit2.y;
						if (Mechanics.CheckField() == false) {	// Группа не определена возвращаем на исходную позицию
							_movingObject = "Down:J+1";	// Обмен местами по горизонтали с объектом стоящим внизу
							Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
							this.addEventListener(Event.ENTER_FRAME, AnimationBackExchange);
							this.play();
						} else Mechanics.SimplyRemove(this);	// обработка удаления помеченных объектов
						return;
					}
				}
				if (_movingObject == "Down:J+1") { // Смещение по вертикале вниз
					_unit1.y += 10; // вправо
					_unit2.y -= 10; // влево
					if (_unit1.y >= _unit2.posY) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationExchange);
						_unit1.posY = _unit1.y;
						_unit2.posY = _unit2.y;
						if (Mechanics.CheckField() == false) {	// Группа не определена возвращаем на исходную позицию
							_movingObject = "Up:J-1";	// Обмен местами по горизонтали с объектом стоящим вверху
							Mechanics.ExchangeCrystals(_unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
							this.addEventListener(Event.ENTER_FRAME, AnimationBackExchange);
							this.play();
						} else Mechanics.SimplyRemove(this);	// обработка удаления помеченных объектов
						return;
					}
				}
				
			}
		}
		
		/* Анимация возврата на исходную позицию в случае если группа не определена */
		private function AnimationBackExchange(e:Event):void 
		{
			/* Анимация пеемещания кристалов */
			if (_movingObject !="") {
				if (_movingObject == "Right:I+1") { // Смещение по горизонтале вправо
					_unit1.x += 10; // вправо
					_unit2.x -= 10; // влево
					if (_unit1.x >= _unit2.posX) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationBackExchange);
						_unit1.posX = _unit1.x;
						_unit2.posX = _unit2.x;
						blockedField = false; 
					}
				}
				if (_movingObject == "Left:I-1") { // Смещение по горизонтале влево
					_unit1.x -= 10;
					_unit2.x += 10;
					if (_unit1.x <= _unit2.posX) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationBackExchange);
						_unit1.posX = _unit1.x;
						_unit2.posX = _unit2.x;
						blockedField = false;
					}
				}
				if (_movingObject == "Up:J-1") { // Смещение по вертикале вверх
					_unit1.y -= 10; // вправо
					_unit2.y += 10; // влево
					if (_unit1.y <= _unit2.posY) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationBackExchange);
						_unit1.posY = _unit1.y;
						_unit2.posY = _unit2.y;
						blockedField = false;
					}
				}
				if (_movingObject == "Down:J+1") { // Смещение по вертикале вниз
					_unit1.y += 10; // вправо
					_unit2.y -= 10; // влево
					if (_unit1.y >= _unit2.posY) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationBackExchange);
						_unit1.posY = _unit1.y;
						_unit2.posY = _unit2.y;
						blockedField = false;
					}
				}
			}
		}
		
		
		
		/*==========================================================================================================*/
		
		/* ИНДИКАТОРЫ ИГРОКОВ --------------------------------------------------------------------------------------*/
		private function showIndicators():void
		{
			userXP = Resource.FIGHTER_HIP_POINTS;
			botXP = Resource.BOT_HIP_POINTS;
			/* XP пользователя */
			this.addChild(new Label(20, 0, 200, 25, "Arial", 16, 0xF4E660, Resource.FIGHTER_NAME, false));
			_userIndicatorXP = new Shape();
			_userIndicatorXP.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_userIndicatorXP.graphics.beginFill(0xCC0000, 1);
			_userIndicatorXP.graphics.drawRect(0, 0, 200, 10);
			_userIndicatorXP.graphics.endFill();
			_userIndicatorXP.graphics.beginFill(0x0000FF, 1);
			_userIndicatorXP.graphics.drawRect(0, 0, calculationIndicator(Resource.FIGHTER_HIP_POINTS, userXP, 200), 10);
			_userIndicatorXP.graphics.endFill();
			_userIndicatorXP.x = 20; _userIndicatorXP.y = 25;
			this.addChild(_userIndicatorXP);
			_userLabelXP = new Label(25, 20, 200, 20, "Arial", 12, 0xF4E660, userXP.toString() + " / " + Resource.FIGHTER_HIP_POINTS.toString(), false); 
			this.addChild(_userLabelXP);
			/* Mana пользователя */
			_userIndicatorMana = new Shape();
			_userIndicatorMana.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_userIndicatorMana.graphics.beginFill(0xFFFF80, 1);
			_userIndicatorMana.graphics.drawRect(0, 0, 100, 10);
			_userIndicatorMana.graphics.endFill();
			_userIndicatorMana.graphics.beginFill(0x31DE27, 1);
			_userIndicatorMana.graphics.drawRect(0, 0, calculationIndicator(Resource.FIGHTER_MANA, userMana, 100), 10);
			_userIndicatorMana.graphics.endFill();
			_userIndicatorMana.x = 20; _userIndicatorMana.y = 40;
			this.addChild(_userIndicatorMana);
			_userLabelMana = new Label(25, 35, 200, 20, "Arial", 12, 0x000000, userMana.toString() + " / " + Resource.FIGHTER_MANA.toString(), false); 
			this.addChild(_userLabelMana);
			
			/* XP бота */
			this.addChild(new Label(580, 0, 200, 25, "Arial", 16, 0xF4E660, Resource.BOT_NAME, false));
			_botIndicatorXP = new Shape();
			_botIndicatorXP.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_botIndicatorXP.graphics.beginFill(0xCC0000, 1);
			_botIndicatorXP.graphics.drawRect(0, 0, 200, 10);
			_botIndicatorXP.graphics.endFill();
			_botIndicatorXP.graphics.beginFill(0x0000FF, 1);
			_botIndicatorXP.graphics.drawRect(0, 0, calculationIndicator(Resource.BOT_HIP_POINTS, botXP, 200), 10);
			_botIndicatorXP.graphics.endFill();
			_botIndicatorXP.x = 580; _botIndicatorXP.y = 25;
			this.addChild(_botIndicatorXP);
			_botLabelXP = new Label(590, 20, 200, 20, "Arial", 12, 0xF4E660, botXP.toString() + " / " + Resource.BOT_HIP_POINTS.toString(), false); 
			this.addChild(_botLabelXP);
			/* Mana бота */
			_botIndicatorMana = new Shape();
			_botIndicatorMana.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_botIndicatorMana.graphics.beginFill(0xFFFF80, 1);
			_botIndicatorMana.graphics.drawRect(0, 0, 100, 10);
			_botIndicatorMana.graphics.endFill();
			_botIndicatorMana.graphics.beginFill(0x31DE27, 1);
			_botIndicatorMana.graphics.drawRect(0, 0, calculationIndicator(Resource.BOT_MANA, botMana, 100), 10);
			_botIndicatorMana.graphics.endFill();
			_botIndicatorMana.x = 680; _botIndicatorMana.y = 40;
			this.addChild(_botIndicatorMana);
			_botLabelMana = new Label(690, 35, 200, 20, "Arial", 12, 0x000000, botMana.toString() + " / " + Resource.BOT_MANA.toString(), false); 
			this.addChild(_botLabelMana);
			
			if (Resource.Language == "eng") {
				if (actionPlayer == "USER")	_actionFighter = new Label(350, 20, 200, 40, "Arial", 18, 0xF4E660, "Your hit " + _countTimer.toString(), false);
				else _actionFighter = new Label(320, 20, 200, 40, "Arial", 18, 0xF4E660, "Beat the opponent " + _countTimer.toString(), false);
			}else{
				if (actionPlayer == "USER")	_actionFighter = new Label(350, 20, 200, 40, "Arial", 18, 0xF4E660, "Ваш удар " + _countTimer.toString(), false);
				else _actionFighter = new Label(325, 20, 200, 40, "Arial", 18, 0xF4E660, "Удар противника " + _countTimer.toString(), false);
			}
			this.addChild(_actionFighter);
		}
		
		private function editIndicators():void
		{
			/* XP пользователя */
			this.removeChild(_userIndicatorXP);
			_userIndicatorXP = new Shape();
			_userIndicatorXP.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_userIndicatorXP.graphics.beginFill(0xCC0000, 1);
			_userIndicatorXP.graphics.drawRect(0, 0, 200, 10);
			_userIndicatorXP.graphics.endFill();
			_userIndicatorXP.graphics.beginFill(0x0000FF, 1);
			_userIndicatorXP.graphics.drawRect(0, 0, calculationIndicator(Resource.FIGHTER_HIP_POINTS, userXP, 200), 10);
			_userIndicatorXP.graphics.endFill();
			_userIndicatorXP.x = 20; _userIndicatorXP.y = 25;
			this.addChild(_userIndicatorXP);
			this.removeChild(_userLabelXP);
			_userLabelXP = new Label(25, 20, 200, 20, "Arial", 12, 0xF4E660, userXP.toString() + " / " + Resource.FIGHTER_HIP_POINTS.toString(), false); 
			this.addChild(_userLabelXP);
			
			/* Mana пользователя */
			this.removeChild(_userIndicatorMana);
			_userIndicatorMana = new Shape();
			_userIndicatorMana.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_userIndicatorMana.graphics.beginFill(0xFFFF80, 1);
			_userIndicatorMana.graphics.drawRect(0, 0, 100, 10);
			_userIndicatorMana.graphics.endFill();
			_userIndicatorMana.graphics.beginFill(0x31DE27, 1);
			_userIndicatorMana.graphics.drawRect(0, 0, calculationIndicator(Resource.FIGHTER_MANA, userMana, 100), 10);
			_userIndicatorMana.graphics.endFill();
			_userIndicatorMana.x = 20; _userIndicatorMana.y = 40;
			this.addChild(_userIndicatorMana);
			this.removeChild(_userLabelMana);
			_userLabelMana = new Label(25, 35, 200, 20, "Arial", 12, 0x000000, userMana.toString() + " / " + Resource.FIGHTER_MANA.toString(), false); 
			this.addChild(_userLabelMana);
			
			/* XP бота ------------------------------------------------------*/
			this.removeChild(_botIndicatorXP);
			_botIndicatorXP = new Shape();
			_botIndicatorXP.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_botIndicatorXP.graphics.beginFill(0xCC0000, 1);
			_botIndicatorXP.graphics.drawRect(0, 0, 200, 10);
			_botIndicatorXP.graphics.endFill();
			_botIndicatorXP.graphics.beginFill(0x0000FF, 1);
			_botIndicatorXP.graphics.drawRect(0, 0, calculationIndicator(Resource.BOT_HIP_POINTS, botXP, 200), 10);
			_botIndicatorXP.graphics.endFill();
			_botIndicatorXP.x = 580; _botIndicatorXP.y = 25;
			this.addChild(_botIndicatorXP);
			this.removeChild(_botLabelXP);
			_botLabelXP = new Label(590, 20, 200, 20, "Arial", 12, 0xF4E660, botXP.toString() + " / " + Resource.BOT_HIP_POINTS.toString(), false); 
			this.addChild(_botLabelXP);
			
			/* Mana бота */
			this.removeChild(_botIndicatorMana);
			_botIndicatorMana = new Shape();
			_botIndicatorMana.graphics.lineStyle(2, 0xFFFFFF, 0.7);
			_botIndicatorMana.graphics.beginFill(0xFFFF80, 1);
			_botIndicatorMana.graphics.drawRect(0, 0, 100, 10);
			_botIndicatorMana.graphics.endFill();
			_botIndicatorMana.graphics.beginFill(0x31DE27, 1);
			_botIndicatorMana.graphics.drawRect(0, 0, calculationIndicator(Resource.BOT_MANA, botMana, 100), 10);
			_botIndicatorMana.graphics.endFill();
			_botIndicatorMana.x = 680; _botIndicatorMana.y = 40;
			this.addChild(_botIndicatorMana);
			this.removeChild(_botLabelMana);
			_botLabelMana = new Label(690, 35, 200, 20, "Arial", 12, 0x000000, botMana.toString() + " / " + Resource.BOT_MANA.toString(), false); 
			this.addChild(_botLabelMana);
		}
		
		private function calculationIndicator(start:int, actual:int, widthIndicators:int):Number
		{
			var result:Number = 0;
			var difference:Number = 0;
			
			if (widthIndicators > start) { // если жизнь меньше 200 изначально
				difference = (widthIndicators - start) - (start - actual);
				result = actual + difference;
			}
			if (widthIndicators == start) { // если жизнь меньше 200 изначально
				difference = (start - actual);
				result = widthIndicators - difference;
			}
			if (widthIndicators < start) { // если жизнь больше 200 изначально
				difference = start / actual;
				result = widthIndicators / difference;
			}
			return result;
		}
		
		public function ReductionXP(typeHit:String):void // уменьшение жизни (тип удара)
		{
			//удар = [тип удара] * [сила] - ([блок] * [защита]) - [ловкость врага] + [ваша ловкость]
			
			var result:int = 0;
			
			if (typeHit == "HIT_1") { // верхний удар ногой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			if (typeHit == "HIT_2") { // нижний удар ногой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			if (typeHit == "HIT_3") { // удар ногой с разворота
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			if (typeHit == "HIT_4") { // блок
				if (actionPlayer == "USER") {
					userBlock = 3;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						botBlock = 3;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_5") { // нижний удар рукой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			if (typeHit == "HIT_6") { // верхний удар рукой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}
					else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			if (typeHit == "HIT_7") { // апперкот
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_POWER - (botBlock * Resource.BOT_DEFENSE) - Resource.BOT_SLEIGHT + Resource.FIGHTER_SLEIGHT;
					this.addChild(new Blood(_botFighter.x - 20, _botFighter.y - 30));
					if ((botXP - result) > 0) {
						botXP -= result; botBlock = 0;
						editIndicators();
					}else { // БОЙ ЗАВЕРШЕН!!!
						botXP = 0;
						editIndicators();
						battleEnd("USER", "BOT");
					}
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_POWER - (userBlock * Resource.FIGHTER_DEFENSE) - Resource.FIGHTER_SLEIGHT + Resource.BOT_SLEIGHT;
						this.addChild(new Blood(_userFighter.x - 20, _userFighter.y - 30));
						if ((userXP - result) > 0) {
							userXP -= result; userBlock = 0;
							editIndicators();
						}else { // БОЙ ЗАВЕРШЕН!!!
							userXP = 0;
							editIndicators();
							battleEnd("BOT", "USER");
						}
					}
				}
			}
			
		}
		
		public function IncreaseMana(typeHit:String):void
		{
			var result:int = 0;
			if (typeHit == "HIT_1") { // верхний удар ногой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_1 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_1 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_2") { // нижний удар ногой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_2 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_2 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_3") { // удар ногой с разворота
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_3 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_3 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_4") { // блок
				
			}
			if (typeHit == "HIT_5") { // нижний удар рукой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_5 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_5 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_6") { // верхний удар рукой
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_6 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_6 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			if (typeHit == "HIT_7") { // апперкот
				if (actionPlayer == "USER") {
					result = Resource.DEFAULT_HIT_7 * Resource.FIGHTER_INTELLECT;
					if ((userMana + result) <= Resource.FIGHTER_MANA) userMana += result;
					else userMana = Resource.FIGHTER_MANA;
					editIndicators();
				}else{
					if (actionPlayer == "BOT") {
						result = Resource.DEFAULT_HIT_7 * Resource.BOT_INTELLECT;
						if ((botMana + result) <= Resource.FIGHTER_MANA) botMana += result;
						else botMana = Resource.FIGHTER_MANA;
						editIndicators();
					}
				}
			}
			
		}
				
		public function ReductionMana():void // уменьшение маны
		{
			
		}
		/*-------------------------------------------------------------*/
		
		/* Смена очередности ударов. Работа искуственного интелекта -- */
		private function Exchange():void // поменятся (связан с AnimationMoveDown)
		{
			if (actionPlayer == "USER") {
				actionPlayer = "BOT";
				_actionFighter.x = 325;
				if (Resource.Language == "eng") _actionFighter.text = "Beat the opponent " + _countTimer.toString();
				else _actionFighter.text = "Удар противника " + _countTimer.toString();
				blockedField = true;
			} else {
				actionPlayer = "USER";
				_actionFighter.x = 350;
				if (Resource.Language == "eng") _actionFighter.text = "Your hit " + _countTimer.toString();
				else _actionFighter.text = "Ваш удар " + _countTimer.toString();
				blockedField = false;
			}
		}
		
		private function timerRun():void
		{
			_countTimer = 10;
			_timer.start();
		}
		
		private function timerStop():void
		{
			_timer.stop();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			//...
		}

		private function completeHandler(e:TimerEvent):void
		{
			
			if (_countTimer <= 0) {
				_countTimer = 10;
				Exchange();
			}
			if (actionPlayer == "USER") {
				if (Resource.Language == "eng") _actionFighter.text = "Your hit " + _countTimer.toString();
				else _actionFighter.text = "Ваш удар " + _countTimer.toString();
			}
			else {
				if (Resource.Language == "eng") _actionFighter.text = "Beat the opponent " + _countTimer.toString();
				else _actionFighter.text = "Удар противника " + _countTimer.toString();
				if (_countTimer == 9) Mechanics.HitAI(this); // ход искуственного интеллекта
			}
			_countTimer--;
            _timer.start();
		} 
		/*-------------------------------------------------------------*/
		
		
		/* СРАЖЕНИЕ ЗАВЕРШЕНО -----------------------------------------*/
		private function battleEnd(PlayerWin:String, PlayerLose:String):void
		{
			_gameEnd = true; // игра завершена
			this.removeChild(_userFighter);
			this.removeChild(_botFighter);
			if (PlayerWin == "USER" && PlayerLose == "BOT") { showUserWin(Resource.FIGHTER_ID); showBotLose(Resource.BOT_ID); }
			if (PlayerWin == "BOT" && PlayerLose == "USER") { showBotWin(Resource.BOT_ID); showUserLose(Resource.FIGHTER_ID); }
			// Инициализация окно завершения уровня
			if (PlayerWin == "USER") _windowGameEnd = new GameEnd("WIN");  // связан с AnimationMoveDown
			if (PlayerWin == "BOT") _windowGameEnd = new GameEnd("LOSE");  // связан с AnimationMoveDown
		}
		/*-------------------------------------------------------------*/
		
		/* КНОПКИ: Назад, Настройки, Играть ---------------------------*/
		private function buttonSettings():void
		{
			if (Resource.Language == "eng") _battonSetting = new Button(0, 565, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Settings", 40);
			else _battonSetting = new Button(0, 565, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Настройки", 30);
			_battonSetting.addEventListener(MouseEvent.CLICK, onMouseClickButtonSettings);
			this.addChild(_battonSetting);
		}
		
		private function onMouseClickButtonSettings(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_FALSE_SHOW" }, true));
		}
		
		private function buttonBack():void
		{
			if (Resource.Language == "eng") _battonBack = new Button(650, 565, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Back", 50);
			else _battonBack = new Button(650, 565, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Назад", 40);
			_battonBack.addEventListener(MouseEvent.CLICK, onMouseClickButtonBack);
			this.addChild(_battonBack);
		}
		
		private function onMouseClickButtonBack(e:MouseEvent):void 
		{
			_timer.stop();
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_BACK_IN_TOURNAMENT_STAIRS" }, true));
			
		}
		
	}

}
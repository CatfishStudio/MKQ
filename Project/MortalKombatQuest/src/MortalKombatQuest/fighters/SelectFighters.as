package MortalKombatQuest.fighters 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import MortalKombatQuest.Stats;
	import MortalKombatQuest.kernel.Atlas;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.fighters.FighterIcon;
	import MortalKombatQuest.fighters.Characteristics;
	import MortalKombatQuest.animation.Fighter;
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.buttons.Button;
	
	public class SelectFighters extends Sprite 
	{
		public var GameType:String;
		
		private var _fighter:Sprite;
		private var _characteristics:Characteristics;
		private var _battonPlay:Button;
		private var _battonBack:Button;
		private var _battonSetting:Button;
		
		public function SelectFighters() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			this.addChild(Resource.SelectFightersBackground);
			
			this.addChild(new FighterIcon(35, 80, "KITANA_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(95, 80, "REPTILE_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(155, 80, "SONYA_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(215, 80, "JAX_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(275, 80, "NIGHTWOLF_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(335, 80, "JADE_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 240, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(395, 80, "SCORPION_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 288, 0, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(455, 80, "RAIN_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(515, 80, "KANO_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(575, 80, "MILEENA_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(635, 80, "ERMAC_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(695, 80, "SUBZERO_1_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 59, 48, 59, 0, 0).bitmapData, false));
			
			this.addChild(new FighterIcon(35, 150, "SUBZERO_2_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 240, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(95, 150, "NOOBSAIBOT_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 288, 59, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(155, 150, "SEKTOR_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 118, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(215, 150, "SINDEL_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 118, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(275, 150, "STRYKER_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 118, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(335, 150, "SYREX_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 118, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(395, 150, "KUNGLAO_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 118, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(455, 150, "KABAL_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 177, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(515, 150, "SHEEVA_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 177, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(575, 150, "SHANGTSUNG_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 177, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(635, 150, "LIUKANG_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 177, 48, 59, 0, 0).bitmapData, false));
			this.addChild(new FighterIcon(695, 150, "SMOKE_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 177, 48, 59, 0, 0).bitmapData, false));
			
			this.addChild(new FighterIcon(275, 10, "MOTARO_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 236, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(335, 10, "SHAOKAHN_MK3U", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 236, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(215, 220, "LIUKANG_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 312, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(275, 220, "KUNGLAO_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 312, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(335, 220, "JOHNYCAGE_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 312, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(395, 220, "REPTILE_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 312, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(455, 220, "SUBZERO_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 371, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(515, 220, "SHANGTSUNG_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 371, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(215, 290, "KITANA_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 371, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(275, 290, "JAX_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 371, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(335, 290, "MILEENA_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 430, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(395, 290, "BARAKA_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 430, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(455, 290, "SCORPION_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 430, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(515, 290, "RAIDEN_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 430, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(395, 10, "KINTARO_MK2", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 489, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(275, 360, "JOHNYCAGE_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 568, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(335, 360, "KANO_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 568, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(395, 360, "SUBZERO_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 568, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(455, 360, "SONYA_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 568, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(275, 430, "RAIDEN_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 627, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(335, 430, "LIUKANG_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 48, 627, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(395, 430, "SCORPION_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 96, 627, 48, 59, 0, 0).bitmapData));
			this.addChild(new FighterIcon(455, 430, "SHANGTSUNG_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 192, 627, 48, 59, 0, 0).bitmapData));
			
			this.addChild(new FighterIcon(455, 10, "GORO_MK1", Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 144, 627, 48, 59, 0, 0).bitmapData));
			
			_fighter = new Sprite();
			_fighter.addChild(new Fighter(25, 300, 0, 0, 800, 260, 100, 130, Resource.KitanaMK3U_Atlas, 7, 100, false));
			Resource.FIGHTER_ICON = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 0, 48, 59, 0, 0).bitmapData);
			Resource.FIGHTER_CLOSE = false;
			this.addChild(_fighter);
			_characteristics = new Characteristics(580, 250, "KITANA_MK3U");
			this.addChild(_characteristics);
			
			buttonPlay("CREATE");
			buttonBack();
			buttonSettings();
			//onStats();
			
		}
		
		private function onStats():void
		{
			this.addChild(new Stats());
		}
		
		private function buttonSettings():void
		{
			if (Resource.Language == "eng") _battonSetting = new Button(320, 540, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Settings", 40);
			else _battonSetting = new Button(320, 540, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Настройки", 30);
			_battonSetting.addEventListener(MouseEvent.CLICK, onMouseClickButtonSettings);
			this.addChild(_battonSetting);
		}
		
		private function onMouseClickButtonSettings(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_FALSE_SHOW" }, true));
		}
		
		private function buttonBack():void
		{
			if (Resource.Language == "eng") _battonBack = new Button(605, 540, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Back", 50);
			else _battonBack = new Button(605, 540, 150, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Назад", 40);
			_battonBack.addEventListener(MouseEvent.CLICK, onMouseClickButtonBack);
			this.addChild(_battonBack);
		}
		
		private function onMouseClickButtonBack(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_BACK_IN_START_MENU" }, true));
		}
		
		private function buttonPlay(status:String):void
		{
			if (status == "CREATE") {
				if(Resource.FIGHTER_CLOSE == false){
					if (Resource.Language == "eng")_battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Play", 50);
					else _battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Играть", 40);
					_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
					this.addChild(_battonPlay);
				}else {
					if (Resource.Language == "eng")_battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 16, "Buy", 55);
					else _battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 16, "Купить", 40);
					_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
					this.addChild(_battonPlay);
				}
			}
			if (status == "RESET") {
				if(Resource.FIGHTER_CLOSE == false){
					this.removeChild(_battonPlay);
					if (Resource.Language == "eng")_battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Play", 50);
					else _battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Играть", 40);
					_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
					this.addChild(_battonPlay);
				}else {
					this.removeChild(_battonPlay);
					if (Resource.Language == "eng")_battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 16, "Buy", 55);
					else _battonPlay = new Button(605, 500, 150, 35, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 16, "Купить", 40);
					_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
					this.addChild(_battonPlay);
				}
			}
		}
		
		private function onMouseClickButtonPlay(e:Event):void 
		{
			if (GameType == "TOURNAMENT") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_TOURNAMENT_STAIRS" }, true));
			if (GameType == "PLAYER_VS_PLAYER") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_PLAYER_VS_PLAYER" }, true));
			Resource.SelectGameType = GameType;	// отмечаем выбранный тип игры (Турнир или ПвП)
		}
		
		/* Событие: управление окнами игры */
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.param.id)
			{
				case "KITANA_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 800, 260, 100, 130, Resource.KitanaMK3U_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "REPTILE_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.ReptileMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SONYA_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 800, 260, 100, 130, Resource.SonyaMK3U_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "JAX_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.JaxMK3U_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "NIGHTWOLF_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.NightwolfMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "JADE_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 700, 260, 100, 130, Resource.JadeMK3U_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SCORPION_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.ScorpionMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "RAIN_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.RainMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KANO_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 600, 280, 100, 140, Resource.KanoMK3U_Atlas, 5, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "MILEENA_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.MileenaMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "ERMAC_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.ErmacMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SUBZERO_1_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.Subzero1MK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SUBZERO_2_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 1000, 260, 100, 130, Resource.Subzero2MK3U_Atlas, 9, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "NOOBSAIBOT_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.NoobsaibotMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SEKTOR_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 800, 280, 100, 140, Resource.SektorMK3U_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SINDEL_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.SindelMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "STRYKER_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.StrykerMK3U_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SYREX_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 100, 0, 800, 280, 100, 140, Resource.CyrexMK3U_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KUNGLAO_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 900, 280, 100, 140, Resource.KungLaoMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KABAL_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 900, 280, 100, 140, Resource.KabalMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SHEEVA_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 265, 0, 0, 1000, 300, 100, 150, Resource.SheevaMK3U_Atlas, 9, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SHANGTSUNG_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 900, 260, 100, 130, Resource.ShangTsungMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "LIUKANG_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 300, 0, 0, 1600, 260, 100, 130, Resource.LiuKangMK3U_Atlas, 15, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SMOKE_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 900, 280, 100, 140, Resource.SmokeMK3U_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "MOTARO_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(-150, 180, 0, 0, 2800, 400, 200, 200, Resource.MotaroMK3U_Atlas, 10, 200, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SHAOKAHN_MK3U":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 260, 0, 0, 700, 320, 100, 160, Resource.ShaoKahnMK3U_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "LIUKANG_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.LiuKangMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KUNGLAO_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 800, 280, 100, 140, Resource.KungLaoMK2_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "JOHNYCAGE_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.JohnnyCageMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "REPTILE_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.ReptileMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SUBZERO_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 1200, 280, 100, 140, Resource.SubzeroMK2_Atlas, 11, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SHANGTSUNG_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.ShangTsungMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KITANA_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 600, 280, 100, 140, Resource.KitanaMK2_Atlas, 5, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "JAX_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 260, 0, 0, 700, 300, 100, 150, Resource.JaxMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "MILEENA_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 1200, 280, 100, 140, Resource.MileenaMK2_Atlas, 11, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "BARAKA_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 900, 280, 100, 140, Resource.BarakaMK2_Atlas, 8, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SCORPION_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.ScorpionMK2_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "RAIDEN_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 260, 0, 0, 1000, 300, 100, 150, Resource.RaidenMK2_Atlas, 9, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KINTARO_MK2":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(-50, 260, 0, 0, 1860, 310, 155, 155, Resource.KintaroMK2_Atlas, 11, 155, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "JOHNYCAGE_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 600, 280, 100, 140, Resource.JohnnyCageMK1_Atlas, 5, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "KANO_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.KanoMK1_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SUBZERO_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 1200, 280, 100, 140, Resource.SubzeroMK1_Atlas, 11, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SONYA_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.SonyaMK1_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "RAIDEN_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 1000, 280, 100, 140, Resource.RaidenMK1_Atlas, 9, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "LIUKANG_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 800, 280, 100, 140, Resource.LiuKangMK1_Atlas, 7, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SCORPION_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 700, 280, 100, 140, Resource.ScorpionMK1_Atlas, 6, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "SHANGTSUNG_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(25, 280, 0, 0, 600, 280, 100, 140, Resource.ShangTsungMK1_Atlas, 5, 100, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
				
				case "GORO_MK1":
					this.removeChild(_fighter);
					_fighter = new Sprite();
					_fighter.addChild(new Fighter(-50, 260, 0, 0, 1050, 320, 150, 160, Resource.GoroMK1_Atlas, 6, 150, false));
					this.addChild(_fighter);
					
					this.removeChild(_characteristics);
					_characteristics = new Characteristics(580, 250, e.param.id);
					this.addChild(_characteristics);
					buttonPlay("RESET");
				break;
			}
		}
		
		
	}

}
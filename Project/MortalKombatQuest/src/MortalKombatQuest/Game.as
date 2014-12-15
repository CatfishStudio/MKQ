package MortalKombatQuest 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.resource.Resource
	import MortalKombatQuest.menu.StartMenu;
	import MortalKombatQuest.windows.Setting;
	import MortalKombatQuest.fighters.SelectFighters;
	import MortalKombatQuest.animation.Stairs;
	import MortalKombatQuest.level.Level;
	
	public class Game extends Sprite 
	{
		private var _mask:Sprite = new Sprite();// маска 800х600
		
		private var _startMenu:StartMenu;		// главное меню игры
		private var _windowSetting:Setting;		// окно настроек
		private var _selectFighters:SelectFighters;	// окно выбора персонажа
		private var _stairs:Stairs;				// турнирная лестница
		private var _level:Level;				// уровень для проведения поединка
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			/* Маска размеров 800 на 600 */
			_mask.graphics.beginFill(0x333333, 1);
			_mask.graphics.drawRect(0, 0, 800, 600);
			_mask.x = 0; _mask.y = 0;
			_mask.graphics.endFill();
			this.addChild(_mask)
			this.mask = _mask; // применение маси
			
			/* Глобальное событие при выборе, смене окна */
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			/* Загрузка окна: главное меню игры */
			_startMenu = new StartMenu();
			this.addChild(_startMenu);
		}
		
		/* Событие: управление окнами игры */
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.param.id)
			{
			case "GAME_WINDOW_SETTING_SHOW": // Открыть окно настроек
               _windowSetting = new Setting(true);
			   this.addChild(_windowSetting);
               break;
			   
			case "GAME_WINDOW_SETTING_FALSE_SHOW": // Открыть окно настроек
               _windowSetting = new Setting(false);
			   this.addChild(_windowSetting);
               break;
			   
			case "GAME_WINDOW_SETTING_CLOSE": // Закрыть окно настроек
               this.removeChild(_windowSetting);
               break;
			   
			case "GAME_RESET": // Перезапуск после смены языка
				this.removeChild(_windowSetting);
				this.removeChild(_startMenu);
				_startMenu = new StartMenu();
				this.addChild(_startMenu);
				break;   
				
			case "GAME_PLAYER_VS_PLAYER": // 
               
				break;
				
			case "GAME_TOURNAMENT_SELECT_FIGHTERS": // Окно выбора бойца (турнир)
				this.removeChild(_startMenu);
				_selectFighters = new SelectFighters();
				_selectFighters.GameType = "TOURNAMENT";
				this.addChild(_selectFighters);
				break;
			   
			case "GAME_BACK_IN_START_MENU": // Возврат в главное меню
               this.removeChild(_selectFighters);
			   _startMenu = new StartMenu();
				this.addChild(_startMenu);
               break;
			   
			case "GAME_TOURNAMENT_STAIRS": // Стена соперников (турнир)
                this.removeChild(_selectFighters);
				_stairs = new Stairs();
				this.addChild(_stairs);
				break;
			
			case "GAME_BACK_IN_SELECT_FIGHTERS": // Возврат в окно выбора бойца (турнир)
                this.removeChild(_stairs);
				_selectFighters = new SelectFighters();
				_selectFighters.GameType = "TOURNAMENT";
				this.addChild(_selectFighters);
				break;
			
			case "GAME_TOURNAMENT_FIGHT": // Поединок (турнир) загрузка уровня
                this.removeChild(_stairs);
				_level = new Level();
				this.addChild(_level);
				break;
			
			case "GAME_BACK_IN_TOURNAMENT_STAIRS": // Возврат на стену соперников (турнир)
                this.removeChild(_level);
				_stairs = new Stairs();
				this.addChild(_stairs);
				break;
				
			}
		}
		
	}

}
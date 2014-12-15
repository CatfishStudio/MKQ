package MortalKombatQuest.menu 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Sprite;
	
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.resource.Resource;
	
	public class StartMenu extends Sprite 
	{
		[Embed(source = '../media/textures/logo.png')]
		private var Logo:Class;
		private var _logo:Bitmap = new Logo();
		
		private var _battonTournament:Label;
		private var _battonPvP:Label;
		private var _battonSettings:Label;
		private var _authorText:Sprite;
		
		public function StartMenu() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.graphics.beginFill(0x000000, 1);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1, 0xFFFFFF, 0.5);
			this.graphics.drawRect(3, 3, 794, 594);
			
			_logo.x = 140; _logo.y = 20;
			this.addChild(_logo);
			
			this.addChild(new Label(260, 490, 500, 100, "garamond", 34, 0xFFFF00, "MORTAL KOMBAT \n          QUEST", false));
			this.addChild(new Label(259, 491, 500, 100, "garamond", 34, 0xFF8000, "MORTAL KOMBAT \n          QUEST", false));
			
			if (Resource.Language == "eng") _battonPvP = new Label(325, 320, 350, 30, "arial", 22, 0xFFFFFF, "Player vs. Player", false);
			else _battonPvP = new Label(305, 320, 350, 30, "arial", 22, 0xFFFFFF, "Сразиться с другом", false);
			_battonPvP.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_battonPvP.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_battonPvP.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_battonPvP.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_battonPvP.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			this.addChild(_battonPvP);
			
			if (Resource.Language == "eng") _battonTournament = new Label(345, 360, 250, 30, "arial", 22, 0xFFFFFF, "Tournament", false);
			else _battonTournament = new Label(325, 360, 250, 30, "arial", 22, 0xFFFFFF, "Одиночная игра", false);
			_battonTournament.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_battonTournament.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_battonTournament.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_battonTournament.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_battonTournament.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			this.addChild(_battonTournament);
			
			if (Resource.Language == "eng") _battonSettings = new Label(365, 400, 250, 30, "arial", 22, 0xFFFFFF, "Settings", false);
			else _battonSettings = new Label(355, 400, 250, 30, "arial", 22, 0xFFFFFF, "Настройки", false);
			_battonSettings.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_battonSettings.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_battonSettings.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_battonSettings.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_battonSettings.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			this.addChild(_battonSettings);
			
			_authorText = new Sprite();
			_authorText.graphics.beginFill(0x000000, 1);
			_authorText.graphics.drawRect(340, 585, 125, 20);
			_authorText.graphics.endFill();
			_authorText.addChild(new Label(340, 585, 125, 30, "Arial", 12, 0xFFFFFF, "Catfish Studio Games", false));
			this.addChild(_authorText);
		}
		
		
		private function onMouseClickButton(e:MouseEvent):void 
		{
			if ((e.target as Label).text == "Settings" || (e.target as Label).text == "Настройки") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_SHOW" }, true));
			if ((e.target as Label).text == "Player vs. Player" || (e.target as Label).text == "Сразиться с другом") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_PLAYER_VS_PLAYER" }, true));
			if ((e.target as Label).text == "Tournament" || (e.target as Label).text == "Одиночная игра") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_TOURNAMENT_SELECT_FIGHTERS" }, true));
		}
		
		
		private function onMouseUpButton(e:MouseEvent):void 
		{
			(e.target as Label).scaleX += 0.01; (e.target as Label).scaleY += 0.01;
			(e.target as Label).x -= 1; (e.target as Label).y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			(e.target as Label).scaleX -= 0.01; (e.target as Label).scaleY -= 0.01;
			(e.target as Label).x += 1; (e.target as Label).y += 1;
		}
		
		private function onMouseOutButton(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMouseOverButton(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
	}

}
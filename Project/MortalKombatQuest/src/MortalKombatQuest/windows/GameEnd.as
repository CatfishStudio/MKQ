package MortalKombatQuest.windows 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Bitmap;
	
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.animation.Dragons;
	import MortalKombatQuest.buttons.Button;
	
	public class GameEnd extends MovieClip 
	{
		private var _panel:Sprite = new Sprite();
		private var _bg:Sprite = new Sprite();
		private var _title:Shape = new Shape();
		
		private var _bInfo:Sprite = new Sprite();
		private var _bMusic:Sprite = new Sprite();
		private var _bSound:Sprite = new Sprite();
		private var _bLanguage:Sprite = new Sprite();
		private var _bClose:Sprite = new Sprite();
		
		private var _status:String;
		
		private var _battonPlay:Button;
		private var _battonBack:Button;
		
		public function GameEnd(status:String) 
		{
			super();
			_status = status;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_bg.graphics.lineStyle(1, 0x000000, 1);
			_bg.graphics.beginFill(0x000000, 1);
			_bg.graphics.drawRect(0, 0, 800, 600);
			_bg.graphics.endFill();
			_bg.x = 0; _bg.y = 0;
			_bg.alpha = 0.4;
			this.addChild(_bg);
			
			_title.graphics.lineStyle(2, 0x8080FF, 1);
			_title.graphics.beginFill(0x000000, 0);
			_title.graphics.drawRect(245, -5, 310, 210);
			_title.graphics.endFill();
			_title.alpha = 1;
			_panel.addChild(_title);
			
			
			_panel.graphics.lineStyle(1, 0x000000, 0);
			_panel.graphics.beginFill(0x000000, 1);
			_panel.graphics.drawRect(250, 0, 300, 200);
			_panel.graphics.endFill();
			_panel.x = 0; _panel.y = -50;
			//_panel.alpha = 0.9;
			
			if (Resource.Language == "eng") {
				if (_status == "WIN") _panel.addChild(new Label(340, 60, 400, 30, "Aria", 24, 0xFFFFFF, "YOU WIN!", false));
				else _panel.addChild(new Label(340, 60, 400, 30, "Aria", 24, 0xFFFFFF, "YOU LOSE!", false));
			}
			else {
				if (_status == "WIN") _panel.addChild(new Label(330, 60, 400, 30, "Aria", 24, 0xFFFFFF, "Вы победили!", false));
				else _panel.addChild(new Label(330, 60, 400, 30, "Aria", 24, 0xFFFFFF, "Вы проиграли!", false));
			}
			
			_panel.addChild(new Dragons(250, 0, 0));
			_panel.addChild(new Dragons(470, 0, 62));
			
			
			if (_status == "WIN") {
				if (Resource.Language == "eng")_battonPlay = new Button(280, 150, 100, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Next", 25);
				else _battonPlay = new Button(280, 150, 100, 35, 0xFFFFFF, 0x8080FF, 0xFFFFFF, 16, "Далее", 20);
				_battonPlay.addEventListener(MouseEvent.CLICK, onMouseClickButtonPlay);
				_panel.addChild(_battonPlay);
			}else{
				if (Resource.Language == "eng") _battonBack = new Button(280, 150, 100, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Back", 25);
				else _battonBack = new Button(280, 150, 100, 35, 0x8080FF, 0x8080FF, 0xFFFFFF, 16, "Назад", 20);
				_battonBack.addEventListener(MouseEvent.CLICK, onMouseClickButtonBack);
				_panel.addChild(_battonBack);
			}
			
			
			
			
			this.addChild(_panel);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_panel.y == 200) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			else _panel.y += 50;
		}
		
		private function onMouseClickButtonPlay(e:Event):void 
		{
			Resource.TournamentWin++; // увеличиваем количество побед в турнире
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_BACK_IN_TOURNAMENT_STAIRS" }, true));
		}
		
		private function onMouseClickButtonBack(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_BACK_IN_TOURNAMENT_STAIRS" }, true));
		}
	}

}
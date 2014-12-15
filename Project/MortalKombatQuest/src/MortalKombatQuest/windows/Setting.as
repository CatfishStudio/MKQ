package MortalKombatQuest.windows 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Bitmap;
	
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.text.Label;
	
	public class Setting extends MovieClip 
	{
		[Embed(source = '../media/textures/information.png')]
		private var Info:Class;
		private var _info:Bitmap = new Info();
		
		[Embed(source = '../media/textures/close.png')]
		private var Close:Class;
		private var _close:Bitmap = new Close();
				
		[Embed(source = '../media/textures/music.png')]
		private var MusicOn:Class;
		private var _musicOn:Bitmap = new MusicOn();
		[Embed(source = '../media/textures/music_off.png')]
		private var MusicOff:Class;
		private var _musicOff:Bitmap = new MusicOff();
		
		[Embed(source = '../media/textures/sound.png')]
		private var SoundOn:Class;
		private var _soundOn:Bitmap = new SoundOn();
		[Embed(source = '../media/textures/sound_off.png')]
		private var SoundOff:Class;
		private var _soundOff:Bitmap = new SoundOff();
		
		[Embed(source = '../media/textures/rus.png')]
		private var LanguageRus:Class;
		private var _languageRus:Bitmap = new LanguageRus();
		[Embed(source = '../media/textures/eng.png')]
		private var LanguageEng:Class;
		private var _languageEng:Bitmap = new LanguageEng();
		
		private var _panel:Sprite = new Sprite();
		private var _bg:Sprite = new Sprite();
		
		private var _bInfo:Sprite = new Sprite();
		private var _bMusic:Sprite = new Sprite();
		private var _bSound:Sprite = new Sprite();
		private var _bLanguage:Sprite = new Sprite();
		private var _bClose:Sprite = new Sprite();
		
		private var _language:Boolean;
		
		public function Setting(language:Boolean = false) 
		{
			super();
			_language = language;
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
			
			_panel.graphics.lineStyle(1, 0x000000, 0);
			_panel.graphics.beginFill(0xF0F0F0, 1);
			_panel.graphics.drawRect(0, 0, 800, 100);
			_panel.graphics.endFill();
			_panel.x = 0; _panel.y = -50;
			_panel.alpha = 0.9;
			
			if(Resource.Language == "eng") _panel.addChild(new Label(320, 10, 400, 30, "Aria", 24, 0x000000, "SETTINGS GAME", false));
			else _panel.addChild(new Label(320, 10, 400, 30, "Aria", 24, 0x000000, "Настройки игры", false));
			
			if (Resource.Music) _bMusic.addChild(_musicOn);
			else _bMusic.addChild(_musicOff);
			_bMusic.x = 250; _bMusic.y = 50;
			_bMusic.addEventListener(MouseEvent.CLICK, onMouseClickMusic);
			_bMusic.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_bMusic.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_bMusic.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_bMusic.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			_panel.addChild(_bMusic);
			
			if (Resource.Sound) _bSound.addChild(_soundOn);
			else _bSound.addChild(_soundOff);
			_bSound.x = 350; _bSound.y = 50;
			_bSound.addEventListener(MouseEvent.CLICK, onMouseClickSound);
			_bSound.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_bSound.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_bSound.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_bSound.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			_panel.addChild(_bSound);
			
			if(_language){
				if (Resource.Language == "eng") _bLanguage.addChild(_languageRus);
				else _bLanguage.addChild(_languageEng);
				_bLanguage.x = 450; _bLanguage.y = 50;
				_bLanguage.addEventListener(MouseEvent.CLICK, onMouseClickLanguage);
				_bLanguage.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
				_bLanguage.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
				_bLanguage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
				_bLanguage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
				_panel.addChild(_bLanguage);
			}
			
			_bInfo.addChild(_info);
			_bInfo.x = 550; _bInfo.y = 50;
			_bInfo.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_bInfo.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_bInfo.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_bInfo.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			_panel.addChild(_bInfo);
			
			_bClose.addChild(_close);
			_bClose.x = 765; _bClose.y = 5;
			_bClose.addEventListener(MouseEvent.CLICK, onMouseClickClose);
			_bClose.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_bClose.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_bClose.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_bClose.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			_panel.addChild(_bClose);
			
			
			this.addChild(_panel);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_panel.y == 250) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			else _panel.y += 50;
		}
		
		private function onMouseClickLanguage(e:MouseEvent):void 
		{
			if (Resource.Language == "eng") Resource.Language = "rus";
			else Resource.Language = "eng";
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_RESET" }, true));
		}
		
		private function onMouseClickSound(e:MouseEvent):void 
		{
			if (Resource.Sound) {
				Resource.Sound = false;
				_bSound.removeChild(_soundOn)
				_bSound.addChild(_soundOff);
			}else {
				Resource.Sound = true;
				_bSound.removeChild(_soundOff)
				_bSound.addChild(_soundOn);
			}
		}
		
		private function onMouseClickMusic(e:MouseEvent):void 
		{
			if (Resource.Music) {
				Resource.Music = false;
				_bMusic.removeChild(_musicOn)
				_bMusic.addChild(_musicOff);
			}else {
				Resource.Music = true;
				_bMusic.removeChild(_musicOff)
				_bMusic.addChild(_musicOn);
			}
		}
		
		private function onMouseClickClose(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_CLOSE" }, true));
		}
		
		private function onMouseUpButton(e:MouseEvent):void 
		{
			(e.target as Sprite).scaleX += 0.01; (e.target as Sprite).scaleY += 0.01;
			(e.target as Sprite).x -= 1; (e.target as Sprite).y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			(e.target as Sprite).scaleX -= 0.01; (e.target as Sprite).scaleY -= 0.01;
			(e.target as Sprite).x += 1; (e.target as Sprite).y += 1;
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
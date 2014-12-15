package MortalKombatQuest.fighters 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.events.NavigationEvent;
	import MortalKombatQuest.kernel.Atlas;
	
	public class FighterIcon extends Sprite
	{
		private var _iconFighter:Sprite;
		private var _name:String;
		private var _icon:Bitmap;
		private var _close:Boolean;
		
		public function FighterIcon(x:int, y:int, name:String, icon:BitmapData, close:Boolean = true) 
		{
			_name = name;
			_close = close;
			_icon = new Bitmap(icon);
			this.x = x; this.y = y;
			this.graphics.lineStyle(1, 0x000000, 1);
			this.graphics.beginFill(0x808080, 1);
			this.graphics.drawRect(0, 0, 51, 62);
			this.graphics.endFill();
			
			_iconFighter = new Sprite();
			_iconFighter.addChild(new Bitmap(_icon.bitmapData));
			_iconFighter.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_iconFighter.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_iconFighter.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_iconFighter.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_iconFighter.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			_iconFighter.x = 2; _iconFighter.y = 2;
			this.addChild(_iconFighter);
			
			if (_close) {
				var closeIcon:Bitmap = new Bitmap(Atlas.AtlasGetBitmap(Resource.SelectFightersIcon, 350, 800, 48, 59, true, 0x000000000000, 0, 686, 48, 59, 0, 0).bitmapData);
				closeIcon.x = 2; closeIcon.y = 2;
				this.addChild(closeIcon);
			}
		}
		
		
		private function onMouseClickButton(e:MouseEvent):void 
		{
			Resource.FIGHTER_ICON = new Bitmap(_icon.bitmapData);	// сохраняем в ресурсах выбранную иконку игрока.
			Resource.FIGHTER_CLOSE = _close;
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: _name }, true));
		}
		
		private function onMouseUpButton(e:MouseEvent):void 
		{
			_iconFighter.scaleX += 0.01; _iconFighter.scaleY += 0.01;
			_iconFighter.x -= 1; _iconFighter.y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			_iconFighter.scaleX -= 0.01; _iconFighter.scaleY -= 0.01;
			_iconFighter.x += 1; _iconFighter.y += 1;
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
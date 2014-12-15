package MortalKombatQuest.buttons 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import MortalKombatQuest.text.Label;
	
	public class Button extends Sprite 
	{
		private var _button:Sprite = new Sprite();
		private var _xPos:int = 0;
		private var _yPos:int = 0;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _colorBorder:int = 0x000000;
		private var _colorBackground:int = 0x000000;
		private var _colorText:int = 0xFFFFFF;
		private var _sizeText:int = 0;
		private var _text:String;
		private var _indent:int;
		
		public function Button(xPos:int, yPos:int, bWidth:int, bHeight:int, colorBorder:int, colorBackground:int, colorText:int, sizeText:int, text:String, indent:int) 
		{
			this.x = xPos; this.y = yPos;
			_width = bWidth; _height = bHeight;
			_colorBorder = colorBorder; 
			_colorBackground = colorBackground;
			_colorText = colorText;
			_sizeText = sizeText; _text = text;
			_indent = indent;
			
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.graphics.lineStyle(1, _colorBorder, 0.5);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			
			_button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			_button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			_button.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			
			_button.graphics.lineStyle(1, _colorBorder, 0.5);
			_button.graphics.beginFill(_colorBackground, 0.5);
			_button.graphics.drawRect(5, 5, _width - 10, _height - 10);
			_button.graphics.endFill();
			
			_button.addChild(new Label(5 + _indent, 5, _width - 10, _height - 10, "arial", _sizeText, _colorText, _text, false));
			this.addChild(_button);
		}
		
		private function onMouseUpButton(e:MouseEvent):void 
		{
			_button.scaleX += 0.01; _button.scaleY += 0.01;
			_button.x -= 1; _button.y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			_button.scaleX -= 0.01; _button.scaleY -= 0.01;
			_button.x += 1; _button.y += 1;
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
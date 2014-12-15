package MortalKombatQuest.animation 
{
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import MortalKombatQuest.resource.Resource;
	
	public class FighterWin extends MovieClip 
	{
		// полная картинка
		private var _imageBD:BitmapData;
		// размер выбраной картинки
		private var _canvasBD:BitmapData;
		private var _image:Bitmap;
		private var _loaderImage:Bitmap; 
		
		private var _rect:Rectangle;
		private var _pt:Point;
		
		private var _countFPS:int = 0;
		private var _countFrames:int = 0;
		private var _startPointX:int = 0;
		private var _startPointY:int = 0;
		private var _moving:int = 0;
		
		public function FighterWin(x:int, y:int, startPointX:int, startPointY:int,  fullWidth:int, fullHeight:int, frameWidth:int, frameHeight:int, atlas:Bitmap, countFrames:int, moving:int) 
		{
			_imageBD = new BitmapData(fullWidth, fullHeight, true, 0x000000000000);
			_canvasBD = new BitmapData(frameWidth, frameHeight, true, 0x000000000000);
			_rect = new Rectangle(startPointX, startPointY, fullWidth, fullHeight); //исходный размер
			_pt  = new Point(0, 0); // начальная точка
			_countFrames = countFrames;	// количество кадров в атласе
			_startPointX = startPointX;
			_startPointY = startPointY;
			_moving = moving;
			
			_image = new Bitmap(atlas.bitmapData);
			_imageBD.draw(_image); // загрузка атласа
			
			super()
			this.x = x; this.y = y;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_rect.x = _startPointX;
			_canvasBD.copyPixels(_imageBD, _rect, _pt);
			_loaderImage = new Bitmap(_canvasBD);
			_loaderImage.scaleX += 1;
			_loaderImage.scaleY += 1;
			_loaderImage.smoothing = true;
			this.addChild(_loaderImage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_countFPS += 30;
			if (_countFPS == 90) {
				_rect.x += _moving;
				
				if (_rect.x > (_moving * _countFrames)) {
					this.stop();
				}
				
				_canvasBD.copyPixels(_imageBD, _rect, _pt);
				_loaderImage = new Bitmap(_canvasBD);
				_loaderImage.scaleX += 1;
				_loaderImage.scaleY += 1;
				_countFPS = 0;
			}
		}
	}

}
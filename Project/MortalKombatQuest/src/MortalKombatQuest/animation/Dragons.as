package MortalKombatQuest.animation 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class Dragons extends MovieClip 
	{
		// полная картинка
		private var _imageBD:BitmapData = new BitmapData(1600, 124, true, 0x000000000000);
		// размер выбраной картинки
		private var _canvasBD:BitmapData = new BitmapData(80, 62, true, 0x000000000000);
		private var _image:Bitmap;
		private var _loaderImage:Bitmap; 
		
		private var _rect:Rectangle = new Rectangle(0, 0, 1600, 124); //исходный размер
		private var _pt:Point = new Point(0, 0); // начальная точка 
		private var _posY:int;
		
		[Embed(source = '../media/textures/dragons.png')]
		public var LoaderImage:Class; 
		
		public function Dragons(_x:int, _y:int, posY:int) 
		{
			super();
			this.x = _x; this.y = _y;
			_posY = posY;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_image = new LoaderImage();
			_imageBD.draw(_image); // загрузка картинки
			_rect.x = 0;
			_rect.y = _posY;
			_canvasBD.copyPixels(_imageBD, _rect, _pt);
			_loaderImage = new Bitmap(_canvasBD);
			this.addChild(_loaderImage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_rect.x += 80;
			if (_rect.x > 1600) {
				_rect.x = 0;
				//this.stop();
				//removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//this.parent.removeChild(this);	// удаляет сам себя
			}
			_canvasBD.copyPixels(_imageBD, _rect, _pt);
			_loaderImage = new Bitmap(_canvasBD);
		}
		
	}

}
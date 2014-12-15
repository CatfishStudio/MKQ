package MortalKombatQuest.units 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.kernel.Atlas;
	
	public class Unit extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип ячейки
		public var unitType:String = "HIT_0";			// тип удара			
		
		public var flagRemove:Boolean = false;
		public var posColumnI:int = 0;
		public var posRowJ:int = 0;
		public var posX:int = 0;
		public var posY:int = 0;
		
		private var _hitImage:Bitmap;
		
		public function Unit() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function HitShow():void
		{
			if (unitType == "HIT_0") {
				this.visible = false;
			}
			if (unitType == "HIT_1") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 0, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_2") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 80, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_3") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 160, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_4") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 240, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_5") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 320, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_6") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 400, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_7") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 480, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
		}
		
		public function HitUpdate():void
		{
			this.removeChild(_hitImage);
			if (unitType == "HIT_0") {
				this.visible = false;
			}
			if (unitType == "HIT_1") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 0, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_2") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 80, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_3") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 160, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_4") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 240, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_5") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 320, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_6") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 400, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
			if (unitType == "HIT_7") {
				_hitImage = new Bitmap(Atlas.AtlasGetBitmap(Resource.HitsAtlas, 560, 80, 80, 80, true, 0x000000000000, 480, 0, 80, 80, 0, 0).bitmapData);
				this.addChild(_hitImage);
			}
		}
	}

}
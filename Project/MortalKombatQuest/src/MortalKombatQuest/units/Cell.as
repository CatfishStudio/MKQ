package MortalKombatQuest.units 
{
	import flash.display.Shape;
	import flash.events.Event;
	
	import MortalKombatQuest.resource.Resource;
	
	public class Cell extends Shape 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";				// тип ячейки
		
		public function Cell() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (cellType == "CELL_TYPE_EMPTY") this.visible = false;
			if (cellType == "CELL_TYPE_CLEAR") {
				this.graphics.lineStyle(5, 0x000000, 1);
				this.graphics.beginFill(0x000000, 1);
				this.graphics.drawRect(0, 0, Resource.CELL_WIDTH, Resource.CELL_HEIGHT);
				this.graphics.endFill();
				this.alpha = 0.4;
			}
		}
		
	}

}
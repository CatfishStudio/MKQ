package MortalKombatQuest.kernel 
{
	import MortalKombatQuest.level.Level;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.units.Cell;
	import MortalKombatQuest.units.Unit;
	import MortalKombatQuest.animation.Flash;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Mechanics 
	{
		/* Генератор случайный число */
		public static function RandomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			return index;
		}
		
		/* Создание 2D массива тип Array */
		public static function CreateCellArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:Cell = new Cell();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		public static function CreateUnitArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:Unit = new Unit();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		/* Создание 2D массива тип Vector */
		public static function CreateCellVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<Cell>>
		{
			var _matrixCell:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Cell> = new Vector.<Cell>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Cell());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		public static function CreateUnitVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<Unit>>
		{
			var _matrixCell:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Unit> = new Vector.<Unit>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Unit());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		/* Проверка строка (3-и и более в ряд) */
		public static function CheckRow(row:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем в строке (по столбцам) */
			for (var i:int = 0; i < Resource.COLUMNS; i++) {
				if (i < Resource.COLUMNS - 2) {
					if ((Resource.MatrixUnit[i][row] as Unit).unitType != "HIT_0") {
						
					/* Группа из 3-х объектов */
					if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 1][row].unitType && Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 2][row].unitType) {
						/*Отмечаем кристалы для удаления */
						resultCheck = true;
						(Resource.MatrixUnit[i][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+1][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+2][row] as Unit).flagRemove = true;
						//(Resource.MatrixUnit[i][row] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[i+1][row] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[i+2][row] as Unit).alpha = 0.2;
						
						/* Группа из 4-х кристалов */
						if (i < Resource.COLUMNS - 3) {
							if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 3][row].unitType) {
								(Resource.MatrixUnit[i + 3][row] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[i+3][row] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (i < Resource.COLUMNS - 4) {
									if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 4][row].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[i + 4][row] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[i+4][row] as Unit).alpha = 0.2;
								
									}
								}
							}
						}
					}
					}
				}else break;
			}
			return resultCheck;
		}
		
		/* Проверка колонки (3-и и более в ряд) */
		public static function CheckColumn(column:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем  в столбце (по строкам) */
			for (var j:int = 0; j < Resource.ROWS; j++) {
				if (j < Resource.ROWS - 2) {
					if((Resource.MatrixUnit[column][j] as Unit).unitType != "HIT_0"){
					/* Группа из 3-х объектов */
					if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+1].unitType && Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+2].unitType) {
						/*Отмечаем кристалы для удаления */
						resultCheck = true;
						(Resource.MatrixUnit[column][j] as Unit).flagRemove = true;
						(Resource.MatrixUnit[column][j+1] as Unit).flagRemove = true;
						(Resource.MatrixUnit[column][j+2] as Unit).flagRemove = true;
						//(Resource.MatrixUnit[column][j] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[column][j+1] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[column][j+2] as Unit).alpha = 0.2;
						
						/* Группа из 4-х кристалов */
						if (j < Resource.ROWS - 3) {
							if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+3].unitType) {
								(Resource.MatrixUnit[column][j+3] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[column][j+3] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (j < Resource.ROWS - 4) {	// < 6
									if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+4].unitType) {
										(Resource.MatrixUnit[column][j+4] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[column][j+4] as Unit).alpha = 0.2;
									}
								}
							}
						}
					}
					}
				}else break;
			}
			
			return resultCheck;
		}
		
		/* Общая проверка колонок и строк (3-и и более в ряд) */
		public static function CheckField():Boolean
		{
			var resultCheck:Boolean = false;
			/* i - столбец; j - строка */
			for (var i:int = 0; i < Resource.COLUMNS; i++) {
				if (CheckColumn(i) == true) resultCheck = true;
				for (var j:int = 0; j < Resource.ROWS; j++) {
					if (CheckRow(j) == true) resultCheck = true;
				}
			}
			return resultCheck;
		}
		
		/* Обмен местами в массиве выбранных пользователем  объектов */
		public static function ExchangeCrystals(columnCrystal1:int, rowCrystal1:int, columnCrystal2:int, rowCrystal2:int):void
		{
			var crystalMove:Unit = new Unit();
			crystalMove = Resource.MatrixUnit[columnCrystal1][rowCrystal1];
			Resource.MatrixUnit[columnCrystal1][rowCrystal1] = Resource.MatrixUnit[columnCrystal2][rowCrystal2];
			Resource.MatrixUnit[columnCrystal2][rowCrystal2] = crystalMove;
			
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posColumnI = columnCrystal1;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posRowJ = rowCrystal1;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posColumnI = columnCrystal2;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posRowJ = rowCrystal2;
		}
		
		/* Удаление на поле всех отмеченных ячеек (Удаление, сортировка, добавление */
		public static function SimplyRemoveNoEmpty(level:MovieClip):void
		{
			
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>(); // массив юнитов сохраняемых на поле
				
				/* Удаление помеченных кристалов */
				for (var j1:int = Resource.ROWS - 1; j1 >= 0; j1--) {
					
					/* Удаление */
					if ((Resource.MatrixUnit[i][j1] as Unit).flagRemove == true && (Resource.MatrixUnit[i][j1] as Unit).unitType != "HIT_0") {	// удаление 
						/* анимация звезд */
						level.addChild(new Flash((Resource.MatrixUnit[i][j1] as Unit).x - 50, (Resource.MatrixUnit[i][j1] as Unit).y - 30));
						/* Удаление объект с поля */
						level.removeChild(Resource.MatrixUnit[i][j1]);
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из главного массива
					}else {
						/* Сохраняем удар в промежуточный массив */
						matrixUnits.push((Resource.MatrixUnit[i][j1] as Unit));
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из массива
						
					}
				}
				
					
				/* Возвращаем оставщиеся кристалы в массив игрового поля и добавляем новые */
				var indexJ:int = 0;
				for (var j2:int = Resource.ROWS - 1; j2 >= 0; j2--) {	// 5-4-3-2-1-0
					
					if (matrixUnits.length > j2) { // ПЕРЕНОС УДАРОВ ----------------------------------
						/* Перемещение кристала в массиве */
						(matrixUnits[j2] as Unit).posRowJ = indexJ;		// изменяем индекс положения в строке
						(matrixUnits[j2] as Unit).posY = 70 + (80 * indexJ); // перерасчет позиции
						Resource.MatrixUnit[i].push(matrixUnits[j2]); 	// Переносим (добавляем) в массив
						
					}else { // ДОБАВЛЕНИЕ НОВЫХ УДАРОВ -------------------------------------------------
						
						/* Добавление новых объектов в массив и на поле */
						var newUnit:Unit = new Unit();
						newUnit.x = 165 + (80 * i);
						newUnit.y = 0 + (80 * 0);	// начальная позиция для нового объекта
						newUnit.posColumnI = i;
						newUnit.posRowJ = indexJ;
						newUnit.posX = newUnit.x;
						newUnit.posY = 70 + (80 * indexJ);
						
						var type:int = RandomIndex();
						if (type >= 0 && type < 2) newUnit.unitType = "HIT_1";
						if (type >= 2 && type < 3) newUnit.unitType = "HIT_2";
						if (type >= 3 && type < 5) newUnit.unitType = "HIT_3";
						if (type >= 5 && type < 6) newUnit.unitType = "HIT_4";
						if (type >= 6 && type < 8) newUnit.unitType = "HIT_5";
						if (type >= 8 && type < 9) newUnit.unitType = "HIT_6";
						if (type >= 9 && type <= 10) newUnit.unitType = "HIT_7";
						
						/*события*/
						newUnit.addEventListener(MouseEvent.CLICK, (level as Level).onMouseUnitClick);
						newUnit.addEventListener(MouseEvent.MOUSE_DOWN, (level as Level).onMouseUnitDown);
						newUnit.addEventListener(MouseEvent.MOUSE_UP, (level as Level).onMouseUnitUp);
						newUnit.addEventListener(MouseEvent.MOUSE_MOVE, (level as Level).onMouseUnitMove);
						newUnit.addEventListener(MouseEvent.MOUSE_OUT, (level as Level).onMouseUnitOut);
						newUnit.addEventListener(MouseEvent.MOUSE_OVER, (level as Level).onMouseUnitOver);
						newUnit.cellType = "CELL_TYPE_CLEAR";
						newUnit.HitShow();
						
						Resource.MatrixUnit[i].push(newUnit);
						(level as Level).addChild(Resource.MatrixUnit[i][indexJ]);
						
					}
					
					indexJ++;
				}
			}
			
			/* Вызываем функцию спуска */
			(level as Level).addEventListener(Event.ENTER_FRAME, (level as Level).AnimationMoveDown);
			(level as Level).play();
			
		}
		
		
		/* Удаление на поле всех отмеченных ячеек (Удаление, сортировка, добавление */
		public static function SimplyRemove(level:MovieClip):void
		{
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>(); // массив юнитов сохраняемых на поле
				var matrixEmpty:Vector.<Unit> = new Vector.<Unit>(); // массив пустот сохраняемых на поле
				var matrixAll:Vector.<Unit> = new Vector.<Unit>(); // массив всех эдементов игрового поля (после слияния и добавления)
				
				/* Удаление помеченных кристалов ===================================================================================*/
				for (var j1:int = Resource.ROWS - 1; j1 >= 0; j1--) {
					
					/* Удаление */
					if ((Resource.MatrixUnit[i][j1] as Unit).flagRemove == true && (Resource.MatrixUnit[i][j1] as Unit).unitType != "HIT_0") {	// удаление 
						/* анимация вспышки */
						level.addChild(new Flash((Resource.MatrixUnit[i][j1] as Unit).x - 50, (Resource.MatrixUnit[i][j1] as Unit).y - 30));
						/* Удаление объект с поля */
						level.removeChild(Resource.MatrixUnit[i][j1]);
						/* Уменьшение жизни и увеличение маны */
						(level as Level).ReductionXP((Resource.MatrixUnit[i][j1] as Unit).unitType); // жизнь
						(level as Level).IncreaseMana((Resource.MatrixUnit[i][j1] as Unit).unitType); // мана
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из главного массива
						
					}else {
						/* Проверка пустота или нет */
						if ((Resource.MatrixUnit[i][j1] as Unit).unitType == "HIT_0") { // HIT_0 - пустота
							
							/* переносим пустоту в промежуточный массив */
							matrixEmpty.push((Resource.MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							Resource.MatrixUnit[i].pop(); // Удаляем из массива
								
						}else { // HIT_1, HIT_2, HIT_3, HIT_4, HIT_5, HIT_6, HIT_7 - не пустота
							
							/* Сохраняем удар в промежуточный массив */
							matrixUnits.push((Resource.MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							Resource.MatrixUnit[i].pop(); // Удаляем из массива
							
						}
					}
				}
				/*================================================================================================================*/
				
				
				/* Слияние двух массивов и добавление новых объектов =============================================================*/
				var totalRows:int = matrixUnits.length + matrixEmpty.length;
				if (totalRows == Resource.ROWS) { // слияние без добавлений ----------
					for (var iTotal:int = Resource.ROWS - 1; iTotal >= 0; iTotal--) {
						if (matrixEmpty.length > 0){ // пустоты
							if ((matrixEmpty[0] as Unit).posRowJ == iTotal) {
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}
						}
						if (matrixUnits.length > 0) { // объекты
							if ((matrixUnits[0] as Unit).posRowJ == iTotal) {
								matrixAll.push(matrixUnits[0]); // переносим
								matrixUnits.shift(); // удаляем
							}
						}
					}
				}else { // слияние с добавлением -------------------------------------
					for (var iAdd:int = Resource.ROWS - 1; iAdd >= 0; iAdd--) {
						if (matrixEmpty.length > 0){ // пустоты
							if ((matrixEmpty[0] as Unit).posRowJ == iAdd) {
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}else { // в пустоте не найдено
								if (matrixUnits.length > 0) { // объекты
									if ((matrixUnits[0] as Unit).posRowJ == iAdd) {
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}else { // переносим объект вниз
										(matrixUnits[0] as Unit).posRowJ = iAdd;		// изменяем индекс положения в строке
										(matrixUnits[0] as Unit).posY = 70 + (80 * iAdd); // перерасчет позиции
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}
								}else { // создаём новый объект
							
									/* Добавление новых объектов в массив и на поле */
									var newUnit1:Unit = new Unit();
									newUnit1.x = 165 + (80 * i);
									newUnit1.y = 0 + (80 * 0);	// начальная позиция для нового объекта
									newUnit1.posColumnI = i;
									newUnit1.posRowJ = iAdd;
									newUnit1.posX = newUnit1.x;
									newUnit1.posY = 70 + (80 * iAdd);
							
									var type1:int = RandomIndex();
									if (type1 >= 0 && type1 < 2) newUnit1.unitType = "HIT_1";
									if (type1 >= 2 && type1 < 3) newUnit1.unitType = "HIT_2";
									if (type1 >= 3 && type1 < 5) newUnit1.unitType = "HIT_3";
									if (type1 >= 5 && type1 < 6) newUnit1.unitType = "HIT_4";
									if (type1 >= 6 && type1 < 8) newUnit1.unitType = "HIT_5";
									if (type1 >= 8 && type1 < 9) newUnit1.unitType = "HIT_6";
									if (type1 >= 9 && type1 <= 10) newUnit1.unitType = "HIT_7";
						
									/*события*/
									newUnit1.addEventListener(MouseEvent.CLICK, (level as Level).onMouseUnitClick);
									newUnit1.addEventListener(MouseEvent.MOUSE_DOWN, (level as Level).onMouseUnitDown);
									newUnit1.addEventListener(MouseEvent.MOUSE_UP, (level as Level).onMouseUnitUp);
									newUnit1.addEventListener(MouseEvent.MOUSE_MOVE, (level as Level).onMouseUnitMove);
									newUnit1.addEventListener(MouseEvent.MOUSE_OUT, (level as Level).onMouseUnitOut);
									newUnit1.addEventListener(MouseEvent.MOUSE_OVER, (level as Level).onMouseUnitOver);
									newUnit1.cellType = "CELL_TYPE_CLEAR";
									newUnit1.HitShow();
						
									matrixAll.push(newUnit1);
									(level as Level).addChild(newUnit1)
								}
							}
						}else { // пустоты закончились
								if (matrixUnits.length > 0) { // объекты
									if ((matrixUnits[0] as Unit).posRowJ == iAdd) {
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}else { // переносим объект вниз
										(matrixUnits[0] as Unit).posRowJ = iAdd;		// изменяем индекс положения в строке
										(matrixUnits[0] as Unit).posY = 70 + (80 * iAdd); // перерасчет позиции
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}
								}else { // создаём новый объект
							
									/* Добавление новых объектов в массив и на поле */
									var newUnit2:Unit = new Unit();
									newUnit2.x = 165 + (80 * i);
									newUnit2.y = 0 + (80 * 0);	// начальная позиция для нового объекта
									newUnit2.posColumnI = i;
									newUnit2.posRowJ = iAdd;
									newUnit2.posX = newUnit2.x;
									newUnit2.posY = 70 + (80 * iAdd);
							
									var type2:int = RandomIndex();
									if (type2 >= 0 && type2 < 2) newUnit2.unitType = "HIT_1";
									if (type2 >= 2 && type2 < 3) newUnit2.unitType = "HIT_2";
									if (type2 >= 3 && type2 < 5) newUnit2.unitType = "HIT_3";
									if (type2 >= 5 && type2 < 6) newUnit2.unitType = "HIT_4";
									if (type2 >= 6 && type2 < 8) newUnit2.unitType = "HIT_5";
									if (type2 >= 8 && type2 < 9) newUnit2.unitType = "HIT_6";
									if (type2 >= 9 && type2 <= 10) newUnit2.unitType = "HIT_7";
						
									/*события*/
									newUnit2.addEventListener(MouseEvent.CLICK, (level as Level).onMouseUnitClick);
									newUnit2.addEventListener(MouseEvent.MOUSE_DOWN, (level as Level).onMouseUnitDown);
									newUnit2.addEventListener(MouseEvent.MOUSE_UP, (level as Level).onMouseUnitUp);
									newUnit2.addEventListener(MouseEvent.MOUSE_MOVE, (level as Level).onMouseUnitMove);
									newUnit2.addEventListener(MouseEvent.MOUSE_OUT, (level as Level).onMouseUnitOut);
									newUnit2.addEventListener(MouseEvent.MOUSE_OVER, (level as Level).onMouseUnitOver);
									newUnit2.cellType = "CELL_TYPE_CLEAR";
									newUnit2.HitShow();
						
									matrixAll.push(newUnit2);
									(level as Level).addChild(newUnit2)
								}
						}
						
					}
				}
				/*================================================================================================================*/
				
				
				/* Возвращаем объекты обратно в главный массив ==================================================================*/
				
				for (var j2:int = Resource.ROWS - 1; j2 >= 0; j2--) {	// 5-4-3-2-1-0
					Resource.MatrixUnit[i].push(matrixAll[j2]); 	// Переносим (добавляем) в массив
				}
				
			}
			
			/* Вызываем функцию спуска */
			(level as Level).addEventListener(Event.ENTER_FRAME, (level as Level).AnimationMoveDown);
			(level as Level).play();
			
		}
	
		
		/* Определение возможности хода и перестановка в случае отсутствия такой возможности 
		 * (связан с Level.AnimationMoveDown) */
		public static function CheckCombinations():Boolean
		{
			/*	   0  1  2  3  4  5
			 * 	0:[0][0][0][0][1][0]
				1:[0][0][1][1][0][1]
				2:[0][0][0][0][1][0]
				3:[0][0][0][0][0][0]
				4:[0][0][0][0][0][0]
				5:[0][0][0][0][0][0]
			 * */
			// Проверка строк и колонок
			for (var iCol:int = 0; iCol < Resource.COLUMNS; iCol++) {
				for (var iRow:int = 0; iRow < Resource.ROWS; iRow++) {
					
					if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0") {
							
							// ПРОВЕРКА СТРОКИ ---------------------------------------------------------------------------------------------
							if (iRow == 0) {
								//[1][1][X][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) return true;
								//[1][X][1][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) return true;
								//[0][1][X][1]
								//[0][0][1][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) return true;
								//[0][1][1][X]
								//[0][0][0][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) return true;
								//[0][X][1][1]
								//[0][1][0][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) return true;
							}else {
								//[1][1][X][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) return true;
								//[1][X][1][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) return true;
								//[0][1][1][X]
								//[0][0][0][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) return true;
								//[0][0][0][1]
								//[0][1][1][X]
								if((iCol + 2) < Resource.COLUMNS && (iRow - 1) >= 0)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow - 1] as Unit).unitType) return true;
								//[0][X][1][1]
								//[0][1][0][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) return true;
								//[0][1][0][0]
								//[0][X][1][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) return true;
								//[0][0][1][0]
								//[0][1][X][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow - 1) >= 0)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow - 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) return true;
								//[0][1][X][1]
								//[0][0][1][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) return true;
							}
							
							// ПРОВЕРКА КОЛОНКИ -----------------------------------------------------------------------------------------
							if (iCol == 0) {
								//[1]
								//[1]
								//[X]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) return true;
								//[1]
								//[X]
								//[1]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) return true;
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) return true;
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
							}else {
								//[1]
								//[1]
								//[X]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) return true;
								//[1]
								//[X]
								//[1]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) return true;
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
								//[0][1]
								//[1][X]
								//[0][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol - 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) return true;
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
								//[0][1]
								//[0][1]
								//[1][X]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol - 1][iRow + 2] as Unit).unitType) return true;
								//[1][X]
								//[0][1]
								//[0][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) return true;
							}
					}
				}
			}
			
			// Если при проверке не было найдено возможных групп
			// выполняем обновление объектов игрового поля
			var indexFileXML:int = RandomIndex();
			if (indexFileXML >= 0 && indexFileXML < 1) indexFileXML = 0;
			if (indexFileXML >= 1 && indexFileXML < 3) indexFileXML = 1;
			if (indexFileXML >= 3 && indexFileXML < 5) indexFileXML = 2;
			if (indexFileXML >= 5 && indexFileXML < 7) indexFileXML = 3;
			if (indexFileXML >= 7 && indexFileXML <= 10) indexFileXML = 4;
			
			var indexCell:int = 0;
			for (var iC:int = 0; iC < Resource.COLUMNS; iC++) {
				for (var iR:int = 0; iR < Resource.ROWS; iR++) {
					if ((Resource.MatrixUnit[iC][iR] as Unit).unitType != "HIT_0") {
						(Resource.MatrixUnit[iC][iR] as Unit).y = 0 + (80 * 0);	// начальная позиция спуска
						(Resource.MatrixUnit[iC][iR] as Unit).unitType = Resource.FileXMLCombinations[indexFileXML].cell[indexCell].cellObject;
						(Resource.MatrixUnit[iC][iR] as Unit).HitUpdate();
					}
					indexCell++;
				}
			}
			
			
			return false; // возможных комбинаций не было обнаружено (поле было обновлено и необходим спуск обновленных объектов level.AnimationMoveDown)
		}
		
		
		/* Определение силы удара по его названию */
		public static function GetPowerHit(nameHit:String):int
		{
			if (nameHit == "HIT_1") return Resource.DEFAULT_HIT_1;
			if (nameHit == "HIT_2") return Resource.DEFAULT_HIT_2;
			if (nameHit == "HIT_3") return Resource.DEFAULT_HIT_3;
			if (nameHit == "HIT_4") return RandomIndex();
			if (nameHit == "HIT_5") return Resource.DEFAULT_HIT_5;
			if (nameHit == "HIT_6") return Resource.DEFAULT_HIT_6;
			if (nameHit == "HIT_7") return Resource.DEFAULT_HIT_7;
			return 0;
		}
		
		/* Ход искусственного интеллекта */
		public static function HitAI(level:MovieClip):void
		{
			var movingObject:String;
			var powerHit:int = 0;
			var unit1:Unit;
			var unit2:Unit;
			
			// Проверка строк и колонок
			for (var iCol:int = 0; iCol < Resource.COLUMNS; iCol++) {
				for (var iRow:int = 0; iRow < Resource.ROWS; iRow++) {
					
					if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0") {
							
							// ПРОВЕРКА СТРОКИ ---------------------------------------------------------------------------------------------
							if (iRow == 0) {
								//[1][1][X][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 2][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 3][iRow] as Unit);
											movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][X][1][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][1][X][1]
								//[0][0][1][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit);
											movingObject = "Down:J+1";	// Обмен местами по вертикале с объектом стоящим снизу
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][1][1][X]
								//[0][0][0][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 2][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit);
											movingObject = "Down:J+1";	// Обмен местами по вертикале с объектом стоящим снизу
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][X][1][1]
								//[0][1][0][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Down:J+1";	// Обмен местами по вертикале с объектом стоящим снизу
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType);
										}
									}
							}else {
								//[1][1][X][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 2][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 3][iRow] as Unit);
											movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][X][1][1]
								if((iCol + 3) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 3][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][1][1][X]
								//[0][0][0][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 2][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit);
											movingObject = "Down:J+1";	// Обмен местами по вертикале с объектом стоящим снизу
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][0][0][1]
								//[0][1][1][X]
								if((iCol + 2) < Resource.COLUMNS && (iRow - 1) >= 0)
									if ((Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow - 1] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 2][iRow - 1] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 2][iRow] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][X][1][1]
								//[0][1][0][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType);
										}
									}
								//[0][1][0][0]
								//[0][X][1][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][0][1][0]
								//[0][1][X][1]
								if((iCol + 2) < Resource.COLUMNS && (iRow - 1) >= 0)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow - 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 1][iRow - 1] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][1][X][1]
								//[0][0][1][0]
								if((iCol + 2) < Resource.COLUMNS && (iRow + 1) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 2][iRow] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
							}
							
							// ПРОВЕРКА КОЛОНКИ -----------------------------------------------------------------------------------------
							if (iCol == 0) {
								//[1]
								//[1]
								//[X]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 2] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 3] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1]
								//[X]
								//[1]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 2] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType);
										}
									}
							}else {
								//[1]
								//[1]
								//[X]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 2] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 3] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1]
								//[X]
								//[1]
								//[1]
								if((iRow + 3) < Resource.ROWS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 3] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Down:J+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 1] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[0][1]
								//[1][X]
								//[0][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol - 1][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol - 1][iRow + 1] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 1] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow + 2] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow + 2] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol + 1) < Resource.COLUMNS)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol + 1][iRow] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol + 1][iRow] as Unit).unitType);
										}
									}
								//[0][1]
								//[0][1]
								//[1][X]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol - 1][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol - 1][iRow + 2] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow + 2] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol][iRow] as Unit).unitType);
										}
									}
								//[1][X]
								//[0][1]
								//[0][1]
								//[0][0]
								if((iRow + 2) < Resource.ROWS && (iCol - 1) >= 0)
									if ((Resource.MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 1] as Unit).unitType && (Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType == (Resource.MatrixUnit[iCol][iRow + 2] as Unit).unitType) {
										if (GetPowerHit((Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType) > powerHit) {
											unit1 = (Resource.MatrixUnit[iCol - 1][iRow] as Unit);
											unit2 = (Resource.MatrixUnit[iCol][iRow] as Unit);
											movingObject = "Right:I+1";
											powerHit = GetPowerHit((Resource.MatrixUnit[iCol - 1][iRow] as Unit).unitType);
										}
									}
							}
					}
				}
			}
			// Вызываем функцию выполняющею ход искуственного интеллекта
			(level as Level).onUnitMoveAI(unit1.posColumnI, unit1.posRowJ, unit2.posColumnI, unit2.posRowJ, movingObject);
		}
		
		
		
	}
}
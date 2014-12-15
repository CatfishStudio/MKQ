package MortalKombatQuest.resource 
{
	import flash.display.Bitmap;
	import MortalKombatQuest.units.Cell;
	import MortalKombatQuest.units.Unit;
	
	public class Resource 
	{
		
		/* Костанты */
		public static const COLUMNS:int = 6;
		public static const ROWS:int = 6;
		public static const CELL_WIDTH:int = 80;
		public static const CELL_HEIGHT:int = 80;
		
		/* Характеристики ударов */
		public static const DEFAULT_HIT_1:int = 2;			// верхний удар ногой
		public static const DEFAULT_HIT_2:int = 1;			// нижний удар ногой
		public static const DEFAULT_HIT_3:int = 5;			// удар ногой с разворота
		public static const DEFAULT_HIT_4:int = 0;			// блок
		public static const DEFAULT_HIT_5:int = 1;			// нижний удар рукой
		public static const DEFAULT_HIT_6:int = 2;			// верхний удар рукой
		public static const DEFAULT_HIT_7:int = 7;			// апперкот
		
		/* Харкатеристики по умолчанию */
		public static const DEFAULT_LEVEL:int = 1;			// уровень бойца
		public static const DEFAULT_HIP_POINTS:int = 10;	// очки жизни НР (хп)
		public static const DEFAULT_MANA:int = 50;			// очки магии Mana(мана)
		public static const DEFAULT_POWER:int = 1;			// сила (урон наносимый игроком)
		public static const DEFAULT_DEFENSE:int = 1;		// защита (эффективность блока)
		public static const DEFAULT_SLEIGHT:int = 0;		// ловкость (соотношение промоха врага и ловкости бойца)
		public static const DEFAULT_INTELLECT:int = 1;		// интелект (скорость восстановления маны)
		public static const DEFAULT_LEADERSHIP:int = 1;		// лидерство (количество использований скрилов за раунд)
		public static const DEFAULT_SCORE:int = 0;			// счет очков для повышения уровня
		public static const DEFAULT_POINTS:int = 0;			// очки распределения умения
	
		/* Характеристики выбранного героя */
		public static var FIGHTER_ID:String;				// Идентификатор бойца
		public static var FIGHTER_NAME:String;				// Имя бойца
		public static var FIGHTER_LEVEL:int = 0;			// уровень бойца
		public static var FIGHTER_HIP_POINTS:int = 0;		// очки жизни НР (хп)
		public static var FIGHTER_MANA:int = 0;				// очки магии Mana(мана)
		public static var FIGHTER_POWER:int = 0;			// сила (урон наносимый игроком)
		public static var FIGHTER_DEFENSE:int = 0;			// защита (эффективность блока)
		public static var FIGHTER_SLEIGHT:int = 0;			// ловкость (соотношение промоха врага и ловкости бойца)
		public static var FIGHTER_INTELLECT:int = 0;		// интелект (скорость восстановления маны)
		public static var FIGHTER_LEADERSHIP:int = 0;		// лидерство (количество использований скрилов за раунд)
		public static var FIGHTER_ICON:Bitmap;				// иконка выбранного героя (FighterIcon.as)
		public static var FIGHTER_CLOSE:Boolean;			// флаг открыт или закрыт боец или нет (FighterIcon.as)
		public static var FIGHTER_SCORE:int = 0;			// счет очков для повышения уровня
		public static var FIGHTER_POINTS:int = 0;			// очки распределения умения
		
		/* Характеристики выбранного бота */
		public static var BOT_ID:String;				// Идентификатор бойца
		public static var BOT_NAME:String;				// Имя бойца
		public static var BOT_LEVEL:int = 0;			// уровень бойца
		public static var BOT_HIP_POINTS:int = 0;		// очки жизни НР (хп)
		public static var BOT_MANA:int = 0;				// очки магии Mana(мана)
		public static var BOT_POWER:int = 0;			// сила (урон наносимый игроком)
		public static var BOT_DEFENSE:int = 0;			// защита (эффективность блока)
		public static var BOT_SLEIGHT:int = 0;			// ловкость (соотношение промоха врага и ловкости бойца)
		public static var BOT_INTELLECT:int = 0;		// интелект (скорость восстановления маны)
		public static var BOT_LEADERSHIP:int = 0;		// лидерство (количество использований скрилов за раунд)
		public static var BOT_ICON:Bitmap;				// иконка выбранного героя (FighterIcon.as)
		public static var BOT_CLOSE:Boolean;			// флаг открыт или закрыт боец или нет (FighterIcon.as)
		
		/* Выбранная игра (ТУРНИР / ПвП) */
		public static var SelectGameType:String;			// выбранная в данное время игра (Game.as)
		public static var TournamentWin:int = 0;			// Количество побед в турнире (в данной сессии) (SelectFighters.as)
		public static var TournamentFighters:Array = [];	// Соперники в турнире (боты 12 штук)(SelectFighters.as)
		
		
		/* Настройки игры (Setting.as)*/
		public static var Music:Boolean = true;
		public static var Sound:Boolean = true;
		public static var Language:String = "eng";
		
		/* Текстуры общего назначения (LoadResource.as) */
		public static var SelectFightersBackground:Bitmap;
		public static var SelectFightersIcon:Bitmap;
		public static var TournamentAtlas:Bitmap;
		public static var LevelsAtlas:Bitmap;
		public static var HitsAtlas:Bitmap;
		
		/* Текстуры анимации бойцов (LoadResource.as) */
		public static var KitanaMK3U_Atlas:Bitmap;
		public static var ReptileMK3U_Atlas:Bitmap;
		public static var SonyaMK3U_Atlas:Bitmap;
		public static var JaxMK3U_Atlas:Bitmap;
		public static var NightwolfMK3U_Atlas:Bitmap;
		public static var JadeMK3U_Atlas:Bitmap;
		public static var ScorpionMK3U_Atlas:Bitmap;
		public static var RainMK3U_Atlas:Bitmap;
		public static var KanoMK3U_Atlas:Bitmap;
		public static var MileenaMK3U_Atlas:Bitmap;
		public static var ErmacMK3U_Atlas:Bitmap;
		public static var Subzero1MK3U_Atlas:Bitmap;
		public static var Subzero2MK3U_Atlas:Bitmap;
		public static var NoobsaibotMK3U_Atlas:Bitmap;
		public static var SektorMK3U_Atlas:Bitmap;
		public static var SindelMK3U_Atlas:Bitmap;
		public static var StrykerMK3U_Atlas:Bitmap;
		public static var CyrexMK3U_Atlas:Bitmap;
		public static var KungLaoMK3U_Atlas:Bitmap;
		public static var KabalMK3U_Atlas:Bitmap;
		public static var SheevaMK3U_Atlas:Bitmap;
		public static var ShangTsungMK3U_Atlas:Bitmap;
		public static var LiuKangMK3U_Atlas:Bitmap;
		public static var SmokeMK3U_Atlas:Bitmap;
		public static var MotaroMK3U_Atlas:Bitmap;
		public static var ShaoKahnMK3U_Atlas:Bitmap;
		
		public static var LiuKangMK2_Atlas:Bitmap;
		public static var KungLaoMK2_Atlas:Bitmap;
		public static var JohnnyCageMK2_Atlas:Bitmap;
		public static var ReptileMK2_Atlas:Bitmap;
		public static var SubzeroMK2_Atlas:Bitmap;
		public static var ShangTsungMK2_Atlas:Bitmap;
		public static var KitanaMK2_Atlas:Bitmap;
		public static var JaxMK2_Atlas:Bitmap;
		public static var MileenaMK2_Atlas:Bitmap;
		public static var BarakaMK2_Atlas:Bitmap;
		public static var ScorpionMK2_Atlas:Bitmap;
		public static var RaidenMK2_Atlas:Bitmap;
		public static var KintaroMK2_Atlas:Bitmap;
		
		public static var JohnnyCageMK1_Atlas:Bitmap;
		public static var KanoMK1_Atlas:Bitmap;
		public static var SubzeroMK1_Atlas:Bitmap;
		public static var SonyaMK1_Atlas:Bitmap;
		public static var RaidenMK1_Atlas:Bitmap;
		public static var LiuKangMK1_Atlas:Bitmap;
		public static var ScorpionMK1_Atlas:Bitmap;
		public static var ShangTsungMK1_Atlas:Bitmap;
		public static var GoroMK1_Atlas:Bitmap;
		
		/* Загружаемые XML Файлы (LoadResource.as) (Level.as)*/
		public static var FileXMLCombinations:Vector.<XML> = new Vector.<XML>();
		public static var FilesXML:Vector.<XML> = new Vector.<XML>();
		
		
		/* Игровое поле (Level.as)*/
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Объекты игрового поля */
		public static var MatrixUnit:Vector.<Vector.<Unit>>;
	}

}
package MortalKombatQuest.fighters 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.buttons.Button;
	
	public class Characteristics extends Sprite 
	{
		private var _title:Shape = new Shape();
		private var _bg:Shape = new Shape();
		private var _fighterName:String;
		private var _buttonBuy:Button;
		private var _buttonHP:Button;
		private var _buttonMana:Button;
		private var _buttonPower:Button;
		private var _buttonDefense:Button;
		private var _buttonSleight:Button;
		private var _buttonIntellect:Button;
		private var _buttonLeadership:Button;
		
		public function Characteristics(x:int, y:int, id:String) 
		{
			_title.graphics.lineStyle(1, 0xFFFFFF, 1);
			_title.graphics.beginFill(0x000000, 1);
			_title.graphics.drawRect(20, -20, 160, 30);
			_title.graphics.endFill();
			_title.alpha = 1;
						
			_bg.graphics.lineStyle(1, 0xFFFFFF, 1);
			_bg.graphics.beginFill(0x000000, 1);
			_bg.graphics.drawRect(0, 0, 200, 260);
			_bg.graphics.endFill();
			_bg.alpha = 0.4;
			
			this.x = x; this.y = y;
			this.addChild(_bg);
			this.addChild(_title);
			
			if (id == "KITANA_MK3U") _fighterName = "Kitana";
			if (id == "REPTILE_MK3U") _fighterName = "Reptile";
			if (id == "SONYA_MK3U")  _fighterName = "Sonya";
			if (id == "JAX_MK3U") _fighterName ="Jax";
			if (id == "NIGHTWOLF_MK3U") _fighterName ="Nightwolf";
			if (id == "JADE_MK3U") _fighterName ="Jade";
			if (id == "SCORPION_MK3U")  _fighterName = "Scorpion";
			if (id == "RAIN_MK3U")  _fighterName ="Rain";
			if (id == "KANO_MK3U")  _fighterName ="Kano";
			if (id == "MILEENA_MK3U")  _fighterName ="Mileena";
			if (id == "ERMAC_MK3U")  _fighterName ="Ermac";
			if (id == "SUBZERO_1_MK3U")  _fighterName ="Sub-Zero";
			
			if (id == "SUBZERO_2_MK3U")  _fighterName ="Sub-Zero";
			if (id == "NOOBSAIBOT_MK3U")  _fighterName ="Noob Saibot";
			if (id == "SEKTOR_MK3U")  _fighterName ="Sektor";
			if (id == "SINDEL_MK3U")  _fighterName ="Sindel";
			if (id == "STRYKER_MK3U")  _fighterName ="Stryker";
			if (id == "SYREX_MK3U")  _fighterName ="Syrex";
			if (id == "KUNGLAO_MK3U")  _fighterName ="Kung Lao";
			if (id == "KABAL_MK3U")  _fighterName ="Kabal";
			if (id == "SHEEVA_MK3U")  _fighterName ="Sheeva";
			if (id == "SHANGTSUNG_MK3U")  _fighterName ="Shang Tsung";
			if (id == "LIUKANG_MK3U")  _fighterName ="Liu Kang";
			if (id == "SMOKE_MK3U")  _fighterName ="Smoke";
			
			if (id == "MOTARO_MK3U")  _fighterName ="Motaro";
			if (id == "SHAOKAHN_MK3U")  _fighterName ="Shao Kahn";
			
			if (id == "LIUKANG_MK2")  _fighterName ="Liu Kang";
			if (id == "KUNGLAO_MK2")  _fighterName ="Kung Lao";
			if (id == "JOHNYCAGE_MK2")  _fighterName ="Johnny Cage";
			if (id == "REPTILE_MK2")  _fighterName ="Reptile";
			if (id == "SUBZERO_MK2")  _fighterName ="Sub-Zero";
			if (id == "SHANGTSUNG_MK2")  _fighterName ="Shang Tsung";
			
			if (id == "KITANA_MK2")  _fighterName ="Kitana";
			if (id == "JAX_MK2")  _fighterName ="Jax";
			if (id == "MILEENA_MK2")  _fighterName ="Mileena";
			if (id == "BARAKA_MK2")  _fighterName ="Baraka";
			if (id == "SCORPION_MK2")  _fighterName ="Scorpion";
			if (id == "RAIDEN_MK2")  _fighterName ="Raiden";
			
			if (id == "KINTARO_MK2")  _fighterName ="Kintaro";
			
			if (id == "JOHNYCAGE_MK1")  _fighterName ="Johnny Cage";
			if (id == "KANO_MK1")  _fighterName ="Kano";
			if (id == "SUBZERO_MK1")  _fighterName ="Sub-Zero";
			if (id == "SONYA_MK1")  _fighterName ="Sonya";
			
			if (id == "RAIDEN_MK1")  _fighterName ="Raiden";
			if (id == "LIUKANG_MK1")  _fighterName ="Liu Kang";
			if (id == "SCORPION_MK1")  _fighterName ="Scorpion";
			if (id == "SHANGTSUNG_MK1")  _fighterName ="Shang Tsung";
			
			if (id == "GORO_MK1")  _fighterName ="Goto";
			
			this.addChild(new Label((_bg.width / 4) + (_fighterName.length / 2), -15, 200, 30, "Arial", 16, 0xFFFF00, _fighterName, false));
			
			if (Resource.Language == "eng") {
				_buttonBuy = new Button(30, 20, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonBuy); // кнопка +
				this.addChild(new Label(60, 20, 150, 20, "Arial", 16, 0xFF8000, "Level: " + Resource.DEFAULT_LEVEL.toString(), false));
				this.addChild(new Label(30, 45, 150, 20, "Arial", 16, 0xFF8000, "Score: " + Resource.DEFAULT_SCORE.toString(), false));
				this.addChild(new Label(130, 45, 150, 20, "Arial", 16, 0xFF8000, "Points: " + Resource.DEFAULT_POINTS.toString(), false));
				this.graphics.lineStyle(1, 0xFFFFFF, 1);
				this.graphics.moveTo(5, 65);
				this.graphics.lineTo(190, 65);
				
				_buttonHP = new Button(30, 70, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonHP); // кнопка +
				this.addChild(new Label(60, 75, 150, 30, "Arial", 16, 0xFFFFFF, "HP: " + Resource.DEFAULT_HIP_POINTS.toString(), false));
				_buttonMana = new Button(30, 95, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonMana); // кнопка +
				this.addChild(new Label(60, 100, 150, 30, "Arial", 16, 0xFFFFFF, "Mana: " + Resource.DEFAULT_MANA.toString(), false));
				_buttonPower = new Button(30, 120, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonPower); // кнопка +
				this.addChild(new Label(60, 125, 150, 30, "Arial", 16, 0xFFFFFF, "Power: " + Resource.DEFAULT_POWER.toString(), false));
				_buttonDefense = new Button(30, 145, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonDefense); // кнопка +
				this.addChild(new Label(60, 150, 150, 30, "Arial", 16, 0xFFFFFF, "Defense: " + Resource.DEFAULT_DEFENSE.toString(), false));
				_buttonSleight = new Button(30, 170, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonSleight); // кнопка +
				this.addChild(new Label(60, 175, 150, 30, "Arial", 16, 0xFFFFFF, "Sleight: " + Resource.DEFAULT_SLEIGHT.toString(), false));
				_buttonIntellect = new Button(30, 195, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonIntellect); // кнопка +
				this.addChild(new Label(60, 200, 150, 30, "Arial", 16, 0xFFFFFF, "Intellect: " + Resource.DEFAULT_INTELLECT.toString(), false));
				_buttonLeadership = new Button(30, 220, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonLeadership); // кнопка +
				this.addChild(new Label(60, 225, 150, 30, "Arial", 16, 0xFFFFFF, "Leadership: " + Resource.DEFAULT_LEADERSHIP.toString(), false));
			}else {
				_buttonBuy = new Button(30, 20, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonBuy); // кнопка +
				this.addChild(new Label(60, 20, 150, 30, "Arial", 16, 0xFF8000, "Уровень: " + Resource.DEFAULT_LEVEL.toString(), false));
				this.addChild(new Label(30, 45, 150, 30, "Arial", 16, 0xFF8000, "Счет: " + Resource.DEFAULT_SCORE.toString(), false));
				this.addChild(new Label(130, 45, 150, 30, "Arial", 16, 0xFF8000, "Очки: " + Resource.DEFAULT_POINTS.toString(), false));
				this.graphics.lineStyle(1, 0xFFFFFF, 1);
				this.graphics.moveTo(5, 65);
				this.graphics.lineTo(190, 65);
				_buttonHP = new Button(30, 70, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonHP); // кнопка +
				this.addChild(new Label(60, 75, 150, 30, "Arial", 16, 0xFFFFFF, "Жизнь: " + Resource.DEFAULT_HIP_POINTS.toString(), false));
				_buttonMana = new Button(30, 95, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonMana); // кнопка +
				this.addChild(new Label(60, 100, 150, 30, "Arial", 16, 0xFFFFFF, "Мана: " + Resource.DEFAULT_MANA.toString(), false));
				_buttonPower = new Button(30, 120, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonPower); // кнопка +
				this.addChild(new Label(60, 125, 150, 30, "Arial", 16, 0xFFFFFF, "Сила: " + Resource.DEFAULT_POWER.toString(), false));
				_buttonDefense = new Button(30, 145, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonDefense); // кнопка +
				this.addChild(new Label(60, 150, 150, 30, "Arial", 16, 0xFFFFFF, "Защита: " + Resource.DEFAULT_DEFENSE.toString(), false));
				_buttonSleight = new Button(30, 170, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonSleight); // кнопка +
				this.addChild(new Label(60, 175, 150, 30, "Arial", 16, 0xFFFFFF, "Ловкость: " + Resource.DEFAULT_SLEIGHT.toString(), false));
				_buttonIntellect = new Button(30, 195, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonIntellect); // кнопка +
				this.addChild(new Label(60, 200, 150, 30, "Arial", 16, 0xFFFFFF, "Интеллект: " + Resource.DEFAULT_INTELLECT.toString(), false));
				_buttonLeadership = new Button(30, 220, 25, 25, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 9, "+", 2);
				this.addChild(_buttonLeadership); // кнопка +
				this.addChild(new Label(60, 225, 150, 30, "Arial", 16, 0xFFFFFF, "Лидерство: " + Resource.DEFAULT_LEADERSHIP.toString(), false));
			}
			
			Resource.FIGHTER_ID = id;
			Resource.FIGHTER_NAME = _fighterName;
			Resource.FIGHTER_LEVEL = Resource.DEFAULT_LEVEL;
			Resource.FIGHTER_HIP_POINTS = Resource.DEFAULT_HIP_POINTS;
			Resource.FIGHTER_MANA = Resource.DEFAULT_MANA;
			Resource.FIGHTER_POWER = Resource.DEFAULT_POWER;
			Resource.FIGHTER_DEFENSE = Resource.DEFAULT_DEFENSE;
			Resource.FIGHTER_SLEIGHT = Resource.DEFAULT_SLEIGHT;
			Resource.FIGHTER_INTELLECT = Resource.DEFAULT_INTELLECT;
			Resource.FIGHTER_LEADERSHIP = Resource.DEFAULT_LEADERSHIP;
			Resource.FIGHTER_SCORE = Resource.DEFAULT_SCORE;
			Resource.FIGHTER_POINTS = Resource.DEFAULT_POINTS;
		}
		
	}

}
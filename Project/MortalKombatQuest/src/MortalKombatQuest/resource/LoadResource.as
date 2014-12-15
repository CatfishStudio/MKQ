package MortalKombatQuest.resource 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import MortalKombatQuest.text.Label;
	import MortalKombatQuest.resource.Resource;
	import MortalKombatQuest.animation.SpinerLoader;
	
	public class LoadResource extends Sprite
	{
		[Embed(source = '../media/textures/mk_logo1.png')]
		private var Logo:Class;
		private var _logo:Bitmap = new Logo();
		
		[Embed(source = '../media/textures/progress.png')]
		private var ProcessBar:Class;
		private var _progressBar:Bitmap = new ProcessBar();
		
		private var _progressText:Label; // текст загрузки в процентах
		private var _spiner:SpinerLoader; // спинер
		private var _authorText:Label; // автор
		
		private var _loaderART:Loader; // для загрузки арта
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		
		private var _percentComplete:uint = 0;	// процент выполненой загрузки
		
		public function LoadResource() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_logo.x = 320; _logo.y = 100;
			this.addChild(_logo);
			
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(350, 350, 200, 30, "Arial", 16, 0x000000, "Загрузка", false);
			_progressText.text = "Загрузка 0%";
			this.addChild(_progressText);
			
			/* Прогресс бар (индикатор загрузки) */
			this.graphics.lineStyle(1,0x000000);
			this.graphics.drawRect(300, 380, 200, 10);
			_progressBar.x = 300; _progressBar.y = 381;
			_progressBar.width = 0; _progressBar.height = 9;
			this.addChild(_progressBar);
			
			/* Цикличный индикатор загрузки */
			_spiner = new SpinerLoader();
			this.addChild(_spiner);
			
			/* Авторские права */
			_authorText = new Label(335, 550, 200, 30, "Arial", 12, 0x000000, "Catfish Studio Games", false);
			this.addChild(_authorText);
			
			/* Начало загрузки данных с сервера */
			Load("resource/textures/background_select_fighters.jpg","LOAD_IMAGE");
		}
		
		/* ЗАГРУЗКА РЕСУРСОВ С СЕРВЕРА ---------------------------
		 * загрузка png файлов
		 * загрузка xml файлов
		 * */
		private function Load(path:String, type:String):void
		{
			if(_percentComplete < 100){
				if (type == "LOAD_IMAGE") {
					/* Подготовка загрузки ART*/
					_loaderART = new Loader();
					_loaderART.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFileComplete);
					_loaderART.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_loaderART.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_urlReq = new URLRequest(path);
					_loaderART.load(_urlReq);
				}
				if (type == "LOAD_XML") {
					/* Подготовка загрузки XML */
					_loaderXML = new URLLoader();
					_loaderXML.addEventListener(Event.COMPLETE, loadFileComplete);
					_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_urlReq = new URLRequest(path);
					_loaderXML.load(_urlReq);
				}
			}else {
				LoadComplite();
			}
		}
		
		private function loadFileComplete(e:Event):void 
		{
			_loaderART.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadFileComplete);
			_percentComplete += 1;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width += 2;
			
			if(_percentComplete == 1){
				Resource.SelectFightersBackground = new Bitmap();
				Resource.SelectFightersBackground = (e.target.content as Bitmap);
				Load("resource/textures/all_fighters.png", "LOAD_IMAGE");
			}
			if(_percentComplete == 2){
				Resource.SelectFightersIcon = new Bitmap();
				Resource.SelectFightersIcon = (e.target.content as Bitmap);
				Load("resource/textures/kitana_1.png", "LOAD_IMAGE");
			}
			if(_percentComplete == 3){
				Resource.KitanaMK3U_Atlas = new Bitmap();
				Resource.KitanaMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/reptile_1.png", "LOAD_IMAGE");
			}
			if(_percentComplete == 4){
				Resource.ReptileMK3U_Atlas = new Bitmap();
				Resource.ReptileMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sonya_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 5) {
				Resource.SonyaMK3U_Atlas = new Bitmap();
				Resource.SonyaMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/jax_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 6) {
				Resource.JaxMK3U_Atlas = new Bitmap();
				Resource.JaxMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/nightwolf.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 7) {
				Resource.NightwolfMK3U_Atlas = new Bitmap();
				Resource.NightwolfMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/jade.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 8) {
				Resource.JadeMK3U_Atlas = new Bitmap();
				Resource.JadeMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/scorpion_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 9) {
				Resource.ScorpionMK3U_Atlas = new Bitmap();
				Resource.ScorpionMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/rain.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 10) {
				Resource.RainMK3U_Atlas = new Bitmap();
				Resource.RainMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kano_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 11) {
				Resource.KanoMK3U_Atlas = new Bitmap();
				Resource.KanoMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/mileena_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 12) {
				Resource.MileenaMK3U_Atlas = new Bitmap();
				Resource.MileenaMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/ermac.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 13) {
				Resource.ErmacMK3U_Atlas = new Bitmap();
				Resource.ErmacMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sub_zero_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 14) {
				Resource.Subzero1MK3U_Atlas = new Bitmap();
				Resource.Subzero1MK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sub_zero_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 15) {
				Resource.Subzero2MK3U_Atlas = new Bitmap();
				Resource.Subzero2MK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/noobsaibot.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 16) {
				Resource.NoobsaibotMK3U_Atlas = new Bitmap();
				Resource.NoobsaibotMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sektor.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 17) {
				Resource.SektorMK3U_Atlas = new Bitmap();
				Resource.SektorMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sindel.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 18) {
				Resource.SindelMK3U_Atlas = new Bitmap();
				Resource.SindelMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/stryker.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 19) {
				Resource.StrykerMK3U_Atlas = new Bitmap();
				Resource.StrykerMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/cyrex.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 20) {
				Resource.CyrexMK3U_Atlas = new Bitmap();
				Resource.CyrexMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kung_lao_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 21) {
				Resource.KungLaoMK3U_Atlas = new Bitmap();
				Resource.KungLaoMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kabal.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 22) {
				Resource.KabalMK3U_Atlas = new Bitmap();
				Resource.KabalMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sheeva.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 23) {
				Resource.SheevaMK3U_Atlas = new Bitmap();
				Resource.SheevaMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/shang_tsung_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 24) {
				Resource.ShangTsungMK3U_Atlas = new Bitmap();
				Resource.ShangTsungMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/liu_kang_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 25) {
				Resource.LiuKangMK3U_Atlas = new Bitmap();
				Resource.LiuKangMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/smoke.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 26) {
				Resource.SmokeMK3U_Atlas = new Bitmap();
				Resource.SmokeMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/motaro.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 27) {
				Resource.MotaroMK3U_Atlas = new Bitmap();
				Resource.MotaroMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/shao_kahn.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 28) {
				Resource.ShaoKahnMK3U_Atlas = new Bitmap();
				Resource.ShaoKahnMK3U_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/liu_kang_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 29) {
				Resource.LiuKangMK2_Atlas = new Bitmap();
				Resource.LiuKangMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kung_lao_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 30) {
				Resource.KungLaoMK2_Atlas = new Bitmap();
				Resource.KungLaoMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/johnny_cage_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 31) {
				Resource.JohnnyCageMK2_Atlas = new Bitmap();
				Resource.JohnnyCageMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/reptile_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 32) {
				Resource.ReptileMK2_Atlas = new Bitmap();
				Resource.ReptileMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sub_zero_3.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 33) {
				Resource.SubzeroMK2_Atlas = new Bitmap();
				Resource.SubzeroMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/shang_tsung_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 34) {
				Resource.ShangTsungMK2_Atlas = new Bitmap();
				Resource.ShangTsungMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kitana_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 35) {
				Resource.KitanaMK2_Atlas = new Bitmap();
				Resource.KitanaMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/jax_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 36) {
				Resource.JaxMK2_Atlas = new Bitmap();
				Resource.JaxMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/mileena_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 37) {
				Resource.MileenaMK2_Atlas = new Bitmap();
				Resource.MileenaMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/baraka.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 38) {
				Resource.BarakaMK2_Atlas = new Bitmap();
				Resource.BarakaMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/scorpion_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 39) {
				Resource.ScorpionMK2_Atlas = new Bitmap();
				Resource.ScorpionMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/raiden_1.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 40) {
				Resource.RaidenMK2_Atlas = new Bitmap();
				Resource.RaidenMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kintaro.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 41) {
				Resource.KintaroMK2_Atlas = new Bitmap();
				Resource.KintaroMK2_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/johnny_cage_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 42) {
				Resource.JohnnyCageMK1_Atlas = new Bitmap();
				Resource.JohnnyCageMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/kano_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 43) {
				Resource.KanoMK1_Atlas = new Bitmap();
				Resource.KanoMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sub_zero_4.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 44) {
				Resource.SubzeroMK1_Atlas = new Bitmap();
				Resource.SubzeroMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/sonya_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 45) {
				Resource.SonyaMK1_Atlas = new Bitmap();
				Resource.SonyaMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/raiden_2.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 46) {
				Resource.RaidenMK1_Atlas = new Bitmap();
				Resource.RaidenMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/liu_kang_3.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 47) {
				Resource.LiuKangMK1_Atlas = new Bitmap();
				Resource.LiuKangMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/scorpion_3.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 48) {
				Resource.ScorpionMK1_Atlas = new Bitmap();
				Resource.ScorpionMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/shang_tsung_3.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 49) {
				Resource.ShangTsungMK1_Atlas = new Bitmap();
				Resource.ShangTsungMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/goro.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 50) {
				Resource.GoroMK1_Atlas = new Bitmap();
				Resource.GoroMK1_Atlas = (e.target.content as Bitmap);
				Load("resource/textures/tournament.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 51) {
				Resource.TournamentAtlas = new Bitmap();
				Resource.TournamentAtlas = (e.target.content as Bitmap);
				Load("resource/textures/levels.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 52) {
				Resource.LevelsAtlas = new Bitmap();
				Resource.LevelsAtlas = (e.target.content as Bitmap);
				Load("resource/textures/hits.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 53) {
				Resource.HitsAtlas = new Bitmap();
				Resource.HitsAtlas = (e.target.content as Bitmap);
				
				/* Загрузка XML файлов (Уровни)*/
				Load("resource/levels/level01.xml", "LOAD_XML");
			}
			if (_percentComplete == 54) {
				Resource.FileXMLCombinations.push(new XML(e.target.data));
				Load("resource/levels/level02.xml", "LOAD_XML");
			}
			if (_percentComplete == 55) {
				Resource.FileXMLCombinations.push(new XML(e.target.data));
				Load("resource/levels/level03.xml", "LOAD_XML");
			}
			if (_percentComplete == 56) {
				Resource.FileXMLCombinations.push(new XML(e.target.data));
				Load("resource/levels/level04.xml", "LOAD_XML");
			}
			if (_percentComplete == 57) {
				Resource.FileXMLCombinations.push(new XML(e.target.data));
				Load("resource/levels/level05.xml", "LOAD_XML");
			}
			if (_percentComplete == 58) {
				Resource.FileXMLCombinations.push(new XML(e.target.data));
				Load("resource/levels/level1.xml", "LOAD_XML");
			}
			if (_percentComplete == 59) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level2.xml", "LOAD_XML");
			}
			if (_percentComplete == 60) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level3.xml", "LOAD_XML");
			}
			if (_percentComplete == 61) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level4.xml", "LOAD_XML");
			}
			if (_percentComplete == 62) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level5.xml", "LOAD_XML");
			}
			if (_percentComplete == 63) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level6.xml", "LOAD_XML");
			}
			if (_percentComplete == 64) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level7.xml", "LOAD_XML");
			}
			if (_percentComplete == 65) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level8.xml", "LOAD_XML");
			}
			if (_percentComplete == 66) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level9.xml", "LOAD_XML");
			}
			if (_percentComplete == 67) {
				Resource.FilesXML.push(new XML(e.target.data));
				Load("resource/levels/level10.xml", "LOAD_XML");
			}
			if (_percentComplete == 68) {
				Resource.FilesXML.push(new XML(e.target.data));
				//Load("resource/textures/", "LOAD_IMAGE");
				LoadComplite(); // завершение загрузки
			}
			if(_percentComplete == 100){
			
			}
		}
		
		
		/* Обработка ОШИБКИ при загрузке ------------------------*/
		private function ioError(e:IOErrorEvent):void 
		{
			this.removeChild(_spiner)
			this.addChild(new Label(340, 400, 200, 30, "Arial", 16, 0xFF00FF, "Ошибка загрузки!", false));
		}
				
		private function securityError(e:SecurityErrorEvent):void 
		{
			this.removeChild(_spiner)
			this.addChild(new Label(340, 400, 200, 30, "Arial", 16, 0xFF00FF, "Ошибка загрузки!", false));
		}
		
		private function LoadComplite():void
		{
			_percentComplete = 100;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width = 200;
			dispatchEvent(new Event(Event.CLEAR));
		}
	}

}
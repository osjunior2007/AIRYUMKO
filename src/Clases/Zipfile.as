package Clases
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	import Clases.IDEComponentes;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	public class Zipfile
	{  private static var instancia:Zipfile;
		public var zip:FZip = new FZip();
		public var New_zip:FZip = new FZip();
		public var index:uint = 0;
		public var done:Boolean = false;
		public var proyecto_zip:String="Rails.zip";
		////////////////////////////////////////////////////////////////////////
		public var cadena:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="ListRequest.send();">'+"\n";
		public var canvasdatagrid:String='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
		public var DataGridposx:int=20;
		public var datagridHead:String='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
		public var canvascomponente:String='<mx:Canvas updateComplete="set_update()" x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
		public var HeadService:String="";
		public var clearparam:String="";
		public var setupdate:String="";
		public var migrationBody:String="";
		public var validate:String="";
		public var posx:int=10;
		public var posy:int=20;
		[Bindable] public var list_components:Array = new Array();
		
		public function Zipfile()
		{
		}
		
		
		public function init_value():void
		{
			cadena='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="ListRequest.send();">'+"\n";
			canvasdatagrid='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
			DataGridposx=20;
			datagridHead='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
			canvascomponente='<mx:Canvas updateComplete="set_update()" x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
			HeadService="";
			clearparam="";
			setupdate="";
			migrationBody="";
			validate="";
			posx=10;
			posy=20;
		}
		
		
		
		public static function getInstance():Zipfile
		{
			if( instancia==null ) 
				instancia = new Zipfile();
			return instancia;
		}
		
		
		
		public function add_file(path:String,file:String):void
		{
			var archivo:ByteArray = new ByteArray();
			archivo.writeUTFBytes(file);
			zip.addFile(path, archivo);
		}
		
		
		public function open():void
		{
			var docsDir:File = File.applicationDirectory
			try
			{
				docsDir.browseForDirectory("Select Directory for extract");  
				docsDir.addEventListener(Event.SELECT, saveData);
			}
			catch (error:Error)
			{
				Alert.show("Failed:", error.message);
			}	
			
		}
		
		
		public function saveData(event:Event):void 
		{
			var file:File = event.target as File;
			file = file.resolvePath("Proyecto.zip");
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			zip.serialize(stream);
			stream.close();
			Alert.show("Downloades File !!");
		}
		
		
		public function Load_File(file:String):void {
			New_zip = new FZip();
			New_zip.addEventListener(Event.COMPLETE, onComplete);
			New_zip.load(new URLRequest(file));
		}	
		
		
		
		private function onComplete(evt:Event):void {
			for(var i=0;i<=New_zip.getFileCount()-1;i++) {
				var file:FZipFile = New_zip.getFileAt(i);
				add_file(file.filename,file.content.toString());
			}
			get_components();
		}
		
		
		
		public function Result_build_MainMXML (e:Event):void
		{    
			var name:String="";
			var MainApp:String="";	
			for(var i:int=0;i<=Database.getInstance().personData.length-1;i++){
				name=Database.getInstance().personData[i].nombre;
				name=name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length);
				//build controller
				add_file("app/controllers/"+name+"_controller.rb",Database.getInstance().personData[i].controlador);
				//build models
				add_file("app/models/"+name+".rb",Database.getInstance().personData[i].modelo);
				//build helpers
				add_file("app/helpers/"+name+"_helper.rb","module "+name+"sHelper \n end");
				//Main Canvas
				MainApp+='<mx:Canvas label="'+Database.getInstance().personData[i].nombre+'" width="100%" height="100%" showEffect="WipeDown" hideEffect="WipeUp">'+" \n";
				MainApp+='<'+Database.getInstance().personData[i].nombre+'  id="'+Database.getInstance().personData[i].nombre+'"  showEffect="WipeDown" hideEffect="WipeUp" width="98%" height="98%"  y="0" x="0" />'+" \n";
				MainApp+='</mx:Canvas>'+" \n";
			}
			MainApp='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Application  xmlns="Componentes.*" xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">'+" \n"+'<mx:TabNavigator x="10" y="22" width="98%" height="95%">'+" \n"+MainApp;
			MainApp+="</mx:TabNavigator>"+" \n"+'<mx:Style source="css.css"/> '+" \n"+'</mx:Application>';
			add_file("src/Main.mxml",MainApp);
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Result_build_MainMXML);
			open();
		}
		public function build_MainMXML():void
		{
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Result_build_MainMXML);
			Database.getInstance().getDatos("select nombre,id_modulo,modelo,controlador,name_prural from modulos");
		}   
		
		public function get_components():void
		{
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Result_components);
			Database.getInstance().getDatos("select * from componentes");
		}
		
		public function Result_components(e:Event):void
		{ 
			list_components=Database.getInstance().personData;
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Result_components);
			Database.getInstance().exampleDB.close();
			Database.getInstance().initAndOpenDatabase();
			build_MainMXML();
		}
		
		public function Buil_Components_Mxml(id:String):String
		{
			init_value();
			for(var i:int=0;i<=list_components.length-1;i++){
				if(list_components[i]==id){	
					datagridHead+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
					HeadService+=IDEComponentes.getInstance().Http_service_Create(list_components[i].identificador);
					canvascomponente+=IDEComponentes.getInstance().Crear_Mxml(list_components[i].componente_id,list_components[i].identificador,list_components[i].etiqueta,list_components[i].tamano,list_components[i].tipo);
				}
			}
			
			return "";	
		}
		
		
	}
}
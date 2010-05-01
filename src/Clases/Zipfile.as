package Clases
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
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
		public var proyecto_zip:String="amfphp.zip";
		public var proyecto_name:String="Escuela";
		public var database_name:String="Escuela";
		public var user_database:String="root";
		public var password_database:String="";
		public var canvascomponente:String="";
		////////////////////////////////////////////////////////////////////////
		public var cadena:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="DataModels.getInstance().set_canvas(this,CanvasDataInpust);ListRequest.send();">'+"\n";
		public var canvasdatagrid:String='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
		public var DataGridposx:int=20;
		public var datagridHead:String='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
		public var HeadService:String="";
		public var setupdate:String="";
		public var migrationBody:String="";
		public var validate:String="";
		public var posx:int=10;
		public var posy:int=20;
		public var sw:int=0;
		public var migrationHead:String="";
		public var database_sql:String="";
		public var Head_database_sql:String="";
		public var nameclases:String="";
		[Bindable] public var list_components:Array = new Array();
		[Bindable] public var list_relaciones:Array = new Array();
		[Bindable] public var list_modulos:Array = new Array();
		public var Modulos_relacionados:String="";
		public var Date_Today:String="";
		public var migrationcant:int=0;
		public var TipoFramework:int=0;
		public var Position_Objets:String="";
		public var MainApp:String="";
		
		public function Zipfile()
		{
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
			zip = new FZip();
			New_zip.addEventListener(Event.COMPLETE, onComplete);
			New_zip.load(new URLRequest(file));
		}
		
		
		
		private function onComplete(evt:Event):void {
			for(var i:int=0;i<=New_zip.getFileCount()-1;i++) {
				var file:FZipFile = New_zip.getFileAt(i);
				if (file.filename=="src/Clases/App.as"||file.filename==".settings/org.eclipse.core.resources.prefs"||file.filename=="bin-debug/history/history.css"
					||file.filename=="bin-debug/history/historyFrame.html"||file.filename=="bin-debug/history/history.js"
					||file.filename=="bin-debug/ejemplo.html"||file.filename=="bin-debug/ejemplo.swf"||file.filename=="bin-debug/AC_OETags.js"||file.filename=="bin-debug/playerProductInstall.swf"
					||file.filename=="html-template/index.template.html"||file.filename=="html-template/AC_OETags.js"||file.filename=="html-template/playerProductInstall.swf"||file.filename=="html-template/history/history.css"
					||file.filename=="html-template/history/history.js" ||file.filename=="html-template/history/historyFrame.html"){
					if (file.filename!="bin-debug/ejemplo.html"&& file.filename!="bin-debug/ejemplo.swf"){
						add_file(this.proyecto_name+"/"+file.filename,file.content.toString());
					}else{
						if (file.filename=="bin-debug/ejemplo.html"){
							add_file(this.proyecto_name+"/bin-debug/"+this.proyecto_name+".html",BuildMxmlComponets.getInstance().Build_Html_Template(this.proyecto_name));
						}
						if (file.filename=="bin-debug/ejemplo.swf"){
							add_file(this.proyecto_name+"/bin-debug/"+this.proyecto_name+".swf",file.content.toString());
						}
					}
				}else{
					if(file.filename!="src/Clases/"&&file.filename!="src/"&&file.filename!=".settings/"&&file.filename!=".settings/org.eclipse.core.resources.prefs"&&file.filename!="bin-debug/history/history.css"
						&&file.filename!="bin-debug/"&&file.filename!="bin-debug/history/"&&file.filename!="bin-debug/history/historyFrame.html"&&file.filename!="bin-debug/history/history.js"
						&&file.filename!="bin-debug/ejemplo.html"&&file.filename!="bin-debug/ejemplo.swf"&&file.filename!="bin-debug/AC_OETags.js"&&file.filename!="bin-debug/playerProductInstall.swf"
						&&file.filename!="html-template/history/"&&file.filename!="html-template/"&&file.filename!="html-template/index.template.html"&&file.filename!="html-template/AC_OETags.js"&&file.filename!="html-template/playerProductInstall.swf"&&file.filename!="html-template/history/history.css"
						&&file.filename!="html-template/history/history.js"&&file.filename!="html-template/history/historyFrame.html"){
						add_file(file.filename,file.content.toString());
					}
				}
			}
			get_relaciones();
		}
		
		//Esta funcion Construye el Main.xml y tambien el Amfphp server
		public function Result_build_MainMXML (e:Event):void
		{
			var name_modelo:String="";
			var name:String="";
			MainApp="";
			nameclases="";
			if(Database.getInstance().personData!=null){
				list_modulos=Database.getInstance().personData;
				for(var i:int=0;i<=Database.getInstance().personData.length-1;i++){
					name=Database.getInstance().personData[i].nombre;
					name_modelo=Database.getInstance().personData[i].nombre;
					name_modelo=name_modelo.substring(0,name_modelo.length-1);
					name=name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length);
					BuildMxmlComponets.getInstance().Create_ControllerAndModels(name,name_modelo,user_database,password_database,i);
					add_file(this.proyecto_name+"/src/Controllers/"+name.substr(0,name.length-1)+"Controller.as",CreateMVC.getInstance().CREATE_CONTROLLER(name.substr(0,name.length-1)));
					add_file(this.proyecto_name+"/src/Models/"+name.substr(0,name.length-1)+".as",CreateMVC.getInstance().CREATE_MODEL(name.substr(0,name.length-1),Database.getInstance().personData[i].id_modulo));
					BuildMxmlComponets.getInstance().CREATE_SQL_MIGRATION(Database.getInstance().personData[i].id_modulo,Database.getInstance().personData[i].nombre,Zipfile.getInstance().list_components)
					BuildMxmlComponets.getInstance().CREATE_FORM(Database.getInstance().personData[i].id_modulo,Database.getInstance().personData[i].nombre)
					BuildMxmlComponets.getInstance().CREATE_MXML_COMPONENTS(Database.getInstance().personData[i].id_modulo,Database.getInstance().personData[i].id_nombre,name.substr(0,name.length-1));
				}
				
				if(proyecto_zip=="amfphp.zip"){
					Head_database_sql="CREATE DATABASE /*!32312 IF NOT EXISTS*/`"+database_name.toLowerCase()+"` /*!40100 DEFAULT CHARACTER SET latin1 */;"+"\n"+"USE `"+database_name.toLowerCase()+"`;"+"\n"+Head_database_sql;
					add_file("amfphp/database.sql",Head_database_sql);
				}
				
				BuildMxmlComponets.getInstance().Main_Mxml();
			}
		}
		
		public function get_relaciones():void
		{
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Resutl_get_relaciones);
			Database.getInstance().getDatos("select id,modulo_principal,tipo_relacion,modulo_relacionado from relaciones");
		}
		
		public function Verificar_Modulo_Relacion(Lista:Array,Elemento:String):Boolean
		{
			var sw:Boolean=false;
			var i:int=0;
			while(i<=Lista.length-1&&sw==false){
				if(Lista[i].modulo_relacionado==Elemento){
					sw=true;
				}
				i++;
			}
			return sw;
		}
		
		public function Obtener_Clases_Relacionadas(modulos:Array,relaciones:Array,Elemento:String):String
		{
			var cadena:String="";
			for(var i:int=0;i<=relaciones.length-1;i++){
				if(relaciones[i].modulo_principal==Elemento){
					for(var j:int=0;j<=modulos.length-1;j++){
						if (relaciones[i].modulo_relacionado==modulos[j].id_modulo){
							cadena+="  import Clases."+modulos[j].nombre.substr(0,1).toLocaleUpperCase()+modulos[j].nombre.substr(1,modulos[j].nombre.length)+";"+"\n";
						}
					}
				}
				
			}
			return cadena;
		}
		
		public function Resutl_get_relaciones(e:Event):void
		{
			list_relaciones=Database.getInstance().personData;
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Resutl_get_relaciones);
			get_components()
		}
		
		public function build_MainMXML():void
		{
			//Quety que busca todo los modulos para luego ser construidos
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Result_build_MainMXML);
			Database.getInstance().getDatos("select nombre,id_modulo from modulos");
		}
		
		public function get_components():void
		{
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Result_components);
			Database.getInstance().getDatos("select componente_id,id_modulo,etiqueta,identificador,tamano,replace(replace(tipo,'Numerico','0'),'Alfanumerico','1') as tipo,requerido from componentes");
		}
		
		public function Result_components(e:Event):void
		{
			list_components=Database.getInstance().personData;
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Result_components);
			Database.getInstance().exampleDB.close();
			Database.getInstance().initAndOpenDatabase();
			build_MainMXML();
		}
		
		
	}
}
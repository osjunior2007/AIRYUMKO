package Clases
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import mx.controls.Alert;
	import Clases.Mobile.CreateMobileApp;
	public class Zipfile
	{  private static var instancia:Zipfile;
		public var zip:FZip = new FZip();
		public var New_zip:FZip = new FZip();
		public var index:uint = 0;
		public var done:Boolean = false;
		public var proyecto_zip:String="amfphp.zip";
		public var proyecto_name:String="";
		public var proyecto_type:String="mobile";
		public var database_name:String="";
		public var user_database:String="root";
		public var password_database:String="";
		////////////////////////////////////////////////////////////////////////
		public var cadena:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="DataModels.getInstance().set_canvas(this,CanvasDataInpust);ListRequest.send();">'+"\n";
	    public var canvasdatagrid:String='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
		public var DataGridposx:int=20;
		public var datagridHead:String='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
		public var setupdate:String="";
		public var migrationBody:String="";
		public var validate:String="";
		public var posx:int=10;
		public var posy:int=20;
		public var sw:int=0;
		public var migrationHead:String="";
		public var database_sql:String="";
		public var Head_database_sql:String="";
		public var relaciones_mxml_form:String="";
		public var count_mxml_form:int=2;
		public var helper_class_name:String="";
		[Bindable] public var list_components:Array = new Array();
		[Bindable] public var list_relaciones:Array = new Array();
		[Bindable] public var list_modulos:Array = new Array();
		public var Date_Today:String="";
		public var migrationcant:int=0;
		public var TipoFramework:int=0;
		public var Position_Objets:String="";
		public var MainApp:String="";
		public var Relation_Remote_name:String=""
		public var XmlParamert:String="";
		public var view_path:String="";
		public var mediators_name="";
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
			file = file.resolvePath(this.proyecto_name+".zip");
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
				if (file.filename=="libs/catalog.xml"||file.filename=="libs/library.swf"||file.filename=="src/Clases/ServiceRecords.as"||file.filename==".settings/org.eclipse.core.resources.prefs"||file.filename=="bin-debug/history/history.css"
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
					if(file.filename!="libs/"&&file.filename!="libs/library.swf"&&file.filename!="libs/catalog.xml"&&file.filename!="src/Clases/"&&file.filename!="src/"&&file.filename!=".settings/"&&file.filename!=".settings/org.eclipse.core.resources.prefs"&&file.filename!="bin-debug/history/history.css"
						&&file.filename!="bin-debug/"&&file.filename!="bin-debug/history/"&&file.filename!="bin-debug/history/historyFrame.html"&&file.filename!="bin-debug/history/history.js"
						&&file.filename!="bin-debug/ejemplo.html"&&file.filename!="bin-debug/ejemplo.swf"&&file.filename!="bin-debug/swfobject.js"&&file.filename!="bin-debug/AC_OETags.js"&&file.filename!="bin-debug/playerProductInstall.swf"
						&&file.filename!="html-template/history/"&&file.filename!="html-template/"&&file.filename!="html-template/index.template.html"&&file.filename!="html-template/AC_OETags.js"&&file.filename!="html-template/playerProductInstall.swf"&&file.filename!="html-template/history/history.css"
						&&file.filename!="html-template/history/history.js"&&file.filename!="html-template/history/historyFrame.html"){
						add_file(file.filename,file.content.toString());
					}
				}
			}
			 list_relaciones=Database.getInstance().relacion.findBySQL("select id,modulo_principal,tipo_relacion,modulo_relacionado from relacions");;
			 list_components=Database.getInstance().component.findBySQL("select componente_id,modulo_id,etiqueta,identificador,tamano,replace(replace(tipo,'Numerico','0'),'Alfanumerico','1') as tipo,requerido,tipo_relacion,modulo_relacionado from componentes");
          
			 if(this.proyecto_type=="Web"){
				 CreateWebpApp(Database.getInstance().mod.findBySQL("select name,id from modulos"));
			 }
			 
			 if(this.proyecto_type=="Mobile"){
			   CreateMobileApp.getInstance().CreateApp(Database.getInstance().mod.findBySQL("select name,id from modulos"));
			 }
				
		}
		
		//Esta funcion Construye el Main.xml y tambien el Amfphp server
		public function CreateWebpApp(Modulos:Array):void
		{
			var name_modelo:String="";
			var name:String="";
			MainApp="";
			mediators_name="";
			if(Modulos!=null){
				list_modulos=Modulos;
				for(var i:int=0;i<=list_modulos.length-1;i++){
					name=list_modulos[i].name;
					name=name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)
					BuildMxmlComponets.getInstance().init_value();
					BuildMxmlComponets.getInstance().CREATE_BACKEND(name,user_database,password_database,list_modulos[i].id,i);
				    add_file(this.proyecto_name+"/src/Controllers/"+name+"Controller.as",CreateMVC.getInstance().CREATE_CONTROLLER(name,list_modulos[i].id, BuildMxmlComponets.getInstance().IF_MODULO_RELATION(list_modulos[i].id)));
					add_file(this.proyecto_name+"/src/Models/"+name+"Model.as",CreateMVC.getInstance().CREATE_MODEL(name,list_modulos[i].id));
					mediators_name+='<mediators:'+name+'Controller id="'+name+'" />'+"\n";
					BuildMxmlComponets.getInstance().CREATE_SQL_MIGRATION(list_modulos[i].id,list_modulos[i].name,Zipfile.getInstance().list_components)
					BuildMxmlComponets.getInstance().CREATE_VIEW(list_modulos[i].id,list_modulos[i].name,Zipfile.getInstance().list_components)
					if(Verificar_Modulo_Relacion(list_components,list_modulos[i].id)==false){
					   BuildMxmlComponets.getInstance().CREATE_MAIN_VIEW_TAB(list_modulos[i].id,list_modulos[i].id,name);
				    }
				}
				if(proyecto_zip=="amfphp.zip"){
					Head_database_sql="CREATE DATABASE /*!32312 IF NOT EXISTS*/`"+database_name.toLowerCase()+"` /*!40100 DEFAULT CHARACTER SET latin1 */;"+"\n"+"USE `"+database_name.toLowerCase()+"`;"+"\n"+Head_database_sql;
					add_file("amfphp/database.sql",Head_database_sql);
				}
				BuildMxmlComponets.getInstance().CREATE_BEANS_MEDIATORS(mediators_name);
				BuildMxmlComponets.getInstance().CREATE_MAIN_VIEW_APPLICATION();
			}
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
		
		
		
		public function get_modulo_name(id_modulo:String):String
		{
		 var i:int=0;
		 var sw:int=0;
		 var cadena:String="";
		  while(i<=list_modulos.length-1&&sw==0){
		  	  	if (list_modulos[i].id_modulo==id_modulo){
		 			sw=1;
		 			cadena=list_modulos[i].nombre
		 		}
		 	 i++;	
		    }
		 return cadena;	
		}
		
		
	}
}
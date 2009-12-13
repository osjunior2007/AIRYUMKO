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
		public var proyecto_zip:String="Rails.zip";
		public var proyecto_name:String="Proyecto";
		public var user_database:String="root";
		public var password_database:String="";
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
		public var sw:int=0;
		public var migrationHead:String="";
		[Bindable] public var list_components:Array = new Array();
 	    public var Date_Today:String="";
		public var migrationcant:int=0;
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
			sw=0;
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
			for(var i=0;i<=New_zip.getFileCount()-1;i++) {
				var file:FZipFile = New_zip.getFileAt(i);
				add_file(file.filename,file.content.toString());
			}
			get_components();
		}
		
		
		
		public function Result_build_MainMXML (e:Event):void
		{    
			var name_modelo:String="";
			var name:String="";
			var MainApp:String="";	
			for(var i:int=0;i<=Database.getInstance().personData.length-1;i++){
				name=Database.getInstance().personData[i].nombre;
				name_modelo=Database.getInstance().personData[i].nombre;
				name=name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length);
				//build controller
				add_file("app/controllers/"+name+"_controller.rb",Database.getInstance().personData[i].controlador);
				//build models
				add_file("app/models/"+name_modelo.substring(0,name_modelo.length-1)+".rb",Database.getInstance().personData[i].modelo);
				//build helpers
				add_file("app/helpers/"+name+"_helper.rb","module "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+"Helper \n end");
				//Main Canvas
				MainApp+='<mx:Canvas label="'+Database.getInstance().personData[i].nombre+'" width="100%" height="100%" showEffect="WipeDown" hideEffect="WipeUp">'+" \n";
				MainApp+='<'+name_modelo+'  id="'+Database.getInstance().personData[i].nombre+'"  showEffect="WipeDown" hideEffect="WipeUp" width="98%" height="98%"  y="0" x="0" />'+" \n";
				MainApp+='</mx:Canvas>'+" \n";
				Buil_Components_Mxml(Database.getInstance().personData[i].id_modulo,Database.getInstance().personData[i].nombre)
			}
			MainApp='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Application  xmlns="Componentes.*" xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">'+" \n"+'<mx:TabNavigator x="10" y="22" width="98%" height="95%">'+" \n"+MainApp;
			MainApp+="</mx:TabNavigator>"+" \n"+'<mx:Style source="css.css"/> '+" \n"+'</mx:Application>';
			add_file("src/Main.mxml",MainApp);
			add_file("config/database.yml",IDEComponentes.getInstance().database_yml (proyecto_name,user_database,password_database));
			
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Result_build_MainMXML);
			open();
		}
		public function build_MainMXML():void
		{
			Database.getInstance().dbStatement.addEventListener(SQLEvent.RESULT, Result_build_MainMXML);
			Database.getInstance().getDatos("select nombre,id_modulo,modelo,controlador from modulos");
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
		
		public function Buil_Components_Mxml(id:String,nombre:String):String
		{
	
			init_value();
		 	for(var i:int=0;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
					sw=1;
					datagridHead+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
					HeadService+=IDEComponentes.getInstance().Http_service_Create(list_components[i].identificador);
					canvascomponente+=IDEComponentes.getInstance().Crear_Mxml(list_components[i].componente_id,list_components[i].identificador,list_components[i].etiqueta,list_components[i].tamano,list_components[i].tipo);
				   if(list_components[i].requerido=="true"){
					 validate+=IDEComponentes.getInstance().Validation(list_components[i].identificador);   
				   }
				   clearparam+="      "+"Att_"+list_components[i].identificador+".text=''\n";
				   setupdate+="      "+"Att_"+list_components[i].identificador+".text=datos.selectedItem."+list_components[i].identificador+"\n";
				   if(list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
					 migrationBody+=IDEComponentes.getInstance().Create_migration(list_components[i].identificador,list_components[i].componente_id,list_components[i].tamano);
				   }
				   
				}
			}
			IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+15;
			if(sw==1)
			{
				HeadService=IDEComponentes.getInstance().Head_Http_service(nombre)+HeadService+'</objetos>'+"\n"+'</mx:request>'+"\n"+'</mx:HTTPService>'+"\n" +'<mx:HTTPService contentType="application/xml" id="UpdateRequest" result="updateHandler(event);" url="http://localhost:3000/'+nombre+'/update" useProxy="false"  method="POST">'+"\n"+'<mx:request xmlns="">'+"\n"+'<objetos>'+" \n" +"<id>{datos.selectedItem.id}</id>" +" \n"+HeadService+'</objetos>'+"\n"+'</mx:request>'+"\n"+'</mx:HTTPService>'+ "\n";
				HeadService+=validate+'<mx:ViewStack x="0" y="0" id="View_01" width="100%" height="100%">'+"\n";
				datagridHead+='</mx:columns>'+"\n"+'</mx:DataGrid>';
				canvasdatagrid+=datagridHead+"\n"+IDEComponentes.getInstance().Crear_Button("Crear","crear","{wiew_sw=false;View_01.selectedIndex=1}",DataGridposx,"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Update","UpdateView","wiew_sw=true;validate_id_update();",DataGridposx+96,"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Delete","deletes","deleteHandler(event);",DataGridposx+196,"{datos.height+50}","true")+"\n"+'<mx:Label x="'+DataGridposx+'" y="25" text="Modulo - '+nombre+' "/>'+"\n"+'</mx:Canvas>'+"\n";
				cadena+= HeadService+IDEComponentes.getInstance().Create_Script(clearparam,nombre.substring(0,nombre.length-1),setupdate);
				cadena+=canvasdatagrid;
				cadena+=canvascomponente;
				cadena+=IDEComponentes.getInstance().Crear_Button("Submit","submit","CreateRequest.send();",IDEComponentes.getInstance().posx,IDEComponentes.getInstance().posy,"false")+"\n";
				cadena+=IDEComponentes.getInstance().Crear_Button("Update","updates","UpdateRequest.send()",IDEComponentes.getInstance().posx+96,IDEComponentes.getInstance().posy,"false")+"\n";
				IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+96;
				cadena+=IDEComponentes.getInstance().Crear_Button("Back","back","View_01.selectedIndex=0;clear_field()",IDEComponentes.getInstance().posx+96,IDEComponentes.getInstance().posy,"true")+"\n";
				cadena+='</mx:Canvas>'+"\n"+'</mx:ViewStack>'+"\n"+'</mx:Canvas>';
				add_file("src/Componentes/"+nombre+".mxml",cadena);
				migrationHead="class CreateTable"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length)+" < ActiveRecord::Migration \n"+"def self.up \n  create_table "+'"'+nombre+'", '+":force => true do |t| \n";
				migrationHead+=migrationBody+"end \n end \n def self.down \n  drop_table "+'"'+nombre+'"'+"\n  end \n end \n";
				Date_Today=new Date().fullYear.toString()+(new Date().month+1).toString()+new Date().date.toString()+new Date().getHours().toString()+new Date().getMinutes().toString()+new Date().getSeconds().toString()+migrationcant.toString();
				add_file("db/migrate/"+Date_Today+"_create_table_"+nombre+".rb",migrationHead);
				migrationcant++;
			    }else{
				 cadena='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" >'+"\n";	
			     add_file("src/Componentes/"+nombre+".mxml",cadena+"\n"+'</mx:Canvas>');
				}
		 	return "";	
		}
		
		
	}
}
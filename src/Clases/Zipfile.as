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
		public var proyecto_name:String="Proyecto";
		public var user_database:String="root";
		public var password_database:String="";
		public var canvascomponente:String="";
		////////////////////////////////////////////////////////////////////////
		public var cadena:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="DataModels.getInstance().set_canvas(this,CanvasDataInpust);ListRequest.send();">'+"\n";
		public var canvasdatagrid:String='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="WipeDown" hideEffect="WipeUp">'+"\n";
		public var DataGridposx:int=20;
		public var datagridHead:String='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
		public var HeadService:String="";
		public var Objectparam:String="";
		public var setupdate:String="";
		public var migrationBody:String="";
		public var validate:String="";
		public var posx:int=10;
		public var posy:int=20;
		public var sw:int=0;
		public var migrationHead:String="";
		public var nameclases:String="";
		[Bindable] public var list_components:Array = new Array();
 	    public var Date_Today:String="";
		public var migrationcant:int=0;
		public var TipoFramework:int=0;
		public function Zipfile()
		{
		}
		
		
		public function init_value():void
		{
		  	cadena='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" creationComplete="App.getInstance().set_canvas(this);App.getInstance().operation('+"'index'"+',{});">'+"\n";
		   if(IDEComponentes.getInstance().RequeriedEfecctCanvas==0){
		  	canvasdatagrid='<mx:Canvas x="0" y="0"  width="98%" height="98%" showEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).showEffect+'" hideEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).hideEffect+'">'+"\n";
		  	}else{
		     canvasdatagrid='<mx:Canvas x="0" y="0"  width="98%" height="98%" >'+"\n";
		  	}
		  	DataGridposx=20;
		  	datagridHead='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
		  	 if(IDEComponentes.getInstance().RequeriedEfecctCanvas==0){
		     canvascomponente='<mx:Canvas id="InputsObjects" updateComplete="set_update()" x="0" y="0"  width="98%" height="98%" showEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).showEffect+'" hideEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).hideEffect+'">'+"\n";
		     }else{
		     canvascomponente='<mx:Canvas id="InputsObjects" updateComplete="set_update()" x="0" y="0"  width="98%" height="98%" >'+"\n";
		     }
		  	HeadService="";
		  	Objectparam="";
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
			nameclases="";
		  if(Database.getInstance().personData!=null){	
			for(var i:int=0;i<=Database.getInstance().personData.length-1;i++){
				name=Database.getInstance().personData[i].nombre;
				name_modelo=Database.getInstance().personData[i].nombre;
				name_modelo=name_modelo.substring(0,name_modelo.length-1);
				name=name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length);
				
				//PhpActiveRecoreds
				if(proyecto_zip=="amfphp.zip"){
				   add_file("amfphp/services/"+name+"Controller.php",ActiveRecords.getInstance().set_controllador(name));
				   add_file("amfphp/services/models/"+name_modelo+".php",ActiveRecords.getInstance().set_modelo(name_modelo.substr(0,1).toLocaleUpperCase()+name_modelo.substr(1,name_modelo.length)));
				   if(i==0){
				    add_file("amfphp/services/lib/database.php",ActiveRecords.getInstance().Data_Base("Proyecto","root",""));
				   }
				}
				
				//Only ROR
				if(proyecto_zip=="Rails.zip"){
				//build controller
				  add_file("app/controllers/"+name+"_controller.rb",MC_RubyonRails.getInstance().set_controllador(name));
				  add_file("app/models/"+name_modelo+".rb",MC_RubyonRails.getInstance().set_modelo(name_modelo.substr(0,1).toLocaleUpperCase()+name_modelo.substr(1,name_modelo.length)));
				  add_file("app/helpers/"+name+"_helper.rb","module "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+"Helper \n end");
				   if(i==0){
				    add_file("config/database.yml",IDEComponentes.getInstance().database_yml (proyecto_name,user_database,password_database));
				    }
				}
				if(proyecto_zip=="cake_1.2.3.8166.zip"){
				 //CakePhp	
				 add_file("app/controllers/"+name+"_controller.php",CakePHP.getInstance().set_controllador(name));
				 add_file("app/models/"+name_modelo+".php",CakePHP.getInstance().set_modelo(name_modelo.substr(0,1).toLocaleUpperCase()+name_modelo.substr(1,name_modelo.length)));
				 //Database Cake
				}
				
				//Main Canvas
			    if(IDEComponentes.getInstance().RequeriedEfecctCanvas==0){
		        MainApp+='<mx:Canvas click="App.getInstance().set_canvas('+Database.getInstance().personData[i].nombre+');" label="'+Database.getInstance().personData[i].nombre+'" width="100%" height="100%" showEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).showEffect+'" hideEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).hideEffect+'">'+"\n";
			    MainApp+='<'+name.substr(0,name.length-1)+' creationComplete="'+name+'.getInstance().set_canvas('+Database.getInstance().personData[i].nombre+');"  id="'+Database.getInstance().personData[i].nombre+'"  showEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).showEffect+'" hideEffect="'+IDEComponentes.getInstance().EfecctCanvas.getItemAt(0).hideEffect+'" width="98%" height="98%"  y="0" x="0" />'+" \n";
		        }else{
		        MainApp+='<mx:Canvas click="App.getInstance().set_canvas('+Database.getInstance().personData[i].nombre+');" label="'+Database.getInstance().personData[i].nombre+'" width="100%" height="100%" >'+"\n";
			    MainApp+='<'+name.substr(0,name.length-1)+' creationComplete="'+name+'.getInstance().set_canvas('+Database.getInstance().personData[i].nombre+');"  id="'+Database.getInstance().personData[i].nombre+'"  width="98%" height="98%"  y="0" x="0" />'+" \n";  
			    }
			    
				MainApp+='</mx:Canvas>'+" \n";
				Buil_Components_Mxml(Database.getInstance().personData[i].id_modulo,name)
	            nameclases+="         import Clases."+name+""+" \n";
	           }
	      
			    MainApp='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Application  xmlns="Componentes.*" xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">'+" \n"+'<mx:TabNavigator x="10" y="22" width="98%" height="95%">'+" \n"+MainApp;
			    //MainApp+="</mx:TabNavigator>"+" \n"+'<mx:Style source="css.css"/> '+" \n";
			    MainApp+="</mx:TabNavigator>"+" \n";
			    MainApp+="<mx:Script>"+" \n";
		        MainApp+="          <![CDATA["+" \n";
			    MainApp+=nameclases;
			    MainApp+="         import Clases.App;"+" \n";
		        MainApp+="       ]]>"+" \n";
	            MainApp+=" </mx:Script>"+"\n"+'</mx:Application>';
			    add_file("src/Main.mxml",MainApp);
			
			  
			    
			 Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT,Result_build_MainMXML);
			 open();
		  }//If not is null 	 
		}
		
	public function build_MainMXML():void
		{
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
		
		public function Buil_Components_Mxml(id:String,nombre:String):String
		{
	     if(list_components!=null){
			init_value();
			Objectparam="objeto={}; \n"
		 	for(var i:int=0;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
					sw=1;
					datagridHead+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
					canvascomponente+=IDEComponentes.getInstance().Crear_Mxml(list_components[i].componente_id,list_components[i].identificador,list_components[i].etiqueta,list_components[i].tamano,list_components[i].tipo);
				   if(list_components[i].requerido=="true"){
					 validate+=IDEComponentes.getInstance().Validation(list_components[i].identificador);   
				   }
				   Objectparam+="  objeto."+list_components[i].identificador+"="+"this.canvas['Att_"+list_components[i].identificador+"'].text"+"\n";
				   setupdate+=" "+"Att_"+list_components[i].identificador+".text=datos.selectedItem."+list_components[i].identificador+"\n";

				  
				  //Only ROR
				  if(proyecto_zip=="Rails.zip"){
				    if(list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
					  migrationBody+=IDEComponentes.getInstance().Create_migration(list_components[i].identificador,list_components[i].componente_id,list_components[i].tamano);
				     }
				  }
				   
				}
			}
			IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+15;
			if(sw==1)
			{
				HeadService=IDEComponentes.getInstance().Head_RemoteObject(nombre)+"\n";
				HeadService+=validate+'<mx:ViewStack x="0" y="0" id="View_01" width="100%" height="100%">'+"\n";
				datagridHead+='</mx:columns>'+"\n"+'</mx:DataGrid>';
				canvasdatagrid+=datagridHead+"\n"+IDEComponentes.getInstance().Crear_Button("Crear","crear","{wiew_sw=false;View_01.selectedIndex=1}",DataGridposx,"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Update","UpdateView","wiew_sw=true;App.getInstance().validate_id_update(event);",DataGridposx+96,"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Delete","deletes",""+nombre+".getInstance().create_object()",DataGridposx+196,"{datos.height+50}","true")+"\n"+'<mx:Label x="'+DataGridposx+'" y="25" text="Modulo - '+nombre+' "/>'+"\n"+'</mx:Canvas>'+"\n";
				cadena+= HeadService+IDEComponentes.getInstance().Create_Script(nombre,setupdate);
				cadena+=canvasdatagrid;
				cadena+=canvascomponente;
				cadena+=IDEComponentes.getInstance().Crear_Button("Create","submit","App.getInstance().operation('create',"+nombre+".getInstance().create_object());",IDEComponentes.getInstance().posx,IDEComponentes.getInstance().posy,"false")+"\n";
				cadena+=IDEComponentes.getInstance().Crear_Button("Update","updates","App.getInstance().operation('update',"+nombre+".getInstance().create_object());",IDEComponentes.getInstance().posx+96,IDEComponentes.getInstance().posy,"false")+"\n";
				IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+96;
				cadena+=IDEComponentes.getInstance().Crear_Button("Back","back","View_01.selectedIndex=0;",IDEComponentes.getInstance().posx+96,IDEComponentes.getInstance().posy,"true")+"\n";
				cadena+='</mx:Canvas>'+"\n"+'</mx:ViewStack>'+"\n"+'</mx:Canvas>';
				add_file("src/Componentes/"+nombre+".mxml",cadena);
				
				if(proyecto_zip=="amfphp.zip"){
			     add_file("src/Clases/"+nombre+".as",ActiveRecords.getInstance().Create_Class_object(nombre,Objectparam));
			     }
			   
			   //Only ROR
				if(proyecto_zip=="Rails.zip"){
				  migrationHead="class CreateTable"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length)+" < ActiveRecord::Migration \n"+"def self.up \n  create_table "+'"'+nombre+'", '+":force => true do |t| \n";
				  migrationHead+=migrationBody+"end \n end \n def self.down \n  drop_table "+'"'+nombre+'"'+"\n  end \n end \n";
				  Date_Today=new Date().fullYear.toString()+(new Date().month+1).toString()+new Date().date.toString()+new Date().getHours().toString()+new Date().getMinutes().toString()+new Date().getSeconds().toString()+migrationcant.toString();
				  add_file("db/migrate/"+Date_Today+"_create_table_"+nombre+".rb",migrationHead);
				  migrationcant++;
				}
				/////
				
			    }else{
				 cadena='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300" >'+"\n";	
			     add_file("src/Componentes/"+nombre+".mxml",cadena+"\n"+'</mx:Canvas>');
				}
		  IDEComponentes.getInstance().posx=10;
		  IDEComponentes.getInstance().posy=20;
		  }//If not is null	
		  return "";	
		}
		
		
	}
}
package Clases
{
	
	import flash.events.*;
	import mx.controls.Alert;
	public class BuildMxmlComponets
	{
		private static var instancia:BuildMxmlComponets;
		
		public function BuildMxmlComponets()
		{
		}
		
		public static function getInstance():BuildMxmlComponets
		{
			if( instancia==null )
				instancia = new BuildMxmlComponets();
			return instancia;
		}
		
		
		public function Create_ControllerAndModels(name:String,name_modelo:String,user_database:String,password_database:String,sw:int):void
		{
			//PhpActiveRecoreds
			if( Zipfile.getInstance().proyecto_zip=="amfphp.zip"){
				Zipfile.getInstance().add_file("amfphp/services/"+name+"Controller.php",ActiveRecords.getInstance().set_controllador(name));
				Zipfile.getInstance().add_file("amfphp/services/models/"+name_modelo+".php",ActiveRecords.getInstance().set_modelo(name_modelo));
				if(sw==0){
					Zipfile.getInstance().add_file("amfphp/services/lib/database.php",ActiveRecords.getInstance().Data_Base( Zipfile.getInstance().database_name.toLowerCase(),user_database,password_database));
				}
			}
			
			//Only ROR
			if( Zipfile.getInstance().proyecto_zip=="Rails.zip"){
				//build controller
				Zipfile.getInstance().add_file("app/controllers/"+name+"_controller.rb",MC_RubyonRails.getInstance().set_controllador(name));
				Zipfile.getInstance().add_file("app/models/"+name_modelo+".rb",MC_RubyonRails.getInstance().set_modelo(name_modelo.substr(0,1).toLocaleUpperCase()+name_modelo.substr(1,name_modelo.length)));
				Zipfile.getInstance().add_file("app/helpers/"+name+"_helper.rb","module "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+"Helper \n end");
				if(sw==0){
					Zipfile.getInstance().add_file("config/database.yml",IDEComponentes.getInstance().database_yml ( Zipfile.getInstance().proyecto_name,user_database,password_database));
				}
			}
		}
		
		
		public function CREATE_MXML_COMPONENTS(id_modulo:String,name_componente:String,name:String):void
		{
			if(Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_relaciones,id_modulo)==false){
				Zipfile.getInstance().Modulos_relacionados=Zipfile.getInstance().Obtener_Clases_Relacionadas(Zipfile.getInstance().list_modulos,Zipfile.getInstance().list_relaciones,id_modulo)
				Zipfile.getInstance().MainApp+='<s:NavigatorContent label="'+name+'" width="100%" height="100%" >'+"\n";
				Zipfile.getInstance().MainApp+='<'+name.toLowerCase()+' id="'+name+'"  width="98%" height="98%"  y="0" x="0" />'+" \n";
				Zipfile.getInstance().MainApp+='</s:NavigatorContent>'+" \n";
			}
			Zipfile.getInstance().nameclases+="         import Clases."+name+""+" \n";
		}
		
		
		public function CREATE_FORM(id:String,nombre:String):void
		{
			if(Zipfile.getInstance().list_components!=null){
			   IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+15;
				if(IF_CONTAIN_COMPONENTS(id)==1)
				{
                	Zipfile.getInstance().HeadService=IDEComponentes.getInstance().Head_RemoteObject(nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-1))+"\n";
					Zipfile.getInstance().HeadService+=Zipfile.getInstance().validate+IDEComponentes.getInstance().Create_Script(nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2))+'<mx:ViewStack x="0" y="0" id="View_01" width="100%" height="100%">'+"\n";
					if(Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_components,id)==true){
				 	Zipfile.getInstance().datagridHead='<s:Button click="{'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'Helper.getInstance().Back_Root_Component()}" x="20" y="0" label="Back"/>'+"\n"+Zipfile.getInstance().datagridHead;
					}
					Zipfile.getInstance().datagridHead+='</mx:columns>'+"\n"+'</mx:DataGrid>';
					Zipfile.getInstance().canvasdatagrid+=Zipfile.getInstance().datagridHead+"\n"+IDEComponentes.getInstance().Crear_Button("Crear","crear","{View_01.selectedIndex=1}",Zipfile.getInstance().DataGridposx.toString(),"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Update","UpdateView","{App.getInstance().CHANGE_VIEW('update')}",(Zipfile.getInstance().DataGridposx+96).toString(),"{datos.height+50}","true")+"\n"+IDEComponentes.getInstance().Crear_Button("Delete","deletes","{App.getInstance().VALIDATE_DELETE_ID(event)}",(Zipfile.getInstance().DataGridposx+196).toString(),"{datos.height+50}","true")+"\n"+'<mx:Label x="'+Zipfile.getInstance().DataGridposx+'" y="25" text="Modulo - '+nombre+' "/>'+"\n"+'</s:NavigatorContent>'+"\n";
					Zipfile.getInstance().cadena='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<s:Group xmlns="Views.*"'+' creationComplete="'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'Helper.getInstance().SET_CANVAS(this)"'+' xmlns:fx="http://ns.adobe.com/mxml/2009"  xmlns:s="library://ns.adobe.com/flex/spark" xmlns:mx="library://ns.adobe.com/flex/mx"  width="400" height="300">'+"\n";
					Zipfile.getInstance().cadena+=Zipfile.getInstance().HeadService;
					Zipfile.getInstance().cadena+=Zipfile.getInstance().canvasdatagrid;
					Zipfile.getInstance().cadena+=Zipfile.getInstance().canvascomponente;
					Zipfile.getInstance().cadena+="<mx:FormItem >"+"\n"+"<s:HGroup>"+"\n"+IDEComponentes.getInstance().Crear_Button("Create","submit","{"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"Controller.getInstance().Create(this);}",IDEComponentes.getInstance().posx.toString(),IDEComponentes.getInstance().posy.toString(),"false")+"\n";
					Zipfile.getInstance().cadena+=IDEComponentes.getInstance().Crear_Button("Update","updates","{"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"Controller.getInstance().Update(this);}",(IDEComponentes.getInstance().posx+96).toString(),IDEComponentes.getInstance().posy.toString(),"false")+"\n";
				    Zipfile.getInstance().cadena+=IDEComponentes.getInstance().Crear_Button("Back","back","{"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+".getInstance().REMOTE_ACCESS('index',{});"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"Helper.getInstance().BACK_TO_LIST(this)}",(IDEComponentes.getInstance().posx+96).toString(),(IDEComponentes.getInstance().posy).toString(),"true")+"\n";
				 	Zipfile.getInstance().cadena+="</s:HGroup>"+"\n"+"</mx:FormItem>"+"\n"+"</mx:Form>"+"\n"+'</s:NavigatorContent>'+"\n"+Zipfile.getInstance().relaciones_mxml_form+'\n'+'</mx:ViewStack>'+"\n"+'</s:Group>';
					Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+nombre.substr(0,nombre.length-1)+".mxml",Zipfile.getInstance().cadena);
				}
				IDEComponentes.getInstance().posx=10;
				IDEComponentes.getInstance().posy=20;
			}//If not is null
			
		}
		
		public function IF_CONTAIN_COMPONENTS(id:String):int
		{
			var sw:int=0;
			var i:int=0;
			while(i<=Zipfile.getInstance().list_components.length-1&&sw==0){
				if(Zipfile.getInstance().list_components[i].id_modulo==id){
					sw=1;
				}
				i++;
			}
			
			return sw;
		}
		
		
		
		public function CREATE_SQL_MIGRATION(id:String,nombre:String,list_components:Array):void
		{
			var sw:int=0;
			for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
					sw=1;
				    Zipfile.getInstance().datagridHead+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
					Zipfile.getInstance().canvascomponente+=IDEComponentes.getInstance().Crear_Mxml(list_components[i].componente_id,list_components[i].identificador,list_components[i].etiqueta,list_components[i].tamano,list_components[i].tipo,list_components[i].requerido,list_components[i].tipo_relacion);
					if(Zipfile.getInstance().proyecto_zip=="amfphp.zip"){
						if(list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
							Zipfile.getInstance().database_sql+=IDEComponentes.getInstance().Create_database_sql(list_components[i].identificador,list_components[i].componente_id,list_components[i].tamano);
						}
					}
					
					if(Zipfile.getInstance().proyecto_zip=="Rails.zip"){
						if(list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
							Zipfile.getInstance().migrationBody+=IDEComponentes.getInstance().Create_migration(list_components[i].identificador,list_components[i].componente_id,list_components[i].tamano);
						}
					}
					
				}
			}
			
			if(Zipfile.getInstance().proyecto_zip=="amfphp.zip"){
				Zipfile.getInstance().database_sql="CREATE TABLE"+"`"+nombre.toLowerCase()+"` ("+"\n"+"`id` bigint(11) NOT NULL AUTO_INCREMENT,"+"\n"+Zipfile.getInstance().database_sql;
				Zipfile.getInstance().database_sql+="PRIMARY KEY (`id`)"+" \n"+")"+"ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;"+"\n"+"\n";
				Zipfile.getInstance().Head_database_sql+=Zipfile.getInstance().database_sql;
				Zipfile.getInstance().database_sql="";
			}
			
			//Only ROR
			if(Zipfile.getInstance().proyecto_zip=="Rails.zip"){
				Zipfile.getInstance().migrationHead="class CreateTable"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length)+" < ActiveRecord::Migration \n"+"def self.up \n  create_table "+'"'+nombre+'", '+":force => true do |t| \n";
				Zipfile.getInstance(). migrationHead+=Zipfile.getInstance().migrationBody+"end \n end \n def self.down \n  drop_table "+'"'+nombre+'"'+"\n  end \n end \n";
				Zipfile.getInstance().Date_Today=new Date().fullYear.toString()+(new Date().month+1).toString()+new Date().date.toString()+new Date().getHours().toString()+new Date().getMinutes().toString()+new Date().getSeconds().toString()+Zipfile.getInstance().migrationcant.toString();
				Zipfile.getInstance().add_file("db/migrate/"+Zipfile.getInstance().Date_Today+"_create_table_"+nombre+".rb",Zipfile.getInstance().migrationHead);
				Zipfile.getInstance().migrationcant++;
			}
			
			
		}
		
		
		public function Main_Mxml():void
		{
			
			Zipfile.getInstance().MainApp='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<s:Application  xmlns="Views.*" xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark" xmlns:mx="library://ns.adobe.com/flex/mx">'+" \n"+'<mx:TabNavigator change="App.getInstance().GET_LIST(Header)" id="Header" x="10" y="22" width="98%" height="95%">'+" \n"+ Zipfile.getInstance().MainApp;
			Zipfile.getInstance().MainApp+="</mx:TabNavigator>"+" \n";
			Zipfile.getInstance().MainApp+="<fx:Script>"+" \n";
			Zipfile.getInstance().MainApp+="          <![CDATA["+" \n";
			Zipfile.getInstance().MainApp+="         import Clases.App;"+" \n";
			Zipfile.getInstance().MainApp+="       ]]>"+" \n";
			Zipfile.getInstance().MainApp+=" </fx:Script>"+"\n"+'</s:Application>';
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/"+Zipfile.getInstance().proyecto_name+".mxml",Zipfile.getInstance().MainApp);
			Database.getInstance().dbStatement.removeEventListener(SQLEvent.RESULT, Zipfile.getInstance().Result_build_MainMXML);
			
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/.actionScriptProperties",IDEComponentes.getInstance().Create_Flex_ActionScript_Properties(Zipfile.getInstance().proyecto_name));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/.flexProperties",IDEComponentes.getInstance().Create_Flex_Properties());
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/.project",IDEComponentes.getInstance().Create_Proyect_Flex(Zipfile.getInstance().proyecto_name));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/libs/","");
			Zipfile.getInstance().open();
		}
		
		
		public function init_value():void
		{
			
			Zipfile.getInstance().canvasdatagrid='<s:NavigatorContent id="OutputsObjects" x="0" y="0"  width="98%" height="98%" >'+"\n";
			Zipfile.getInstance().DataGridposx=20;
			Zipfile.getInstance().datagridHead='<mx:DataGrid horizontalScrollPolicy="auto" id="datos" x="'+ Zipfile.getInstance().DataGridposx+'" y="46" width="98%" height="85%" >'+"\n"+"<mx:columns>"+"\n";
			Zipfile.getInstance().canvascomponente='<s:NavigatorContent id="InputsObjects" creationComplete="App.getInstance().SET_CANVAS_COMPLETE();" x="0" y="0"  width="98%" height="98%" >'+"\n"+"<mx:Form x='0' y='0' width='100%' height='100%'>"+"\n";
			Zipfile.getInstance().HeadService="";
			Zipfile.getInstance().setupdate="";
			Zipfile.getInstance().migrationBody="";
			Zipfile.getInstance().validate="";
			Zipfile.getInstance().posx=10;
			Zipfile.getInstance().posy=20;
			Zipfile.getInstance().sw=0;
			Zipfile.getInstance().relaciones_mxml_form="";
			Zipfile.getInstance().count_mxml_form=2;
			Zipfile.getInstance().helper_class_name="";
		}
		
		
		
		public function Build_Html_Template(name:String):String
		{
			var cadena:String="";
			cadena='<html lang="en">'+"\n";
			cadena+="<head>"+"\n";
			cadena+='<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'+"\n";
			cadena+='<link rel="stylesheet" type="text/css" href="history/history.css" />'+'\n';
			cadena+='<title></title>';
			cadena+='<script src="AC_OETags.js" language="javascript"></script>'+"\n";
			cadena+='<script src="history/history.js" language="javascript"></script>'+"\n"
			cadena+='<style>'+"\n";
			cadena+='body { margin: 0px; overflow:hidden }'+"\n";
			cadena+='</style>'+"\n";
			cadena+='<script language="JavaScript" type="text/javascript">'+"\n";
			cadena+='var requiredMajorVersion = 9;'+"\n";
			cadena+='var requiredMinorVersion = 0;'+"\n";
			cadena+='var requiredRevision = 28;'+"\n";
			cadena+='</script>'+"\n";
			cadena+='</head>'+"\n";
			cadena+='<body scroll="no">'+"\n";
			cadena+='<script language="JavaScript" type="text/javascript">'+"\n";
			cadena+='var hasProductInstall = DetectFlashVer(6, 0, 65);'+"\n";
			cadena+='var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);'+"\n\n\n";
			cadena+='if ( hasProductInstall && !hasRequestedVersion ) {'+"\n";
			cadena+='var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";'+"\n";
			cadena+='var MMredirectURL = window.location;'+"\n";
			cadena+='  document.title = document.title.slice(0, 47) + " - Flash Player Installation";'+"\n";
			cadena+=' var MMdoctitle = document.title;'+"\n";
			cadena+='AC_FL_RunContent('+"\n";
			cadena+='"src", "playerProductInstall",'+"\n";
			cadena+='"FlashVars", "MMredirectURL="'+'+MMredirectURL+'+"'&MMplayerType='"+'+MMPlayerType+'+"'&MMdoctitle='"+' +MMdoctitle+"",'+"\n";
			cadena+='"width", "100%",'+"\n";
			cadena+='"height", "100%",'+"\n";
			cadena+='"align", "middle",'+"\n";
			cadena+='"id", "'+name+'",'+"\n";
			cadena+='"quality", "high",'+"\n";
			cadena+='"bgcolor", "#869ca7",'+"\n";
			cadena+='"name", "'+name+'",'+"\n";
			cadena+='"allowScriptAccess","sameDomain",'+"\n";
			cadena+='"type", "application/x-shockwave-flash",'+"\n";
			cadena+='"pluginspage", "http://www.adobe.com/go/getflashplayer"'+"\n";
			cadena+=');'+"\n";
			cadena+='} else if (hasRequestedVersion) {'+"\n";
			cadena+='AC_FL_RunContent('+"\n";
			cadena+='"src", "'+name+'",'+"\n";
			cadena+='"width", "100%",'+"\n";
			cadena+='"height", "100%",'+"\n";
			cadena+='"align", "middle",'+"\n";
			cadena+='"id", "'+name+'",'+"\n";
			cadena+='"quality", "high",'+"\n";
			cadena+='"bgcolor", "#869ca7",'+"\n";
			cadena+='"name", "'+name+'",'+"\n";
			cadena+='"allowScriptAccess","sameDomain",'+"\n";
			cadena+='"type", "application/x-shockwave-flash",'+"\n";
			cadena+='"pluginspage", "http://www.adobe.com/go/getflashplayer"'+"\n";
			cadena+=');'+"\n";
			cadena+='} else {  '+"\n";
			cadena+="  var alternateContent ="+"'Alternate HTML content should be placed here.'"+"\n";
			cadena+="	+ 'This content requires the Adobe Flash Player. '"+"\n"
			cadena+=" 	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';"+"\n"
			cadena+=' document.write(alternateContent);  // insert non-flash content'+"\n";
			cadena+='}'+"\n";
			cadena+='</script>'+"\n";
			cadena+='<noscript>'+"\n";
			cadena+='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+"\n";
			cadena+='id="'+name+'" width="100%" height="100%"'+"\n";
			cadena+='codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">'+"\n";
			cadena+='<param name="movie" value="'+name+'.swf" />'+"\n";
			cadena+='<param name="quality" value="high" />'+"\n";
			cadena+='<param name="bgcolor" value="#869ca7" />'+"\n";
			cadena+='<param name="allowScriptAccess" value="sameDomain" />'+"\n";
			cadena+='<embed src="'+name+'.swf" quality="high" bgcolor="#869ca7"'+"\n";
			cadena+='width="100%" height="100%" name="'+name+'" align="middle"'+"\n";
			cadena+='play="true"'+"\n";
			cadena+='loop="false"'+"\n";
			cadena+='quality="high"'+"\n";
			cadena+='allowScriptAccess="sameDomain"'+"\n";
			cadena+='type="application/x-shockwave-flash"'+"\n";
			cadena+='pluginspage="http://www.adobe.com/go/getflashplayer">'+"\n";
			cadena+='</embed>'+"\n";
			cadena+='</object>'+"\n";
			cadena+='</noscript>'+"\n";
			cadena+='</body>'+"\n";
			cadena+='</html>'+"\n";
			return cadena;
		}
		
		
		
	}
}
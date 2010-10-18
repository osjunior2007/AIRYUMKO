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


		public function Create_ControllerAndModels(name:String,name_modelo:String,user_database:String,password_database:String,id_modulo:String,sw:int):void
		{
			//PhpActiveRecoreds
			if( Zipfile.getInstance().proyecto_zip=="amfphp.zip"){

				if(Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_components,id_modulo)==false){
				 Zipfile.getInstance().add_file("amfphp/services/"+name+"Controller.php",ActiveRecords.getInstance().set_controllador(name));
				}else{
			     Zipfile.getInstance().add_file("amfphp/services/"+name+"Controller.php",ActiveRecords.getInstance().set_controllador_relation(name, Get_All_Modoule_Elements(Zipfile.getInstance().list_components,id_modulo)));
				}

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


		public function CREATE_MAIN_VIEW_TAB(id_modulo:String,name_componente:String,name:String):void
		{
			if(Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_relaciones,id_modulo)==false){
				Zipfile.getInstance().view_path+="xmlns:"+name.toLowerCase()+'="Views.'+name.substr(0,1).toLocaleUpperCase()+ name.substr(1,name.length).toString()+'.*"'+"\n";
				Zipfile.getInstance().MainApp+='<s:NavigatorContent label="'+name+'" width="100%" height="100%" >'+"\n";
				Zipfile.getInstance().MainApp+='<'+name.toLowerCase()+':'+name.substr(0,1).toLocaleUpperCase()+ name.substr(1,name.length).toString()+'Index  width="100%" height="100%"   />'+" \n";
				Zipfile.getInstance().MainApp+='</s:NavigatorContent>'+" \n"+" \n";
			}
		}
		
		public function CREATE_INDEX_MXML(id:String,nombre:String,list_components:Array):String
		{
		   var cadena:String="";
		  if(IF_MODULO_RELATION(id)==0){
		   cadena+='<s:Group xmlns:'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+'="Views.'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'.*"'+'\n';   
           cadena+='xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n"; 
           cadena+='xmlns:s="library://ns.adobe.com/flex/spark"'+"\n";  
           cadena+='xmlns:mx="library://ns.adobe.com/flex/mx"'+"\n";  
           cadena+='width="100%" height="100%">'+"\n";  
           cadena+='<mx:ViewStack    x="0" y="0" id="'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'View" width="100%" height="100%">'+"\n";
           cadena+='<s:NavigatorContent   x="0" y="0"  width="98%" height="98%" >'+"\n";
           cadena+=CREATE_DATAGRID(id,list_components);
           cadena+='<mx:Button   id="NewBtn" label="Crear" enabled="true" width="86" x="20" y="{datos.height+50}" />'+"\n";
           cadena+='<mx:Button   id="ShowBtn" label="Update" enabled="true" width="86" x="116" y="{datos.height+50}" />'+"\n";
	       cadena+='<mx:Button   id="DeleteBtn" label="Delete" enabled="true" width="86" x="212" y="{datos.height+50}" />'+"\n";
           cadena+='</s:NavigatorContent>'+"\n";
           cadena+='<s:NavigatorContent   x="0" y="0"  width="98%" height="98%" >'+"\n";
           cadena+='<'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+':'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'Form id="'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'Form"/>'+"\n";
           cadena+='</s:NavigatorContent>'+"\n";
           cadena+='</mx:ViewStack>'+"\n";
           cadena+='</s:Group>'+"\n";
          }else{
           cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";  
           cadena+='<s:Group xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n";  
		   cadena+=' xmlns:s="library://ns.adobe.com/flex/spark"'+"\n"; 
		   cadena+=' xmlns:mx="library://ns.adobe.com/flex/mx"'+"\n";   
		   cadena+=' xmlns:'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+'="Views.'+nombre.substr(0,1).toUpperCase()+nombre.substr(1,nombre.length-2)+'.*">'+"\n"; 
	       cadena+='<fx:Declarations>'+"\n"; 
		   cadena+='<s:TitleWindow id="windows_'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+'" title="'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+'" width="100%" height="100%" >'+"\n"; 
           cadena+=' <'+nombre.substr(0,1).toLocaleLowerCase()+nombre.substr(1,nombre.length-2)+':'+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+'Form/>'+"\n"; 
           cadena+='</s:TitleWindow>	'+"\n"; 	
	       cadena+='</fx:Declarations>'+"\n"; 
           cadena+=CREATE_DATAGRID_WITH_OPTION(id,list_components);
	       cadena+='<mx:Button id="btn_add"  top="{datos.height+5}" left="0" label="Add" />'+"\n"; 
	       cadena+='<mx:Button id="btn_update" top="{datos.height+5}" left="80" label="Update" />'+"\n"; 
           cadena+='</s:Group>'+"\n"; 
          }
		  return cadena;
	  }
		
		


		public function CREATE_VIEW(id:String,nombre:String,list_components:Array):void
		{   var cadena:String="";
			if(Zipfile.getInstance().list_components!=null){
			   IDEComponentes.getInstance().posx=IDEComponentes.getInstance().posx+15;
				if(IF_CONTAIN_COMPONENTS(id)==1)
				{
                //Create Index Mxml
                 Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"/"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"Index.mxml",CREATE_INDEX_MXML(id,nombre,list_components));
                 //Create Form Mxml
                  cadena="";
                  cadena+='<s:Group  '+CREATE_VIEW_PATH(id,nombre,list_components)+"\n";
                  cadena+='xmlns:fx="http://ns.adobe.com/mxml/2009" ' + "\n";
                  cadena+=' xmlns:s="library://ns.adobe.com/flex/spark"'+"\n";
                  cadena+=' xmlns:mx="library://ns.adobe.com/flex/mx"  width="100%" height="100%">'+"\n";
                  cadena+='<mx:Form  visible="true" width="100%">'+"\n";
		          cadena+=CREATE_FORM(id,nombre,list_components);
             	  cadena+="<mx:FormItem >"+"\n";             	  
             	  cadena+="<s:HGroup>"+"\n";
			      cadena+='  <mx:Button  id="submitBtn" label="Create" enabled="true" width="86" x="25" y="20" />'+"\n";
			      cadena+='  <mx:Button  id="updateBtn" label="Update" enabled="true" width="86" x="121" y="20" />'+"\n";
			       if (IF_MODULO_RELATION(id)==0){
			      cadena+='  <mx:Button id="backlBtn" label="Atras" />'+"\n";
			      }
			     
			      cadena+='</s:HGroup>'+"\n";
		          cadena+='</mx:FormItem>'+"\n";
	              cadena+='</mx:Form>'+"\n";
                  cadena+='</s:Group>'+"\n";
                  Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"/"+nombre.substr(0,1).toLocaleUpperCase()+nombre.substr(1,nombre.length-2)+"Form.mxml",cadena);
            	}
			}//If not is null

		}
		
		
       public function IF_MODULO_RELATION(id:String):int
		{
			var sw:int=0;
			var i:int=0;
			while(i<=Zipfile.getInstance().list_relaciones.length-1&&sw==0){
				if(Zipfile.getInstance().list_relaciones[i].modulo_relacionado==id){
					sw=1;
				}
				i++;
			}

			return sw;
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
		
		
		public function CREATE_FORM(id:String,nombre:String,list_components:Array):String
		{
		   var sw:int=0;
		   var cadena:String="";
		   
		   for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
				   if(list_components[i].componente_id!="5"){
				   	cadena+=IDEComponentes.getInstance().CREATE_COMPONENTS(list_components[i].componente_id,list_components[i].identificador,list_components[i].etiqueta,list_components[i].tamano,list_components[i].tipo,list_components[i].requerido,list_components[i].tipo_relacion,list_components[i].modulo_relacionado,id)+"\n";
		           }else{
		            cadena+='<mx:FormItem label="'+list_components[i].etiqueta+'" width="100%">'+"\n";
		 	        cadena+='<'+list_components[i].etiqueta.substr(0,1).toLocaleLowerCase()+list_components[i].etiqueta.substr(1,list_components[i].etiqueta.length-2)+':'+list_components[i].etiqueta.substr(0,1).toLocaleUpperCase()+list_components[i].etiqueta.substr(1,list_components[i].etiqueta.length-2)+'Index  width="100%" height="100%" />'+"\n";
			        cadena+='</mx:FormItem>'+"\n";
		           }  
		        }
		     }
		    return cadena;
		}
		
		
		public function CREATE_VIEW_PATH(id:String,nombre:String,list_components:Array):String
		{
		   var sw:int=0;
		   var cadena:String="";
		   
		   for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
				   if(list_components[i].componente_id=="5"){
				    cadena+='xmlns:'+list_components[i].etiqueta.substr(0,1).toLocaleLowerCase()+list_components[i].etiqueta.substr(1,list_components[i].etiqueta.length-2)+'="Views.'+list_components[i].etiqueta.substr(0,1).toLocaleUpperCase()+list_components[i].etiqueta.substr(1,list_components[i].etiqueta.length-2)+'.*"'+"\n"	
		           }  
		        }
		     }
		    return cadena;
		}
		
		
		
		public function CREATE_DATAGRID_WITH_OPTION(id:String,list_components:Array):String
		{
		  	var sw:int=0;
		  	var cadena:String="";
		  	
		   cadena+='<mx:DataGrid top="0"  horizontalScrollPolicy="auto" id="datos"  width="100%" height="150" >'+"\n"
           cadena+='<mx:columns>'+"\n"
		   cadena+='<mx:DataGridColumn   dataField="options" width="25" headerText=" " editable="false">'+"\n"
		   cadena+=' <mx:itemRenderer>'+"\n"
		   cadena+='  <fx:Component>'+"\n"
		   cadena+='    <mx:CheckBox selected="{(data.options =='+" 'true')"+'?true:false}" click="{data.options = (data.options !='+" 'true') ? 'true' : 'false';}"+' " >'+"\n"
		   cadena+='   </mx:CheckBox>'+"\n"
		   cadena+='  </fx:Component>'+"\n"
		   cadena+=' </mx:itemRenderer>'+"\n"
		   cadena+='</mx:DataGridColumn>'+"\n"
		
			for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
				   if(list_components[i].componente_id!="5"){
			  	    cadena+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
				    }	
			 		
				}	
			}
		    cadena+='</mx:columns>'+"\n"
            cadena+=' </mx:DataGrid>'+"\n"
			return cadena;	
		}
		
		
		public function CREATE_DATAGRID(id:String,list_components:Array):String
		{
		  	var sw:int=0;
		  	var cadena:String="";
		  	
		   cadena+='<mx:DataGrid   horizontalScrollPolicy="auto" id="datos" x="20" y="46" width="95%" height="85%" >'+"\n"
           cadena+='<mx:columns>'+"\n"
		  	
			for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
				   if(list_components[i].componente_id!="5"){
			  	    cadena+=IDEComponentes.getInstance().Crear_Column_DataGrid(list_components[i].etiqueta,list_components[i].identificador,list_components[i].tamano);
				    }	
			 		
				}	
			}
		    cadena+='</mx:columns>'+"\n"
            cadena+=' </mx:DataGrid>'+"\n"
			return cadena;	
		}
		



		public function CREATE_SQL_MIGRATION(id:String,nombre:String,list_components:Array):void
		{
			var sw:int=0;
			var sql_relations:String="";
			for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id){
					sw=1;
					 
				    
					if(Zipfile.getInstance().proyecto_zip=="amfphp.zip"){
						if(list_components[i].tipo_relacion=="0"&&list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
							Zipfile.getInstance().database_sql+=IDEComponentes.getInstance().Create_database_sql(list_components[i].identificador,list_components[i].componente_id,list_components[i].tamano);
						}
						//Relation Many to Many
						if(list_components[i].tipo_relacion=="2"&&list_components[i].identificador!="id"&&list_components[i].identificador!="ID"){
						  sql_relations=IDEComponentes.getInstance().Create_database_sql("id_"+list_components[i].identificador,"8","5");
						  sql_relations+=IDEComponentes.getInstance().Create_database_sql("id_"+nombre.toLowerCase(),"8","5");
						  list_components[i].identificador=list_components[i].identificador.substr(0,1).toLowerCase()+list_components[i].identificador.substr(1,list_components[i].identificador.length-1);
						   sql_relations="CREATE TABLE"+"`"+nombre.substring(0,nombre.length-1).toLowerCase()+"_"+list_components[i].identificador+"` ("+"\n"+"`id` bigint(11) NOT NULL AUTO_INCREMENT,"+"\n"+sql_relations;
				          sql_relations+="PRIMARY KEY (`id`)"+" \n"+")"+"ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;"+"\n"+"\n";
				          Zipfile.getInstance().Head_database_sql+=sql_relations;
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
		
		public function CREATE_BEANS_MEDIATORS(mediators_name:String):void
		{
		 	var cadena:String="";
		   cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
           cadena+='<swiz:BeanLoader xmlns:mx="http://www.adobe.com/2006/mxml"'+"\n";
	       cadena+='xmlns:swiz="http://swiz.swizframework.org"'+"\n";
	       cadena+='xmlns:mediators="Controllers.*">'+"\n";
	       cadena+=mediators_name;
	       cadena+="</swiz:BeanLoader>"+"\n";
	       Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Beans.mxml",cadena);
				
		 	
		}
		


		public function CREATE_MAIN_VIEW_APPLICATION():void
		{
            //Create the  Bean application
			Zipfile.getInstance().MainApp='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<s:Application  xmlns="Views.*"'+'\n'+Zipfile.getInstance().view_path+' xmlns:fx="http://ns.adobe.com/mxml/2009" '+'\n'+' xmlns:s="library://ns.adobe.com/flex/spark" '+'\n'+' xmlns:mx="library://ns.adobe.com/flex/mx" width="100%" height="100%">'+" \n"+'<mx:TabNavigator   x="10" y="22" width="100%" height="100%">'+" \n"+ Zipfile.getInstance().MainApp;
			Zipfile.getInstance().MainApp+="</mx:TabNavigator>"+" \n"+"</s:Application>";
	        Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/MainView.mxml",Zipfile.getInstance().MainApp);
			
			//create the main view
		    Zipfile.getInstance().MainApp='<?xml version="1.0" encoding="utf-8"?>'+"\n"; 
		    Zipfile.getInstance().MainApp+='<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml"'+"\n"; 
		    Zipfile.getInstance().MainApp+='xmlns:swiz="http://swiz.swizframework.org" xmlns:views="Views.*">'+"\n";
			Zipfile.getInstance().MainApp+='<swiz:SwizConfig'+"\n";
			Zipfile.getInstance().MainApp+='strict="true"'+"\n";
			Zipfile.getInstance().MainApp+='mediateBubbledEvents="true"'+"\n";
			Zipfile.getInstance().MainApp+='viewPackages="Views"'+"\n";
			Zipfile.getInstance().MainApp+='injectionEvent="preinitialize"'+"\n";
			Zipfile.getInstance().MainApp+='beanLoaders="{ [ Beans ] }" />'+"\n";
			Zipfile.getInstance().MainApp+='<views:MainView id="mainView" />'+"\n";
			Zipfile.getInstance().MainApp+='</mx:Application>'+"\n";
		    Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/"+Zipfile.getInstance().proyecto_name+".mxml",Zipfile.getInstance().MainApp);
			//////////////////////////////////
			
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
			Zipfile.getInstance().datagridHead+='<mx:DataGridColumn visible="false" width="110" headerText="id" dataField="id"/>'+"\n";
			Zipfile.getInstance().setupdate="";
			Zipfile.getInstance().migrationBody="";
			Zipfile.getInstance().validate="";
			Zipfile.getInstance().posx=10;
			Zipfile.getInstance().posy=20;
			Zipfile.getInstance().sw=0;
			Zipfile.getInstance().relaciones_mxml_form="";
			Zipfile.getInstance().count_mxml_form=2;
			Zipfile.getInstance().helper_class_name="";
			Zipfile.getInstance().Relation_Remote_name="";
			Zipfile.getInstance().XmlParamert="";
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

		public function Get_All_Modoule_Elements(list_components:Array,id_modulo:String):String
		{
		  var cadena:String="";
		  for(var i:int=1;i<=list_components.length-1;i++){
				if(list_components[i].id_modulo==id_modulo){
				cadena+=list_components[i].identificador+",";
				}
		  }
		  return cadena.substr(0,cadena.length-1);
		}



	}
}
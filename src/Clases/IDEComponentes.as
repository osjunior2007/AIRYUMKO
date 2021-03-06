package Clases
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	public class IDEComponentes
	{
		private static var instancia:IDEComponentes;
		public var posx:int=10;
		public var posy:int=20;
		public var RequeriedEfecctCanvas:int=1;
	    [Bindable] public var EfecctCanvas:ArrayCollection = new ArrayCollection([{showEffect:"WipeDown", hideEffect:"WipeUp"}]);
		public var HeadCanvas:String='<?xml version="1.0" encoding="utf-8"?>\n<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300">'
		public var MainCanvas:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Application  xmlns="Componentes.*" xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">'+" \n"+'<mx:TabNavigator x="10" y="22" width="98%" height="95%">'+" \n";
       public var last_modulo_insert:String="";
		
		public function IDEComponentes()
		{
			
		}
		
	
		  public static function getInstance():IDEComponentes
		{
			if( instancia==null ) 
			instancia = new IDEComponentes();
			return instancia;
		}
		
		public function Crear_campo_de_texto(idenficador:String,longitud:String,restricion:int,pass:int,requiredtype:String):String
		{ var cadena:String="";
		 if(pass==0){
		  cadena='  <mx:TextInput width="350" x="'+(posx)+'" y="'+posy+'"';
		 }else{
		  cadena='  <mx:TextInput displayAsPassword="true" width="350" x="'+(posx)+'" y="'+posy+'"';	
		 }
		 cadena+=" ";
	      	cadena+='id="Att_'+idenficador.toLowerCase()+'" '+'maxChars="'+longitud+'"';
	      	if(restricion==0){
	      	 cadena+=' restrict="0-9"'	
	      	 }
	      	 if(requiredtype=="true"){
	      	 cadena+=' name="required"'		
	      	 }
	      cadena+=' />'	 
	      return cadena; 	
		}
		
		
		public function Crear_Fecha(idenficador_Boton:String,Entrada:String):String
		{ var cadena:String="";
		  cadena='  <mx:DateValidator source="{'+Entrada+'}" property="text" allowedFormatChars="/" trigger="{'+idenficador_Boton+'}" triggerEvent="click"/>';
	       return cadena; 	
		}
		
		
	   public function Crear_Text_Area(idenficador:String,longitud:String):String
		{ var cadena:String="";
		 cadena='  <mx:TextArea id="Att_'+idenficador.toLowerCase()+'" height="120" width="350" x="'+(posx)+'" y="'+posy+'" '+ 'maxChars="'+longitud+'"';
		 cadena+=' />'	 
	      return cadena; 	
		}
		
		public function Crear_CheckBox(idenficador:String):String
		{ var cadena:String="";
		 cadena='  <mx:CheckBox id="Att_'+idenficador.toLowerCase()+'" x="'+(posx)+'" y="'+posy+'"';
		 cadena+=' />'	 
	      return cadena; 	
		}
		
		public function Crear_label(texto:String):String
		{ 
		 return '  <mx:Label text="'+texto+'" x="'+posx+'" y="'+posy+'" />'; 	
		}
		
		public function Crear_Button(texto:String,id:String,action:String,posx:String,posy:String,enabled:String):String
		{
			return '  <mx:Button click="'+action+'" id="'+id+'" label="'+texto+'" enabled="'+enabled+'" width="86" x="'+posx+'" y="'+posy+'" />';
		}
		

		public function Crear_Column_DataGrid(etiqueta:String,dato:String,longitud:int):String
		{
			return '<mx:DataGridColumn width="110" headerText="'+etiqueta+'" dataField="'+dato.toLowerCase()+'"/>'+"\n";
		}
		
			
	    public function Head_RemoteObject(name:String):String
		{
		   var cadena:String="";
		   cadena+='<mx:RemoteObject showBusyCursor="true" endpoint="{App.getInstance().AMFurl}" id="amf" source="'+name+'Controller" destination="amfphp">'+"\n";
		   cadena+='<mx:method name="index" result="{'+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length-2)+'Helper.getInstance().List(event,datos);}"  fault="{App.getInstance().REQUEST_FAULT(event);}"/>'+"\n";
		   cadena+='<mx:method name="create" result="{App.getInstance().SUCCESS_REQUEST(event);}" fault="{'+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length-2)+'Helper.getInstance().REQUEST_FAULT(event);}"/>'+"\n";
		   cadena+='<mx:method name="update" result="{App.getInstance().SUCCESS_REQUEST(event);}"  fault="{'+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length-2)+'Helper.getInstance().REQUEST_FAULT(event);}"/>'+"\n";
		   cadena+=' <mx:method name="destroy" result="{App.getInstance().SUCCESS_REQUEST(event);}" fault="{'+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length-2)+'Helper.getInstance().REQUEST_FAULT(event);}"/>'+"\n";
		   cadena+='</mx:RemoteObject>'+"\n";
           return cadena;
		}
		

		
		public function Create_migration(nombre:String,tipo:String,tamano:String):String
		{
			var cadena:String="";
			if(tipo=="0"||tipo=="4"){
				cadena+=" t.column :"+nombre.toLowerCase()+", :string, :limit => "+tamano+"\n";
			}
			
			if(tipo=="1"){
				cadena+=" t.column :"+nombre.toLowerCase()+", :text, :limit => "+tamano+"\n";
			}
			
			if(tipo=="2"){
				cadena+=" t.column :"+nombre.toLowerCase()+", :datetime \n";
			}
			
			return cadena;
		}
		
		
			public function Create_database_sql(nombre:String,tipo:String,tamano:String):String
		{
			var cadena:String="";
			if(tipo=="0"||tipo=="4"){
				cadena+="`"+nombre.toLowerCase()+"` varchar ("+tamano+") DEFAULT NULL,"+"\n";
			}
			
			if(tipo=="1"){
				cadena+="`"+nombre.toLowerCase()+"` text,"+"\n";
			}
			
			if(tipo=="2"){
				cadena+="`"+nombre.toLowerCase()+"` datetime DEFAULT NULL,"+" \n";
			}
			//Boolean
			if(tipo=="3"){
				cadena+="`"+nombre.toLowerCase()+"` tinyint(1) DEFAULT NULL,"+" \n";
			}
			//Float
			if(tipo=="5"){
				cadena+="`"+nombre.toLowerCase()+"` double DEFAULT NULL,"+" \n";
			}
			//Decimal
			if(tipo=="6"){
				cadena+="`"+nombre.toLowerCase()+"` decimal ("+tamano+",0) DEFAULT NULL,"+" \n";
			}
				//Char
			if(tipo=="7"){
				cadena+="`"+nombre.toLowerCase()+"` char ("+tamano+") DEFAULT NULL,"+" \n";
			}
			//int
			if(tipo=="8"){
				cadena+="`"+nombre.toLowerCase()+"` int ("+tamano+") DEFAULT NULL,"+" \n";
			}
			//date
			if(tipo=="9"){
				cadena+="`"+nombre.toLowerCase()+"` date NULL,"+" \n";
			}
         return cadena;
		}
		
		
		public function Validation(idenficador:String):String
		{
			return "<mx:Validator requiredFieldError='"+idenficador.toLowerCase()+" is required' id='reqValid_"+idenficador.toLowerCase()+"' required='true' source='{Att_"+idenficador.toLowerCase()+"}' property='text' valid='App.getInstance().handleValid(event,Att_"+idenficador.toLowerCase()+")' invalid='App.getInstance().handleValid(event,Att_"+idenficador.toLowerCase()+")'/> \n";
		}
		
		public function Create_Script(name:String):String
		{
			var cadena:String="";
			cadena+='<fx:Script>'+"\n";
			cadena+='<![CDATA['+"\n";
			cadena+="  import mx.controls.Alert;"+"\n";
			cadena+="  import mx.events.ValidationResultEvent;"+"\n";
			cadena+="  import Clases.App;"+"\n";
            cadena+="  import Controllers."+name+"Controller;"+"\n";
		    cadena+="  import Helpers."+name+"Helper;"+"\n";
			cadena+= Zipfile.getInstance().helper_class_name;
		    return cadena+"]]>"+"\n"+"</fx:Script>"+"\n";
		}
		
		public function database_yml (database:String,usuario:String,contrasena:String):String
		{  var cadena:String="";
			cadena+="development:"+"\n";
			cadena+=" adapter: mysql"+"\n";
			cadena+=" encoding: utf8"+"\n";
			cadena+=" database: "+database+"_development"+"\n";
			cadena+=" username: "+usuario+"\n";
			cadena+=" password: "+contrasena+"\n";
			cadena+=" host: localhost"+"\n\n\n";
			
			cadena+="test:"+"\n";
			cadena+=" adapter: mysql"+"\n";
			cadena+=" encoding: utf8"+"\n";
			cadena+=" database: "+database+"_test"+"\n";
			cadena+=" username: "+usuario+"\n";
			cadena+=" password: "+contrasena+"\n";
			cadena+=" host: localhost"+"\n";
			
			cadena+="production:"+"\n";
			cadena+=" adapter: mysql"+"\n";
			cadena+=" encoding: utf8"+"\n";
			cadena+=" database: "+database+"_production"+"\n";
			cadena+=" username: "+usuario+"\n";
			cadena+=" password: "+contrasena+"\n";
			cadena+=" host: localhost"+"\n";
	        return cadena;
		}
		
		public function Create_migrate(tabla_nombre:String):String
		{   var cadena:String="";
			cadena="class Create"+tabla_nombre+" < ActiveRecord::Migration \n end";
			return "";
		}
		
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public function construir_arbol(proyectos:ArrayCollection):String
            {
                 var datostree:String="<node label='App'>"+"\n";
                 for(var i:int=0;i<=proyectos.length-1;i++){
                  datostree+="<node label='Vista'><node label='"+proyectos[i]+".mxml'/></node>";
                  datostree+="<node label='Modelo'><node label='"+proyectos[i]+".erb'/></node>";
                  datostree+="<node label='Controlador'><node label='"+proyectos[i]+".erb'/></node>";
                 }
                 datostree+="</node>";
                return datostree;
            }
            
       public function CREATE_COMPONENTS(id_componente:String,nombre:String,etiqueta:String,tamano:String,tipodato:int,requiredtype:String,tipo_relacion:String,modulo_relacionado:String,id_modulo:String):String
              {
              	 
                var modulo:String="";
               if(id_componente=="0"){
              	  modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n";
				  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0,requiredtype)+'\n';	
              	  modulo+="</mx:FormItem>"+"\n";
              	 }
              	 
              	 if(id_componente=="1"){
              	  modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n";
				  modulo+=IDEComponentes.getInstance().Crear_Text_Area(nombre,tamano)+'\n';	
              	  modulo+="</mx:FormItem>"+"\n"
              	 }	
              	 
              	  if(id_componente=="3"){
              	   modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n";
				   modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0,requiredtype)+'\n';	
				   modulo+=IDEComponentes.getInstance().Crear_Fecha("agregar",nombre)+'\n';	
	               modulo+="</mx:FormItem>"+"\n"
              	  }	
              	 
              	if(id_componente=="4"){
              	  modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n";
				  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,1,requiredtype)+'\n';	
              	  modulo+="</mx:FormItem>"+"\n"
              	 }
              	 if(id_componente=="5"){
              	 	 if (tipo_relacion=="1"){
		          	   modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n"
		          	   modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0,requiredtype)+'\n';	
              	       modulo+=Crear_Button(nombre,"BtN_"+nombre,"action","","","true")+'\n';	
              	       modulo+="</mx:FormItem>"+"\n";
		          	  }	
		          	 if (tipo_relacion=="2"){
   	                    modulo+="<mx:FormItem  label='"+etiqueta+"'>"+"\n";
		          	    modulo+='<mx:DataGrid horizontalScrollPolicy="auto" id="relacion_'+Zipfile.getInstance().get_modulo_name(modulo_relacionado)+'"  width="{View_01.width-110}" height="150" >'+"\n"+"<mx:columns>"+"\n";
              	        modulo+='<mx:DataGridColumn   dataField="options" width="25" headerText=" " editable="false">'+"\n";
                        modulo+='<mx:itemRenderer>'+"\n";
                        modulo+='<fx:Component>'+"\n";
                        modulo+='<mx:CheckBox selected="'+"{(data.options == 'true')?true:false}"+'"'+' click="{data.options ='+" (data.options != 'true') ? 'true' : 'false';} "+'" >'+"\n";
                        modulo+='</mx:CheckBox>'+"\n";
                        modulo+='</fx:Component>'+"\n";
                        modulo+='</mx:itemRenderer>'+"\n";
                        modulo+=' </mx:DataGridColumn>'+"\n";
                        modulo+=Crear_Datagrid_Relationes(modulo_relacionado);
              	        modulo+="</mx:columns>"+"\n";
              	        modulo+="</mx:DataGrid>"+"\n";
              	        modulo+='<mx:Button click="{'+etiqueta.substr(0,1).toUpperCase()+etiqueta.substr(1,etiqueta.length-2)+'Helper.getInstance().Get_Elements_Relation(this)}"/>'+"\n";
              	        modulo+="</mx:FormItem>"+"\n";
              	   	  }	
		          	  if (tipo_relacion=="3"){
		          	   modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n"
		          	   //modulo+=""Boton
              	       modulo+="</mx:FormItem>"+"\n";
		          	  }	
		          	  Zipfile.getInstance().relaciones_mxml_form+='<s:NavigatorContent label="'+nombre+'" width="100%" height="100%" >'+"\n";
				      Zipfile.getInstance().relaciones_mxml_form+='<'+nombre.toLowerCase().substr(0,nombre.length-1)+" creationComplete='"+nombre.substr(0,1).toString().toUpperCase()+nombre.substr(1,nombre.length-2)+"Helper.getInstance().Set_Root_Component(this)'" +' id="'+nombre+'"  width="98%" height="98%"  y="0" x="0" />'+" \n";
				      Zipfile.getInstance().relaciones_mxml_form+='</s:NavigatorContent>'+" \n";
				      //Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Helpers/"+nombre.substr(0,1).toString().toUpperCase()+nombre.substr(1,nombre.length-2)+"Helper.as",Helpers.getInstance().CREATE_HELPER(nombre.substr(0,1).toString().toUpperCase()+nombre.substr(1,nombre.length-2),modulo_relacionado));
					  Zipfile.getInstance().helper_class_name+="  import Helpers."+nombre.substr(0,1).toString().toUpperCase()+nombre.substr(1,nombre.length-2)+"Helper;"+"\n";
					  Zipfile.getInstance().count_mxml_form++;
		            
		           }
              	 
              	   if(id_componente=="6"){
              	    modulo+="<mx:FormItem label='"+etiqueta+"'>"+"\n";
				    modulo+=IDEComponentes.getInstance().Crear_CheckBox(nombre)+'\n';	
				    modulo+="</mx:FormItem>"+"\n"
				   }
              	 
              	 
                 return modulo;	
              }
              
		     
              public function buscar_componente(identificador:String,temp:ArrayCollection):int{
              	  var i:int=0;
              	  var sw:int=0;
                 	while(i<=temp.length-1&&sw==0){
              		   if(temp.getItemAt(i).nombre==identificador){
              		  sw=1;	
              		  }
              		 i++; 
                   }
                  return sw;
               }
               
               
                public function borrar_componente(dataset:DataGrid,temp:ArrayCollection,mensaje_eliminar:String):void
              {
                if(dataset.selectedIndex>=0){	 
              	 temp.removeItemAt(dataset.selectedIndex);
                 dataset.dataProvider=temp;
                }else{
                 Alert.show(mensaje_eliminar);	
                }
              }
              
              public function Crear_arbol(datos:Array):String
              {
               var datostree:String="<node label='Arbol'>";
                 if(datos!=null){	
               	   for(var i:int=0;i<=datos.length-1;i++)
                	  {
              	      datostree+="<node label='"+datos[i].name+"'  data='"+datos[i].id+"' />"	
              	      }  
              	      this.last_modulo_insert=datos[datos.length-1].id
                     datostree+="</node>";
                    return datostree;
                  }else{
               	   return "<node label='Arbol'><node label='App'/></node>";
                  }
              }
              
              public function Create_Proyect_Flex(nombre:String):String
              {
              	var cadena:String="";
              	cadena+='<?xml version="1.0" encoding="UTF-8"?>'+"\n";
                cadena+="<projectDescription>"+"\n";
	            cadena+="<name>"+nombre+"</name>"+"\n";
	            cadena+="<comment></comment>"+"\n";
	            cadena+="<projects>"+"\n";
	            cadena+="</projects>"+"\n";
	            cadena+="<buildSpec>"+"\n";
	   	        cadena+="<buildCommand>"+"\n";
			    cadena+="<name>com.adobe.flexbuilder.project.flexbuildercadena</name>"+"\n";
			    cadena+="<arguments>"+"\n";
			    cadena+="</arguments>"+"\n";
		        cadena+="</buildCommand>"+"\n";
	            cadena+="</buildSpec>"+"\n";
	            cadena+="<natures>"+"\n";
		        cadena+="<nature>com.adobe.flexbuilder.project.flexnaturecadena</nature>"+"\n";
		        cadena+="<nature>com.adobe.flexbuilder.project.actionscriptnaturecadena</nature>"+"\n";
	            cadena+="</natures>"+"\n";
                cadena+="</projectDescription>"+"\n";
        	    return cadena;
              }
              
              public function Create_Flex_Properties():String
              {
              	return '<?xml version="1.0" encoding="UTF-8"?><flexProperties flexServerType="0" toolCompile="true" useServerFlexSDK="false" version="1"/>';
              }
              public function Create_Flex_ActionScript_Properties(nombre:String):String
              {
              	var cadena:String="";
              	cadena+='<?xml version="1.0" encoding="UTF-8"?>'+"\n";
                cadena+='<actionScriptProperties mainApplicationPath="'+nombre+'.mxml" version="3">'+"\n";
                cadena+='<compiler additionalCompilerArguments="-locale en_US" copyDependentFiles="true" enableModuleDebug="true" flexSDK="Flex 4.5" generateAccessible="false"  htmlExpressInstall="true" htmlGenerate="true" htmlHistoryManagement="true" htmlPlayerVersion="10.1.0" htmlPlayerVersionCheck="true" outputFolderPath="bin-debug" sourceFolderPath="src" strict="true" useApolloConfig="false" verifyDigests="true" warn="true">'+"\n";
                cadena+="<compilerSourcePath/>"+"\n";
                cadena+='<libraryPath defaultLinkType="1">'+"\n";
                cadena+='<libraryPathEntry kind="4" path=""/>'+"\n";
                cadena+='<libraryPathEntry kind="1" linkType="1" path="libs"/>'+"\n";
                cadena+="</libraryPath>"+"\n";
                cadena+="<sourceAttachmentPath/>"+"\n";
                cadena+="</compiler>"+"\n";
                cadena+="<applications>"+"\n";
                cadena+='<application path="'+nombre+'.mxml"/>'+"\n";
                cadena+="</applications>"+"\n";
                cadena+="<modules/>"+"\n";
                cadena+="<buildCSSFiles/>"+"\n";
                cadena+="</actionScriptProperties>"+"\n";
                return cadena;
              }
              
              
              public function Crear_Datagrid_Relationes(modulo_relacionado:String):String
              {
              	var cadena:String="";
              	for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
				   if(Zipfile.getInstance().list_components[i].id_modulo==modulo_relacionado){
				   	  cadena+=IDEComponentes.getInstance().Crear_Column_DataGrid(Zipfile.getInstance().list_components[i].etiqueta,Zipfile.getInstance().list_components[i].identificador,Zipfile.getInstance().list_components[i].tamano);
				   }
              	}
              	return cadena;
              }
              
              
               public function Remote_Object_Relation(name:String):String
              {
              	var cadena:String="";
              	cadena+='<mx:RemoteObject showBusyCursor="true" endpoint="{App.getInstance().AMFurl}" id="relationship_'+name+'" source="'+name.substr(0,1).toUpperCase()+name.substr(1,name.length-1)+'Controller" destination="amfphp">'+"\n";
                cadena+='<mx:method name="index" result="{'+name.substr(0,1).toUpperCase()+name.substr(1,name.length-2)+'Helper.getInstance().List(event,relacion_'+name+');}"  fault="{App.getInstance().REQUEST_FAULT(event);}"/>'+"\n";
                cadena+='</mx:RemoteObject>'+"\n";
                Zipfile.getInstance().Relation_Remote_name+="     params['relationship_"+name+"'].index.send({});"+"\n";
              	return cadena;
              }
              
          
              
           
      }
}
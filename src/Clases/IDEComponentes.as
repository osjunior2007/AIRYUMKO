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
		public var HeadCanvas:String='<?xml version="1.0" encoding="utf-8"?>\n<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300">'
		public var MainCanvas:String='<?xml version="1.0" encoding="utf-8"?>'+" \n"+'<mx:Application  xmlns="Componentes.*" xmlns:mx="http://www.adobe.com/2006/mxml" layout="absolute">'+" \n"+'<mx:TabNavigator x="10" y="22" width="98%" height="95%">'+" \n";

		
		public function IDEComponentes()
		{
			
		}
		
	
		  public static function getInstance():IDEComponentes
		{
			if( instancia==null ) 
			instancia = new IDEComponentes();
			return instancia;
		}
		
		public function Crear_campo_de_texto(idenficador:String,longitud:String,restricion:int,pass:int):String
		{ var cadena:String="";
		 if(pass==0){
		  cadena='<mx:TextInput width="350" x="'+(posx+180)+'" y="'+posy+'"';
		 }else{
		   cadena='<mx:TextInput displayAsPassword="true" width="350" x="'+(posx+180)+'" y="'+posy+'"';	
		 }
		 cadena+=" ";
	      	cadena+='id="'+idenficador+'" '+'maxChars="'+longitud+'"';
	      	if(restricion==0){
	      	 cadena+=' restrict="0-9"'	
	      	 }
	      cadena+=' />'	 
	      return cadena; 	
		}
		
		
		public function Crear_Fecha(idenficador_Boton:String,Entrada:String):String
		{ var cadena:String="";
		  cadena='<mx:DateValidator source="{'+Entrada+'}" property="text" allowedFormatChars="/" trigger="{'+idenficador_Boton+'}" triggerEvent="click"/>';
	       return cadena; 	
		}
		
		
	   public function Crear_Text_Area(idenficador:String,longitud:String):String
		{ var cadena:String="";
		 cadena='<mx:TextArea height="120" width="350" x="'+(posx+180)+'" y="'+posy+'" '+ 'maxChars="'+longitud+'"';
		 cadena+=' />'	 
	      return cadena; 	
		}
		
		public function Crear_CheckBox(idenficador:String):String
		{ var cadena:String="";
		 cadena='<mx:CheckBox id="'+idenficador+'" x="'+(posx+180)+'" y="'+posy+'"';
		 cadena+=' />'	 
	      return cadena; 	
		}
		
		public function Crear_label(texto:String):String
		{ 
		 return '<mx:Label text="'+texto+'" x="'+posx+'" y="'+posy+'" />'; 	
		}
		
		public function Crear_Button(texto,id,action,posx,posy,enable):String
		{
			return '<mx:Button click="'+action+'" id="'+id+'" label="'+texto+'" enabled="'+enable+'" width="86" x="'+posx+'" y="'+posy+'" />';
		}
		

		public function Crear_Column_DataGrid(etiqueta:String,dato:String,longitud:int):String
		{
			return '<mx:DataGridColumn width="'+(longitud*10)+'" headerText="'+etiqueta+'" dataField="'+dato+'"/>'+"\n";
		}
		
	    public function Head_Http_service(nombre:String):String
		{
			var cadena:String="";
			nombre=nombre.substring(0,1).toUpperCase()+nombre.substring(1,nombre.length);
			cadena=' <mx:HTTPService id="ListRequest" url="http://localhost:3000/'+nombre+'s/list" useProxy="false" result="onJSONLoad(event,datos)" resultFormat="text"/>'+"\n";
			cadena+=' <mx:HTTPService id="DeleteRequest" result="ListRequest.send();" url="http://localhost:3000/'+nombre+'s/delete" useProxy="false"/>'+"\n";
			cadena+='<mx:HTTPService contentType="application/xml" id="CreateRequest" url="http://localhost:3000/'+nombre+'s/create" result="resul_create(event)" useProxy="false" method="POST">'+"\n"+'<mx:request xmlns="">'+"\n"+'<objetos>'+"\n";
			return cadena;
		}
		
		public function Http_service_Create(identificador:String):String
		{
			return '<'+identificador+'>{Att_'+identificador+'.text}</'+identificador+'>'+"\n";
		}
		
		public function Create_migration(nombre:String,tipo:String,tamano:String):String
		{
			var cadena:String="";
			if(tipo=="0"||tipo=="4"){
				cadena+=" t.column :"+nombre+", :string, :limit => "+tamano+"\n";
			}
			
			if(tipo=="1"){
				cadena+=" t.column :"+nombre+", :text, :limit => "+tamano+"\n";
			}
			
			if(tipo=="2"){
				cadena+=" t.column :"+nombre+", :datetime \n";
			}
			
			return cadena;
		}
		
		public function Validation(idenficador:String):String
		{
			return "<mx:Validator id='reqValid_"+idenficador+"' required='true' source='{Att_"+idenficador+"}' property='text' valid='handleValid(event)' invalid='handleValid(event)'/> \n";
		}
		
		public function Create_Script(nom_function:String,tabla:String,setupdate:String):String
		{
			var cadena:String="";
			cadena+='<mx:Script>'+"\n";
			cadena+='<![CDATA['+"\n";
			cadena+="import mx.controls.Alert"+"\n";
			cadena+="import mx.events.CloseEvent"+"\n";
			cadena+="import mx.events.DataGridEvent"+"\n";
			cadena+="import mx.events.DataGridEventReason"+"\n";
			cadena+="import mx.collections.ArrayCollection"+"\n";
			cadena+="import mx.rpc.events.ResultEvent"+"\n";
			cadena+="import mx.events.ValidationResultEvent"+"\n";
			cadena+="public var wiew_sw:Boolean=false"+"\n";
			cadena+="import com.adobe.serialization.json.JSON"+"\n";
			cadena+='[Bindable]private var dataArray:ArrayCollection;'+"\n"+'[Bindable]private var dataArray1:ArrayCollection;'+"\n";
			cadena+='private function onJSONLoad(event:ResultEvent,datos:DataGrid):void'+"\n";
			cadena+='{'+"\n";
			cadena+="dataArray = new ArrayCollection((JSON.decode(event.result as String))as Array)"+"\n";
			cadena+="dataArray1=new ArrayCollection();"+"\n";
			cadena+="for (var i:int=0;i<=dataArray.length-1;i++){"+"\n";
			cadena+="dataArray1.addItem(dataArray.getItemAt(i)."+tabla+");"+"\n";
			cadena+="}"+"\n";
			cadena+="datos.dataProvider=dataArray1;"+"\n";
			cadena+="}'"+"\n";
			cadena+="private function deleteHandler(event:Event):void"+"\n";
			cadena+="{"+"\n";
			cadena+='Alert.show("Are you sure you want to delete this item?", "Delete Item", 3, this,';
			cadena+="function(event:CloseEvent):void"+"\n";
			cadena+="{"+"\n";
			cadena+="if (event.detail==Alert.YES)"+"\n";
			cadena+="DeleteRequest.send({id: datos.selectedItem.id});"+"\n";
			cadena+="});"+"\n";
			cadena+="}"+"\n";
			
			cadena+=" private function updateHandler(event:Event) : void"+"\n";
			cadena+="{"+"\n";
			cadena+="View_01.selectedIndex=0;"+"\n";
			cadena+="ListRequest.send();"+"\n";
			cadena+="};"+"\n";
			
		    cadena+="public  function resul_create(event:ResultEvent):void"+"\n";
			cadena+="{"+"\n";
			cadena+='if(event.message.body.toString()=="0")'+"\n";
			cadena+="{"+"\n";
			cadena+="ListRequest.send();"+"\n";
			cadena+="View_01.selectedIndex=0;"+"\n";
			cadena+="clear_field();"+"\n";
			cadena+="}else{"+"\n";
			cadena+='Alert.show("No se pudo realizar la operación")';
			cadena+="}"+"\n";
			cadena+="}"+"\n";
			
			cadena+="\n public function clear_field():void { \n"+nom_function+"} \n";
			cadena+="\n public function set_update():void { \n  if(wiew_sw){"+setupdate+" } "+"\n"+ " }"+ " \n";
			cadena+="private function handleValid(eventObj:ValidationResultEvent):void {"+"\n";
			cadena+="if(eventObj.type==ValidationResultEvent.VALID){"+"\n";
			cadena+="submit.enabled = true;"+"\n";
			cadena+="updates.enabled = true;"+"\n";
			cadena+="}else{"+"\n";
			cadena+="submit.enabled = false;"+"\n";
			cadena+="updates.enabled= false;"+"\n";
			cadena+="}"+"\n"
			cadena+="}"+"\n";
			cadena+="\n  public function validate_id_update():void"+"\n";
			cadena+="{"+"\n";
			cadena+="if(datos.selectedIndex>=0){"+"\n";
			cadena+="View_01.selectedIndex=1"+"\n";
			cadena+="}else{"+"\n";
			cadena+="Alert.show('Seleccione un elemento..');"+"\n";
			cadena+="}"+"\n";
			cadena+="} \n";
			return cadena+"]]>"+"\n"+"</mx:Script>"+"\n";
		}
		
		public function database_yml (database:String,usuario:String,contrasena:String):String
		{  var cadena:String="";
			cadena+="development:"+"\n";
			cadena+="adapter: mysql"+"\n";
			cadena+="encoding: utf8"+"\n";
			cadena+="database: "+database+"_development"+"\n";
			cadena+="username: "+usuario+"\n";
			cadena+="password: "+contrasena+"\n";
			cadena+="host: localhost"+"\n\n\n";
			
			cadena+="test:"+"\n";
			cadena+="adapter: mysql"+"\n";
			cadena+="encoding: utf8"+"\n";
			cadena+="database: "+database+"_test"+"\n";
			cadena+="username: "+usuario+"\n";
			cadena+="password: "+contrasena+"\n";
			cadena+="host: localhost"+"\n";
			
			cadena+="production:"+"\n";
			cadena+="adapter: mysql"+"\n";
			cadena+="encoding: utf8"+"\n";
			cadena+="database: "+database+"_production"+"\n";
			cadena+="username: "+usuario+"\n";
			cadena+="password: "+contrasena+"\n";
			cadena+="host: localhost"+"\n";
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
            
       public function Crear_Mxml(id_componente:String,nombre:String,etiqueta:String,tamano:String,tipodato:int):String
              {
                var modulo:String="";
                modulo=IDEComponentes.getInstance().HeadCanvas+'\n';
                IDEComponentes.getInstance().posx=10;
		        IDEComponentes.getInstance().posy=20;
              	 if(id_componente=="1"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
				  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
				  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
              	 
              	 if(id_componente=="2"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';
				  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
				  modulo+=IDEComponentes.getInstance().Crear_Text_Area(nombre,tamano)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+130;	
              	 }	
              	 
              	  if(id_componente=="4"){
              	   modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';	
				   IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
              	   modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0)+'\n';	
				   IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
				   modulo+=IDEComponentes.getInstance().Crear_Fecha("agregar",nombre)+'\n';	
              	   IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	  }	
              	 
              	if(id_componente=="5"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';	
				  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
              	  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,1)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
              	 
              	 if(id_componente=="7"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';	
				  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+20;
              	  modulo+=IDEComponentes.getInstance().Crear_CheckBox(nombre)+'\n';	
				  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
                  modulo+='</mx:Canvas>';
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
              	      datostree+="<node label='"+datos[i].nombre+"' name_prural='"+datos[i].name_prural+"'  data='"+datos[i].id_modulo+"' />"	
              	      }  
                     datostree+="</node>";
                    return datostree;
                  }else{
               	   return "<node label='Arbol'><node label='App'/></node>";
                  }
              }
           
      }
}
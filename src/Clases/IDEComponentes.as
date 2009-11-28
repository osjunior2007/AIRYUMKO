package Clases
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.TextInput;
	public class IDEComponentes
	{
		private static var instancia:IDEComponentes;
		public var posx:int=10;
		public var posy:int=20;
		public var HeadCanvas:String='<?xml version="1.0" encoding="utf-8"?>\n<mx:Canvas xmlns:mx="http://www.adobe.com/2006/mxml" width="600" height="300">'
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
            
       public function crear_modulo(id_componente:String,nombre:String,etiqueta:String,tamano:String,tipodato:int,proyectos:ArrayCollection,Modulo_name:TextInput):String
              {
                var modulo:String="";
                modulo=IDEComponentes.getInstance().HeadCanvas+'\n';
              if(Modulo_name.text!=""){  
               if(!proyectos.contains(Modulo_name.text)){ 
                IDEComponentes.getInstance().posx=10;
		        IDEComponentes.getInstance().posy=20;
              	 if(id_componente=="1"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
              	  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
              	 
              	 if(id_componente=="2"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
              	  modulo+=IDEComponentes.getInstance().Crear_Text_Area(nombre,tamano)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+130;	
              	 }	
              	 
              	  if(id_componente=="4"){
              	   modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
              	   modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,0)+'\n';	
              	   modulo+=IDEComponentes.getInstance().Crear_Fecha("agregar",nombre)+'\n';	
              	   IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	  }	
              	 
              	if(id_componente=="5"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
              	  modulo+=IDEComponentes.getInstance().Crear_campo_de_texto(nombre,tamano,tipodato,1)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
              	 
              	 if(id_componente=="7"){
              	  modulo+=IDEComponentes.getInstance().Crear_label(etiqueta)+'\n';		
              	  modulo+=IDEComponentes.getInstance().Crear_CheckBox(nombre)+'\n';	
              	  IDEComponentes.getInstance().posy=IDEComponentes.getInstance().posy+30;	
              	 }
        
              	 proyectos.addItem(Modulo_name.text);
             	}else{
              	 Alert.show("ya esta");	
              	 }
              	}else{
              	 Alert.show("El nombre del modulo no puede ser nulo");	
              	}
                 modulo+='</mx:Canvas>';
                 Alert.show(modulo);
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
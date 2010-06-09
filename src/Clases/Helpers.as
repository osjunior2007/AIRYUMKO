package Clases
{
	//import mx.messaging.AbstractConsumer;
	import mx.controls.Alert;
	public class Helpers
	{
		
		private static var instancia:Helpers; 
		public function Helpers()
		{
		}
		
		
		public function CREATE_HELPER_BLANK(value:String):String
		{
		  var cadena:String="";
		  cadena="package Helpers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import Clases.App;"+"\n";
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+="import mx.utils.ArrayUtil;"+"\n";
          cadena+="import mx.messaging.ChannelSet;"+"\n";
          cadena+="import mx.messaging.channels.AMFChannel;"+"\n";
          cadena+="import mx.rpc.events.FaultEvent;"+"\n";
          cadena+="import mx.rpc.events.ResultEvent;"+"\n";
          cadena+="import mx.rpc.remoting.RemoteObject;"+"\n";
          cadena+="import mx.controls.DataGrid;"+"\n";
          cadena+="import mx.controls.Alert;"+"\n";
		  cadena+="import Helpers."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n"+"{"+"\n";
		  cadena+="     private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
		  cadena+="	 public var objeto:Object={};"+"\n";
		  cadena+="     public var group:Group;"+"\n";
		  cadena+="	 public var typeOperation:String=''"+"\n";
		  cadena+="     public var serilizacion:Array;"+"\n";
		  cadena+="     public var Root_Component:Group;"+"\n"+"\n";
		  cadena+=Helper_Instance(value)+"\n";
		  cadena+=Helper_Back_To_List()+"\n";
		  cadena+=HELPER_REMOTE_ACCESS()+"\n";
		  cadena+=HELPER_SET_CANVAS()+"\n";
		  cadena+=HELPER_GET_LIST()+"\n";
		  cadena+=HELPER_CREATE_BUTTON()+"\n";
		  cadena+=HELPER_REQUEST_FAULT()+"\n";
	      cadena+="  }"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}
		
	   
	   public function CREATE_HELPER(value:String,id:String):String
		{
	      Zipfile.getInstance().XmlParamert=Helpers.getInstance().HELPER_GET_ELEMENTS_RELATION(value,id);
		  var cadena:String="";
		  cadena="package Helpers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+="import mx.utils.ArrayUtil;"+"\n";
          cadena+="import mx.messaging.ChannelSet;"+"\n";
          cadena+="import mx.messaging.channels.AMFChannel;"+"\n";
          cadena+="import mx.rpc.events.FaultEvent;"+"\n";
          cadena+="import mx.rpc.events.ResultEvent;"+"\n";
          cadena+="import mx.rpc.remoting.RemoteObject;"+"\n";
          cadena+="import mx.controls.DataGrid;"+"\n";
          cadena+="import mx.controls.Alert;"+"\n";
		  cadena+="import Helpers."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n"+"{"+"\n";
		  cadena+="     private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
		  cadena+="	 public var objeto:Object={};"+"\n";
		  cadena+="     public var group:Group;"+"\n";
		  cadena+="	 public var typeOperation:String=''"+"\n";
		  cadena+="     public var serilizacion:Array;"+"\n";
          cadena+="     public var Root_Component:Group;"+"\n"+"\n";
		  cadena+=Helper_Set_Root_Component(value)+"\n";
		  cadena+=Helper_Back_Root_Component()+"\n";
		  cadena+=Helper_Instance(value)+"\n";
		  cadena+=Helper_Back_To_List()+"\n";
		  cadena+=HELPER_REMOTE_ACCESS()+"\n";
		  cadena+=HELPER_SET_CANVAS()+"\n";
		  cadena+=HELPER_GET_LIST()+"\n";
		  cadena+= Zipfile.getInstance().XmlParamert+"\n";
		  cadena+=HELPER_REQUEST_FAULT()+"\n";
	      cadena+="  }"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}
		
		public function Helper_Back_To_List():String
		{
	   	   var cadena:String=""
		   cadena+="    public function BACK_TO_LIST(params:Group):void"+"\n"+"     {"+"\n";
		   return cadena+"\n"+"       params['View_01'].selectedIndex=0;"+"\n"+CreateMVC.getInstance().Clear_Input+"\n"+"    }"+"\n\n";
	   		
		}
		
		
	    public function Helper_Set_Root_Component(value:String):String
		{
			var cadena:String=""
		    cadena+="    public function Set_Root_Component(Root_Component:Group):void"+"\n"+"     {"+"\n";
			return cadena+"\n"+"       this.Root_Component=Root_Component;"+"\n"+"     }"+"\n";
		}
		
		public function Helper_Back_Root_Component():String
		{
			var cadena:String=""
		    cadena+="    public function Back_Root_Component():void"+"\n"+"     {"+"\n";
			return cadena+"\n"+"       this.Root_Component['View_01'].selectedIndex=1;"+"\n"+"     }"+"\n";
		}
			
		public function Helper_Instance(value:String):String
		{
			var cadena:String="";
			cadena+="    public static function getInstance():"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
		    cadena+="    {"+"\n";
			cadena+="        if( instancia==null )"+"\n";
			cadena+="         instancia = new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper();"+"\n"
			cadena+="         return instancia;"+"\n";
		    cadena+="    }"+"\n";
		    return cadena;

		}	
		
		public function HELPER_REMOTE_ACCESS():String
		{
			var cadena:String=""
		    cadena+="    public function REMOTE_ACCESS(tipo:String,objeto:Object):void"+"\n"+"     {"+"\n";
			cadena+="       this.typeOperation=tipo;"+"\n";
			cadena+='       if(tipo=="index"){'+"\n";
			cadena+="	         this.group['amf'].index.send();"+"\n";
			cadena+="         }"+"\n";
			cadena+="      }"+"\n";
			return  cadena;
		 }
		 
		 
		  public function HELPER_SET_CANVAS():String
		  {
		  	  var cadena:String=""
		      cadena+="    public function SET_CANVAS(group:Group):void"+"\n";
		      cadena+="     { "+"\n";
		      cadena+="        this.group=group;"+"\n";
		      cadena+="        REMOTE_ACCESS('index',{});"+"\n";
		      cadena+="     } "+"\n";
		      return cadena; 
		  }
		  
		  
		  public function HELPER_GET_LIST():String
		  {
		  	var cadena:String=""
		  	cadena+="    public function List(e:ResultEvent,datos:DataGrid):void"+"\n";
	        cadena+="     {"+"\n";
		  	cadena+="       serilizacion=new Array();"+"\n";
		    cadena+="       for (var i:String in ArrayUtil.toArray(e.result)){"+"\n";
			cadena+="         serilizacion.push(ArrayUtil.toArray(e.result)[i][0]);"+"\n";
		    cadena+="        }"+"\n";
		    cadena+="        datos.dataProvider=serilizacion;"+"\n";
		    cadena+="     } "+"\n";
		    return cadena;
		  }
		  
		  public function  HELPER_REQUEST_FAULT():String
		  {
		   var cadena:String="";
		   cadena+="    public function REQUEST_FAULT(e:FaultEvent):void"+"\n";
		   cadena+="     {"+"\n";
		   cadena+="       Alert.show(String (e.fault.faultDetail),'Error');"+"\n";
		   cadena+="     } "+"\n";
		   return cadena;
		  }
		  
	
		  public function HELPER_CREATE_BUTTON():String
		  {
		   var cadena:String="";
		   cadena+=" public function Create_Button(params:Group):void"+"\n";
           cadena+=" { ";
     	   cadena+="   params['View_01'].selectedIndex=1;"+"\n";
     	   cadena+=Zipfile.getInstance().Relation_Remote_name;
           cadena+="}"+"\n";
		   return cadena;	
		  }
		  
		  public function HELPER_GET_ELEMENTS_RELATION(name:String,id:String):String
		  {
		  	var cadena:String="";
		  	var etiquetas:String="";
		   for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
				if(Zipfile.getInstance().list_components[i].id_modulo==id){
					 if(Zipfile.getInstance().list_components[i].componente_id!="5"){
					   if(Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_components,Zipfile.getInstance().list_components[i].id_modulo)==true){
					      etiquetas+="         cadena+='<"+Zipfile.getInstance().list_components[i].etiqueta+">'"+"+params['relacion_"+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].id_modulo)+"'].dataProvider.getItemAt(i)."+Zipfile.getInstance().list_components[i].etiqueta+"+'</"+Zipfile.getInstance().list_components[i].etiqueta+">'"+"\n";	
		                  }
		              }
		           }
		        }
		       cadena="    public function Get_Elements_Relation(params:Group):String {"+"\n";
		       cadena+='        var cadena:String="";'+"\n"; 
		       cadena+='        cadena+='+'"'+'<'+name+'>'+'";'+"\n";
               cadena+="        for(var i:int=0;i<=params['relacion_"+name.substr(0,1).toUpperCase()+name.substr(1,name.length)+"s'].dataProvider.length-1;i++){"+"\n";
		       cadena+="        if(params['relacion_"+name.substr(0,1).toUpperCase()+name.substr(1,name.length)+"s'].dataProvider.getItemAt(i).options=='true'){"+"\n";
		       cadena+='         cadena+='+'"'+'<values>'+'";'+"\n";
		       cadena+=             etiquetas;
		       cadena+='         cadena+='+'"'+'</values>'+'";'+"\n";
		       cadena+="         }"+"\n";
		       cadena+="        }"+"\n";
               cadena+='        cadena+='+'"'+'</'+name+'>'+'"'+"\n";
		       cadena+="       return cadena;"+"\n";
		       cadena+="   } ";
		      return cadena;
		  }
		  
			 
		public static function getInstance():Helpers
		{
			if( instancia==null ) 
				instancia = new Helpers();
			return instancia;
		}
		

	}
}
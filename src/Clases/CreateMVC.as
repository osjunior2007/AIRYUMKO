package Clases
{
	public class CreateMVC
	{
		import mx.controls.Alert;
	    private static var instancia: CreateMVC;
	    public var Clear_Input:String="";
     	public function CreateMVC()
		{
		}


		public function MVC_Controller_Create(value:String,relations:String):String
		{
		 var cadena:String=""
		 cadena+="    public function Create(params:Group):void"+"\n";
		 cadena+="     {"+"\n";
		 cadena+="         var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model=new "+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model(params);"+"\n";
		 cadena+="         "+relations;
		 cadena+="         "+value.toLocaleLowerCase()+".Save();"+"\n";
		 cadena+="     }";
		 return cadena;
		}
		
		public function MVC_Controller_Update(value:String,relations:String):String
		{
		 var cadena:String=""
		 cadena+="    public function Update(params:Group):void"+"\n";
		 cadena+="     {"+"\n";
		 cadena+="         var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model=new "+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model(params);"+"\n";
		 cadena+="         "+relations;
		 cadena+="         "+value.toLocaleLowerCase()+".Update();"+"\n";
		 cadena+="     }";
		 return cadena;
		}
		
		
		public function MVC_Controller_Destroy(value:String):String
		{
		 var cadena:String=""
		 cadena+="    public function Destroy(params:Group):void"+"\n";
		 cadena+="     {"+"\n";
		 cadena+="         var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model=new "+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"Model(params);"+"\n";
		 cadena+="         "+value.toLocaleLowerCase()+".Destroy("+value.toLocaleLowerCase()+".id);"+"\n";
		 cadena+="     }";
		 return cadena;
		}


		public function MVC_Controller_List(value:String):String
		{
		  return "";
		}

		public function MVC_Controller_Init(value:String):String
		{
		  var cadena:String=""	
		  cadena+="    public function "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller()"+"\n";
		  cadena+="     {"+"\n"
		  cadena+="     }";
		  return cadena;
		}

		public function CREATE_CONTROLLER(value:String,id:String):String
		{
		  var cadena:String="";
		  var relations:String="";
		  var name:String="";
		  var import_library:String="";
		
	    	for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
  			  if(Zipfile.getInstance().list_components[i].id_modulo==id){
  			  	if(Zipfile.getInstance().list_components[i].componente_id=="5"){
  			  	   name=Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado);
  			  	   name=name.substr(0,1).toUpperCase()+name.substr(1,name.length-2);
  			        if(i==1){
  			        relations="       "+value.toLocaleLowerCase()+"."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+"=Helpers."+name+"Helper.getInstance().Get_Elements_Relation(params);"+"\n";
  			  	    import_library="    import Helpers."+name+"Helper;"+"\n";
  			  	   }else{
  			  	    relations+="       "+value.toLocaleLowerCase()+"."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+"=Helpers."+name+"Helper.getInstance().Get_Elements_Relation(params);"+"\n";
  			  	    import_library+="import Helpers."+name+"Helper;"+"\n";
  			  	  }
  			  	}
  			  }
  			} 
  		  cadena="package Controllers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+=import_library;
		  cadena+="import Models."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller"+"\n"+"{"+"\n";
		  cadena+=" private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller"+"\n";
		  cadena+=MVC_Controller_Init(value)+"\n";
		  cadena+=MVC_Controller_List(value)+"\n";
		  cadena+=MVC_Controller_Create(value,relations)+"\n";
		  cadena+=MVC_Controller_Update(value,relations)+"\n";
		  cadena+=MVC_Controller_Destroy(value)+"\n";
		  cadena+=MVC_Controller_Instance(value)+"\n";
		  cadena+="}"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}



		public function MVC_Controller_Instance(value:String):String
		{
			var cadena:String="";
			cadena+="    public static function getInstance():"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller"+"\n";
		    cadena+="     {"+"\n";
			cadena+="        if( instancia==null )"+"\n";
			cadena+="         instancia = new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller();"+"\n"
			cadena+="         return instancia;"+"\n";
		    cadena+="     }"+"\n";
		    return cadena;

		}

		//////////////////////////////////////////////////////////////////////////////////////

		public function CREATE_MODEL(value:String,id:String):String
		{
		  var cadena:String="";
		  var Global_Variables:String='     public var id:String=""'+"\n";	
		  var Create_Object:String="";
		  Clear_Input="";
		  var Init_Input:String="";
		  var name_model:String="";
	
 		for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
  			  if(Zipfile.getInstance().list_components[i].id_modulo==id){
  				if(i==1){
  				    if(Zipfile.getInstance().list_components[i].componente_id=="5"){
  			          Global_Variables+="     public var "+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+':String="";'+"\n";
	  			      Create_Object+="this.Objeto."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+""+"=this."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+"\n";
		            }else{
	  				 Init_Input="this."+Zipfile.getInstance().list_components[i].etiqueta+"=params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text"+"\n";
	  				 Global_Variables+="     public var "+Zipfile.getInstance().list_components[i].etiqueta+':String="";'+"\n";
	  				 Create_Object="this.Objeto."+Zipfile.getInstance().list_components[i].etiqueta+"=this."+Zipfile.getInstance().list_components[i].etiqueta+""+"\n";
		             Clear_Input="       params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text='';"+"\n";
	  			    }
  				}else
  				{
	  			   if(Zipfile.getInstance().list_components[i].componente_id=="5"){
	  			       Global_Variables+="     public var "+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+':String="";'+"\n";
	  				   Create_Object+="this.Objeto."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+""+"=this."+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+"\n";
		            }else{
	  			     Init_Input+="this."+Zipfile.getInstance().list_components[i].etiqueta+"=params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text"+"\n";
	  				 Global_Variables+="     public var "+Zipfile.getInstance().list_components[i].etiqueta+':String="";'+"\n";
	  				 Create_Object+="this.Objeto."+Zipfile.getInstance().list_components[i].etiqueta+"=this."+Zipfile.getInstance().list_components[i].etiqueta+""+"\n";
		             Clear_Input+="       params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text='';"+"\n";
	  			     }
  			 	}
  			  }
  		    }
  		    cadena+="package Models "+"\n"+"{"+"\n";
  		    cadena+="import spark.components.Group;"+"\n";
	        cadena+="import mx.controls.Alert;"+"\n";
		    cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model"+"\n"+"{"+"\n";
		    cadena+="     public var Objeto:Object={};"+"\n"+"     public var params:Group;"+"\n";
		    cadena+=Global_Variables;
		    cadena+=Model_Init(value,Init_Input);
		    cadena+=Model_Save(Create_Object);
		    cadena+=Model_Update(Create_Object);
		    cadena+=Model_Destroy();
		    cadena+="  }"+"\n"
		    cadena+="}";
		    return cadena;
		}


		public function Model_Save(value:String):String
		{
		 var cadena:String="";
		 cadena+="    public function Save():void"+"\n";
		 cadena+="    {"+"\n";
		 cadena+="     "+value;
		 cadena+="     this.params['amf'].create.send(this.Objeto);"+"\n";
		 cadena+="    }"+"\n";
		 return cadena; 
		}
		
		public function Model_Update(value:String):String
		{
		 var cadena:String="";
		 cadena+="    public function Update():void"+"\n";
		 cadena+="    {"+"\n";
		 cadena+="     "+value;
		 cadena+="     this.params['amf'].update.send(this.Objeto);"+"\n";
		 cadena+="    }"+"\n";
		 return cadena; 
		}
		
		public function Model_Destroy():String
		{
		 var cadena:String="";
		 cadena+="    public function Destroy(id:String):void"+"\n";
		 cadena+="    {"+"\n";
		 cadena+="     this.Objeto={}"+"\n"
		 cadena+="     this.Objeto.id=id;"+"\n";
		 cadena+="     this.params['amf'].destroy.send(this.Objeto);"+"\n";
		 cadena+="    }"+"\n";
		 return cadena; 
		}

		public function Model_Init(name:String,value:String):String
		{
		 var cadena:String="";
		 cadena+="    public function "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+"Model(params:Group)"+"\n";
		 cadena+="    {"+"\n";
		 cadena+="      "+value;
		 cadena+="    }"+"\n";
		 return cadena
		}




		public static function getInstance():CreateMVC
		{
			if( instancia==null )
				instancia = new CreateMVC();
			return instancia;
		}

	}
}
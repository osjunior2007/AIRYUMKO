package Clases
{
	public class CreateMVC
	{
		import mx.controls.Alert;
	    private static var instancia: CreateMVC;

		public function CreateMVC()
		{
		}


		public function MVC_Controller_Create(value:String):String
		{
		 var cadena:String=""
		 cadena+="public function Create(params:Group):void"+"\n"+" {"+"\n";
		 return cadena+"\n"+"   var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"=new "+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"(params);"+"\n"+value+".Save();"+"\n"+"\n"+"}";
		}

		public function MVC_Controller_Update(value:String):String
		{
			var cadena:String=""
		    cadena+="public function Update(params:Group):void"+"\n"+" {"+"\n";
			return cadena+"\n"+"   var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"=new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"(params);"+"\n"+value+".Update();"+"\n"+"\n"+"}";;
		}

		public function MVC_Controller_Destroy(value:String):String
		{
			var cadena:String=""
		    cadena+="public function Destroy(params:Group):void"+"\n"+" {"+"\n";
			return cadena+"\n"+"   var "+value.toLocaleLowerCase()+":"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"=new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"(params);"+"\n"+value+".Destroy("+value+".id);"+"\n"+"\n"+"}";;
		}

		public function MVC_Controller_List(value:String):String
		{
		  return "";
		}

		public function MVC_Controller_Init(value:String):String
		{
		  return "public function "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller()"+"\n"+"{"+"\n"+"}"+"\n";
		}

		public function CREATE_CONTROLLER(value:String):String
		{
		  var cadena:String="";
		  cadena="package Controllers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import Models."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+";"+"\n";
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+="import Controllers."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller"+"\n"+"{"+"\n";
		  cadena+=MVC_Controller_Init(value)+"\n";
		  cadena+=MVC_Controller_List(value)+"\n";
		  cadena+=MVC_Controller_Create(value)+"\n";
		  cadena+=MVC_Controller_Update(value)+"\n";
		  cadena+=MVC_Controller_Destroy(value)+"\n";
		  cadena+=MVC_Controller_Instance(value)+"\n";
		  cadena+="}"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}



		public function MVC_Controller_Instance(value:String):String
		{
			var cadena:String="";
			cadena+="public static function getInstance():"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller"+"\n";
		    cadena+="{"+"\n";
			cadena+="    if( instancia==null )"+"\n";
			cadena+="     instancia = new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller();"+"\n"
			cadena+="      return instancia;"+"\n";
		    cadena+="}"+"\n";
		    return cadena;

		}

		//////////////////////////////////////////////////////////////////////////////////////

		public function CREATE_MODEL(value:String,id:String):String
		{
		  var cadena:String="";
		  var Global_Variables:String="";
		  var Create_Object:String="";
		  var Clear_Input:String="";
		  var Init_Input:String="";
		  var name_model:String="";
			for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
  				if(Zipfile.getInstance().list_components[i].id_modulo==id){
  				 Global_Variables+="       public var "+Zipfile.getInstance().list_components[i].etiqueta+':String="";'+"\n";
  				 Create_Object+="          this.Objeto."+Zipfile.getInstance().list_components[i].etiqueta+"=this."+Zipfile.getInstance().list_components[i].etiqueta+""+"\n";
	             Clear_Input+="            params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text='';"+"\n";
  				 Init_Input+="             this."+Zipfile.getInstance().list_components[i].etiqueta+"=params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text"+"\n";
  				}
  		    }
  		    cadena+="package Models "+"\n"+"{"+"\n";
	        cadena+="import spark.components.Group;"+"\n"+"import mx.controls.Alert;"+"\n";
		    cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+" "+"\n"+"{"+"\n";
		    cadena+="   public var Objeto:Object={};"+"\n"+"   public var params:Group;"+"\n";
		    cadena+=Global_Variables;
		    cadena+=Model_Init(value,Init_Input);
		    cadena+=Model_Save(Create_Object);
		    cadena+=Model_Update(Create_Object);
		    cadena+=Model_Update(Create_Object);
		    cadena+=Model_Destroy();
		    cadena+=Model_Clear_Form(Clear_Input);
		    cadena+="}"+"\n"+"}";
		    return cadena;
		}


		public function Model_Save(value:String):String
		{
		 return "       public function Save():void {"+"\n"+value+"      this.params['amf'].create.send(this.Object);"+"\n"+"    }"+"\n";
		}

		public function Model_Update(value:String):String
		{
		 return "       public function Update():void {"+"\n"+value+"    this.params['amf'].update.send(this.Objeto);"+"\n"+"   }"+"\n";
		}

		public function Model_Destroy():String
		{
		 return "       public function Destroy(id:String):void {"+"\n"+"     this.Objeto={}"+"\n"+"    this.Objeto.id=id;"+"\n"+"    this.params['amf'].destroy.send(this.Objeto);"+"\n"+"      }"+"\n";
		}

		public function Model_Clear_Form(value:String):String
		{
		 return "   public function Clear_Form():void {"+"\n"+value+"\n"+"   }"+"\n";
		}

		public function Model_Init(name:String,value:String):String
		{
		 return "       public function "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+" (params:Group) {"+"\n"+value+"\n"+"   }"+"\n";
		}




		public static function getInstance():CreateMVC
		{
			if( instancia==null )
				instancia = new CreateMVC();
			return instancia;
		}

	}
}
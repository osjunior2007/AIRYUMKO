package Clases
{
	public class Helpers
	{
		
		private static var instancia:Helpers; 
		
		public function Helpers()
		{
		}
		
			
			public function Helper_Instance(value:String):String
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
		
		
		
		public function CREATE_HELPER(value:String,id:String):String
		{
		  var cadena:String="";
		  var Clear_Input:String="";
	      var Dinamic_Component:String="";
		  if (Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_relaciones,id)==true)
		   {
				for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
	  				if(Zipfile.getInstance().list_components[i].id_modulo==id){
	  				  Clear_Input+="            params['Att_"+Zipfile.getInstance().list_components[i].etiqueta+"'].text='';"+"\n";
	  				}
	  				
	  			  if (Zipfile.getInstance().Verificar_Modulo_Relacion(Zipfile.getInstance().list_relaciones,id)==true)
			       {
			       	  Dinamic_Component+=BuildMxmlComponets.getInstance().DINAMIC_COMPONENTS(Zipfile.getInstance().list_components[i].etiqueta,Zipfile.getInstance().list_components[i].componente_id)
			       }
	  		     }
	  	   
			      cadena="package Helpers"+"\n";
				  cadena+="{"+"\n";
				  cadena+="import spark.components.Group;"+"\n";
				  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n"+"{"+"\n";
				  cadena+=" private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
				  cadena+=Helper_Instance(value)+"\n";
			      cadena+=Model_Clear_Form(Clear_Input);
				  cadena+=Create_Dinamic_Form(Dinamic_Component);
				  cadena+="}"+"\n";
				  cadena+="}"+"\n";
		   }
  		  return cadena;
		}

		
		public function Model_Clear_Form(value:String):String
		{
		 return "   public function Clear_Form():void {"+"\n"+value+"\n"+"   }"+"\n";
		}
		
		public function Create_Dinamic_Form(form:String):String
		{
	      return "       public  function Create_Attributes(Root_VBox:VGroup):void  {"+"\n"+BuildMxmlComponets.getInstance().CREATE_DINAMIC_BOX()+"\n\n"+form+"\n";
		}
		
		public static function getInstance():Helpers
		{
			if( instancia==null ) 
				instancia = new Helpers();
			return instancia;
		}
		

	}
}
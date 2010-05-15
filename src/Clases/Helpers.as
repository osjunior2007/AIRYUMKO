package Clases
{
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
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+="import Helpers."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n"+"{"+"\n";
		  cadena+=" private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
		  cadena+=Helper_Instance(value)+"\n";
	      cadena+="  }"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}
		
	   
	   public function CREATE_HELPER(value:String):String
		{
		  var cadena:String="";
		  cadena="package Helpers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import spark.components.Group;"+"\n";
		  cadena+="import Helpers."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper;"+"\n";
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n"+"{"+"\n";
		  cadena+=" private static var instancia: "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Helper"+"\n";
		  cadena+="  public var Root_Component:Group;"+"\n"+"\n";
		  cadena+=Helper_Set_Root_Component(value)+"\n";
		  cadena+=Helper_Back_Root_Component()+"\n";
		  cadena+=Helper_Instance(value)+"\n";
	      cadena+="  }"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
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
			return cadena+"\n"+"       this.Root_Component['View_01'].selectedIndex=0;"+"\n"+"     }"+"\n";
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
       			
		
		public static function getInstance():Helpers
		{
			if( instancia==null ) 
				instancia = new Helpers();
			return instancia;
		}
		

	}
}
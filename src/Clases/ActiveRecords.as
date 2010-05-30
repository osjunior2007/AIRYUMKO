package Clases
{
	import mx.controls.Alert;
	public class ActiveRecords
	{
		private static var instancia:ActiveRecords; 
		public var cadena:String="";
		public var Controlador_nombre:String="";
		public var Modelo_nombre:String="";
	
		 public static function getInstance():ActiveRecords
		{
			if( instancia==null ) 
			instancia = new ActiveRecords();
			return instancia;
		}
		
		  public function metodo_list(nombre:String):String
		{ 
			cadena="function index() {"+'\n';
			cadena+=" return amf("+nombre.substr(0,nombre.length-1)+"::find(all));"+'\n'; 
            cadena+="}"+'\n';
            return cadena;
           
		}
		
		
		 public function metodo_list_relation(nombre:String,attribute:String):String
		{ 
			cadena=" function index($param) {"+'\n';
			cadena+=' if ($param[type]=="all") {'+'\n';
			cadena+="   return amf("+nombre.substr(0,nombre.length-1)+"::find(all));"+'\n'; 
            cadena+=" }else{"+'\n';
            cadena+="   return amf("+nombre.substr(0,nombre.length-1)+"::find(all,array('select' "+'=> "'+" 'false' as options,"+attribute+""+'")));'+'\n';
            cadena+=" }"+'\n';
            cadena+="}"+'\n';
            return cadena;
      	}
		
        public  function metodo_Crear(nombre:String):String
		{ 
			cadena=" function create($param) {"+'\n';
			cadena+="$"+nombre.substr(0,nombre.length-1)+" = new "+nombre.substr(0,nombre.length-1)+"($param);"+'\n'; 
			cadena+="if ($"+nombre.substr(0,nombre.length-1)+"->is_valid()){"+'\n'; 
			cadena+="$"+nombre.substr(0,nombre.length-1)+"->save();"+'\n';
			cadena+='return 0;';
			cadena+="}else{"+'\n';
			cadena+='return 1; '+"\n";
            cadena+="}"+"\n";
            cadena+="}";
            return cadena;
		 }
		 
		  public  function metodo_actualizar(nombre:String):String
		{ 
			cadena=" function update($param) {"+'\n';
			cadena+="$"+nombre.substr(0,nombre.length-1)+" = "+nombre.substr(0,nombre.length-1)+"::find_by_id($param[id]);"+'\n'; 
			cadena+="if ($"+nombre.substr(0,nombre.length-1)+"->is_valid()){"+'\n'; 
			cadena+="$"+nombre.substr(0,nombre.length-1)+"->update_attributes($param);"+'\n';
			cadena+="return 0; "+'\n';
			cadena+="}else{"+'\n';
			cadena+="return 1; "+'\n';
			cadena+="}"+'\n';
		    cadena+="}"+'\n';
            return cadena;
		 }
		  
	 public  function metodo_borrar(nombre:String):String
		{ 
			cadena="function destroy ($param) {"+'\n';
			cadena+="$"+nombre.substr(0,nombre.length-1)+" = "+nombre.substr(0,nombre.length-1)+"::find($param[id]);"+'\n'; 
			cadena+="if ($"+nombre.substr(0,nombre.length-1)+"->is_valid()){"+'\n'; 
			cadena+="$"+nombre.substr(0,nombre.length-1)+"->delete();"+'\n';
			cadena+="return 0; "+'\n';
			cadena+="}else{"+'\n';
			cadena+="return  1; "+'\n';
			cadena+="}"+'\n';
			cadena+="}"+'\n';
            return cadena;
		 }
		 
		  public function set_controllador(Controlador_nombre:String):String
		{
			var variableg:String=Controlador_nombre;
			Controlador_nombre="<?php"+'\n';
			Controlador_nombre+='include("lib/database.php");'+'\n';
			Controlador_nombre+="class "+variableg+"Controller {"+'\n\n'; 
			Controlador_nombre+=metodo_list(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_Crear(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_borrar(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_actualizar(variableg)+'\n\n\n'; 
			Controlador_nombre+="}"+'\n';
			cadena+="?>"+'\n';
			return Controlador_nombre;
		}
		
		  public function set_controllador_relation(Controlador_nombre:String,attribute:String):String
		{
			var variableg:String=Controlador_nombre;
			Controlador_nombre="<?php"+'\n';
			Controlador_nombre+='include("lib/database.php");'+'\n';
			Controlador_nombre+="class "+variableg+"Controller {"+'\n\n'; 
			Controlador_nombre+=metodo_list_relation(variableg,attribute)+'\n\n\n'; 
			Controlador_nombre+=metodo_Crear(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_borrar(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_actualizar(variableg)+'\n\n\n'; 
			Controlador_nombre+="}"+'\n';
			cadena+="?>"+'\n';
			return Controlador_nombre;
		}
		
		public function set_modelo(modelo:String):String
		{
		   modelo=modelo.substring(0,1).toUpperCase()+modelo.substring(1,cadena.length)
		   Modelo_nombre="<?php"+'\n\n';
		   Modelo_nombre+="class "+modelo+" extends ActiveRecord\\\Model"+'\n';
		   Modelo_nombre+="{"+'\n\n';
		   Modelo_nombre+=" static $table_name = '"+modelo+"s';"+"\n";
		   Modelo_nombre+="}"+'\n\n';
		   Modelo_nombre+="?>";
		   return Modelo_nombre;
		}
		
		public function Data_Base(name:String,user:String,pass:String):String
		{
		 cadena="<?php \n require_once ('ActiveRecord.php');\n\n"
		 cadena+="ActiveRecord\\\Config::initialize(function($cfg)"+"\n";
		 cadena+="{"+"\n";	
		 cadena+=" $cfg->set_model_directory('models');"+"\n";	
		 cadena+="$cfg->set_connections(array('development' => 'mysql://"+user+":@127.0.0.1/"+name+"'));"+"\n\n";
		 cadena+="});"+"\n\n";	
		 cadena+=" function amf($sMessage) {"+"\n";	
		 cadena+="  $cant=0;"+"\n";	
		 cadena+="  $array = array();"+"\n";	
		 cadena+="  foreach($sMessage as $key )"+"\n";	
		 cadena+="    {"+"\n";	
		 cadena+="  $array[$cant]=array($key->attributes());"+"\n";	
		 cadena+="  $cant++;"+"\n";	
		 cadena+="     }"+"\n";	
		 cadena+="    return $array;"+"\n";	
		 cadena+="       }"+"\n\n\n";	
		 cadena+="    ?>"+"\n";		
		 return cadena;	
		}
		
		public function Create_Class_object(name:String,attibute:String):String
		{   
			cadena="package Clases"+"\n";
            cadena+="{"+"\n";   
		    cadena+="  import mx.collections.ArrayCollection;"+"\n";
		    cadena+="  import mx.containers.Canvas;"+"\n";
		    cadena+="  import mx.rpc.remoting.RemoteObject;"+"\n";
		    cadena+="  import mx.messaging.channels.AMFChannel;"+"\n";
		    cadena+="  import mx.rpc.remoting.RemoteObject;"+"\n";
	        cadena+="  import mx.utils.ArrayUtil;"+"\n\n"; 
	        cadena+="  import mx.rpc.events.ResultEvent;"+"\n";
            cadena+="  import mx.messaging.ChannelSet;"+"\n";

	        
            cadena+=" public class "+name+""+"\n";
		    cadena+="  {"+"\n\n"+" private static var instancia: "+name+";"+"\n";
	        cadena+="   private var serilizacion:Array=new Array();"+"\n";
	        cadena+="   public function "+name+"()"+"\n";
			cadena+="   {"+"\n";
			cadena+="   }"+"\n";
			cadena+=""+"\n";
            cadena+=" public function GET_LIST(e:ResultEvent,canvas:Canvas):void {"+"\n";
			cadena+="     serilizacion=new Array()"+"\n";
		    cadena+="     for (var i:String in ArrayUtil.toArray(e.result)){"+"\n";
	  	    cadena+="          serilizacion.push(ArrayUtil.toArray(e.result)[i][0]);"+"\n";
	        cadena+="       }"+"\n";
	        cadena+="        canvas['datos'].dataProvider=serilizacion;"+"\n";
	        cadena+="    }"+"\n";
	        cadena+="   public static function getInstance():"+name+""+"\n";
			cadena+="   {"+"\n";
			cadena+="   if( instancia==null )"+"\n";
			cadena+="     instancia = new "+name+"();"+"\n";
			cadena+="      return instancia;"+"\n";
			cadena+="     }"+"\n";
	        cadena+="   }"+"\n";
            cadena+=" }"+"\n";
			return cadena;
		}
		
		
	}
}



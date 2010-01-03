package Clases
{
	public class CakePHP
	{ 
		private static var instancia:CakePHP; 
		public var cadena:String="";
		public var Controlador_nombre:String="";
		public var Modelo_nombre:String="";
		
		public function CakePHP()
		{
		}
		
		public static function getInstance():CakePHP
		{
			if( instancia==null ) 
				instancia = new CakePHP();
			return instancia;
		}
		
		
		  public function metodo_list(nombre:String):String
		{ 
			cadena="var $name = 'Posts';"+'\n';
			cadena+="function index() {"+'\n';
			cadena+="$this->set('"+nombre+"', $this->Post->find('all'));"+'\n';  
            cadena+="}"+'\n';
            return cadena;
		}
		
		
        public  function metodo_Crear(nombre:String):String
		{ 
			
	        cadena=" function add()"+'\n';
			cadena+=" if (!empty($this->data)) {"+'\n'; 
			cadena+="   if ($this->"+nombre+"->save($this->data)) {"+'\n'; 
			cadena+="    }"+'\n';
			cadena+="  }"+'\n';
			cadena+="}"+'\n';
            return cadena;
		 }
		 
		  public  function metodo_borrar(nombre:String):String
		{ 
			cadena="def delete"+'\n';
			cadena+="@"+nombre+" = "+nombre.substr(0,nombre.length-1)+".find(params[:id])"+'\n'; 
			cadena+="if @"+nombre+".destroy"+'\n'; 
			cadena+="#render :xml => 0 "+'\n';
			cadena+="render :json => @nombre.to_json"+'\n';
			cadena+="else"+'\n';
			cadena+="render :xml => 1 "+'\n';
			cadena+="end"+'\n';
            cadena+="end"+'\n';
            return cadena;
		 }
		 
		  public  function metodo_actualizar(nombre:String):String
		{ 
			cadena="def update"+'\n';
			cadena+="@"+nombre+"= "+nombre.substr(0,nombre.length-1)+".find(params[:objetos][:id])"+'\n'; 
			cadena+="if @"+nombre+".update_attributes(params[:objetos])"+'\n'; 
			cadena+="render :xml => 0 "+'\n';
			cadena+="else"+'\n';
			cadena+="render :xml => 1 "+'\n';
			cadena+="end"+'\n';
            cadena+="end"+'\n';
            return cadena;
		 }
		 
		  public function set_controllador(Controlador_nombre:String):String
		{
			var variableg:String=Controlador_nombre;
			Controlador_nombre=Controlador_nombre.substring(0,1).toUpperCase()+Controlador_nombre.substring(1,variableg.length)
			Controlador_nombre="class "+Controlador_nombre+"Controller < ApplicationController"+'\n\n'; 
			Controlador_nombre+=metodo_list(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_Crear(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_borrar(variableg)+'\n\n\n'; 
			Controlador_nombre+=metodo_actualizar(variableg)+'\n\n\n'; 
			Controlador_nombre+="end";
			return Controlador_nombre;
		}
		
		public function set_modelo(modelo:String):String
		{
		   modelo=modelo.substring(0,1).toUpperCase()+modelo.substring(1,cadena.length)
		   Modelo_nombre="class "+modelo+" < ActiveRecord::Base"+'\n\n';
		   Modelo_nombre+="end";
		   return Modelo_nombre;
		}
		

		
		
	}
}
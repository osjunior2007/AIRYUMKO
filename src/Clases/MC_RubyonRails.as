package Clases
{
	import mx.controls.Alert;
	public class MC_RubyonRails
	{
		private static var instancia:MC_RubyonRails; 
		public var cadena:String="";
		public var Controlador_nombre:String="";
		public var Modelo_nombre:String="";
		public function MC_RubyonRails()
		{
		}
		
		
		
		  public static function getInstance():MC_RubyonRails
		{
			if( instancia==null ) 
			instancia = new MC_RubyonRails();
			return instancia;
		}
		
		  public function metodo_list(nombre:String):String
		{ 
			cadena="def list"+'\n';
			cadena+="@"+nombre+" = "+nombre.substr(0,nombre.length-1)+".find :all"+'\n'; 
			cadena+="render :json => @"+nombre+".to_json"+'\n'; 
            cadena+="end"+'\n';
            return cadena;
		}
		
		
        public  function metodo_Crear(nombre:String):String
		{ 
			cadena="def create"+'\n';
			cadena+="@"+nombre+" ="+nombre.substr(0,nombre.length-1)+".new(params[:objetos])"+'\n'; 
			cadena+="if @"+nombre+".save"+'\n'; 
			cadena+="render :xml => 0 "+'\n';
			cadena+="else"+'\n';
			cadena+="render :xml => 1 "+'\n';
			cadena+="end"+'\n';
            cadena+="end"+'\n';
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



/*has_many :audience_ethnicities
  has_many :audience_marital_statuses
  belongs_to :request_for_idea
  belongs_to :education_level
  belongs_to :planning_category
 
  def audience_ethnicities=(attrs)
    if new_record? 
      attrs.each do |att|
        audience_ethnicities.build(att)
      end
    else
    end
  end*/
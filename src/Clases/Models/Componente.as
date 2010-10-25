package Clases.Models
{
	import flight.db.activeRecord.ActiveRecord;
	
	public dynamic class Componente extends ActiveRecord
	{
	   public var modulo_id:String;
	   public var etiqueta:String;
	   public var identificador:String;
	   public var tamano:String;
	   public var componente:String;
	   public var componente_id:String;
	   public var requerido:String;
	   public var tipo:String;
	   public var modulo_relacionado:String;
	   public var tipo_relacion:String;
	   
	}
}
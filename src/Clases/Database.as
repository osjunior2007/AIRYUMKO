package Clases
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
    import flight.db.activeRecord.TableCreator;
	import flash.utils.getQualifiedClassName;
    import Clases.Models.*;  
      
	public class Database
	{   private static var instancia:Database;
	   	public var exampleDB:SQLConnection;
	    public var exampleDBFile:File;
	    public var dbStatement:SQLStatement;
       [Bindable]
        public var personData:Array;
         [Bindable]
        public var TreeData:Array;
        public var mod:Modulo=new Modulo();
		public var component:Componente=new Componente();
		public var relacion:Relacion=new Relacion();
        
        
		public function Database()
		{
		}

		  public static function getInstance():Database
		{
			if( instancia==null )
			instancia = new Database();
			return instancia;
		}

			public function initAndOpenDatabase():void
			{
			    TableCreator.updateTable(mod);
			    TableCreator.updateTable(component);
				TableCreator.updateTable(relacion);
			}
		
	}
}
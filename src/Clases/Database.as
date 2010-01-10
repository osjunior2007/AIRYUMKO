package Clases
{  
	import flash.data.SQLResult;
    import flash.filesystem.File;
	import flash.data.SQLStatement;
	import flash.data.SQLConnection;
	import flash.events.SQLEvent;
	import flash.events.SQLErrorEvent;
    import mx.controls.Alert;

    
	public class Database
	{   private static var instancia:Database;
	   	public var exampleDB:SQLConnection;			
	    public var exampleDBFile:File;
	    public var dbStatement:SQLStatement;
       [Bindable]
        public var personData:Array;
        
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
				exampleDBFile = File.applicationStorageDirectory.resolvePath( "Yomko.db" );
                //Alert.show(File.applicationStorageDirectory.nativePath);
				exampleDB = new SQLConnection();
				exampleDB.addEventListener(SQLEvent.OPEN, onExampleDBOpened);
				exampleDB.addEventListener(SQLErrorEvent.ERROR, onExampleDBError);
				exampleDB.open(exampleDBFile);
			}
			public function onExampleDBOpened(event:SQLEvent):void
			{
				if (event.type == "open")
				{
					getRecords();
				}
			}
			public function onExampleDBError(event:SQLEvent):void
			{
			}
			
				public function getRecords():void
			{
	           var sqlQuery:String="CREATE TABLE IF NOT EXISTS componentes ( id_componente INTEGER PRIMARY KEY AUTOINCREMENT,";
                sqlQuery+="id_modulo INTEGER NOT NULL,";
                sqlQuery+="etiqueta TEXT NOT NULL,";
                sqlQuery+="identificador TEXT NOT NULL,";
                sqlQuery+="tamano TEXT NOT NULL,";
                sqlQuery+="componente TEXT  NOT NULL,";
                sqlQuery+="componente_id TEXT NOT NULL,";
                sqlQuery+="requerido TEXT NOT NULL,";
                sqlQuery+="tipo TEXT NOT NULL";
                sqlQuery+=");";  
                dbStatement = new SQLStatement();
				dbStatement.sqlConnection = exampleDB;
	            dbStatement.text = sqlQuery;
				dbStatement.addEventListener(SQLEvent.RESULT, onDBStatementSelectResult);
				dbStatement.execute();    
                sqlQuery="CREATE TABLE IF NOT EXISTS modulos (";
                sqlQuery+="id_modulo INTEGER PRIMARY KEY AUTOINCREMENT,";
                sqlQuery+="nombre TEXT NOT NULL";
                sqlQuery+="); ";
                dbStatement = new SQLStatement();
				dbStatement.sqlConnection = exampleDB;
	            dbStatement.text = sqlQuery;
				dbStatement.addEventListener(SQLEvent.RESULT, onDBStatementSelectResult);
				dbStatement.execute();
                sqlQuery="CREATE TABLE IF NOT EXISTS relaciones (";
                sqlQuery+="id INTEGER PRIMARY KEY AUTOINCREMENT,";
                sqlQuery+="modulo_principal TEXT NOT NULL,";
                sqlQuery+="tipo_relacion TEXT NOT NULL,";
                sqlQuery+="modulo_relacionado TEXT NOT NULL";
                sqlQuery+=");";
                dbStatement = new SQLStatement();
				dbStatement.sqlConnection = exampleDB;
	            dbStatement.text = sqlQuery;
				dbStatement.addEventListener(SQLEvent.RESULT, onDBStatementSelectResult);
				dbStatement.execute();
				///////////////////////////////////////////////
	      }
	      
	      	public function getDatos(query:String):void
			{  
				dbStatement.text = query;
				dbStatement.removeEventListener(SQLEvent.RESULT, onDBStatementInsertResult);
			    dbStatement.addEventListener(SQLEvent.RESULT, onDBStatementSelectResult);
				dbStatement.execute();
			}
			
			 public function SetDatos(query:String):void
		     {
		       dbStatement.text = query;
		       dbStatement.removeEventListener(SQLEvent.RESULT, onDBStatementSelectResult);
			   dbStatement.addEventListener(SQLEvent.RESULT, onDBStatementInsertResult);
			   dbStatement.execute();
	        }
		
			
			public function onDBStatementSelectResult(event:SQLEvent):void
			{  
				var result:SQLResult = dbStatement.getResult();
			    if (result != null)
			    {
			    	personData = result.data;
			    }
			}
			public function onDBStatementInsertResult(event:SQLEvent):void
			{ 
			    if (exampleDB.totalChanges >= 1)
			    {
			    	getRecords();
			    }
			}

	}
}
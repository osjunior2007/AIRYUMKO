package Clases.Mobile
{   
	import Clases.Database;
	public class CreateModel
	{
		private static var instancia:CreateModel; 
		
		public function CreateModel()
		{
			
				
			
		}	
		
		public function New_Model(id:String,Object:String,type:String):String
		{
			var cadena:String="";
			cadena+='package Models'+"\n";
			cadena+='{'+"\n";
			cadena+='	[Bindable]'+"\n";
			cadena+='	[Table(name="'+Object.toLocaleLowerCase()+'")]'+"\n";
			cadena+='	public class '+Object+''+"\n";
			cadena+='	{  '+"\n";
			cadena+='		[Id]'+"\n";
			cadena+='		public var id:int;'+"\n";
			cadena+=CreateAttributes(Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			cadena+='	}'+"\n";
			return cadena;
		}	
			
		public function CreateAttributes(components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
				if(components[i].tipo=="Numerico"){
					cadena+='        [Column(name="'+components[i].identificador+'")]'+"\n";
				    cadena+='        public var '+components[i].identificador+':Number;'+"\n";
				}
				if(components[i].tipo=="Alfanumerico"){
					cadena+='        [Column(name="'+components[i].identificador+'")]'+"\n";
					cadena+='        public var '+components[i].identificador+':String;'+"\n";
				}
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		}	
		
		
		public static function getInstance():CreateModel
		{
			if( instancia==null ) 
				instancia = new CreateModel();
			return instancia;
		}
	
			
			
	}

}
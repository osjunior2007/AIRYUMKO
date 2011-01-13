package Clases.Mobile
{
	public class ShareFunctions
	{   
		private static var instancia:ShareFunctions; 
		
		public function ShareFunctions()
		{
		}
		
		public function CreateImportViewLibrary(components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			for(var i:int=0;i<=components.length-1;i++)
			{
				NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
				cadena+='	import Views.'+NameComponent+'.'+NameComponent+'SelectedIndex;'+"\n";	
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		}	
		
		
		public function clear_data_params(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			var NameObject:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			for(var i:int=0;i<=components.length-1;i++)
			{
		      cadena="this.data."+NameComponent+"s={};"+"\n";	
			}
			return cadena;
		}	
		
		
		
		public function ActiveListEventRelation(Object:String,components:Array,state:String):String
		{
			var cadena:String="";
			var NameObject:String=""
			var NameComponent:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			for(var i:int=0;i<=components.length-1;i++)
			{
				NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
				cadena="list_"+NameComponent+"s.enabled='"+state+"';"+"\n";
			}
			return cadena;
		} 
		
		
		public function SetAttributeValue(Object:String,components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
				cadena+="Att_"+components[i].identificador+".text="+Object.toLocaleLowerCase()+"."+components[i].identificador+"\n";
			}
			return cadena;
		} 
		
		
		public function SaveElementsRelationship(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			for(var i:int=0;i<=components.length-1;i++)
			{
				NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
				cadena+='if(this.data.'+Object.toLocaleLowerCase()+'.'+components[i].identificador+')'+Object.toLocaleLowerCase()+'.'+components[i].identificador+'='+Object.toLocaleLowerCase()+'.Save'+NameComponent+'(DB.em,this.data.'+Object.toLocaleLowerCase()+'.'+components[i].identificador+');'+"\n";
			}
			return cadena;
		}
		
		
		public function RemoveElementsRelationship(Object:String,components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
			  cadena+=Object.toLocaleLowerCase()+'.'+components[i].identificador+'.removeAll();'+"\n";
			}
			return cadena;
		}
		
		
		
		public static function getInstance():ShareFunctions
		{
			if( instancia==null ) 
				instancia = new ShareFunctions();
			return instancia;
		}
		
	}
}
package Clases.Mobile
{
	import Clases.Database;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.hamcrest.mxml.collection.Array;
	
	public class CreateMobileApp
	{
		private static var instancia:CreateMobileApp; 
		public var relation:Array=new Array();
		public function CreateMobileApp()
		{
		}
		
		public function CreateApp(list_modulos:Array):void
		{
			if(list_modulos!=null){
				relation=Database.getInstance().relacion.findBySQL("select * from relacions")
				for(var i:int=0;i<=list_modulos.length-1;i++)
				{
					if(GetTypeRelation(relation,list_modulos[i].id,"relacionado")&&!GetTypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
					if(!GetTypeRelation(relation,list_modulos[i].id,"relacionado")&&GetTypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
					if(GetTypeRelation(relation,list_modulos[i].id,"relacionado")&&GetTypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
					
				
				}
				
			}	
	    }	
		
		public function GetTypeRelation(list:Array,id:String,type:String):Boolean
		{
			var sw:Boolean=false;
			var i:int=0;
			while(i<=(list.length-1)&&!sw)
			{ 
			   if(type=="relacionado"){
					if(list[i].modulo_relacionado==id){
						sw=true;
					}
				}
			    if(type=="pricipal"){
			      if(list[i].modulo_principal==id){
						sw=true;
				   }	
				}
				
			  i++;	
			}
			return sw;
		}	
		
		
		public static function getInstance():CreateMobileApp
		{
			if( instancia==null ) 
				instancia = new CreateMobileApp();
			return instancia;
		}
		
		
	}
}
package Clases.Mobile
{
	import Clases.Database;
	import Clases.Zipfile;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import org.hamcrest.mxml.collection.Array;
	import Clases.Mobile.*;
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
				   if(TypeRelation(relation,list_modulos[i].id,"relacionado")&&!TypeRelation(relation,list_modulos[i].id,"principal")){
					}
					
				    if(!TypeRelation(relation,list_modulos[i].id,"relacionado")&&TypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
					
					if(TypeRelation(relation,list_modulos[i].id,"relacionado")&&TypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
				
				}
				
			}	
	    }
		
		public function CreateViews(Obj:Object):void
		{
			var NameObj:String=""
			NameObj=Obj.name.toUpperCase()+Obj.name.substring(1,Obj.name.length-1);
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteIndez.mxml",CreateViewIndex.getInstance().IndexView(Obj.id,Obj.name));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteShow.mxml",CreateViewShow.getInstance().ShowView(Obj.id,Obj.name));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteEdit.mxml",CreateViewEdit.getInstance().EditView(Obj.id,Obj.name));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteCreate.mxml",CreateViewCreate.getInstance().CreateView(Obj.id,Obj.name));
		}	
		
		
		public function TypeRelation(list:Array,id:String,type:String):Boolean
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
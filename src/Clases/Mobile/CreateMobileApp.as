package Clases.Mobile
{
	import Clases.Database;
	import Clases.Mobile.*;
	import Clases.Zipfile;
	
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
				   if(relation){
					if(TypeRelation(relation,list_modulos[i].id,"relacionado")&&!TypeRelation(relation,list_modulos[i].id,"principal")){
					}
					if(!TypeRelation(relation,list_modulos[i].id,"relacionado")&&TypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
					if(TypeRelation(relation,list_modulos[i].id,"relacionado")&&TypeRelation(relation,list_modulos[i].id,"principal")){
						
					}
				   }else{
					   CreateViews(list_modulos[i],"R0");  
				   }	
				
				}
				
			}	
	    }
		
		public function CreateViews(Obj:Object,type:String):void
		{
			var NameObj:String=""
			NameObj=Obj.name.substring(0,1).toUpperCase()+Obj.name.substring(1,Obj.name.length);
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteIndex.mxml",CreateViewIndex.getInstance().IndexView(Obj.id,NameObj,type));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteShow.mxml",CreateViewShow.getInstance().ShowView(Obj.id,NameObj,type));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteEdit.mxml",CreateViewEdit.getInstance().EditView(Obj.id,NameObj,type));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Views/"+NameObj+"/EstudianteCreate.mxml",CreateViewCreate.getInstance().CreateView(Obj.id,NameObj,type));
			Zipfile.getInstance().add_file(Zipfile.getInstance().proyecto_name+"/src/Models/"+NameObj+".as",CreateModel.getInstance().New_Model(Obj.id,NameObj,type));
			Zipfile.getInstance().open();
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
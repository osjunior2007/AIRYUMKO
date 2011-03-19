package Clases.Mobile
{   
	import Clases.Database;
	import Clases.Mobile.MobileComponents;
	import Clases.Mobile.ShareFunctions;
	
	import mx.controls.Alert;
	
	import org.hamcrest.mxml.collection.Array;

	public class CreateViewEdit
	{   
		private static var instancia:CreateViewEdit; 
		public function CreateViewEdit()
		{
		}
		
		
		public function EditFunction(id:String,Object:String,type:int):String
		{
			var cadena:String="";
			cadena+='<fx:Script>'+"\n";
			cadena+='	<![CDATA['+"\n";
			cadena+='	import Clases.Database;'+"\n";
			cadena+='	import Models.'+Object+';'+"\n";
			var components:Array= new Array() ;
			components=Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')");
			if(type!=0){
				cadena+=ShareFunctions.getInstance().CreateImportViewLibrary(Database.getInstance().relacion.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			}
			cadena+='	import mx.collections.ArrayCollection;'+"\n";
			cadena+='	public var DB:Database=new Database()'+"\n"+"\n";
			
			if(type==0){
				cadena+='public function Edit(data:Object):void'+"\n";
				cadena+='{'+"\n";
				cadena+='	var '+Object.toLocaleLowerCase()+':'+Object+'=new '+Object+'();'+"\n";
				cadena+='	'+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+' ;'+"\n";
				cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+='}'+"\n";
			}else{
				cadena+='public function Edit(data:Object):void'+"\n";
				cadena+='{'+"\n";
				cadena+='	var '+Object.toLocaleLowerCase()+':'+Object+'=new '+Object+'();'+"\n";
				cadena+='	'+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+';'+"\n";
				cadena+='	if('+Object.toLocaleLowerCase()+'){'+"\n";
				cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			    cadena+=ShareFunctions.getInstance().ActiveListEventRelation(Object,components,"true");
			    cadena+='	}else{'+"\n";
			    cadena+='		'+Object.toLocaleLowerCase()+'=Object_parser.FindObject(this.data.'+Object.toLocaleLowerCase()+'s,this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+' '+"\n";
			    cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			    cadena+=ShareFunctions.getInstance().ActiveListEventRelation(Object,components,"true");
			    cadena+='	}'+"\n";
		  	    cadena+='}	'+"\n";
			}
			cadena+='public function '+Object+'_Update(event:Event):void'+"\n";
			cadena+='{'+"\n";
			cadena+='	'+Object.toLocaleLowerCase()+'=DB.em.load('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+';'+"\n";
		
			if(type!=0)cadena+="if("+Object.toLocaleLowerCase()+"){"+"\n";
			 cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			 if(type!=0)cadena+='this.data.'+Object.toLocaleLowerCase()+'s=Object_parser.UpdateObjects(this.data.'+Object.toLocaleLowerCase()+'s,'+Object.toLocaleLowerCase()+')'+"\n";
			 cadena+=ShareFunctions.getInstance().SaveElementsRelationship(Object,components);
			 if(components!=null){
			 cadena+="Clear_Relations_Params();"+"\n";
			 }
			 cadena+='	DB.em.save('+Object.toLocaleLowerCase()+');'+"\n";
		 	 cadena+='	this.navigator.pushView('+Object+'Index,this.data); '+"\n";
			 if(type!=0){
			 cadena+=' }else{'+"\n";
			 cadena+=''+Object.toLocaleLowerCase()+'=Object_parser.FindObject(this.data.'+Object.toLocaleLowerCase()+'s,this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+' '+"\n";
			 cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' "));
			 cadena+='this.data.'+Object.toLocaleLowerCase()+'s=Object_parser.UpdateObjects(this.data.'+Object.toLocaleLowerCase()+'s,'+Object.toLocaleLowerCase()+')'+"\n";
			 if(components!=null){
				 cadena+="Clear_Relations_Params();"+"\n";
			 }
			 cadena+='this.navigator.pushView('+Object+'Index,this.data);'+"\n";
			 cadena+='}'+"\n";
			}
			cadena+='}'+"\n";
		
		cadena+='public function '+Object+'_Delete(event:Event):void'+"\n";
		cadena+='{  '+"\n"; 
		cadena+='	'+Object.toLocaleLowerCase()+'=DB.em.load('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+';'+"\n";
		if(type!=0){
		cadena+="if("+Object.toLocaleLowerCase()+"){"+"\n";
	    }
		cadena+=ShareFunctions.getInstance().RemoveElementsRelationship(Object,components);
		cadena+='	DB.em.remove('+Object.toLocaleLowerCase()+');'+"\n";
		if(type!=0){
		   cadena+='}else{'+"\n";
		   cadena+=' '+Object.toLocaleLowerCase()+'=Object_parser.FindObject(this.data.'+Object.toLocaleLowerCase()+'s,this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+' '+"\n";
		   cadena+='}'+"\n";
		   cadena+="this.data."+Object.toLocaleLowerCase()+"s=Object_parser.RemoveObject(this.data."+Object.toLocaleLowerCase()+"s,"+Object.toLocaleLowerCase()+")"+"\n";	
		}	
		cadena+='	this.navigator.pushView('+Object+'Index); '+"\n";
		if(components!=null){
			cadena+="Clear_Relations_Params();"+"\n";
		}
		cadena+='}'+"\n";
		
		cadena+=ShareFunctions.getInstance().clear_data_params(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')"));
		
		cadena+=' ]]>'+"\n";
		cadena+='</fx:Script>'+"\n"
		return cadena;	

	} 
	
	public function EditView(id:String,Object:String,type:int):String
	{
		var cadena:String="";
		cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
		cadena+='<s:View creationComplete="Index(this,this.data);" xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n"; 
		cadena+='xmlns:s="library://ns.adobe.com/flex/spark" title="'+Object+'">'+"\n";
		cadena+= EditFunction(id,Object,type)+"\n";		
		cadena+='<s:actionContent>'+"\n";		
		cadena+='	 <s:Button click="'+Object+'_New(event)" id="Btn_new" label="New" />'+"\n";		
		cadena+='</s:actionContent>'+"\n";	
		cadena+='<s:List  id="list" left="0" right="0" top="0" bottom="0"'+"\n";		
		cadena+='		 change="List_event(event)" fontSize="20">'+"\n";		
		cadena+='	 <s:itemRenderer>'+"\n";		
		cadena+='		 <fx:Component>'+"\n";		
		cadena+='			 <s:MobileIconItemRenderer    '+"\n";		 
		cadena+= ShareFunctions.getInstance().IndexListItemrender(id,Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"))+"\n";		 
		cadena+='			  messageField="title">'+"\n";		
		cadena+='			 </s:MobileIconItemRenderer> '+"\n";		
		cadena+='		 </fx:Component>'+"\n";		
		cadena+='	 </s:itemRenderer>	'+"\n";		
		cadena+=' </s:List>'+"\n";		
		cadena+="</s:View>";
		return cadena;	
	}
	
	
	
	
	public static function getInstance():CreateViewEdit
	{
		if( instancia==null ) 
			instancia = new CreateViewEdit();
		return instancia;
	}
	
}
}
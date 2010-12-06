package Clases.Mobile
{   
	import Clases.Mobile.MobileComponents;
	import Clases.Mobile.ShareFunctions;
	import Clases.Database;
	public class CreateEdit
	{   
		private static var instancia:CreateEdit; 
		public function CreateEdit()
		{
		}
		
		public function EditView(id:String,Object:String):String
		{
			var cadena:String="";
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='<s:View creationComplete="Index(this,this.data);" xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n"; 
			cadena+='xmlns:s="library://ns.adobe.com/flex/spark" title="'+Object+'">'+"\n";
			cadena+= CreateIndexFunction(Object)+"\n";		
			cadena+='<s:actionContent>'+"\n";		
			cadena+='	 <s:Button click="'+Object+'_New(event)" id="Btn_new" label="New" />'+"\n";		
			cadena+='</s:actionContent>'+"\n";	
			cadena+='<s:List  id="list" left="0" right="0" top="0" bottom="0"'+"\n";		
			cadena+='		 change="List_event(event)" fontSize="20">'+"\n";		
			cadena+='	 <s:itemRenderer>'+"\n";		
			cadena+='		 <fx:Component>'+"\n";		
			cadena+='			 <s:MobileIconItemRenderer    '+"\n";		 
			cadena+=IndexListItemrender(id,Object,Database.getInstance().relacion.findBySQL("select * from componentes where modulo_id='"+id+"'"))+"\n";		 
			cadena+='			  messageField="title">'+"\n";		
			cadena+='			 </s:MobileIconItemRenderer> '+"\n";		
			cadena+='		 </fx:Component>'+"\n";		
			cadena+='	 </s:itemRenderer>	'+"\n";		
			cadena+=' </s:List>'+"\n";		
			cadena+="</s:View>";
			
		}
		
		public static function getInstance():CreateEdit
		{
			if( instancia==null ) 
				instancia = new CreateEdit();
			return instancia;
		}
		
	}
}
package Clases.Mobile
{
	public class CreateView
	{
		private static var instancia:CreateView; 
		
		public function CreateView()
		{
		}
		
		
	   public function CreateShowFucntion(Object:String):String
	   {
		  
		   cadena+='public function Show(data:Object):void'+"\n";
		   cadena+='{'+"\n";
		   cadena+='   var '+Object.toLocaleLowerCase()+':'+Object+'=new '+Object+'();'+"\n";
		   cadena+='   '+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+' ;'+"\n";
		   cadena+="atributess"
		   cadena+='}'+"\n";
		   
	   }  
		
		
		
		
		public function CreateIndexFunction(Object:String):String
		{
			var cadena:String="";
			 cadena+='<fx:Script>'+"\n";
		     cadena+='<![CDATA['+"\n";
			 cadena+='import Clases.Database;'+"\n";
			 cadena+='import Models.'+Object+';'+"\n";
			 cadena+='import flash.events.MouseEvent;'+"\n";
			 cadena+='import mx.collections.ArrayCollection;'+"\n";
			 cadena+='public var DB:Database=new Database()'+"\n";
			 cadena+="\n";
			 cadena+="\n";
			
			 cadena+='public function Index(_view:'+Object+'Index,data:Object):void'+"\n";
			 cadena+='{'+"\n";
			 cadena+='	this.data={};'+"\n";
			 cadena+='	list.dataProvider=DB.em.findAll('+Object+');'+"\n";
			 cadena+=' }'+"\n";
			
			 cadena+='public function '+Object+'_New(event:Event):void'+"\n";
			 cadena+='{  '+"\n";
			 cadena+='	this.data={};'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'={}	'+"\n";
			 cadena+='	this.data.action="index"'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'.id="0"'+"\n";
			 cadena+='	this.navigator.pushView('+Object+'Create,this.data);'+"\n";
			 cadena+='}'+"\n";
			
			 cadena+='public function List_event(event:Event):void'+"\n";
			 cadena+='{'+"\n";
			 cadena+='	this.data={}'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'={}'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'.id=list.selectedItem.id;'+"\n";
			 cadena+='	this.navigator.pushView('+Object+'Show, this.data)'+"\n";
			 cadena+='}'+"\n";
			 cadena+="\n"; 	
             cadena+=' ]]>'+"\n"
			 cadena+='</fx:Script>'+"\n"
			
		}	
		
		
		
		public function CreateIndex(Object:String):String
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
		//cadena+='			  label="{data.username} {data.last_name}"'+"\n";		
		 cadena+='			  messageField="title">'+"\n";		
		 cadena+='			 </s:MobileIconItemRenderer> '+"\n";		
		 cadena+='		 </fx:Component>'+"\n";		
		 cadena+='	 </s:itemRenderer>	'+"\n";		
	     cadena+=' </s:List>'+"\n";		
		 cadena+="</s:View>";
			
		}
		
		public static function getInstance():CreateView
		{
			if( instancia==null ) 
				instancia = new CreateView();
		 	    return instancia;
		}
		
		
	}
}
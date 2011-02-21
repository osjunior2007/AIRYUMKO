package Clases.Mobile
{  
	import Clases.Database;
	import Clases.Mobile.ShareFunctions;
	import mx.controls.Alert;
	public class CreateViewCreate
	{  
		private static var instancia:CreateViewCreate; 
		public function CreateViewCreate()
		{
		}
		
		
		public function CreateFields(Object:String,components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
				
				if(components[i].componente=="0"){
					cadena+=MobileComponents.getInstance().CreateTextInput({"identificador":components[i].identificador,"longitud":components[i].tamano,"restricion":components[i].tipo,"pass":"0","requiredtype":components[i].requerido,"Enable":"false","focus":"true"})+"\n";	
				}
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		}
		
		
		public function CreateFunction(id:String,Object:String,type:int):String
		{
			var cadena:String="";
			cadena+='<fx:Script>'+"\n";
			cadena+='	<![CDATA['+"\n";
			cadena+='	import Clases.Database;'+"\n";
			cadena+='	import Models.'+Object+';'+"\n";
			if(type!=0){
			cadena+=ShareFunctions.getInstance().CreateImportViewLibrary(Database.getInstance().component.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			}
			cadena+='	import mx.collections.ArrayCollection;'+"\n";
			cadena+='	public var DB:Database=new Database()'+"\n"+"\n";
			cadena+='public function Create(data:Object):void'+"\n";
			cadena+='{'+"\n";
			cadena+='	this.data=data;'+"\n";
			cadena+='}'+"\n";
			
			cadena+='public function '+Object+'_Create(event:Event):void'+"\n";
			cadena+='{  '+"\n";
			cadena+='	'+Object.toLocaleLowerCase()+'=new '+Object+'();'+"\n";
			cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			cadena+=ShareFunctions.getInstance().SaveElementsRelationship(Object,Database.getInstance().component.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			cadena+='	DB.em.save('+Object.toLocaleLowerCase()+');'+"\n";
			cadena+='	this.navigator.pushView('+Object+'Index);'+"\n";
			cadena+='}	'+"\n";
		  	cadena+="\n"; 	
			cadena+=' ]]>'+"\n"
			cadena+='</fx:Script>'+"\n"
			return cadena;	
		} 
		
		
		public function CreateView(id:String,Object:String,type:int):String
		{
			var cadena:String="";
			
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='	<s:View xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n";
			cadena+='			xmlns:s="library://ns.adobe.com/flex/spark"'+"\n";
			cadena+='			xmlns:mx="library://ns.adobe.com/flex/mx"'+"\n";
			cadena+='			creationComplete="Create(this.data);" title="'+Object+'">'+"\n";
			cadena+CreateFunction(id,Object,type);
			cadena+='<s:navigationContent>'+"\n";
			cadena+='	 <s:Button id="homeButton"  icon="@Embed'+"('assets/home.png')"+'"  click="{this.navigator.pushView('+Object+'Index)}"/>'+"\n";
			cadena+='</s:navigationContent>'+"\n";
			cadena+='<s:Scroller width="100%" height="100%">'+"\n";
			cadena+='<s:VGroup height="100%" width="100%" paddingLeft="10" paddingTop="35" paddingRight="20" paddingBottom="20" gap="5">'+"\n";
			cadena+='		 <s:Label text="'+Object+' Information"/>	'+"\n";		
			cadena+='	  <mx:Spacer/>'+"\n";
			cadena+='	  <mx:Spacer/>	'+"\n";
			cadena+=CreateFields(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			cadena+='		 <mx:Spacer/>'+"\n";
			cadena+='		 <mx:Spacer/>	'+"\n";
			cadena+='		 <s:Button click="'+Object+'_Create(event)" id="Btn_create" width="100%" label="Create"/>'+"\n";
			cadena+=' </s:VGroup>'+"\n";
			cadena+='</s:Scroller>	'+"\n";
			cadena+='</s:View>'+"\n";
			
			return cadena;
		}
		
		
		public static function getInstance():CreateViewCreate
		{
			if( instancia==null ) 
				instancia = new CreateViewCreate();
			return instancia;
		}
		
	}
}
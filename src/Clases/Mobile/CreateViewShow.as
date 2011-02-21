package Clases.Mobile
{   
	import Clases.Database;
	import Clases.Mobile.MobileComponents;
	import Clases.Mobile.ShareFunctions;
	import mx.controls.Alert;
	public class CreateViewShow
	{
		private static var instancia:CreateViewShow; 
		
		public function CreateViewShow()
		{
		}
		
		
		
		
		public function ShowFunction(id:String,Object:String,type:int):String
		{
			var cadena:String="";
			cadena+='<fx:Script>'+"\n";
			cadena+='	<![CDATA['+"\n";
			cadena+='	import Clases.Database;'+"\n";
			cadena+='	import Models.'+Object+';'+"\n";
			cadena+='	import mx.collections.ArrayCollection;'+"\n";
			cadena+='	public var DB:Database=new Database()'+"\n"+"\n";
			
			//create import libary for modelo with attributes relation type bx example one to many, many to many,etc.
			if(type!=0){
				cadena+=ShareFunctions.getInstance().CreateImportViewLibrary(Database.getInstance().component.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			} 
			
			//If the module is principal or without relationship type
			if(type==0){
				cadena+='public function Show(data:Object):void'+"\n";
				cadena+='{'+"\n";
				cadena+='   var '+Object.toLocaleLowerCase()+':'+Object+'=new '+Object+'();'+"\n";
				cadena+='   '+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+' ;'+"\n";
				cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+='}'+"\n"+"\n";
			}else
			{
				cadena+='public function Show(data:Object):void'+"\n";
				cadena+='{'+"\n";
				cadena+='	var '+Object.toLocaleLowerCase()+':'+Object+' =new '+Object+'();'+"\n";
				cadena+='	'+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+' ;'+"\n";
				cadena+='	if('+Object.toLocaleLowerCase()+'){'+"\n";
				cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+=ShareFunctions.getInstance().ActiveListEventRelation(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')"),"true");
				cadena+='	}else{'+"\n";
				cadena+='		'+Object.toLocaleLowerCase()+'=Object_parser.FindObject(this.data.'+Object.toLocaleLowerCase()+'s,this.data.'+Object.toLocaleLowerCase()+'.id) as '+Object+' '+"\n";
				cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+=ShareFunctions.getInstance().ActiveListEventRelation(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')"),"false");
				cadena+='	}'+"\n";
				cadena+='}'+"\n";	
			}
			
			//if the model have attributes with many to many,many to one and one to many relationship
			cadena+=CreateListEventRelation(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')"));
			cadena+="\n"; 	
			cadena+=' ]]>'+"\n"
			cadena+='</fx:Script>'+"\n"
			return cadena;	
		} 
		
		
		
		
		public function CreateListRelation(Object:String,components:Array):String
		{
			var NameComponent:String=""
			var cadena:String=""
			if (components!=null){
				for(var i:int=0;i<=components.length-1;i++)
				{
					NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
					cadena+='<s:List change="{List_'+NameComponent+'(event)}" width="100%" id="list_mat" left="0" right="0" top="0" bottom="401" fontSize="20">';
					cadena+='	<s:layout>'+"\n";
					cadena+='		<s:VerticalLayout gap="0" horizontalAlign="justify" paddingBottom="-9"'+"\n";
					cadena+='						  paddingLeft="-8" paddingTop="-12" requestedRowCount="1"/>'+"\n";
					cadena+='	</s:layout>'+"\n";
					cadena+='	<s:dataProvider>'+"\n";
					cadena+='		<s:ArrayList>'+"\n";
					cadena+='			<fx:String>'+NameComponent+'  >></fx:String>'+"\n";
					cadena+='		</s:ArrayList>'+"\n";
					cadena+='	</s:dataProvider>'+"\n";
					cadena+='</s:List>'+"\n";
					
				}
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		} 
		
		
		public function CreateListEventRelation(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameObject:String=""
			var NameComponent:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length);
			if (components!=null){
				for(var i:int=0;i<=components.length-1;i++)
				{
					NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length);
					cadena+="public function List_"+NameComponent+"s(event:Event):void"+"\n";
					cadena+="{"+"\n";
					cadena+="this.data."+NameComponent.toLocaleLowerCase()+"s=new ArrayCollection()"+"\n";
					cadena+="this.data."+NameComponent.toLocaleLowerCase()+"s=(DB.em.load(Estudiante,this.data.estudiante.id) as Estudiante).materias as ArrayCollection"+"\n";
					cadena+="this.data."+NameComponent.toLocaleLowerCase()+"={}"+"\n";
					cadena+="this.data."+NameComponent.toLocaleLowerCase()+".back="+NameObject+"Show"+"\n";
					cadena+="this.navigator.pushView("+NameComponent+"SelectedIndex,this.data)"+"\n";	
					cadena+="}"+"\n"+"\n"+"\n";
				}
			}
			return cadena;
		} 
		
		
		public function CreateFields(Object:String,components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
				if(components[i].componente=="0"){
					cadena+=MobileComponents.getInstance().CreateTextInput({"identificador":components[i].identificador,"longitud":components[i].tamano,"restricion":components[i].tipo,"pass":"0","requiredtype":components[i].requerido,"Enable":"false","focus":"false"})+"\n";	
				}
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		}
		
		
		public function ShowView(id:String,Object:String,type:int):String
		{
			var cadena:String="";
			var NameObject:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length);
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='	<s:View creationComplete="Show(this.data)" xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n";
			cadena+='			xmlns:s="library://ns.adobe.com/flex/spark"'+"\n";
			cadena+='			fontStyle="normal" fontWeight="bold" textDecoration="none" '+"\n";
			cadena+='			title="Show '+Object+'">'+"\n";
			cadena+=ShowFunction(id,Object,type)+"\n";
			cadena+='<s:navigationContent>'+"\n";
			cadena+='	<s:Button id="homeButton"  icon="'+"@Embed('assets/home.png')"+'" click="{this.navigator.pushView('+NameObject+'Index)}"/>'+"\n";
			cadena+='</s:navigationContent>'+"\n";
			cadena+='<s:actionContent>'+"\n";		
			cadena+='	<s:Button click="{this.navigator.pushView('+NameObject+'Edit,this.data)}" id="Btn_update" label="Edit" />'+"\n";		
			cadena+='</s:actionContent>'+"\n";
			cadena+='<s:VGroup width="100%" paddingLeft="10" paddingTop="35" paddingRight="20" paddingBottom="20" gap="5">'+"\n";
			cadena+='	<s:VGroup width="100%">'+"\n";
			cadena+=CreateFields(Object,Database.getInstance().component.findBySQL("select * from componentes where tipo_relacion='0' and modulo_id='"+id+"'"));
			if(type!=0){
				cadena+=CreateListRelation(Object,Database.getInstance().component.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			}
			cadena+='	</s:VGroup>'+"\n";
			cadena+='</s:VGroup>'+"\n";
			cadena+='</s:View>'+"\n";
			return cadena;
		}	
		
		
		
		
		public static function getInstance():CreateViewShow
		{
			if( instancia==null ) 
				instancia = new CreateViewShow();
			return instancia;
		}
		
		
	}
}
package Clases.Mobile
{   
	import Clases.Mobile.MobileComponents;
	import Clases.Mobile.ShareFunctions;
	import Clases.Database;
	public class CreateViewShow
	{
		private static var instancia:CreateViewShow; 
		
		public function CreateViewShow()
		{
		}
		
		
		public function ShowFucntion(id:String,Object:String):String
		{
			var cadena:String="";
			cadena+='<fx:Script>'+"\n";
			cadena+='	<![CDATA['+"\n";
			cadena+='	import Clases.Database;'+"\n";
			cadena+='	import Models.'+Object+';'+"\n";
			cadena+=ShareFunctions.getInstance().CreateImportViewLibrary(Database.getInstance().relacion.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			cadena+='	import mx.collections.ArrayCollection;'+"\n";
			cadena+='	public var DB:Database=new Database()'+"\n"+"\n";
			cadena+='public function Show(data:Object):void'+"\n";
			cadena+='{'+"\n";
			cadena+='   var '+Object.toLocaleLowerCase()+':'+Object+'=new '+Object+'();'+"\n";
			cadena+='   '+Object.toLocaleLowerCase()+'=DB.em.loadItem('+Object+',this.data.'+Object.toLocaleLowerCase()+'.id)as '+Object+' ;'+"\n";
			cadena+=ShareFunctions.getInstance().SetAttributeValue(Object,Database.getInstance().relacion.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			cadena+='}'+"\n"+"\n";
			cadena+=CreateListEventRelation(Object,Database.getInstance().relacion.findBySQL("select * from componentes where modulo_id='"+id+"'"));
			cadena+="\n"; 	
			cadena+=' ]]>'+"\n"
			cadena+='</fx:Script>'+"\n"
		} 
		
		
		
		
		public function CreateListRelation(Object:String,components:Array):String
		{
			var NameComponent:String=""
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
			if(cadena!="")cadena+="\n";
			return cadena;
		} 
		
		
		
		public function CreateListEventRelation(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameObject:String=""
			var NameComponent:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			
			for(var i:int=0;i<=components.length-1;i++)
			{
				NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
				cadena="public function List_"+NameComponent+"s(event:Event):void"+"\n";
				cadena="{"+"\n";
				cadena="	this.data.action=Views."+NameObject+"."+NameObject+"Show;"+"\n";
				cadena="	this.navigator.pushView("+NameComponent+"SelectedIndex,this.data)	"+"\n";
				cadena="}"+"\n"+"\n"+"\n";
				
			}
			return cadena;
		} 
		
		
		public function CreateFields(Object:String,components:Array):String
		{
			var cadena:String="";
			for(var i:int=0;i<=components.length-1;i++)
			{
				if(components[i].componente=="0"){
					cadena+=MobileComponents.getInstance().CreateTextInput({"idenficador":components[i].identificador,"longitud":components[i].tamano,"restricion":components[i].tipo,"pass":"0","requiredtype":components[i].requerido,"Enable":"false","focus":"false"})+"\n";	
				}
			}
			if(cadena!="")cadena+="\n";
			return cadena;
		}
		
		
		public function ShowView(id:String,Object:String):String
		{
			var cadena:String="";
			var NameComponent:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='	<s:View creationComplete="Show(this.data)" xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n";
			cadena+='			xmlns:s="library://ns.adobe.com/flex/spark"'+"\n";
			cadena+='			fontStyle="normal" fontWeight="bold" textDecoration="none" '+"\n";
			cadena+='			title="Show '+Object+'">'+"\n";
			cadena+=CreateShowFucntion(id,Object)+"\n";
			cadena+='<s:navigationContent>'+"\n";
			cadena+='	<s:Button id="homeButton"  icon="'+"@Embed('assets/home.png')"+'click="{this.navigator.pushView('+NameObject+'Index)}"/>'+"\n";
			cadena+='</s:navigationContent>'+"\n";
			cadena+='<s:actionContent>'+"\n";		
			cadena+='	<s:Button click="{this.navigator.pushView('+NameObject+'Edit,this.data)}" id="Btn_update" label="Edit" />'+"\n";		
			cadena+='</s:actionContent>'+"\n";
			cadena+='<s:VGroup width="100%" paddingLeft="10" paddingTop="35" paddingRight="20" paddingBottom="20" gap="5">'+"\n";
			cadena+='	<s:VGroup width="100%">'+"\n";
			cadena+=CreateFields(Object,Database.getInstance().relacion.findBySQL("select * from componentes where tipo_relacion='0' and modulo_id='"+id+"'"));
			cadena+=CreateListRelation(Object,Database.getInstance().relacion.findBySQL("select * from componentes where tipo_relacion='5' and modulo_id='"+id+"'"));
			cadena+='	</s:VGroup>'+"\n";
			cadena+='</s:VGroup>'+"\n";
			cadena+='</s:View>'+"\n";
		}	
		
		
		
		
		public static function getInstance():CreateViewShow
		{
			if( instancia==null ) 
				instancia = new CreateViewShow();
			return instancia;
		}
		
		
	}
}
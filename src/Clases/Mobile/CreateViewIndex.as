package Clases.Mobile
{   
	import Clases.Database;
	
	import mx.controls.Alert;
	public class CreateViewIndex
	{
		private static var instancia:CreateViewIndex; 
		private var SizeItemRenderLable:int=2;
		public function CreateViewIndex()
		{
		}
		
		
		public function IndexListItemrender(id:String,Object:String,components:Array):String
		{
			var cadena:String="label=";
			var i:int=0;
			if(components.length<=SizeItemRenderLable){
				SizeItemRenderLable=components.length;
			}
			while(i<=SizeItemRenderLable-1)
			{
				cadena+="{data."+components[i].identificador+"} ";
				i++;	
			}
			return cadena;
		}
		
		
		public function IndexFunction(Object:String,type:int):String
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
			
			//Pricipal Model or Modelo without relation 
			if (type==0){
				cadena+='public function Index(_view:'+Object+'Index,data:Object):void'+"\n";
				cadena+='{'+"\n";
				cadena+='	this.data={};'+"\n";
				cadena+='	list.dataProvider=DB.em.findAll('+Object+');'+"\n";
				cadena+=' }'+"\n";
			}else{
				cadena+='this.data.'+Object.toLocaleLowerCase()+'s=Object_parser.ObjectsParse(true,this.data.'+Object.toLocaleLowerCase()+'s);'+"\n";
				//If the model is related and principal 
				if(type==1){   
					cadena+='list.dataProvider=Object_parser.JOIN_OBJECT_SELECT(this.data.'+Object.toLocaleLowerCase()+'s,DB.em.findAll('+Object+'));'+"\n";
				}else{
					//If the model is related 
					cadena+='	list.dataProvider=this.data.'+Object.toLocaleLowerCase()+'s;'+"\n";
				}
			}
			
			//Pricipal Model or Modelo without relation 
			if (type==0){
				cadena+='public function Btn_Back(event:Event):void '+"\n";
				cadena+='{ '+"\n";
				cadena+='	this.data.'+Object.toLocaleLowerCase()+'s=new ArrayCollection(); '+"\n";
				cadena+='	this.data.'+Object.toLocaleLowerCase()+'s=Object_parser.ObjectSelect(list.dataProvider as ArrayCollection,this.data.'+Object.toLocaleLowerCase()+'s); '+"\n";
				cadena+='	this.navigator.pushView(this.data.'+Object.toLocaleLowerCase()+'.back,this.data); '+"\n";
				cadena+='} '+"\n";
			}
			
			
			//Pricipal Model or Modelo without relation 
			if (type==0){
			cadena+='public function '+Object+'_New(event:Event):void'+"\n";
			cadena+='{  '+"\n";
			cadena+='	this.data={};'+"\n";
			cadena+='	this.data.'+Object.toLocaleLowerCase()+'={}	'+"\n";
			cadena+='	this.data.'+Object.toLocaleLowerCase()+'.id="0"'+"\n";
			cadena+='	this.navigator.pushView('+Object+'Create,this.data);'+"\n";
			cadena+='}'+"\n";
			}else{
			 cadena+='public function '+Object+'_New(event:Event):void'+"\n";
			 cadena+=' {'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'s=new ArrayCollection();'+"\n";
		     cadena+='	this.data.'+Object.toLocaleLowerCase()+'s=Object_parser.ObjectSelect(list.dataProvider as ArrayCollection,this.data.'+Object.toLocaleLowerCase()+'s);'+"\n";
			 cadena+='	this.data.'+Object.toLocaleLowerCase()+'.id=Object_parser.ObjectsMaxIndex(list.dataProvider as ArrayCollection);'+"\n";
			 cadena+='  this.navigator.pushView('+Object+'Create,this.data);'+"\n";
			 cadena+='}'+"\n";
			}
			
			
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
			return cadena;	
		}	
		
		public function IndexView(id:String,Object:String,type:String):String
		{
			var cadena:String="";
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='<s:View creationComplete="Index(this,this.data);" xmlns:fx="http://ns.adobe.com/mxml/2009"'+"\n"; 
			cadena+='xmlns:s="library://ns.adobe.com/flex/spark" title="'+Object+'">'+"\n";
			//cadena+= IndexFunction(Object)+"\n";		
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
			return cadena;
		}
		
		public static function getInstance():CreateViewIndex
		{
			if( instancia==null ) 
				instancia = new CreateViewIndex();
			return instancia;
		}
		
		
	}
}
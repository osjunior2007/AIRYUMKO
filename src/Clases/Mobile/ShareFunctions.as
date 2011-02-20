package Clases.Mobile
{   import mx.controls.Alert;
	public class ShareFunctions
	{   
		private static var instancia:ShareFunctions; 
		
		public function ShareFunctions()
		{
		}
		
		
		
		public function CreateImportAllViewLibrary(modulos:Array):String
		{
			var cadena:String="";
			var NameModulos:String=""
			if(modulos){
				for(var i:int=0;i<=modulos.length-1;i++)
				{
					NameModulos=modulos[i].name.substring(0,1).toUpperCase()+modulos[i].name.substring(1,modulos[i].name.length);
					cadena+='	                  import Views.'+NameModulos+';'+"\n";	
				}
				if(cadena!="")cadena+="\n";
			}
			return cadena;
		}
		
		
		
		public function CreateButtonTabBar(modulos:Array):String
		{
			var cadena:String="";
			var NameModulos:String=""
			if(modulos){
				for(var i:int=0;i<=modulos.length-1;i++)
				{
					NameModulos=modulos[i].name.substring(0,1).toUpperCase()+modulos[i].name.substring(1,modulos[i].name.length);
					cadena+='             <s:Button id="two" width="100%" height="58" label="'+NameModulos+'" click="{this.myNavigator.pushView('+NameModulos+'Index)}" fontSize="15"/>'+"\n";
				}
				if(cadena!="")cadena+="\n";
			}
			return cadena;
		}
		
		
		
		
		public function CreateImportViewLibrary(components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			if(components){
				for(var i:int=0;i<=components.length-1;i++)
				{
					NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
					cadena+='	import Views.'+NameComponent+'.'+NameComponent+'SelectedIndex;'+"\n";	
				}
				if(cadena!="")cadena+="\n";
			}
			return cadena;
		}	
		
		
		public function clear_data_params(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			var NameObject:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			if(components!=null){
				cadena+="public function Clear_Relations_Params(event:Event):void"+"\n";
		        cadena+="{"+"\n";
				for(var i:int=0;i<=components.length-1;i++)
				{
				 NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
				  cadena+="this.data."+NameComponent+"s={};"+"\n";	
				}
				cadena+="}"+"\n";
			}
			return cadena;
		}	
		
		public function IndexListItemrender(id:String,Object:String,components:Array):String
		{
			var cadena:String="label=";
			var i:int=0;
			var SizeItemRenderLable:int=2;
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
		
		
		public function ActiveListEventRelation(Object:String,components:Array,state:String):String
		{
			var cadena:String="";
			var NameObject:String=""
			var NameComponent:String=""
			NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
			if (components){
				for(var i:int=0;i<=components.length-1;i++)
				{
					NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
					cadena="list_"+NameComponent+"s.enabled='"+state+"';"+"\n";
				}
			}
			return cadena;
		} 
		
		
		public function SetAttributeValue(Object:String,components:Array):String
		{
			var cadena:String="";
			if (components){
				for(var i:int=0;i<=components.length-1;i++)
				{
					cadena+="Att_"+components[i].identificador+".text="+Object.toLocaleLowerCase()+"."+components[i].identificador+";"+"\n";
				}
			}
			return cadena;
		} 
		
		
		public function SaveElementsRelationship(Object:String,components:Array):String
		{
			var cadena:String="";
			var NameComponent:String=""
			if (components){		
				for(var i:int=0;i<=components.length-1;i++)
				{
					NameComponent=components[i].identificador.substring(0,1).toUpperCase()+components[i].identificador.substring(1,components[i].identificador.length-1);
					cadena+='if(this.data.'+components[i].identificador+')'+Object.toLocaleLowerCase()+'.'+components[i].identificador+'='+Object.toLocaleLowerCase()+'.Save'+NameComponent+'(DB.em,this.data.'+components[i].identificador+');'+"\n";
				}
			}
			return cadena;
		}
		
		
		public function RemoveElementsRelationship(Object:String,components:Array):String
		{
			var cadena:String="";
			if (components){	
				for(var i:int=0;i<=components.length-1;i++)
				{
					cadena+=Object.toLocaleLowerCase()+'.'+components[i].identificador+'.removeAll();'+"\n";
				}
				cadena+='DB.em.save('+Object.toLocaleLowerCase()+');';
			}	
			return cadena;
		}
		
		
		
		public static function getInstance():ShareFunctions
		{
			if( instancia==null ) 
				instancia = new ShareFunctions();
			return instancia;
		}
		
	}
}
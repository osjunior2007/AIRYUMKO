package Clases.Mobile
{
	public class CreateLoginPage
	{
		private static var instancia:CreateLoginPage; 
		
		public function CreateLoginPage()
		{
		}
		
		public function CreateLoginView(projectname:String):String
		{
		var cadena:String="";
		cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";	
		cadena+='		<s:View creationComplete="DB.Connection()"  '+"\n";	
		cadena+='				xmlns:mx="library://ns.adobe.com/flex/mx"'+"\n";	
		cadena+='				xmlns:fx="http://ns.adobe.com/mxml/2009" '+"\n";	
		cadena+='				xmlns:s="library://ns.adobe.com/flex/spark" title="'+projectname+'">'+"\n";	
		cadena+='			<fx:Declarations>'+"\n";	
		cadena+='				<!-- Place non-visual elements (e.g., services, value objects) here -->'+"\n";	
		cadena+='			</fx:Declarations>'+"\n";	
		cadena+='			<fx:Script>'+"\n";	
		cadena+='				<![CDATA['+"\n";	
		cadena+='					import Clases.Database;'+"\n";	
		cadena+='					public var DB:Database=new Database()'+"\n";	
		cadena+='				]]>'+"\n";	
		cadena+='			</fx:Script>'+"\n";	
		cadena+='			<s:Scroller width="100%" height="100%">'+"\n";	
		cadena+='			  <s:VGroup height="100%" width="100%" paddingLeft="10" paddingTop="35" paddingRight="20" paddingBottom="20" gap="5">'+"\n";	
		cadena+='				<s:TextInput text="Username :"'+ ' focusOut="'+"{(username.text=='')?username.text='Username :'"+' :username.text}" focusIn="'+"{username.text=''"+'}"  width="100%"   id="username" x="20" y="62"/>'+"\n";	
		cadena+='				 <s:TextInput text="Password :" '+' focusOut="'+"{(password.text=='')?password.text='Password :'"+' :password.text}" focusIn="'+"{password.text=''"+'}" width="100%"  id="password" x="20" y="182"/>'+"\n";
		cadena+='				  <mx:Spacer/>'+"\n";	
		cadena+='				  <mx:Spacer/>'+"\n";	
		cadena+='				 <s:Button width="100%" click="{this.navigator.pushView(MainView)}" id="btn" x="20" y="254"  label="Login"/>'+"\n";	
		cadena+='			  </s:VGroup>'+"\n";	
		cadena+='			</s:Scroller>'+"\n";	
		cadena+='		</s:View>'+"\n";	
		return cadena;
    	}
		
		
		
		public function CreateMainView():String
		{
			var cadena:String="";	
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";	
			cadena+='	<s:View xmlns:fx="http://ns.adobe.com/mxml/2009" creationComplete="{this.myNavigator.pushView(EstudianteIndex)}" '+"\n";	
			cadena+='			xmlns:s="library://ns.adobe.com/flex/spark" actionBarVisible="false">'+"\n";	
			cadena+='		<s:layout>'+"\n";	
			cadena+='			<s:BasicLayout/>'+"\n";	
			cadena+='		</s:layout>'+"\n";	
			cadena+='		<fx:Script>'+"\n";	
			cadena+='			<![CDATA['+"\n";	
			//cadena+='				import Views.Products.*;
	        cadena+='			]]>'+"\n";	
			cadena+='		</fx:Script>'+"\n";	
					
			cadena+='		<fx:Declarations>'+"\n";	
			cadena+='			<!-- Place non-visual elements (e.g., services, value objects) here -->'+"\n";	
			cadena+='		</fx:Declarations>'+"\n";	
					
			cadena+='		<s:VGroup  height="100%" width="100%" gap="0">'+"\n";	
			cadena+='			<s:ViewNavigator  id="myNavigator" width="100%" height="100%" />'+"\n";	
			cadena+='			<s:HGroup left="0" right="0" bottom="0" gap="0" width="100%" >'+"\n";	
			//cadena+='				<s:Button id="two" width="100%" height="58" label="Estudiante"'+"\n";	
			//cadena+='						  click="{this.myNavigator.pushView(EstudianteIndex)}" fontSize="15"/> '+"\n";	
			cadena+='			</s:HGroup>'+"\n";	
			cadena+='		</s:VGroup>'+"\n";	
			cadena+='	</s:View>'+"\n";	

			
		 return "";
		}	
		
		
		public static function getInstance():CreateLoginPage
		{
			if( instancia==null ) 
				instancia = new CreateLoginPage();
			return instancia;
		}
		
		
	}
}
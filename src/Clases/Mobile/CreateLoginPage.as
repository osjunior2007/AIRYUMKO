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
		
		
		public static function getInstance():CreateLoginPage
		{
			if( instancia==null ) 
				instancia = new CreateLoginPage();
			return instancia;
		}
		
		
	}
}
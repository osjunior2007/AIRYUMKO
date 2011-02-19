package Clases.Mobile
{
	public class MobileAirFileGenerate
	{  
		private static var instancia:MobileAirFileGenerate; 
		
		public function MobileAirFileGenerate()
		{
		}
		
		public function CreateMobileApplication(projectname:String):String
		{
			var cadena:String="";
			cadena+='<?xml version="1.0" encoding="utf-8"?>'+"\n";
			cadena+='<s:MobileApplication xmlns:fx="http://ns.adobe.com/mxml/2009" '+"\n";
			cadena+='						 xmlns:s="library://ns.adobe.com/flex/spark" firstView="Views.login">'+"\n";
			cadena+='		<fx:Declarations>'+"\n";
			cadena+='			<!-- Place non-visual elements (e.g., services, value objects) here -->'+"\n";
			cadena+='		</fx:Declarations>'+"\n";
			cadena+='	</s:MobileApplication>'+"\n";
          return cadena;
		}
		
		
		
		public function Create_App_Xml(projectname:String):String
		{
			
			var cadena:String="";
			cadena+='<?xml version="1.0" encoding="utf-8" standalone="no"?>'+"\n";	
			cadena+='	<application xmlns="http://ns.adobe.com/air/application/2.5">'+"\n";	
			cadena+='		<id>'+projectname+'.debug</id>'+"\n";	
			cadena+='			<filename>'+projectname+'</filename>'+"\n";	
			cadena+='		<name>'+projectname+'-debug</name>'+"\n";	
			cadena+='		<versionNumber>0.0.0</versionNumber>'+"\n";	
			cadena+='		<initialWindow>'+"\n";	
			cadena+='			<content>'+projectname+'.swf</content>'+"\n";	
			cadena+='		<autoOrients>true</autoOrients>'+"\n";	
			cadena+='		<fullScreen>false</fullScreen>'+"\n";	
			cadena+='		<visible>false</visible>'+"\n";	
			cadena+='	  </initialWindow>'+"\n";	
			cadena+='	  <android>'+"\n";	
			cadena+='		<manifestAdditions><![CDATA['+"\n";	
			cadena+='		<manifest>'+"\n";	
			cadena+='			<!-- See the Adobe AIR documentation for more information about setting Google Android permissions -->'+"\n";	
			cadena+='			<uses-permission android:name="android.permission.INTERNET"/>'+"\n";	
			cadena+='		</manifest>'+"\n";	
			cadena+='	]]></manifestAdditions>'+"\n";	
			cadena+='	  </android>'+"\n";	
			cadena+='	</application>'+"\n";	
			return cadena;
		}	
		
		
		
		
		public static function getInstance():MobileAirFileGenerate
		{
			if( instancia==null ) 
				instancia = new MobileAirFileGenerate();
			return instancia;
		}
		
		
	}
}
package Clases
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;

	
	public class Zipfile
	{  private static var instancia:Zipfile;
		public var zip:FZip = new FZip();
		public var New_zip:FZip = new FZip();
		public var index:uint = 0;
		public var done:Boolean = false;
		public var proyecto_zip:String="cake_1.2.3.8166.zip";
		
		public function Zipfile()
		{
		}
		
		public static function getInstance():Zipfile
		{
			if( instancia==null ) 
				instancia = new Zipfile();
			return instancia;
		}
		
		
		public function openSite():void
		{
			//add_file("Ejemplo/hello.txt","Hello World!")
			/*var docsDir:File = File.applicationDirectory
			try
			{
				docsDir.browseForDirectory("Select Directory for extract");  
				docsDir.addEventListener(Event.SELECT, saveData);
			}
			catch (error:Error)
			{
				Alert.show("Failed:", error.message);
			}*/
		}
		
		public function add_file(path:String,file:String):void
		{
			var archivo:ByteArray = new ByteArray();
			archivo.writeUTFBytes(file);
			zip.addFile(path, archivo);
		}
		
		
		public function open():void
		{
			var docsDir:File = File.applicationDirectory
			try
			{
				docsDir.browseForDirectory("Select Directory for extract");  
				docsDir.addEventListener(Event.SELECT, saveData);
			}
			catch (error:Error)
			{
				Alert.show("Failed:", error.message);
			}	
			
		}
		
		
		public function saveData(event:Event):void 
		{
			var file:File = event.target as File;
			file = file.resolvePath("Proyecto.zip");
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			zip.serialize(stream);
			stream.close();
		}
		
		
		public function Load_File(file:String):void {
			New_zip = new FZip();
			New_zip.addEventListener(Event.COMPLETE, onComplete);
			New_zip.load(new URLRequest(file));
		}	
		
		
		
		private function onComplete(evt:Event):void {
			for(var i=0;i<=New_zip.getFileCount()-1;i++) {
				var file:FZipFile = New_zip.getFileAt(i);
				  add_file(file.filename,file.content.toString())
				}	
			open();
		}
		
		
	}
}
package Clases
{
	  import deng.fzip.FZip;
      import deng.fzip.FZipLibrary;
      import deng.fzip.FZipFile;
      import flash.filesystem.*;
      import flash.events.Event;
      import flash.net.FileFilter;
      import flash.net.FileReference;
      import flash.events.Event;
      import flash.utils.ByteArray;
      import flash.display.Sprite;
	  import flash.display.StageAlign;
	  import flash.display.StageScaleMode;
	  import flash.events.*;
	  import mx.controls.Alert;
	  import flash.net.URLRequest;
      //public var fileRef:FileReference;
	  import mx.controls.Alert;
	  
	public class Zipfile
	{  private static var instancia:Zipfile;
	    var zip:FZip = new FZip();
	    var index:uint = 0;
	    var done:Boolean = false;
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
         var archivo:ByteArray = new ByteArray();
         archivo.writeUTFBytes("Hello World!");
         zip.addFile("Ejemplo/hello.txt", archivo);
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
     
     
     public function open_zip():void
     {
     	
     }
     
   
      public function saveData(event:Event):void 
       {
        var file:File = event.target as File;
        file = file.resolvePath("hello.zip");
        var stream:FileStream = new FileStream();
        stream.open(file, FileMode.WRITE);
        zip.serialize(stream);
        stream.close();
       }
       
       
       public function Load_File() {
         zip = new FZip();
		 zip.addEventListener(Event.OPEN, onOpen);
		 zip.addEventListener(Event.COMPLETE, onComplete);
		 zip.load(new URLRequest("Ejemplos.zip"));
		}	
		
		private function onOpen(evt:Event):void {
       	   zip.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onComplete(evt:Event):void {
	         done = true;
     }
     
      private function onEnterFrame(evt:Event):void {
       	  
	      if(zip.getFileCount() > index) {
					// yeah, get it
					var file:FZipFile = zip.getFileAt(index);
					// is this a png in the icons folder?
				// if(file.filename.indexOf("ejemplo/Datos") == 0 && file.filename.indexOf(".txt") != -1) {
					// yeah, display it
					    Alert.show(file.filename,file.content.toString());
				//	}
					index++;   
	      }else{
	      	if(done) {
			 zip.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}

	      }
		}
		
}
}
package Clases.Mobile
{
	public class MobileComponents
	{
		public function MobileComponents()
		{
		}
		
		
		public function CreateTextInput(idenficador:String,longitud:String,restricion:String,pass:int,requiredtype:String,Enable:String):String
		{ var cadena:String="";
			if(pass==0){
				cadena='  <mx:TextInput enable="'+Enable+'" width="350" x="'+(posx)+'" y="'+posy+'"';
			}else{
				cadena='  <mx:TextInput displayAsPassword="true" width="350" x="'+(posx)+'" y="'+posy+'"';	
			}
			cadena+=" ";
			cadena+='id="Att_'+idenficador.toLowerCase()+'" '+'maxChars="'+longitud+'"';
			if(restricion=="Numerico"){
				cadena+=' restrict="0-9"'	
			}
			if(requiredtype=="true"){
				cadena+=' name="required"'		
			}
			cadena+=' />'	 
			return cadena; 	
		}
		
		
		public static function getInstance():MobileComponents
		{
			if( instancia==null ) 
				instancia = new MobileComponents();
			return instancia;
		}
		
	}
}
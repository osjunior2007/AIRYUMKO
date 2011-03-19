package Clases.Mobile
{
	import mx.controls.Alert; 
	public class MobileComponents
	{
		private static var instancia:MobileComponents; 
		
		public function MobileComponents()
		{
		}
		
		
		public function CreateTextInput(params:Object):String
		{ 
			
			var cadena:String="";
			var NameObject:String=""
			if(params.pass=="0"){
				cadena='  <s:TextInput  width="100%" ';
			}else{
				cadena='  <s:TextInput displayAsPassword="true" width="100%" ';	
			}
			cadena+=" ";
			
			if(params.focus=="true"){
				//NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
				cadena+='focusOut'+'="'+"{("+"Att_"+params.identificador.toLowerCase()+".text=='')?"+"Att_"+params.identificador.toLowerCase()+".text='"+params.etiqueta+"' : Att_"+params.identificador.toLowerCase()+".text}" +' focusIn="'+"{Att_"+params.identificador.toLowerCase()+".text=''}"+'"';
			}
			cadena+=' id="Att_'+params.identificador.toLowerCase()+'" '+'maxChars="'+params.longitud+'"';
			if(params.restricion=="Numerico"){
				cadena+=' restrict="0-9"'	
			}
			if(params.requiredtype=="true"){
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
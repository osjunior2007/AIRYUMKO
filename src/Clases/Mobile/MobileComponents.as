package Clases.Mobile
{
	public class MobileComponents
	{
		public function MobileComponents()
		{
		}
		
		
		public function CreateTextInput(params:Object):String
		{ 
			
			var cadena:String="";
			var NameComponent:String=""
				
			if(params.pass=="0"){
				cadena='  <mx:TextInput enable="'+params.Enable+'" width="100%"';
			}else{
				cadena='  <mx:TextInput displayAsPassword="true" width="100%"';	
			}
			cadena+=" ";
			
			if(params.focus=="true"){
				NameObject=Object.substring(0,1).toUpperCase()+Object.substring(1,Object.length-1);
				cadena+='focusOut'+"="+"{("+params.idenficador.toLowerCase()+".text=='')?"+params.idenficador.toLowerCase()+".text='"+NameObject+" :' :"+params.idenficador.toLowerCase()+".text}" +"focusIn="+"{"+params.idenficador.toLowerCase()+".text=''}";
			}
			
			cadena+='id="Att_'+params.idenficador.toLowerCase()+'" '+'maxChars="'+params.longitud+'"';
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
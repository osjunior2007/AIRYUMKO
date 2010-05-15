package Clases
{
	public class Helpers
	{
		
		private static var instancia:Helpers; 
		
		public function Helpers()
		{
		}
			
		
		public static function getInstance():Helpers
		{
			if( instancia==null ) 
				instancia = new Helpers();
			return instancia;
		}
		

	}
}
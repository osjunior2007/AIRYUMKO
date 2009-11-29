package Clases
{
	public class CakePHP
	{ 
		private static var instancia:CakePHP; 
		public function CakePHP()
		{
		}
		
		public static function getInstance():CakePHP
		{
			if( instancia==null ) 
				instancia = new CakePHP();
			return instancia;
		}
	}
}
package Clases
{
  import mx.collections.ArrayCollection;
  import spark.components.Group;
  import mx.rpc.remoting.RemoteObject;
  import mx.messaging.channels.AMFChannel;
  import mx.rpc.remoting.RemoteObject;
  import mx.utils.ArrayUtil;

  import mx.rpc.events.ResultEvent;
  import mx.messaging.ChannelSet;
 public class Estudiantes
  {

 private static var instancia: Estudiantes;
   private var serilizacion:Array=new Array();
   public function Estudiantes()
   {
   }

 public function GET_LIST(e:ResultEvent,group:Group):void {
     serilizacion=new Array()
     for (var i:String in ArrayUtil.toArray(e.result)){
          serilizacion.push(ArrayUtil.toArray(e.result)[i][0]);
       }
        group['datos'].dataProvider=serilizacion;
    }
   public static function getInstance():Estudiantes
   {
   if( instancia==null )
     instancia = new Estudiantes();
      return instancia;
     }
   }
 }

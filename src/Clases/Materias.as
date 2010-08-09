package Clases
{
  import mx.collections.ArrayCollection;
  import spark.components.Group;
  import mx.messaging.channels.AMFChannel;
  import mx.rpc.remoting.RemoteObject;
  import mx.utils.ArrayUtil;

  import mx.rpc.events.ResultEvent;
  import mx.messaging.ChannelSet;
  import mx.controls.TextInput;
  import spark.components.HGroup;
  import spark.components.VGroup;
  import mx.controls.ComboBox;
 public class Materias
  {

 private static var instancia: Materias;
   private var serilizacion:Array=new Array();
   public function Materias()
   {
   }

 public function GET_LIST(e:ResultEvent,group:Group):void {
     serilizacion=new Array()
     for (var i:String in ArrayUtil.toArray(e.result)){
          serilizacion.push(ArrayUtil.toArray(e.result)[i][0]);
       }
        group['datos'].dataProvider=serilizacion;
    }
   public static function getInstance():Materias
   {
   if( instancia==null )
     instancia = new Materias();
      return instancia;
     }
   public  function Create_Attributes(Root_VBox:VGroup):void
   {
      var newVBox:VGroup= new VGroup();
      var newHBox :VGroup = new HGroup();
     newVBox.setStyle( "borderColor", "#000000");
     newVBox.setStyle( "borderStyle", "solid" );   
     newVBox.setStyle("paddingBottom", 5);
     newVBox.setStyle("paddingRight", 5);
     newVBox.setStyle("paddingLeft", 5);
     newVBox.setStyle("paddingTop", 5);
     newVBox.percentWidth = 95;

//Components
      //TextInput 
      var LaB_null : Label = new Label();
      var TxT_null : TextInput = new TextInput();
       TxT_null.percentWidth=100;
       newHBox.addChild(LaB_null);
       newHBox.addChild(TxT_null);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);
      //TextInput 
      var LaB_name : Label = new Label();
      var TxT_name : TextInput = new TextInput();
       TxT_name.percentWidth=100;
       newHBox.addChild(LaB_name);
       newHBox.addChild(TxT_name);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);
      //TextInput 
      var LaB_last_name : Label = new Label();
      var TxT_last_name : TextInput = new TextInput();
       TxT_last_name.percentWidth=100;
       newHBox.addChild(LaB_last_name);
       newHBox.addChild(TxT_last_name);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);
      //TextInput 
      var LaB_nombre : Label = new Label();
      var TxT_nombre : TextInput = new TextInput();
       TxT_nombre.percentWidth=100;
       newHBox.addChild(LaB_nombre);
       newHBox.addChild(TxT_nombre);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);
      //TextInput 
      var LaB_codigo : Label = new Label();
      var TxT_codigo : TextInput = new TextInput();
       TxT_codigo.percentWidth=100;
       newHBox.addChild(LaB_codigo);
       newHBox.addChild(TxT_codigo);
         newVBox.addChild(newHBox);
         Root_VBox.addChild(newVBox);

   }
  }
 }

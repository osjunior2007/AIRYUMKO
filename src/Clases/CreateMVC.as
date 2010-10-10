package Clases
{
	public class CreateMVC
	{
		import mx.controls.Alert;
	    private static var instancia: CreateMVC;
	    public var Clear_Input:String="";
     	public function CreateMVC()
		{
		}


		public function MVC_Controller_Create(value:String,model_var:String):String
		{
		 var cadena:String=""
		 cadena+="    public function Create(event:Event):void"+"\n";
		 cadena+="     {"+"\n";
		 cadena+=model_var;
		 cadena+='       this.Save('+value.toLocaleLowerCase()+',{title:"'+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+' Insert",body:"Operacion Exitosa"});'+"\n";
		 cadena+='       List({type:"all"},_view.datos);'+"\n";
		 cadena+='       Clear_Input();'+"\n";
		 cadena+="     }";
		 return cadena;
		}
		
		public function MVC_Controller_Update(value:String,model_var:String):String
		{
		   var cadena:String=""
		   cadena+="    public function Update(event:Event):void"+"\n";
		   cadena+="     {"+"\n";
		   cadena+=model_var;
		   cadena+='       this.UpdateAttribute('+value.toLocaleLowerCase()+',{title:"'+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+' Update",body:"Operacion Exitosa"});'+"\n";
		   cadena+='       List({type:"all"},_view.datos);'+"\n";
		   cadena+='       Clear_Input();'+"\n";
		   cadena+="     }";
		   return cadena;
		}
		
		public function MVC_Controller_Edit(value:String,model_var:String):String
		{
			var cadena:String=""
		   cadena+="  public function Edit():void"+"\n";
	       cadena+="   {   "+"\n";  
	       cadena+=model_var;
           cadena+='     if(this.type=="Show"){'+"\n";
	       cadena+='       _view.submitBtn.enabled=false;'+"\n";
		   cadena+='      _view.updateBtn.enabled=true;'+"\n";	
	       cadena+='     }else{'+"\n";
	       cadena+='      _view.submitBtn.enabled=true;'+"\n";
		   cadena+='     _view.updateBtn.enabled=false;'+"\n";		
	       cadena+='     }'+"\n";
		   cadena+=' }	'+"\n";
		   return cadena;
		}
		
		public function MVC_Controller_BackBtnClick(value:String):String
		{
		     var cadena:String=""	
		     cadena+="  protected function BackBtnClick( event:Event ):void"+"\n";
		     cadena+="  { "+"\n";
			 cadena+='     List({type:"all"},_view.datos);'+"\n";
			 cadena+="     _view."+value.substr(0,1).toLocaleLowerCase()+ value.substr(1,value.length).toString()+"View.selectedIndex=0	"+"\n";	
	         cadena+="  }"+"\n";
		    return cadena;
		}
		
		public function MVC_Controller_Clear(model_var:String):String
		{
		    var cadena:String=""	
			 cadena+=" public function Clear_Input():void"+"\n";
		     cadena+="    {"+"\n";
		     cadena+=model_var;
		     cadena+="     }"+"\n";
		     return cadena;
		}
		
		public function MVC_Controller_confirmHandler(value:String):String
		{
		  var cadena:String=""	
		  cadena+="  private function confirmHandler(event:CloseEvent):void "+"\n";
	      cadena+="   { "+"\n";
	      cadena+="   if( event.detail == Alert.YES)"+"\n";
	      cadena+="    {	"+"\n";
	      cadena+='	    this.Destroy('+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length).toString()+',{title:"'+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length).toString()+' Delete",body:"Operacion Exitosa"});'+"\n";
	      cadena+='	    List({type:"all"}, _view.datos);'+"\n";
	      cadena+="    }"+"\n";
	      cadena+="  }"+"\n";
	      return cadena;
		}
		
		public function MVC_Controller_cleanup():String
		{
		  var cadena:String=""	
		  cadena+=" protected function cleanup( event:Event ):void"+"\n";
		  cadena+="   {"+"\n";
		  cadena+="      _view.NewBtn.removeEventListener( MouseEvent.CLICK, New );"+"\n";
		  cadena+="      _view.ShowBtn.removeEventListener( MouseEvent.CLICK, Show );"+"\n";
		  cadena+="      _view.updateBtn.removeEventListener( MouseEvent.CLICK,Update);"+"\n";
		  cadena+="      _view.DeleteBtn.removeEventListener( MouseEvent.CLICK,Delete);"+"\n";
		  cadena+="      _view.backlBtn.removeEventListener( MouseEvent.CLICK, BackBtnClick );"+"\n";
		  cadena+="      _view.removeEventListener( Event.REMOVED_FROM_STAGE, cleanup );"+"\n";
		  cadena+="   }"+"\n";
		  return cadena;
		}
		
		
		public function MVC_Controller_Destroy(value:String):String
		{
		   var cadena:String=""
		   cadena+="    public function Delete(event:Event):void"+"\n";
		   cadena+="     {"+"\n";
		   cadena+="       "+value.toLocaleLowerCase()+".id=_view.datos.selectedItem.id"+"\n";
		   cadena+='        Alert.show( "Estas seguro?","Confirmación de Borrado", Alert.YES| Alert.NO,null,confirmHandler,null,Alert.YES);'+"\n";
		   cadena+="        }else{"+"\n";
		   cadena+='       	Alert.show("Seleccione un elemento.");'+"\n";
		   cadena+="        }"+"\n";
		   cadena+="     }";
	  	   return cadena;
		}
		
		public function MVC_Controller_New(value:String,model_var:String):String
		{
			  var cadena:String=""
			 cadena+="     public function New(event:Event):void"+"\n";
		     cadena+="     {" +"\n";
		 	 cadena+='       this.type="New";' +"\n";
		 	 cadena+=model_var;
 	         cadena+="       _view."+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"View.selectedIndex=1;"+"\n";
		 	 cadena+="        if(load_form==true) Edit();"+"\n";
		     cadena+="      }"+"\n";
		     return cadena;
		}
		
		
		public function MVC_Controller_Show(value:String,model_var:String):String
		{
			var cadena:String=""
		   cadena+="     public function Show(event:Event):void"+"\n";
		   cadena+="     {" +"\n";
		   cadena+='      this.type="Show";'+"\n"; 
		   cadena+="      if (_view.datos.selectedIndex>=0){ "+"\n";
		   cadena+=model_var; 
           cadena+="      if (load_form==true) Edit();"+"\n"; 
		   cadena+="       _view."+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"View.selectedIndex=1;"+"\n"; 
		   cadena+="      }else"+"\n"; 
		   cadena+="      {"+"\n"; 
		   cadena+='         Alert.show("Seleccione un elemento.");'+"\n"; 
		   cadena+="	  }" +"\n"; 
		   cadena+="     }"+"\n"; 
		   return cadena;
         }

		public function MVC_Controller_List(value:String):String
		{
	      var cadena:String="";
		 cadena+="    public function List(param:Object,Grid:DataGrid):void"+"\n"
	     cadena+="    { "+"\n";
	     cadena+="      this.Index("+value.substr(0,1).toLocaleLowerCase()+ value.substr(1,value.length).toString()+",param,Grid);"+"\n";
	     cadena+="       _view."+value.substr(0,1).toLocaleUpperCase()+ value.substr(1,value.length).toString()+"View.selectedIndex=0;"+"\n";
	     cadena+="    } "+"\n";
		 return cadena;
		}

		public function MVC_Controller_Init(value:String):String
		{
		   var cadena:String="";
		  cadena+='      [Autowire( view="true" )]'+"\n"
	      cadena+="      public function set init_"+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"( value:"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Index):void"+"\n";
		  cadena+="       {"+"\n";
		  cadena+="         _view = value;"+"\n";
		  cadena+='         List({type:"all"},_view.datos);'+"\n";	
		  cadena+="         _view.NewBtn.addEventListener(MouseEvent.CLICK,New);"+"\n";
		  cadena+="         _view.ShowBtn.addEventListener(MouseEvent.CLICK,Show);"+"\n";
		  cadena+="         _view.DeleteBtn.addEventListener(MouseEvent.CLICK,Delete);"+"\n";
	      cadena+="         _view.EstudianteView.addEventListener(IndexChangedEvent.CHANGE,handleActiveViewChanged);"+"\n";
	      cadena+="        }"+"\n";
		  return cadena;
		}

		public function CREATE_CONTROLLER(value:String,id:String):String
		{
		  var cadena:String="";
		  var relations:String="";
		  var name:String="";
		  var init_model_var:String="";
		  var datagrid_model_var:String="";
		  var form_model_var:String="";
		  var View_model_var:String=""; 
		  var Clear_model_var:String=""; 

	    	for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
  			  if(Zipfile.getInstance().list_components[i].id_modulo==id){
  			  	   name=Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado);
  			  	   name=name.substr(0,1).toUpperCase()+name.substr(1,name.length-2);
  			        if(i==1){
  			        init_model_var="        "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'="";'+"\n";
  			  	    datagrid_model_var="      "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'=_view.datos.selectedItem.'+Zipfile.getInstance().list_components[i].etiqueta+';'+"\n";
  			  	    form_model_var="       "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'=_view.Att_'+Zipfile.getInstance().list_components[i].etiqueta+'.text;'+"\n";
  			  	    View_model_var="        _view.Att_"+Zipfile.getInstance().list_components[i].etiqueta+'.text='+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+";"+"\n";
  			  	    Clear_model_var="       _view.Att_"+Zipfile.getInstance().list_components[i].etiqueta+".text='';"+"\n";
  			  	   }else{
  			  	    init_model_var+="       "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'="";'+"\n";
  			  	    datagrid_model_var+="      "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'=_view.datos.selectedItem.'+Zipfile.getInstance().list_components[i].etiqueta+';'+"\n";
  			  	    form_model_var+="       "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+'=_view.Att_'+Zipfile.getInstance().list_components[i].etiqueta+'.text;'+"\n";
  			  	    View_model_var+="       _view.Att_"+Zipfile.getInstance().list_components[i].etiqueta+'.text='+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+"."+Zipfile.getInstance().list_components[i].etiqueta+";"+"\n";
  			  	    Clear_model_var+="      _view.Att_"+Zipfile.getInstance().list_components[i].etiqueta+".text='';"+"\n";
  			  	  }
  			  }
  			} 
  		  cadena="package Controllers"+"\n";
		  cadena+="{"+"\n";
		  cadena+="import Clases.ServiceRecords;;"+"\n";
		  cadena+="import Models."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model;"+"\n";
		  cadena+="import flash.events.Event;"+"\n";
		  cadena+="import mx.controls.DataGrid;"+"\n";
		  cadena+="import views."+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+".*;"+"\n";
		  cadena+="import flash.events.MouseEvent;"+"\n";
	      cadena+="import mx.events.IndexChangedEvent;"+"\n";
	      cadena+="import mx.events.CloseEvent;"+"\n";
		  
		  
		  cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Controller extends ServiceRecords "+"\n"+"{"+"\n";
		  cadena+="public var "+value.substr(0,1).toLocaleLowerCase()+value.substr(1,value.length)+":"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model=new "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model();"+"\n";
		  cadena+='public var type:String=""'+"\n";
	      cadena+="public var load_form:Boolean=false"+"\n";
	      cadena+="protected var _view:"+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Index"+"\n"+"\n";
		  
		  //init_model_var
		  cadena+=MVC_Controller_Init(value)+"\n";
		  cadena+=MVC_Controller_List(value)+"\n";
		  cadena+=MVC_Controller_New(value,init_model_var)+"\n";
		  cadena+= MVC_Controller_Show(value,datagrid_model_var)+"\n";
		  cadena+=MVC_Controller_Create(value,form_model_var)+"\n";
		  cadena+=MVC_Controller_Update(value,form_model_var)+"\n";
		  cadena+=MVC_Controller_Destroy(value)+"\n";
		  cadena+=MVC_Controller_Edit(value,View_model_var)+"\n";
		  cadena+=MVC_Controller_BackBtnClick(value)+"\n";
		  cadena+=MVC_Controller_Clear(Clear_model_var)+"\n";
		  cadena+=MVC_Controller_confirmHandler(value)+"\n";
		  cadena+=MVC_Controller_cleanup()+"\n";
		  cadena+="}"+"\n";
		  cadena+="}"+"\n";
		  return cadena;
		}

      

		//////////////////////////////////////////////////////////////////////////////////////

		public function CREATE_MODEL(value:String,id:String):String
		{
		  var cadena:String="";
		  var Global_Variables:String='     public var id:String=""'+"\n";	
		  var name_model:String=value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length);
	
 		for(var i:int=1;i<=Zipfile.getInstance().list_components.length-1;i++){
  			  if(Zipfile.getInstance().list_components[i].id_modulo==id){
  				if(i==1){
  				    if(Zipfile.getInstance().list_components[i].componente_id=="5"){
  			          Global_Variables+="     public var "+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+':String="";'+"\n";
	  			    }else{
	  				 Global_Variables+="     public var "+Zipfile.getInstance().list_components[i].etiqueta+':String="";'+"\n";
	  				  }
  				}else
  				{
	  			 if(Zipfile.getInstance().list_components[i].componente_id=="5"){
	  			       Global_Variables+="     public var "+Zipfile.getInstance().get_modulo_name(Zipfile.getInstance().list_components[i].modulo_relacionado)+':String="";'+"\n";
	  				  }else{
	  			     Global_Variables+="     public var "+Zipfile.getInstance().list_components[i].etiqueta+':String="";'+"\n";
	  			  }
  			 	}
  			  }
  		    }
  	        cadena+="package Models "+"\n"+"{"+"\n";
	        cadena+="public class "+value.substr(0,1).toLocaleUpperCase()+value.substr(1,value.length)+"Model"+"\n"+"{"+"\n";
		    cadena+=Global_Variables+"\n";
		    cadena+=Model_Init(value)+"\n";
		    cadena+=Model_Source(name_model)+"\n";
		    cadena+="  }"+"\n"
		    cadena+="}";
		    return cadena;
		}


		public function Model_Source(model:String):String
		{
		 var cadena:String="";
		 cadena+="    public function get_source():String"+"\n";
		 cadena+="    {"+"\n";
		 cadena+='      return "'+model+'sController"'+"\n";
		 cadena+="    }"+"\n";
		 return cadena; 
		}
		
		

		public function Model_Init(name:String):String
		{
		 var cadena:String="";
		 cadena+="    public function "+name.substr(0,1).toLocaleUpperCase()+name.substr(1,name.length)+"Model()"+"\n";
		 cadena+="    {"+"\n";
		 cadena+="    }"+"\n";
		 return cadena
		}




		public static function getInstance():CreateMVC
		{
			if( instancia==null )
				instancia = new CreateMVC();
			return instancia;
		}

	}
}
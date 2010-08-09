package Clases
{
	import flash.events.Event;
	
	import mx.containers.Form;
	import mx.containers.TabNavigator;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.events.CloseEvent;
	import mx.events.ValidationResultEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ArrayUtil;
	import mx.validators.Validator;
	
	import spark.components.Group;
	
	public class App
	{   private static var instancia:App;
		private var datos:DataGrid;
		public var group:Group;
		public var objeto:Object={};
		public var typeOperation:String="";
		public var attibute_nombre:String="";
		private var serilizacion:Array=new Array();
		public var wiew_sw:Boolean=false;
		public var OneTime:Boolean=false;
		private var InputValidator:Validator= new Validator();
		private var InputValidatorValue:Boolean;
		public var  AMFurl:String="http://localhost:/amfphp/gateway.php";
		//public var  AMFurl:String="http://localhost:3000/rubyamf/gateway";
		public function App()
		{
		}
		
		public function SET_CANVAS(group:Group):void
		{
			this.group=group;
		}
		
		
		public function GET_LIST(Header:TabNavigator):void
		{ 
			this.group=(Header.getChildAt(Header.selectedIndex) as Object).getChildAt(0);
			App.getInstance().REMOTE_ACCESS('index',{});
		}
		
		
		public function REQUEST_FAULT(e:FaultEvent):void
		{
			Alert.show(String (e.fault));
		} 
		
		
		public function DELETE_VERIFICATION(event:Event):void
		{   
			this.objeto.id=this.group['datos'].selectedItem.id;
			Alert.show("Are you sure you want to delete this item?", "Delete Item", 3,null,SUCCES_DELETE);
			
		}
		
		public function SUCCES_DELETE(event:CloseEvent):void
		{   if (event.detail==Alert.YES)
		{
			this.group['amf'].destroy.send(this.objeto); 
		}
		}    
		
		public function SUCCES_UPDATE(event:Event):void
		{
			this.group['View_01'].selectedIndex=0;
		};
		
		public function FIELD_VALIDATION(eventObj:ValidationResultEvent):void {
			InputValidatorValue=false;	
			if(eventObj.type==ValidationResultEvent.VALID){
				InputValidatorValue=true;	
			}
			return; 
		}
		
		private function SET_VALIDATOR(Input:Object):void
		{
			Input.errorString=GET_INPUTFIELD_NAME(Input.id)+' is required';
			InputValidator.requiredFieldError=GET_INPUTFIELD_NAME(Input.id)+' is required';
			InputValidator.required=true;
			InputValidator.property='text';
			InputValidator.source=Input;
			InputValidator.addEventListener(ValidationResultEvent.VALID, App.getInstance().FIELD_VALIDATION);
			InputValidator.addEventListener(ValidationResultEvent.INVALID, App.getInstance().FIELD_VALIDATION);
			InputValidator.validate();
		} 
		
		public  function SUCCESS_REQUEST(event:ResultEvent):void
		{   this.group['View_01'].selectedIndex=0;
			App.getInstance().CLEAR_ALL_INPUTFIELDS();
			this.group['amf'].index.send();
		}
		
		public function CLEAR_ALL_INPUTFIELDS():void
		{  
		
				for(var i:int=0;i<=this.group['FormInputsObjects'].numElements-1;i++) 
				{
				 if ((this.group['FormInputsObjects'].getElementAt(i) as Object).numElements>0){	
					if(((this.group['FormInputsObjects'].getElementAt(i) as Object).getElementAt(0)).className=='TextInput'||((this.group['FormInputsObjects'].getElementAt(i) as Object).getElementAt(0)).className=='TextArea'){
						((this.group['FormInputsObjects'].getElementAt(i) as Object).getElementAt(0)).text='';	
						((this.group['FormInputsObjects'].getElementAt(i) as Object).getElementAt(0)).errorString='';
					}
				 }	
				}
			
			
			if (this.typeOperation=="create"){
				this.group['submit'].enabled =true;	
				this.group['updates'].enabled =false;	
			}
			
			if (this.typeOperation=="update"){
				this.group['submit'].enabled =false;	
				this.group['updates'].enabled =true;	
			}
			
		} 
		
		public function FIND_INPUTFIELDS_ERRORS():Boolean
		{ 
			var i:int=0;
			var j:int=0;
			var sw:Boolean=true;
			var Validatedata:String="";
			while(i<=this.group['InputsObjects'].numElements-1&&sw) 
			{
				ACTIVATE_INPUT_VALIDATION();
				if((this.group['InputsObjects'].getElementAt(i)  as Object).className=='TextInput'||(this.group['InputsObjects'].getElementAt(i)  as Object).className=='TextArea'){
					if((this.group['InputsObjects'].getElementAt(i)  as Object).errorString!=''){  
						sw=false;
					}
				}
				i++;
			} 
			return sw;
		}
		
		public function ACTIVATE_INPUT_VALIDATION():void
		{
			var i:int=0;
			var Validatedata:String="";
			for(i=0;i<=this.group['InputsObjects'].numElements-1;i++){
				if((this.group['InputsObjects'].getElementAt(i) as Object).className=='TextInput'||(this.group['InputsObjects'].getElementAt(i) as Object).className=='TextArea'){
					if((this.group['InputsObjects'].getElementAt(i) as Object).name=='required'){  
						SET_VALIDATOR((this.group['InputsObjects'].getElementAt(i) as Object));
						if(this.InputValidatorValue){
							(this.group['InputsObjects'].getElementAt(i) as Object).errorString='';
						}
					}
				}
			} 
		}
		
		public function BACK_TO_LIST():void
		{
			App.getInstance().CLEAR_ALL_INPUTFIELDS();
			this.group['View_01'].selectedIndex=0;
			App.getInstance().REMOTE_ACCESS('index',{});
		}
		
		public function GET_INPUTFIELD_NAME(Input:String):String
		{
			return  Input.substring(4,Input.length);	
		}
		
		public function VALIDATE_DELETE_ID(event:Event):void
		{   
			if(this.group['datos'].selectedIndex>=0){
				DELETE_VERIFICATION(event);
			}else{
				Alert.show('Seleccione un elemento..');
			}
		}   
		public function VALIDATE_UPDATE_ID():void
		{
			if(this.group['datos'].selectedIndex>=0){
				this.group['View_01'].selectedIndex=1
			}else{
				Alert.show('Seleccione un elemento..');
			}
		} 
		
		public function CHANGE_VIEW(tipo:String):void
		{
			this.typeOperation=tipo;
			
			if(tipo=="create"){
				this.group['View_01'].selectedIndex=1
			}
			if(tipo=="update"){
				App.getInstance().SET_UPDATE(true);	
				VALIDATE_UPDATE_ID();
			}
		}
		
		public function REMOTE_ACCESS(tipo:String,objeto:Object):void
		{
			
			this.typeOperation=tipo;
			if(tipo=="index"){
				this.group['amf'].index.send();
			}
			if(tipo=="create"){
				if (FIND_INPUTFIELDS_ERRORS()){	
					objeto.id=0;
					this.group['amf'].create.send(objeto);
				}else{
					Alert.show("varfique los campos requeridos");
				}
			}
			if(tipo=="update"){
				if (FIND_INPUTFIELDS_ERRORS()){
					this.group['amf'].update.send(objeto);
				}else{
					Alert.show("varfique los campos requeridos");	
				}
			}
			if(tipo=="destroy"){
				this.group['amf'].destroy.send(objeto);
			}
			
		}
		
		public function ADD_OBJECT():Object
		{   
			this.objeto={}; 
			for(var i:int=0;i<=this.group['InputsObjects'].getChildren().length-1;i++) 
			{  if((this.group['InputsObjects'].getChildAt(i) as Object).className=='TextInput'||(this.group['InputsObjects'].getChildAt(i) as Object).className=='TextArea'){
				attibute_nombre=GET_INPUTFIELD_NAME((this.group['InputsObjects'].getChildAt(i) as Object).id);	
				this['objeto'][attibute_nombre]=(this.group['InputsObjects'].getChildAt(i) as Object).text
			}
			} 
			for(i=0;i<=this.group['OutputsObjects'].getChildren().length-1;i++) 
			{
				if((this.group['OutputsObjects'].getChildAt(i) as Object).className=='DataGrid'){
					if((this.group['OutputsObjects'].getChildAt(i) as Object).selectedIndex>=0){ 
						this['objeto']['id']=(this.group['OutputsObjects'].getChildAt(i) as Object).selectedItem['id'];
					}
					else{
						this['objeto']['id']=0;
					}
				}
			}
			return this.objeto;
		} 
		
		public function SET_CANVAS_COMPLETE():void
		{ 
			this.group["canvas_complete"]=true;
			if(this.group["sw"]){
				this.group['submit'].enabled =false;	
				this.group['updates'].enabled =true; 
				for(var i:int=0;i<=this.group['InputsObjects'].getChildren().length-1;i++) 
				{  if((this.group['InputsObjects'].getChildAt(i) as Object).className=='TextInput'||(this.group['InputsObjects'].getChildAt(i) as Object).className=='TextArea'){
					attibute_nombre=(this.group['InputsObjects'].getChildAt(i) as Object).id;	
					this.group[attibute_nombre].text=(this.group['OutputsObjects'].getChildAt(0) as Object).selectedItem[GET_INPUTFIELD_NAME(attibute_nombre)];
				}
				} 
			}else{
				this.group['submit'].enabled =true;	
				this.group['updates'].enabled =false;	
				App.getInstance().CLEAR_ALL_INPUTFIELDS();	 	
			}
			
		}
		
		public function SET_UPDATE(wiew_sw:Boolean):void
		{
			this.group["sw"]=wiew_sw;
			if(this.group["canvas_complete"]){	
				if(this.group["sw"]){
					this.group['submit'].enabled =false;	
					this.group['updates'].enabled =true;
					for(var i:int=0;i<=this.group['InputsObjects'].getChildren().length-1;i++) 
					{  
						if((this.group['InputsObjects'].getChildAt(i) as Object).className=='TextInput'||(this.group['InputsObjects'].getChildAt(i) as Object).className=='TextArea'){
							attibute_nombre=(this.group['InputsObjects'].getChildAt(i) as Object).id;	
							if((this.group['OutputsObjects'].getChildAt(0) as Object).selectedIndex>=0){
								this.group[attibute_nombre].text=(this.group['OutputsObjects'].getChildAt(0) as Object).selectedItem[GET_INPUTFIELD_NAME(attibute_nombre)];
							}
						}
					} 
				}
			}else{
				App.getInstance().CLEAR_ALL_INPUTFIELDS();	
			}
		}
		
		
		public function FIND_ALL_OBJECTS(e:ResultEvent):void
		{
			serilizacion=new Array();
			for (var i:String in ArrayUtil.toArray(e.result)){
				serilizacion.push(ArrayUtil.toArray(e.result)[i][0]);
			}
			this.group['datos'].dataProvider=serilizacion;
		} 
		
		
		public static function getInstance():App
		{
			if( instancia==null ) 
				instancia = new App();
			return instancia;
		}
		
		public function myfrom(object:Group):void
		{
			Alert.show(object['Att_name'].text);

		}
		
	}
}
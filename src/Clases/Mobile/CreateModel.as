	package Clases.Mobile
	{   
		import Clases.Database;
		
		import org.hamcrest.mxml.collection.Array;

		public class CreateModel
		{
			private static var instancia:CreateModel; 
			
			public function CreateModel()
			{
			}
			
			public function Relationship_SaveItems_Functions(Object:String,components:Array):String
			{ 
				var cadena:String="";
				if(components!=null){	
					for(var i:int=0;i<=components.length-1;i++)
					{	
						if(components[i].tipo=="Indeterminado"){
							if(components[i].tipo_relacion==3){  	
								cadena+="public function SaveMaterias(em:IEntityManager,data:ArrayCollection):ArrayCollection"+"\n";  
								cadena+="{"+"\n";  
								cadena+="	var materias:ArrayCollection = new ArrayCollection();"+"\n";  
								cadena+="	for (var i:int=0;i<=data.length-1;i++)"+"\n";  
								cadena+="	{"+"\n";  
								cadena+="		if (!(em.loadItem(Materia,data.getItemAt(i).id)as Materia)){"+"\n";  
								cadena+="			var materia:Materia=new Materia();"+"\n";  
								cadena+="			materia.codigo=data.getItemAt(i).codigo;"+"\n";  
								cadena+="			materia.name=data.getItemAt(i).name;"+"\n";  
								cadena+="			em.save(materia);"+"\n";  
								cadena+="			data.setItemAt(materia,i);"+"\n";  
								cadena+="		}else{"+"\n";  
								cadena+="			data.setItemAt(data.getItemAt(i),i);"+"\n";  
								cadena+="		}"+"\n";  
								cadena+="	}"+"\n";  
								cadena+="	return data;"+"\n";  
								cadena+="}"+"\n";  
				           }
				
							if(components[i].tipo_relacion==2){
								cadena+="public function SaveOrders(em:IEntityManager,data:ArrayCollection):ArrayCollection"+"\n";  
								cadena+="{"+"\n";  
								cadena+="	var list:ArrayCollection = new ArrayCollection();"+"\n";  
								cadena+="	for (var i:int=0;i<=data.length-1;i++)"+"\n";  
								cadena+="	{"+"\n";  
								cadena+="		if (!(em.loadItem(Order,data.getItemAt(i).id)as Order)){"+"\n";  
								cadena+="			var order:Order= new Order();"+"\n";  
								cadena+="			order.item=data.getItemAt(i).item;"+"\n";  
								cadena+="			list.addItem(order);"+"\n";  
								cadena+="		}"+"\n";  
								cadena+="	}"+"\n";  
								cadena+="	return list;"+"\n";  
								cadena+="}"+"\n";  
							}
						
						}	
					}
				}	
				return cadena;
			}
			
			
			public function Relationship_GetterAndSetter_Functions(Object:String,components:Array):String
			{  
				var cadena:String="";
				if(components!=null){	
					for(var i:int=0;i<=components.length-1;i++)
					{	
						if(components[i].tipo=="Indeterminado"){
							if(components[i].tipo_relacion==3){  
								cadena+="public function set orders(value:IList):void"+"\n";  
								cadena+="{"+"\n";  
								cadena+="	_orders = value;"+"\n";  
								cadena+="	for each(var order:Order in value)"+"\n";  
								cadena+="	{"+"\n";  
								cadena+="		order.estudiante = this;"+"\n";  
								cadena+="	}"+"\n";  
								cadena+="}"+"\n";  
								cadena+="public function get orders():IList"+"\n";  
								cadena+="{"+"\n";  
								cadena+="return _orders;"+"\n";  
								cadena+="}"+"\n";
							}
						}	
					}
				}
				return cadena;
			}
			
			
			//Only For Attribute OneToMany
			public function Relationship_Inverse_Column(Object:String,relations:Array):String
			{
				var cadena:String="";	
				if(relations!=null){	
					for(var i:int=0;i<=relations.length-1;i++)
					{
						if(relations[i].modulo_relacion=="3"){
							cadena+='[ManyToOne(name="estudiante_id", inverse="true")]'+"\n";  
							cadena+='public var estudiante:Estudiante;'+"\n";  
						}	
					}
				}
				return cadena;		
			}
			
			
			public function Relationship_Type_Column(Object:String,type:int):String
			{
				var cadena:String="";	
				//Relation  ManyToOne	
				if(type==1){
					cadena+="[ManyToOne]public var organization:Organization;"+"\n";  
				}
				
				if(type==2){
					cadena+='[ManyToMany(type="Models.Materia",cascade="save-update-delete")]public var materias:IList;'+"\n";   
				}
				
				if(type==3){
					cadena+='[OneToMany(type="Models.Order",cascade="save-update",indexed="true")]private var _orders:IList;'+"\n"; 
				}
				
				return cadena;	
			}	
			
			
			public function New_Model(id:String,Object:String,type:int):String
			{
				var cadena:String="";
				cadena+='package Models'+"\n";
				cadena+='{'+"\n";
				cadena+='	[Bindable]'+"\n";
				cadena+='	[Table(name="'+Object.toLocaleLowerCase()+'")]'+"\n";
				cadena+='	public class '+Object+''+"\n";
				cadena+='	{  '+"\n";
				cadena+='		[Id]'+"\n";
				cadena+='		public var id:int;'+"\n";
				cadena+=Relationship_Inverse_Column(Object,Database.getInstance().relacion.findBySQL("select * from relacions where tipo_relacion='3' and modulo_relacionado='"+id+"'"))+"\n";
				cadena+=CreateAttributes(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+=Relationship_GetterAndSetter_Functions(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"'"));
				cadena+=Relationship_SaveItems_Functions(Object,Database.getInstance().component.findBySQL("select * from componentes where modulo_id='"+id+"' and (tipo_relacion='3' or tipo_relacion='2')"));
				cadena+='}'+"\n";
				return cadena;
			}	
			
			public function CreateAttributes(Object:String,components:Array):String
			{
				var cadena:String="";
				for(var i:int=0;i<=components.length-1;i++)
				{
					if(components[i].tipo=="Numerico"){
						cadena+='        [Column(name="'+components[i].identificador+'")]'+"\n";
						cadena+='        public var '+components[i].identificador+':Number;'+"\n";
					}
					if(components[i].tipo=="Alfanumerico"){
						cadena+='        [Column(name="'+components[i].identificador+'")]'+"\n";
						cadena+='        public var '+components[i].identificador+':String;'+"\n";
					}
					if(components[i].tipo=="Indeterminado"){
						cadena+=Relationship_Type_Column(Object,components[i].tipo_relacion);	
					}
				}
				if(cadena!="")cadena+="\n";
				return cadena;
			}	
			
			
			public static function getInstance():CreateModel
			{
				if( instancia==null ) 
					instancia = new CreateModel();
				return instancia;
			}
			
			
			
		}
		
	}
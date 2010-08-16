<?php 
require_once ('ActiveRecord.php');

ActiveRecord\Config::initialize(function($cfg) {
            $cfg->set_model_directory('models');
            $cfg->set_connections(array('development' => 'mysql://root:@127.0.0.1/myescuela'));

        })






;


function Insert_Relations($param,$id) {
    $xml = simplexml_load_string($param['table_relations']);
    foreach ($xml->values  as $values) {
        relationship($param[(string)$values->name],$id);
    }
}

function Delete_Object($objects) {
    if (count($objects->object) > 0) {
        // display each payment for this order
        foreach ($order->payments as $payment)
            echo "  payment #$payment->id of $$payment->amount by " . $payment->person->name . "\n";
    }
}


function Save_Many_To_Many_Relation($xml,$id,$object,$object_relation) {
    $type="0";
    $root_table="";
    $relation_table="";
    $array = array();
    $xmlget = simplexml_load_string($xml);
    foreach ($xmlget->table  as $value) {
        foreach($value as $key1=>$value1) {
            if($key1=="root_table") {
                $root_table="id_".$value1;
            }else {
                $relation_table="id_".$value1;
            }
        }

    }

    foreach ($xmlget->values  as $value) {
        $array = array();
        $array_relation = array();
        $current_id="";
        foreach($value as $key1=>$value1) {
            if($key1=="id"&&$value1=="") {
                $type="1";
            }
            if($key1=="id"&&$value1!="") {
               $array_relation[$root_table]=$value1;
               $current_id=$value1;
               $type="0";
            }
            $array[$key1]=$value1;
        }

        if($type=="1") {
           $new_object=$object::create($array);
            $array_relation[$root_table]= $new_object->id;
    
         }else{
            $new_object=$object::find((int)$current_id);
            $new_object->update_attributes($array);
           }
        $array_relation[$relation_table]=$id;
        $object_relation::create($array_relation);

    }
}


function Delete_Many_To_Many_Relation($id,$objects,$foren_key) {

    foreach ($objects::find('all',array('conditions' => array(''.$foren_key.'=?',$id))) as $element) {
        $object=$objects::find($element->id);
        $object->delete();
    }

}


function amf($sMessage) {
    $cant=0;
    $array = array();
    foreach($sMessage as $key ) {
        $array[$cant]=array($key->attributes());
        $cant++;
    }
    return $array;
}


?>

<?php
include("lib/database.php");
class ComputadorasController {

    function index($param) {
        if ($param[type]=="all") {
            return amf(Computadora::find(all));
        }
        if ($param[type]=="create_list") {
            return amf(Computadora::find(all,array('select' => " 'false' as options,id,serial,descripcion")));
        }

         if ($param[type]=="update_list") {
          return amf(Computadora::find_by_sql("SELECT 'true' as options, id,serial,descripcion FROM computadoras WHERE id IN (SELECT id_computadoras AS id FROM estudiante_computadoras WHERE id_estudiantes='".$param[id]."') union SELECT 'false' as options, id,serial,descripcion FROM computadoras WHERE id NOT IN (SELECT id_computadoras AS id FROM estudiante_computadoras WHERE id_estudiantes='".$param[id]."')"));
         }

    }

  function create($param) {
        $Computadora = new Computadora($param);
        if ($Computadora->is_valid()) {
            $Computadora->save();
            return 0;
        }else {
            return 1;
        }
    }


    function destroy ($param) {
        $Computadora = Computadora::find($param[id]);
        if ($Computadora->is_valid()) {
            $Computadora->delete();
            return 0;
        }else {
            return  1;
        }
    }



    function update($param) {
        $Computadora = Computadora::find_by_id($param[id]);
        if ($Computadora->is_valid()) {
            $Computadora->update_attributes($param);
            return 0;
        }else {
            return 1;
        }
    }



}

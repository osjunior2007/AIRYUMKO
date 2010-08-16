<?php
include("lib/database.php");
class MateriasController {

    function index($param) {
        if ($param[type]=="all") {
            return amf(Materia::find(all));
        }
        if ($param[type]=="create_list") {
            return amf(Materia::find(all,array('select' => " 'false' as options,id,nombre,codigo")));
        }

       if ($param[type]=="update_list") {
            return amf(Materia::find_by_sql("SELECT 'true' as options, id,nombre,codigo FROM materias WHERE id IN (SELECT id_materias as id FROM estudiante_materias WHERE id_estudiantes='".$param[id]."') union SELECT 'false' as options, id,nombre,codigo FROM materias WHERE id NOT IN (SELECT id_materias as id FROM estudiante_materias WHERE id_estudiantes='".$param[id]."')"));
        }
    }

    



    function create($param) {
        $Materia = new Materia($param);
        if ($Materia->is_valid()) {
            $Materia->save();
            return 0;
        }else {
            return 1;
        }
    }


    function destroy ($param) {
        $Materia = Materia::find($param[id]);
        if ($Materia->is_valid()) {
            $Materia->delete();
            return 0;
        }else {
            return  1;
        }
    }



    function update($param) {
        $Materia = Materia::find_by_id($param[id]);
        if ($Materia->is_valid()) {
            $Materia->update_attributes($param);
            return 0;
        }else {
            return 1;
        }
    }



}

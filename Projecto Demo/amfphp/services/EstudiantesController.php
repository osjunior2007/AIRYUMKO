<?php
include("lib/database.php");
class EstudiantesController {

    function index() {
        return amf(Estudiante::find(all));
    }


    function create($param) {
        $Estudiante = new Estudiante();
        $Estudiante->name=$param['name'];
        $Estudiante->last_name=$param['last_name'];
        if ($Estudiante->is_valid()) {
            $Estudiante->save();
            Save_Many_To_Many_Relation($param['materias'],$Estudiante->id,new materia(),new estudiante_materia());
            Save_Many_To_Many_Relation($param['computadoras'],$Estudiante->id,new computadora(),new estudiante_computadora());
            return 0;
        }else {
            return 1;
        }
    }


    function destroy ($param) {
        $Estudiante = Estudiante::find($param[id]);
        Delete_Many_To_Many_Relation($param[id],Estudiante_materia,"id_estudiantes");
        Delete_Many_To_Many_Relation($param[id],Estudiante_computadora,"id_estudiantes");
        if ($Estudiante->is_valid()) {
            $Estudiante->delete();
            return 0;
        }else {
            return  1;
        }
    }



    function update($param) {
        $Estudiante = Estudiante::find_by_id($param[id]);
        $Estudiante->name=$param['name'];
        $Estudiante->last_name=$param['last_name'];

        Delete_Many_To_Many_Relation($param[id],Estudiante_materia,"id_estudiantes");
        Delete_Many_To_Many_Relation($param[id],Estudiante_computadora,"id_estudiantes");
    
        if ($Estudiante->is_valid()) {
            $Estudiante->save();
            Save_Many_To_Many_Relation($param['materias'],$Estudiante->id,new materia(),new estudiante_materia());
            Save_Many_To_Many_Relation($param['computadoras'],$Estudiante->id,new computadora(),new estudiante_computadora());
            return 0;
        }else {
            return 1;
        }
    }



}

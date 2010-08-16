CREATE DATABASE /*!32312 IF NOT EXISTS*/`myescuela` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `myescuela`;
CREATE TABLE`estudiantes_materias` (
`id` bigint(11) NOT NULL AUTO_INCREMENT,
`id_materias` int (5) DEFAULT NULL, 
`id_estudiantes` int (5) DEFAULT NULL, 
PRIMARY KEY (`id`) 
)ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;

CREATE TABLE`estudiantes_computadoras` (
`id` bigint(11) NOT NULL AUTO_INCREMENT,
`id_computadoras` int (5) DEFAULT NULL, 
`id_estudiantes` int (5) DEFAULT NULL, 
PRIMARY KEY (`id`) 
)ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;

CREATE TABLE`estudiantes` (
`id` bigint(11) NOT NULL AUTO_INCREMENT,
`name` varchar (45) DEFAULT NULL,
`last_name` varchar (45) DEFAULT NULL,
PRIMARY KEY (`id`) 
)ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;

CREATE TABLE`materias` (
`id` bigint(11) NOT NULL AUTO_INCREMENT,
`nombre` varchar (40) DEFAULT NULL,
`codigo` varchar (4) DEFAULT NULL,
PRIMARY KEY (`id`) 
)ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;

CREATE TABLE`computadoras` (
`id` bigint(11) NOT NULL AUTO_INCREMENT,
`serial` varchar (5) DEFAULT NULL,
`descripcion` varchar (20) DEFAULT NULL,
PRIMARY KEY (`id`) 
)ENGINE=MyISAM AUTO_INCREMENT=40001 DEFAULT CHARSET=latin1;


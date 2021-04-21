######################
# user = ISIC_IS     #
# pass = 1S_5%g4&21  #
######################

DROP SCHEMA SIAE;
CREATE SCHEMA IF NOT EXISTS SIAE 
 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE SIAE;

-- -----------------------------------------------------
-- Table `SIAE`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Usuarios` (
  idUsuario VARCHAR(20) NOT NULL,
  nombre_1 VARCHAR(45) NOT NULL,
  nombre_2 VARCHAR(45) NULL DEFAULT NULL,
  nombre_3 VARCHAR(45) NULL DEFAULT NULL,
  apellido_pat VARCHAR(45) NOT NULL,
  apellido_mat VARCHAR(45) NULL,
  correo_inst VARCHAR(45) NOT NULL,
  rol CHAR(1) NOT NULL
  CONSTRAINT `chk_Usuarios_rol`CHECK ( rol in('A', 'R', 'G')) ENFORCED
  COMMENT 'El rol puede ser: (A) alumno, (G) jefe, (R) representante',
  contra VARCHAR(128) NOT NULL,
  numTel VARCHAR(10) NULL DEFAULT NULL,
  foto MEDIUMBLOB NULL,
  PRIMARY KEY (idUsuario)
);

-- -----------------------------------------------------
-- Table `SIAE`.`Responsable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Responsables` (
  tipo CHAR(1) NULL
  CONSTRAINT `chk_Responsables_tipo`CHECK ( tipo in('D', 'E')) ENFORCED
    COMMENT 'El tipo de responsable puede ser: (D) docente o (E) encargado',
  idUsuario VARCHAR(20) NOT NULL,
  PRIMARY KEY (idUsuario),
  CONSTRAINT `fk_Responsables_Usuarios1`
    FOREIGN KEY (idUsuario)
    REFERENCES `SIAE`.`Usuarios` (idUsuario)
);

-- -----------------------------------------------------
-- Table `mydb`.`Asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Asignaturas` (
  idAsignatura INT NOT NULL,
  semestre INT NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  area CHAR(2) NOT NULL
  CONSTRAINT `chk_Asignaturas_area`CHECK ( area IN('CB', 'CI', 'IA', 'DI', 'CS', 'CE','CC') ) ENFORCED
   COMMENT 'El area puede ser (CB), (CI), (IA), (DI), (CS), (CC)',
  credito INT NOT NULL
   CONSTRAINT `chk_Asignaturas_credito`CHECK ( credito BETWEEN 0 AND 10 ) ENFORCED
   COMMENT 'El credito puede ser entre 0 y 10',
  estado CHAR(1) NOT NULL
   CONSTRAINT `chk_Asignaturas_estado`CHECK ( estado in('E', 'D')) ENFORCED
   COMMENT 'El estado puede ser: (E) enable o (D) disable',
  PRIMARY KEY (idAsignatura)
);

-- -----------------------------------------------------
-- Table `SIAE`.`AreasApoyo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`AreasApoyo` (
  idAreasApoyo INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  url VARCHAR(200) NOT NULL,
  dia VARCHAR(20) NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  codigo VARCHAR(100) NULL,
  idResponsable VARCHAR(20) NOT NULL,
  idAsignatura INT NULL,
  estado CHAR(1) NOT NULL
  CONSTRAINT `chk_AreasApoyo_estado`CHECK ( estado IN('E', 'D') ) ENFORCED
   COMMENT 'El area puede ser (E) habilidato, (D) desabilitado',
  PRIMARY KEY (idAreasApoyo),
  CONSTRAINT `fk_AreasApoyo_Asignaturas`
    FOREIGN KEY (idAsignatura)
    REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_AreasApoyo_Responsables`
    FOREIGN KEY (idResponsable)
    REFERENCES Responsables (idUsuario),
  CONSTRAINT `chk_AreasApoyo_horario`
    CHECK( hora_inicio < hora_fin ) ENFORCED
);


-- -----------------------------------------------------
-- Table `SIAE`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Cursos` (
  idCurso INT NOT NULL,
  tipo CHAR(1) NOT NULL
  CONSTRAINT `chk_Cursos_tipo`CHECK ( tipo in('O', 'V')) ENFORCED
    COMMENT 'El tipo de curso puede ser: (O) ordinario o (V) verano',
  estado CHAR(1) NOT NULL
    CONSTRAINT `chk_Cursos_estado`CHECK ( estado in('E', 'D')) ENFORCED
    COMMENT 'El estado puede ser: (E) enable o (D) disable',
  cupo INT NOT NULL
  CONSTRAINT `chk_Cursos_cupo`CHECK ( cupo > 0 ) ENFORCED
   COMMENT 'El cupo debe de ser mayor mayor de cero',
  idAsignatura INT NOT NULL,
  idResponsable VARCHAR(20) NOT NULL,
  PRIMARY KEY (idCurso),
  CONSTRAINT `fk_Curso_Asignaturas`
    FOREIGN KEY (idAsignatura)
    REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_Curso_Responsable1`
    FOREIGN KEY (idResponsable)
    REFERENCES Responsables (idUsuario)
);


-- -----------------------------------------------------
-- Table `SIAE`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Alumnos` (
  matricula VARCHAR(20) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  PRIMARY KEY (matricula),
  CONSTRAINT `fk_Alumnos_Usuarios`
    FOREIGN KEY (matricula)
    REFERENCES Usuarios (idUsuario)
);

-- -----------------------------------------------------
-- Table `SIAE`.`Cursos_Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Cursos_Alumnos` (
  idCurso INT NOT NULL,
  estado CHAR(1) NOT NULL
    CONSTRAINT `chk_Cursos_Alumnos_estado`CHECK ( estado in('S', 'A', 'R')) ENFORCED
    COMMENT 'El estado puede ser: (S) solicitado, (A) aceptado o (R) revocado',
  reporte CHAR(1) NOT NULL DEFAULT 'P'
    CONSTRAINT `chk_Cursos_Alumnos_reporte`CHECK ( reporte in('P','A', 'R')) ENFORCED
    COMMENT 'El estado puede ser: (P) sin registro, (A) aprovado o (R) reprovado',
  matricula VARCHAR(20) NOT NULL,
  PRIMARY KEY (idCurso, matricula),
  CONSTRAINT `fk_Cursos_Alumnos_Alumnos`
    FOREIGN KEY (matricula)
    REFERENCES Alumnos (matricula),
    CONSTRAINT `fk_Cursos_Alumnos_Cursos`
    FOREIGN KEY (idCurso)
    REFERENCES Cursos (idCurso)
);


-- -----------------------------------------------------
-- Table `SIAE`.`Dependencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Dependencias` (
  tipo CHAR(1) NOT NULL
  CONSTRAINT `chk_Dependencias_tipo`CHECK ( tipo in('S', 'C')) ENFORCED
    COMMENT 'El tipo de dependencia puede ser: (S) seriada o (C) Competencia',
  idAsignatura_p INT NOT NULL,
  idAsignatura_h INT NOT NULL,
  PRIMARY KEY (idAsignatura_p, idAsignatura_h),
  CONSTRAINT `fk_Asignaturas_has_Asignaturas_Asignaturas1`
    FOREIGN KEY (idAsignatura_p)
    REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_Dependencias_Asignaturas_h`
    FOREIGN KEY (idAsignatura_h)
    REFERENCES Asignaturas (idAsignatura)
);


-- -----------------------------------------------------
-- Table `SIAE`.`Sesiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Sesiones` (
  idSesion INT NOT NULL AUTO_INCREMENT,
  idCurso INT NOT NULL,
  dia VARCHAR(20) NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  PRIMARY KEY (idSesion),
  CONSTRAINT `fk_Sesiones_Curso1`
    FOREIGN KEY (idCurso)
    REFERENCES Cursos (idCurso),
  CONSTRAINT `chk_Sesiones_horario1`
    CHECK( hora_inicio < hora_fin ) ENFORCED
);



DROP PROCEDURE IF EXISTS proce_nuevo_user;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_user(
    in in_idUsuario VARCHAR(20), in in_nombre_1 VARCHAR(45), in in_nombre_2 VARCHAR(45), in in_nombre_3 VARCHAR(45), in in_apellido_pat VARCHAR(45),
    in in_apellido_mat VARCHAR(45), in in_correo_inst VARCHAR(45), in in_rol CHAR(1), in in_contra VARCHAR(20), in in_num_tel VARCHAR(10))
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg = '1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Usuarios VALUES(in_idUsuario, 
            in_nombre_1, in_nombre_2, in_nombre_3, 
            in_apellido_pat, in_apellido_mat, 
            in_correo_inst, in_rol, SHA2(in_contra, 512), in_num_tel, null);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

CALL proce_nuevo_user(null,'Emeling','Dayan',null,'Ramirez','Garcia','edramirez@itsoeh.edu.mx','A','edramirez','7732234176');
-- idUsuario, nombre_1, nombre_2, nombre_3, apellido_pat, apellido_mat, correo_inst, rol('A', 'R', 'G'), 
CALL proce_nuevo_user('18011830','Emeling','Dayan',null,'Ramirez','Garcia','edramirez@itsoeh.edu.mx','A','edramirez','7732234176');
CALL proce_nuevo_user('18011225','Oswaldo','Jesus',null,'Hernandez','Gomez','ojhernandez@itsoeh.edu.mx','A','ojhernandez','7731314798');
CALL proce_nuevo_user('18011362','Nazareth','Zurisay',null,'Morales','Gino','nzmorales@itsoeh.edu.mx','A','nzmorales','7731103479');
CALL proce_nuevo_user('18011250','Sandra','Monserrat',null,'Bautista','Lopez','sbautista@itsoeh.edu.mx','A','sbautista','7721573570');
CALL proce_nuevo_user('18011530','Carlos','Gabriel',null,'Cruz','Chontal','cgcruz@itsoeh.edu.mx','A','cgcruz','7732010026');
CALL proce_nuevo_user('18011126','Daniel',null,null,'Hernandez','Reyes','dhernandezr@itsoeh.edu.mx','A','dhernandezr','7731171548');
CALL proce_nuevo_user('18011378','Joyce',null,null,'Gress','Hernandez','jgressh@itsoeh.edu.mx','A','jgressh','7712412085');
CALL proce_nuevo_user('D00001','Cristy','Elizabeth',null,'Aguilar','Ojeda','caguilar@itsoeh.edu.mx','R','caguilar','7721619498');
CALL proce_nuevo_user('D00002','Hector','Daniel',null,'Hernandez','Garcia','hdhernandez@itsoeh.edu.mx','R','hdhernandez','7731379500');
CALL proce_nuevo_user('D00006','Dulce','Jazmin',null,'Navarrete','Arias','dnaverrete@itsoeh.edu.mx','R','dnavarrete','2224926179');
CALL proce_nuevo_user('D00003','Aline',null,null,'Perez','Martinez','aperezm@itsoeh.edu.mx','R','aperezm','7727364142');
CALL proce_nuevo_user('D00004','Guadalupe',null,null,'Calvo','Torres','gcalvo@itsoeh.edu.mx','R','gcalvo','7732250534');
CALL proce_nuevo_user('D00005','German',null,null,'Rebolledo','Avalos','grevolledo@itsoeh.edu.mx','R','grevolledo','7721599140');
CALL proce_nuevo_user('D00007','Elizabeth',null,null,'Garcia','Rios','egarcia@itsoeh.edu.mx','R','egarcia',null);
CALL proce_nuevo_user('D00008','Eliut',null,null,'Paredes','Reyes','eparedes@itsoeh.edu.mx','R','eparedes',null);
CALL proce_nuevo_user('D00009','Mario',null,null,'Perez','Bautista','mperez@itsoeh.edu.mx','R','mperez','7721315041');
CALL proce_nuevo_user('D00010','Jorge','Armando',null,'Garcia','Bautista','jgarciab@itsoeh.edu.mx','R','jgarciab','7731798374');
CALL proce_nuevo_user('D00011','Javier',null,null,'Perez','Escamilla','japereze@itsoeh.edu.mx','R','japerezm','7731375841');
CALL proce_nuevo_user('D00012','Lucino',null,null,'Lugo','Lopez','llugol@itsoeh.edu.mx','R','llugol',null);
CALL proce_nuevo_user('D00013','Lorena',null,null,'Mendoza','Guzman','lmendozag@itsoeh.edu.mx','R','lmendozag',null);
CALL proce_nuevo_user('D00014','Juan','Carlos',null,'Ceron','Almaraz','jcerona@itsoeh.edu.mx','R','jcerona',null);
CALL proce_nuevo_user('D00015','Guillermo',null,null,'Castañeda','Ortiz','gcastanedao@itsoeh.edu.mx','R','gcastanedao',null);
CALL proce_nuevo_user('R00014','Gloria','Maria',null,'Álvarez','Herver','galvarez@itsoeh.edu.mx ','R','galvarez', null);
CALL proce_nuevo_user('R00015','Antelmo','Arturo',null,'Arteaga','Valera','aarteaga@itsoeh.edu.mx','R','aarteaga',null);
CALL proce_nuevo_user('R00013','Lucía',null,null,'Rivas','Apiliado','lrivas@itsoeh.edu.mx','R','lrivas',null);
CALL proce_nuevo_user('R00016','Alberto',null,null,'Montoya','Buendia','amontoyab@itsoeh.edu.mx','R','amontoyab',null);
CALL proce_nuevo_user('G1234A','Administrador',null,null,'root','sudo','dever@itsoeh.edu.mx','G','root',null);


DROP PROCEDURE IF EXISTS proce_nueva_asig;
DELIMITER $$
CREATE PROCEDURE proce_nueva_asig(in in_idAsignatura INT, in in_semestre INT, in in_nombre VARCHAR(70), in in_area CHAR(2), in in_credito INT, in in_estado CHAR(1))
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg = '1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Asignaturas VALUES(in_idAsignatura, in_semestre, in_nombre, in_area, in_credito, in_estado);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;
-- area IN('CB', 'CI', 'IA', 'DI', 'CS', 'CE','CC')
-- estado in('E', 'D')
-- credito BETWEEN 0 AND 10
-- idAsignatura, semestre, nombre, credito(0 AND 10 ), estado ('E', 'D')
CALL proce_nueva_asig(101,1, 'Cálculo Diferencial','CB',5,'E');
CALL proce_nueva_asig(201,1, 'Fundamentos de Programación','IA',5,'E');
CALL proce_nueva_asig(301,1, 'Taller de Ética','CS',4,'E');
CALL proce_nueva_asig(401,1, 'Matemáticas Discretas','CB',5,'E');
CALL proce_nueva_asig(501,1, 'Taller de Administración','CE',4,'E');
CALL proce_nueva_asig(601,1, 'Fundamentos de Investigación','CS',4,'E');

CALL proce_nueva_asig(102,2, 'Cálculo Integral','CB','5','E');
CALL proce_nueva_asig(202,2, 'Programación Orientada a Objetos','CI','5','E');
CALL proce_nueva_asig(302,2, 'Contabilidad Financiera','CE','4','E');
CALL proce_nueva_asig(402,2, 'Química','CB','4','E');
CALL proce_nueva_asig(502,2, 'Álgebra Lineal','CB','5','E');
CALL proce_nueva_asig(602,2, 'Probabilidad y Estadística','CB','5','E');

CALL proce_nueva_asig(103,3, 'Cálculo Vectorial','CB',5,'E');
CALL proce_nueva_asig(203,3, 'Estructura de Datos','CI',5,'E');
CALL proce_nueva_asig(303,3, 'Cultura Empresarial','CE',4,'E');
CALL proce_nueva_asig(403,3, 'Investigación de Operaciones','CB',4,'E');
CALL proce_nueva_asig(503,3, 'Sistemas Operativos I','CI',4,'E');
CALL proce_nueva_asig(603,3, 'Física General','CB',5,'E');

CALL proce_nueva_asig(104,4, 'Ecuaciones Diferenciales','CB','5','E');
CALL proce_nueva_asig(204,4, 'Métodos Numéricos','CB','4','E');
CALL proce_nueva_asig(304,4, 'Tópicos Avanzados de Programación','CI',5,'E');
CALL proce_nueva_asig(404,4, 'Fundamentos de Base de Datos','IA','5','E');
CALL proce_nueva_asig(504,4, 'Taller de Sistemas Operativos','DI','4','E');
CALL proce_nueva_asig(604,4, 'Principios Eléctricos y Aplicaciones Digitales','CI','5','E');

CALL proce_nueva_asig(105,5, 'Desarrollo Sustentable','CC',5,'E');
CALL proce_nueva_asig(205,5, 'Fundamentos de Telecomunicaciones','CI',4,'E');
CALL proce_nueva_asig(305,5, 'Taller de Base de Datos','DI',4,'E');
CALL proce_nueva_asig(405,5, 'Simulación','IA',5,'E');
CALL proce_nueva_asig(505,5, 'Fundamentos de Ingeniería de Software','IA',4,'E');
CALL proce_nueva_asig(605,5, 'Arquitectura de Computadoras','IA',5,'E');
CALL proce_nueva_asig(705,5, 'Programación Web','DI',5,'E');

CALL proce_nueva_asig(106,6, 'Lenguajes y Autómatas I','IA','5','E');
CALL proce_nueva_asig(206,6, 'Redes de Computadoras','DI','5','E');
CALL proce_nueva_asig(306,6, 'Administración de Base de Datos','DI','5','E');
CALL proce_nueva_asig(406,6, 'Programación Lógica y Funcional','IA','4','E');
CALL proce_nueva_asig(506,6, 'Ingeniería de Software','DI','5','E');
CALL proce_nueva_asig(606,6, 'Lenguajes de Interfaz','IA','4','E');
CALL proce_nueva_asig(706,6, 'Taller de investigación I','CS','4','E');

CALL proce_nueva_asig(107,7, 'Lenguajes y Autómatas II','DI','5','E');
CALL proce_nueva_asig(207,7, 'Conmutación y Enrutamiento en Redes de Datos','DI','5','E');
CALL proce_nueva_asig(307,7, 'Inteligencia Artificial','DI','4','E');
CALL proce_nueva_asig(407,7, 'Gestión de Proyectos de Software','IA','6','E');
CALL proce_nueva_asig(507,7, 'Sistemas Programables','DI','4','E');

CALL proce_nueva_asig(108,8, 'Graficación','DI','4','E');
CALL proce_nueva_asig(208,8, 'Administración de redes','DI','4','E');
CALL proce_nueva_asig(308,8, 'Taller de investigación II','CS','4','E');

-- ('S08','8','Servicio Social','','10','E');
-- ('109','9','Residencia','','10','E');
 
-- tipo('S', 'C'), idAsignatura_p, idAsignatura_h
INSERT INTO Dependencias
 VALUES('S', '102', '101'),
       ('S', '202', '201'),
       ('S', '103', '102'),
       ('S', '203', '202'),
       ('S', '104', '103'),
       ('S', '304', '202'),
       ('S', '504', '503'),
       ('S', '305', '404'),
       ('S', '405', '403'),
       ('S', '605', '604'),
       ('S', '206', '205'),
       ('S', '506', '505'),
       ('S', '107', '106'),
       ('S', '307', '406'),
       ('S', '507', '606'),
       ('S', '308', '706');

DROP PROCEDURE IF EXISTS proce_nuevo_respo;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_respo(in in_tipo CHAR(1), in in_idUsuario VARCHAR(20))
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;                                                                                                                         
        INSERT INTO Responsables VALUES(in_tipo, in_idUsuario);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;
-- tipo in('D', 'E')
-- CALL proce_nuevo_respo('D','100');

CALL proce_nuevo_respo('D','D00001');
CALL proce_nuevo_respo('D','D00002');
CALL proce_nuevo_respo('D','D00003');
CALL proce_nuevo_respo('D','D00004');
CALL proce_nuevo_respo('D','D00005');
CALL proce_nuevo_respo('D','D00006');
CALL proce_nuevo_respo('D','D00007');
CALL proce_nuevo_respo('D','D00008');
CALL proce_nuevo_respo('D','D00009');
CALL proce_nuevo_respo('D','D00010');
CALL proce_nuevo_respo('D','D00011');
CALL proce_nuevo_respo('D','D00012');
CALL proce_nuevo_respo('D','D00013');
CALL proce_nuevo_respo('D','D00014');
CALL proce_nuevo_respo('D','D00015');
CALL proce_nuevo_respo('E','R00016');


DROP PROCEDURE IF EXISTS proce_nueva_area;
DELIMITER $$
CREATE PROCEDURE proce_nueva_area( in in_nombre VARCHAR(45), in in_url VARCHAR(200), in dia VARCHAR(20), in in_hora_inicio TIME,
    in in_hora_fin TIME, in in_codigo VARCHAR(100), in in_idResponsable VARCHAR(20), in in_idAsignatura INT, in in_estado CHAR(1)
)
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO AreasApoyo(nombre, url, dia, hora_inicio, hora_fin, codigo, idResponsable, idAsignatura, estado) 
        VALUES(in_nombre, in_url, dia, in_hora_inicio, in_hora_fin, in_codigo, in_idResponsable, in_idAsignatura, in_estado);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

-- idAreasApoyo, nombre, url, dia, hora_inicio, hora_fin, codigo,idResponsable, idAsignatura
CALL proce_nueva_area('Asesoria','https://us04web.zoom.us/j/79372928750?pwd=R2svczlSaGR1T2pDenhqMGtYYUoyQT09','Lunes','7:00','9:00','','D00001',101,'D');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Lunes','14:00','17:00','','D00007',204,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Martes','7:00','8:00','', 'D00007',706,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Viernes','12:00','13:00','', 'D00007',706,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','12:00','13:00','', 'D00009',106,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','13:00','14:00','', 'D00009',106,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','16:00','17:00','', 'D00009',202,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','17:00','18:00','', 'D00009',202,'E');
 -- (9,'Asesoria','https://meet.google.com/waj-empi-zjo','Lunes','15:00','16:00','',1,###);
CALL proce_nueva_area('Asesoria','https://meet.google.com/waj-empi-zjo','Martes','13:00','14:00','', 'D00001',506,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Lunes','12:00','13:00','', 'D00004',606,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Martes','17:00','18:00','', 'D00004',606,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Viernes','7:00','8:00','', 'D00004',null,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Martes','13:00','14:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',106,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','8:00','9:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',304,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','12:00','13:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',406,'E');
 -- (17,'Asesoria','https://meet.google.com/lookup/el4fu65dax','Lunes','10:00','11:00','',3,202);
CALL proce_nueva_area('Asesoria','https://meet.google.com/hcy-nggn-wdx','Miercoles','16:00','17:00','',                               'D00015',null,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/lookup/fu4xegew2b','Viernes','16:00','18:00','',                            'D00014',101,'E');


DROP PROCEDURE IF EXISTS proce_nuevo_curso;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_curso( in in_idCurso INT, in in_tipo CHAR(1), in in_estado CHAR(1), in in_cupo INT,
    in in_idAsignatura INT, in in_idResponsable VARCHAR(20) )
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Cursos(idCurso, tipo, estado, cupo, idAsignatura, idResponsable) 
            VALUES(in_idCurso, in_tipo, in_estado, in_cupo, in_idAsignatura, in_idResponsable);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;



-- idCurso, tipo('O', 'V'), estado('E', 'D'), cupo, idAsignatura, idResponsable
CALL proce_nuevo_curso(1001, 'O', 'E',30, 201, 'D00005');
CALL proce_nuevo_curso(1005, 'O', 'D',30, 401, 'D00013');
CALL proce_nuevo_curso(1006, 'O', 'E',15, 101, 'D00010');
CALL proce_nuevo_curso(1007, 'O', 'E',10, 301, 'D00012');
CALL proce_nuevo_curso(1008, 'O', 'E',30, 501, 'D00003');
CALL proce_nuevo_curso(1010, 'O', 'E',30, 601, 'D00006');
CALL proce_nuevo_curso(1003, 'O', 'E',20, 502, 'D00002');
CALL proce_nuevo_curso(1025, 'O', 'E',30, 602, 'D00001');
CALL proce_nuevo_curso(1026, 'O', 'E',15, 102, 'D00004');
CALL proce_nuevo_curso(1027, 'O', 'E',10, 302, 'D00007');
CALL proce_nuevo_curso(1028, 'O', 'E',30, 202, 'D00008');
CALL proce_nuevo_curso(1023, 'O', 'E',20, 402, 'D00009');
CALL proce_nuevo_curso(1014, 'O', 'E',10, 303, 'D00011');
CALL proce_nuevo_curso(1016, 'O', 'E',15, 503, 'D00014');
CALL proce_nuevo_curso(1017, 'O', 'E',10, 603, 'D00015');
CALL proce_nuevo_curso(1011, 'O', 'E',30, 103, 'D00005');
CALL proce_nuevo_curso(1012, 'O', 'E',10, 203, 'D00007');
CALL proce_nuevo_curso(1015, 'O', 'E',30, 403, 'D00003');
CALL proce_nuevo_curso(1041, 'O', 'D',30, 104, 'D00001');
CALL proce_nuevo_curso(1045, 'O', 'E',30, 404, 'D00004');
CALL proce_nuevo_curso(1043, 'O', 'E',20, 204, 'D00002');
CALL proce_nuevo_curso(1046, 'O', 'E',15, 504, 'D00006');
CALL proce_nuevo_curso(1047, 'O', 'E',10, 304, 'D00008');
CALL proce_nuevo_curso(1048, 'O', 'E',30, 604, 'D00009');
CALL proce_nuevo_curso(1054, 'O', 'E',10, 305, 'D00010');
CALL proce_nuevo_curso(1052, 'O', 'E',10, 605, 'D00012');
CALL proce_nuevo_curso(1056, 'O', 'E',10, 205, 'D00011');
CALL proce_nuevo_curso(1058, 'O', 'E',30, 105, 'D00014');
CALL proce_nuevo_curso(1057, 'O', 'E',10, 405, 'D00013');
CALL proce_nuevo_curso(1060, 'O', 'E',30, 505, 'D00015');
CALL proce_nuevo_curso(1059, 'O', 'E',30, 705, 'D00005');
       
CALL proce_nuevo_curso(1064, 'O', 'E',10, 206, 'D00001');
CALL proce_nuevo_curso(1062, 'O', 'E',10, 406, 'D00007');
CALL proce_nuevo_curso(1067, 'O', 'E',10, 306, 'D00011');
CALL proce_nuevo_curso(1068, 'O', 'E',30, 706, 'D00014');
CALL proce_nuevo_curso(1066, 'O', 'E',10, 606, 'D00009');
CALL proce_nuevo_curso(1070, 'O', 'E',30, 506, 'D00015');
CALL proce_nuevo_curso(1069, 'O', 'E',30, 106, 'D00002');
CALL proce_nuevo_curso(1074, 'V', 'E',10, 206, 'D00003');
CALL proce_nuevo_curso(1072, 'V', 'E',10, 406, 'D00004');
CALL proce_nuevo_curso(1076, 'V', 'E',10, 306, 'D00005');
CALL proce_nuevo_curso(1078, 'V', 'E',30, 706, 'D00006');
CALL proce_nuevo_curso(1073, 'V', 'E',10, 606, 'D00008');
CALL proce_nuevo_curso(1080, 'V', 'E',30, 506, 'D00010');
CALL proce_nuevo_curso(1079, 'V', 'E',30, 106, 'D00012');


DROP PROCEDURE IF EXISTS proce_nueva_sesion;
DELIMITER $$
CREATE PROCEDURE proce_nueva_sesion( in in_idCurso INT, in in_dia VARCHAR(20), in in_hora_inicio TIME, in in_hora_fin TIME )
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = TRUE; END;
    SELECT count(*) INTO count FROM SIAE.Sesiones WHERE (idCurso = in_idCurso) AND dia = in_dia AND hora_inicio = in_hora_inicio;
    IF count > 0 THEN SET t_msg = 'XXXX La Sesión ya existe'; SET t_error = TRUE; END IF;
    START TRANSACTION;
        INSERT INTO Sesiones(idCurso, dia, hora_inicio, hora_fin) 
            VALUES(in_idCurso, in_dia, in_hora_inicio, in_hora_fin);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;


-- idSeiones, idCurso, dia, horaInicio, horaFin,
CALL proce_nueva_sesion(1001, 'Martes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1005, 'Miercoles', '7:00',   '09:00');
CALL proce_nueva_sesion(1006, 'Lunes',     '14:00',  '16:00');
CALL proce_nueva_sesion(1007, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1008, 'Jueves',    '9:00',   '11:00');
CALL proce_nueva_sesion(1010, 'Martes',    '11:00',  '13:00');
CALL proce_nueva_sesion(1001, 'Miercoles', '9:00',   '11:00');
CALL proce_nueva_sesion(1005, 'Martes',    '7:00',   '09:00');
CALL proce_nueva_sesion(1006, 'Jueves',    '14:00',  '16:00');
CALL proce_nueva_sesion(1007, 'Martes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1008, 'Lunes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1010, 'Viernes',  '11:00',  '13:00');
       
CALL proce_nueva_sesion(1003, 'Lunes',     '10:00',  '12:00');
CALL proce_nueva_sesion(1025, 'Viernes',   '7:00',   '9:00');
CALL proce_nueva_sesion(1026, 'Lunes',     '12:00',  '13:00');
CALL proce_nueva_sesion(1027, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1028, 'Martes',    '14:00',  '16:00');
CALL proce_nueva_sesion(1023, 'Lunes',     '10:00',  '12:00');
CALL proce_nueva_sesion(1003, 'Martes',     '10:00',  '12:00');
CALL proce_nueva_sesion(1025, 'Lunes',   '7:00',   '9:00');
CALL proce_nueva_sesion(1026, 'Viernes',     '12:00',  '13:00');
CALL proce_nueva_sesion(1027, 'Lunes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1028, 'Lunes',    '14:00',  '16:00');
CALL proce_nueva_sesion(1023, 'Viernes',     '10:00',  '12:00');
       
CALL proce_nueva_sesion(1014, 'Jueves',    '9:00',   '12:00');
CALL proce_nueva_sesion(1016, 'Lunes',     '12:00',  '13:00');
CALL proce_nueva_sesion(1017, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1011, 'Martes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1012, 'Viernes',   '11:00',  '12:00');
CALL proce_nueva_sesion(1015, 'Viernes',   '7:00',   '9:00');

CALL proce_nueva_sesion(1041, 'Martes',    '11:00',  '13:00');
CALL proce_nueva_sesion(1045, 'Viernes',   '7:00',   '9:00');
CALL proce_nueva_sesion(1043, 'Lunes',     '10:00',  '12:00');
CALL proce_nueva_sesion(1046, 'Lunes',     '12:00',  '13:00');
CALL proce_nueva_sesion(1047, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1048, 'Martes',    '14:00',  '16:00');
       
CALL proce_nueva_sesion(1054, 'Jueves',    '8:00',   '9:00');
CALL proce_nueva_sesion(1052, 'Miercoles', '13:00',  '15:00');
CALL proce_nueva_sesion(1056, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1058, 'Martes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1057, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1060, 'Lunes',     '14:00',  '16:00');
CALL proce_nueva_sesion(1059, 'Martes',    '9:00',   '11:00');
       
CALL proce_nueva_sesion(1064, 'Jueves',    '8:00',   '9:00');
CALL proce_nueva_sesion(1062, 'Miercoles', '13:00',  '15:00');
CALL proce_nueva_sesion(1067, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1068, 'Martes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1066, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1070, 'Miercoles', '14:00',  '16:00');
CALL proce_nueva_sesion(1069, 'Lunes',     '9:00',   '11:00');
	
CALL proce_nueva_sesion(1074, 'Jueves',    '8:00',   '9:00');
CALL proce_nueva_sesion(1072, 'Miercoles', '13:00',  '15:00');
CALL proce_nueva_sesion(1076, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1078, 'Martes',    '9:00',   '11:00');
CALL proce_nueva_sesion(1073, 'Viernes',   '16:00',  '17:00');
CALL proce_nueva_sesion(1080, 'Miercoles', '14:00',  '16:00');
CALL proce_nueva_sesion(1079, 'Lunes',     '9:00',   '11:00');

DROP PROCEDURE IF EXISTS proce_nuevo_alumno;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_alumno( in in_matricula VARCHAR(20), in in_fecha_ingreso DATE )
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Alumnos(matricula, fecha_ingreso) VALUES(in_matricula, in_fecha_ingreso);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

CALL proce_nuevo_alumno('18011830','2018-08-06');
CALL proce_nuevo_alumno('18011225','2019-08-06');
CALL proce_nuevo_alumno('18011362','2018-08-06');
CALL proce_nuevo_alumno('18011126','2015-08-06');
CALL proce_nuevo_alumno('18011250','2018-08-06');
CALL proce_nuevo_alumno('18011378','2016-08-06');
CALL proce_nuevo_alumno('18011530','2020-08-06');

-- idCurso, estado('S', 'A', 'R'), estado('P', 'A', 'R'), matricula
 INSERT INTO Cursos_Alumnos VALUES
       (1001,'A','P','18011830'),
       (1003,'A','P','18011225'),
       (1003,'A','P','18011362'),
       (1005,'A','P','18011126'),
       (1005,'R','P','18011250'),
       (1006,'R','P','18011378'),
       (1001,'S','P','18011530'),
       (1010,'A','P','18011830'),
       (1011,'A','P','18011830'),
       (1012,'A','P','18011225'),
       (1014,'A','P','18011362'),
       (1015,'A','P','18011126'),
       (1015,'R','P','18011250'),
       (1016,'R','P','18011378'),
       (1017,'S','P','18011530');















############################################################

-- FUNCIONES
DROP FUNCTION IF EXISTS funci_nombre_user;
DELIMITER $$
CREATE FUNCTION funci_nombre_user ( in_idUsuario VARCHAR(20) ) RETURNS VARCHAR(225)
    DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(225) DEFAULT '';
    SELECT concat(nombre_1 , ' ', COALESCE(nombre_2, ''), ' ', COALESCE(nombre_3, ''), apellido_pat, ' ', COALESCE(apellido_mat, '')) INTO nombre
    FROM Usuarios WHERE idUsuario = in_idUsuario;
    RETURN nombre;
END $$
DELIMITER ;
;
-- SELECT funci_nombre_user(idUsuario) FROM Usuarios;
-- PROCEDIMIENTOS ALMACENADOS
###########################################################################################
USE SIAE;
DROP PROCEDURE IF EXISTS proce_iniciar_sesion; -- Completado * Cambios
DELIMITER $$
CREATE PROCEDURE proce_iniciar_sesion ( in in_idUsuario VARCHAR(20), in in_contra VARCHAR(20) ) 
    NOT DETERMINISTIC   
BEGIN
    DECLARE ob_verif BOOLEAN DEFAULT FALSE;
    DECLARE act INT DEFAULT 0;
    DECLARE sem INT DEFAULT -1;
    DECLARE ob_contra VARCHAR(128);
    DECLARE ob_in_contra VARCHAR(128);
    DECLARE ob_rol CHAR(1);
    DECLARE ob_tipoR CHAR(1);
    DECLARE ob_ingreso DATE DEFAULT NULL;
    
    SELECT contra INTO ob_contra FROM Usuarios WHERE (idUsuario = in_idUsuario);
    SELECT rol INTO ob_rol FROM Usuarios WHERE (idUsuario = in_idUsuario);
    SET ob_in_contra =  SHA2( in_contra, 512);
    IF ob_contra = ob_in_contra THEN SET ob_verif = TRUE; SET act = 1;
	ELSE SELECT act, sem FROM DUAL;
	END IF;
    IF ob_verif = TRUE THEN
        IF ob_rol = 'A' THEN
            SELECT fecha_ingreso INTO ob_ingreso FROM Alumnos WHERE (matricula = in_idUsuario);
            SET sem = round( (datediff( CURRENT_DATE, ob_ingreso)/183.5) + 1 );
        ELSE
            SELECT tipo INTO ob_tipoR FROM Responsables WHERE idUsuario = in_idUsuario;
            IF ob_tipoR = 'D' THEN SET sem = -2; 
            END IF;
        END IF;
		SELECT *, sem, act FROM Usuarios WHERE idUsuario = in_idUsuario;
	END IF;
END $$
DELIMITER ;
;
-- CALL proce_iniciar_sesion('18011126', 'dhernandezr');
-- CALL proce_iniciar_sesion('D00001', 'caguilar');
###########################################################################################
DROP PROCEDURE IF EXISTS proce_reporte_cursos;
DELIMITER $$
CREATE PROCEDURE proce_reporte_cursos()
    DETERMINISTIC
BEGIN
    SELECT idC, cupo, dia, horario, asignatura, credito, docente, semestre, area
    FROM
    (SELECT ca.idC, cupo, credito, semestre, asignatura, ca.idR, group_concat(dia SEPARATOR ',') AS dia, group_concat(horario SEPARATOR ',') AS horario, area
        FROM
        (SELECT c.idC, c.idR, cupo, semestre, asignatura, credito, area FROM
            (SELECT idCurso AS idC, cupo, idAsignatura AS idA, idResponsable AS idR FROM Cursos WHERE estado = 'E' AND tipo = 'O') c
            JOIN 
            (SELECT idAsignatura AS idA, semestre, nombre AS asignatura, credito, area FROM Asignaturas) a
            ON(c.idA=a.idA) 
        ) ca
        JOIN
            (SELECT idSesion AS idS, idCurso AS idC, dia, concat(hora_inicio, ' - ', hora_fin) AS horario FROM Sesiones) s
            ON(s.idC = ca.idC) GROUP BY ca.idC 
        ) cas
    JOIN
    (SELECT idUsuario AS idR, funci_nombre_user(idUsuario) AS docente FROM Usuarios WHERE rol = 'R') u
        ON(cas.idR=u.idR)
        ORDER BY cas.semestre ASC;
END $$
DELIMITER ;
;
--  CALL proce_reporte_cursos();

###########################################################################################
DROP PROCEDURE IF EXISTS proce_reporte_asesorias;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asesorias()
    DETERMINISTIC
BEGIN
    SELECT docente, nombre AS asignatura, dia, horario, url, codigo
    FROM
    (SELECT idAA, url, dia, horario, funci_nombre_user(idUsuario) AS docente, idA, codigo FROM
        (SELECT idAreasApoyo AS idAA, url, dia, concat(hora_inicio,' - ',hora_fin) AS horario, idResponsable AS idR, idAsignatura AS idA, codigo 
        FROM AreasApoyo WHERE estado = 'E') a 
        LEFT JOIN Usuarios ON(a.idR=idUsuario)
    ) b 
    LEFT JOIN Asignaturas ON(b.idA=idAsignatura);
END $$
DELIMITER ;
;
-- CALL proce_reporte_asesorias();

###########################################################################################
DROP PROCEDURE IF EXISTS proce_reporte_asignatura;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asignatura(in in_option BOOLEAN)
    DETERMINISTIC
BEGIN
    IF in_option THEN
        SELECT idAsignatura AS idA, semestre, nombre, area, credito FROM Asignaturas ORDER BY area;
    ELSE
        SELECT idAsignatura, nombre FROM Asignaturas WHERE estado = 'E';
    END IF;
END $$
DELIMITER ;
;
-- CALL proce_reporte_asignatura(true);
-- CALL proce_reporte_asignatura(false);

###########################################################################################
DROP PROCEDURE IF EXISTS proce_reporte_curso_docente;
DELIMITER $$
CREATE PROCEDURE proce_reporte_curso_docente( in in_idUsuario VARCHAR(20) )
    DETERMINISTIC
BEGIN
    SELECT cm.idC, tipo, m, alumno, foto, caa.idA, asignatura, semestre, reporte
    FROM
    (SELECT ca.idC AS idC, a.m, alumno, foto, reporte
        FROM
        (SELECT idUsuario AS m, funci_nombre_user(idUsuario) AS alumno, foto FROM Usuarios WHERE rol = 'A') a
        JOIN 
        (SELECT idCurso AS idC, matricula AS m, reporte FROM Cursos_Alumnos WHERE estado = 'A') ca 
        ON(a.m = ca.m)
    ) cm
    JOIN
    (SELECT c.idC, semestre, asignatura, tipo, c.idA 
        FROM
        (SELECT idCurso AS idC, idAsignatura AS idA, tipo FROM Cursos WHERE estado = 'E' AND idResponsable = in_idUsuario) c
        JOIN
        (SELECT idAsignatura AS idA, semestre, nombre AS asignatura FROM Asignaturas) a
        ON(c.idA = a.idA)
    )caa
    ON(caa.idC=cm.idC) ORDER BY(caa.idA);
END $$
DELIMITER ;
;
-- CALL proce_reporte_curso_docente('D00005');

-- UPDATE Cursos_Alumnos SET reporte = in_reporte WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
###########################################################################################
DROP PROCEDURE IF EXISTS proce_cambio_status_alumno;
DELIMITER $$
CREATE PROCEDURE proce_cambio_status_alumno( in in_idCurso INT, in in_matricula VARCHAR(20), in in_reporte CHAR(1) )
    DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN;
    DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062;
    DECLARE t_msg_error_chk CONDITION FOR 3819;
    DECLARE t_msg_error_fk CONDITION FOR 1452;
    DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        UPDATE Cursos_Alumnos SET reporte = in_reporte WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

-- CALL proce_cambio_status_alumno(1001, '18011530', 'H');
-- '1001', 'S', 'P', '18011530'

DROP PROCEDURE IF EXISTS proce_consulta_curso;
DELIMITER $$
CREATE PROCEDURE proce_consulta_curso()
    DETERMINISTIC
BEGIN
    SELECT ca.idC, tipo, estado, cupo, idA, d.idR, nombre, docente
    FROM
    (
        SELECT c.idC, a.idA, c.idR, tipo, estado, cupo, nombre FROM
        (SELECT idCurso AS idC, tipo, estado, cupo, idAsignatura AS idA, idResponsable AS idR FROM Cursos) c
        JOIN
        (SELECT idAsignatura AS idA, nombre FROM Asignaturas) a
        ON(a.idA=c.idA)
    ) ca
    JOIN
    (
        SELECT r.idR, docente FROM
        (SELECT idUsuario AS idR FROM Responsables WHERE tipo = 'D') r
        JOIN
        (SELECT idUsuario AS idU, funci_nombre_user(idUsuario) AS docente FROM Usuarios) u
        ON(r.idR=u.idU)
    ) d
    ON(ca.idR=d.idR) ORDER BY ca.tipo, ca.idC;
END $$
DELIMITER ;
;
 CALL proce_consulta_curso();

DROP PROCEDURE IF EXISTS proce_consulta_docente;
DELIMITER $$
CREATE PROCEDURE proce_consulta_docente()
    DETERMINISTIC
BEGIN
    SELECT u.idUsuario, nombre FROM
    (SELECT idUsuario, funci_nombre_user(idUsuario) AS nombre FROM Usuarios WHERE rol = 'R') u
    JOIN
    (SELECT idUsuario FROM Responsables WHERE tipo = 'D') r
    ON(u.idUsuario=r.idUsuario);
END $$
DELIMITER ;
;

-- CALL proce_consulta_docente();

DROP PROCEDURE IF EXISTS proce_consulta_asesoria;
DELIMITER $$
CREATE PROCEDURE proce_consulta_asesoria()
    DETERMINISTIC
BEGIN
    SELECT rua.idAA, asignatura, url, dia, horario, estado, docente, extra FROM
        (SELECT a.idAA, idA, dia, horario, url, estado, ru.docente, extra
        FROM
        (SELECT idAreasApoyo AS idAA, url, dia, concat(hora_inicio, ' - ', hora_fin) AS horario, codigo AS extra, idAsignatura AS idA, idResponsable AS idR, estado
        FROM 
            AreasApoyo WHERE idAsignatura is not null) a
        JOIN
            (SELECT r.idR, docente FROM
                (SELECT idUsuario AS idR FROM Responsables WHERE tipo = 'D') r
            JOIN
                (SELECT idUsuario AS idU, funci_nombre_user(idUsuario) AS docente FROM Usuarios) u
            ON(r.idR=u.idU)
            )ru
        ON(ru.idR=a.idR)) rua
    JOIN
        (SELECT idAsignatura AS idA, nombre AS asignatura FROM Asignaturas) a
    ON(rua.idA=a.idA);
END $$
DELIMITER ;
;
-- CALL proce_consulta_asesoria();

DROP PROCEDURE IF EXISTS proce_estado_curso;
DELIMITER $$
CREATE PROCEDURE proce_estado_curso( in in_id INT, in in_estado CHAR(1) )
    DETERMINISTIC
BEGIN
    UPDATE Cursos SET estado = in_estado WHERE (idCurso = in_id);
END $$
DELIMITER ;
;

-- CALL proce_estado_curso(1001, 'D');

DROP PROCEDURE IF EXISTS proce_estado_asignatura;
DELIMITER $$
CREATE PROCEDURE proce_estado_asignatura( in in_id INT, in in_estado CHAR(1) )
    DETERMINISTIC
BEGIN
    UPDATE AreasApoyo SET estado = in_estado WHERE (idAreasApoyo = in_id);
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_consulta_sesion;
DELIMITER $$
CREATE PROCEDURE proce_consulta_sesion(in in_idCurso INT)
    DETERMINISTIC
BEGIN
    SELECT idSesion, idCurso, dia, hora_inicio, hora_fin FROM Sesiones WHERE idCurso = in_idCurso;
END $$
DELIMITER ;
;

CALL proce_consulta_sesion(1001);
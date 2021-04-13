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
  contra VARCHAR(20) NOT NULL,
  PRIMARY KEY (idUsuario)
);

-- -----------------------------------------------------
-- Table `SIAE`.`Responsable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Responsable` (
  tipo CHAR(1) NULL
  CONSTRAINT `chk_Responsables_tipo`CHECK ( tipo in('D', 'E')) ENFORCED
    COMMENT 'El tipo de responsable puede ser: (D) docente o (E) encargado',
  idUsuario VARCHAR(20) NOT NULL,
  PRIMARY KEY (idUsuario),
  CONSTRAINT `fk_Responsable_Usuarios1`
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
-- Table `SIAE`.`areasApoyo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`AreasApoyo` (
  idAreasApoyo INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  url VARCHAR(200) NOT NULL,
  dia VARCHAR(20) NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  codigo VARCHAR(100) NULL,
  idResponsable VARCHAR(20) NOT NULL,
  idAsignatura INT NULL,
  PRIMARY KEY (idAreasApoyo),
  CONSTRAINT `fk_AreasApoyo_Asignaturas`
    FOREIGN KEY (idAsignatura)
    REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_AreasApoyo_Responsables`
    FOREIGN KEY (idResponsable)
    REFERENCES Responsable (idUsuario)
    );


-- -----------------------------------------------------
-- Table `SIAE`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SIAE`.`Cursos` (
  idCurso INT NOT NULL,
  tipo VARCHAR(45) NOT NULL
  CONSTRAINT `chk_Cursos_tipo`CHECK ( tipo in('O', 'V')) ENFORCED
    COMMENT 'El tipo de curso puede ser: (O) ordinario o (V) verano',
  estado VARCHAR(45) NOT NULL
    CONSTRAINT `chk_Cursos_estado`CHECK ( estado in('E', 'D')) ENFORCED
    COMMENT 'El estado puede ser: (E) enable o (D) disable',
  cupo INT NULL,
  idAsignatura INT NOT NULL,
  idResponsable VARCHAR(20) NOT NULL,
  PRIMARY KEY (idCurso),
  CONSTRAINT `fk_Curso_Asignaturas`
    FOREIGN KEY (idAsignatura)
    REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_Curso_Responsable1`
    FOREIGN KEY (idResponsable)
    REFERENCES Responsable (idUsuario)
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
  idSesiones INT NOT NULL AUTO_INCREMENT,
  idCurso INT NOT NULL,
  dia VARCHAR(20) NULL,
  horaInicio TIME NULL,
  horaFin TIME NULL,
  PRIMARY KEY (idSesiones),
  CONSTRAINT `fk_Sesiones_Curso1`
    FOREIGN KEY (idCurso)
    REFERENCES Cursos (idCurso)
    );

-- idUsuario, nombre_1, nombre_2, nombre_3, apellido_pat, apellido_mat, correo_inst, rol('A', 'R')
INSERT INTO Usuarios (idUsuario, nombre_1, nombre_2, apellido_pat, apellido_mat, correo_inst, rol, contra) 
 VALUES('18011830','Emeling','Dayan','Ramirez','Garcia','edramirez@itsoeh.edu.mx','A','edramirez'),
       ('18011225','Oswaldo','Jesus','Hernandez','Gomez','ojhernandez@itsoeh.edu.mx','A','ojhernandez'),
       ('18011362','Nazareth','Zurisay','Morales','Gino','nzmorales@itsoeh.edu.mx','A','nzmorales'),
       ('18011250','Sandra','Montserrat','Bautista','Lopez','smbautista@itsoeh.edu.mx','A','smbautista'),
       ('18011530','Carlos','Gabriel','Cruz','Chontal','cgcruz@itsoeh.edu.mx','G','cgcruz'),
       ('1','Cristy','Elizabeth','Aguilar','Ojeda','caguilar@itsoeh.edu.mx','R','caguilar'),
       ('2','Hector','Daniel','Hernandez','Garcia','hdhernandez@itsoeh.edu.mx','R','hdhernandez'),
       ('6','Dulce','Jazmin','Navarrete','Arias','dnaverrete@itsoeh.edu.mx','R','dnavarrete'),
       ('10','Jorge','Armando','Garcia','Bautista','jgarciab@itsoeh.edu.mx','R','jgarciab'),
       ('14','Juan','Carlos','Ceron','Almaraz','jcerona@itsoeh.edu.mx','R','jcerona'),
       ('1414','Gloria','Maria','Álvarez','Herver','galvarez@itsoeh.edu.mx ','R','galvarez'),
       ('1515','Antelmo','Arturo','Arteaga','Valera','aarteaga@itsoeh.edu.mx','R','aarteaga');
INSERT INTO Usuarios (idUsuario, nombre_1, apellido_pat, apellido_mat, correo_inst, rol, contra) 
 VALUES('18011126','Daniel','Hernandez','Reyes','dhernandezr@itsoeh.edu.mx','A','dhernandezr'),
       ('18011378','Joyce','Gress','Hernandez','jgressh@itsoeh.edu.mx','A','jgressh'),
       ('3','Aline','Perez','Martinez','aperezm@itsoeh.edu.mx','R','aperezm'),
       ('4','Guadalupe','Calvo','Torres','gcalvo@itsoeh.edu.mx','R','gcalvo'),
       ('5','German','Rebolledo','Avalos','grevolledo@itsoeh.edu.mx','R','grevolledo'),
       ('7','Elizabeth','Garcia','Rios','egarcia@itsoeh.edu.mx','R','egarcia'),
       ('8','Eliut','Paredes','Reyes','eparedes@itsoeh.edu.mx','R','eparedes'),
       ('9','Mario','Perez','Bautista','mperez@itsoeh.edu.mx','R','mperez'),
       ('11','Javier','Perez','Escamilla','japereze@itsoeh.edu.mx','R','japerezm'),
       ('12','Lucino','Lugo','Lopez','llugol@itsoeh.edu.mx','R','llugol'),
       ('13','Lorena','Mendoza','Guzman','lmendozag@itsoeh.edu.mx','R','lmendozag'),
       ('15','Guillermo','Castañeda','Ortiz','gcastanedao@itsoeh.edu.mx','R','gcastanedao'),
	   ('1313','Lucía','Rivas','Apiliado','lrivas@itsoeh.edu.mx','R','lrivas'),
       ('12345','Alberto','Montoya','Buendia','amontoyab@itsoeh.edu.mx','R','amontoyab');

-- idAsignatura, semestre, nombre, credito(0 AND 10 ), estado ('E', 'D')
INSERT INTO Asignaturas 
 VALUES('101',1, 'Calculo Diferencial','CB',5,'E'),
       ('201',1, 'Fundamentos de Programación','IA',5,'E'),
       ('301',1, 'Taller de Etica','CS',4,'E'),
       ('401',1, 'Matematicas discretas','CB',5,'E'),# fffrfr
       ('501',1, 'Taller de Administracion','CE',4,'E'),
       ('601',1, 'Fundamentos de Investigacion','CS',4,'E');
INSERT INTO Asignaturas 
 VALUES('102','2','Calculo Integral','CB','5','E'),
       ('202','2','Programación Orientada a Objetos','CI','5','E'),
       ('302','2','Contabilidad Financiera','CE','4','E'),
       ('402','2','Química General','CB','4','E'),
       ('502','2','Algebra Lineal','CB','5','E'),
       ('602','2','Probabilidad y Estadistica','CB','5','E');
INSERT INTO Asignaturas 
 VALUES('103',3,'Calculo Vectorial','CB',5,'E'),
       ('203',3, 'Estructura de Datos','CI',5,'E'),
       ('303',3, 'Cultura Empresarial','CE',4,'E'),
       ('403',3, 'Investigacion de Operaciones','CB',4,'E'),
       ('503',3, 'Sistemas operativos','CI',4,'E'),
       ('603',3, 'Fisica general','CB',5,'E');
INSERT INTO Asignaturas 
 VALUES('104','4','Ecuaciones Diferenciales','CB','5','E'),
       ('204','4','Metodos Numericos','CB','4','E'),
       ('304','4','Topicos Avanzadas De Programacion','CI',5,'E'),
       ('404','4','Fundamentos de Base De Datos','IA','5','E'),
       ('504','4','Taller De Sistemas Operativos','DI','4','E'),
       ('604','4','Principios Electricos y Aplicaciones Digitales','CI','5','E');
INSERT INTO Asignaturas 
 VALUES('105',5,'Desarrollo sustentable','CC',5,'E'),
       ('205',5, 'Fundamentos de Telecomunicaciones','CI',4,'E'),
       ('305',5, 'Taller de Base de Datos','DI',4,'E'),
       ('405',5, 'Simulacion','IA',5,'E'),
       ('505',5, 'Fundamentos de Ingenieria de Software','IA',4,'E'),
       ('605',5, 'Arquitectura de Computadoras','IA',5,'E'),
       ('705',5, 'Programacion web','DI',5,'E');
INSERT INTO Asignaturas 
 VALUES('106','6','Lenguajes y Automatas I','IA','5','E'),
       ('206','6','Redes de Computadora','DI','5','E'),
       ('306','6','Administracion de Base de Datos','DI','5','E'),
       ('406','6','Programacion Logica y Funcional','IA','4','E'),
       ('506','6','Ingenieria de Software','DI','5','E'),
       ('606','6','Lenguajes de Interfaz','IA','4','E'),
       ('706','6','Taller de Investigacion I','CS','4','E');
INSERT INTO Asignaturas 
 VALUES('107','7','Lenguajes y Automatas II','DI','5','E'),
       ('207','7','Conmutación y Enrutamiento de Redes de Datos','DI','5','E'),
       ('307','7','Inteligencia Artificial','DI','4','E'),
       ('407','7','Gestión de Proyectos de Software','IA','6','E'),
       ('507','7','Sistemas Programables','DI','4','E');
 INSERT INTO Asignaturas 
 VALUES('108','8','Graficación','DI','4','E'),
       ('208','8','Administración de Redes','DI','4','E'),
       ('308','8','Taller de Investigación II','CS','4','E');
    -- ('S08','8','Servicio Social','','10','E');
-- INSERT INTO Asignaturas 
-- VALUES('109','9','Residencia','','10','E');
 
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

INSERT INTO Responsable
 VALUES('D','1'),('D','2'),('D','3'),
       ('D','4'),('D','5'),('D','6'),
       ('D','7'),('D','8'),('D','9'),
       ('D','10'),('D','11'),('D','12'),
       ('D','13'),('D','14'),('D','15'),
       ('E','12345');
       
-- idAreasApoyo, nombre, url, dia, hora_inicio, hora_fin, codigo,idResponsable, idAsignatura
INSERT INTO AreasApoyo 
 VALUES(1,'Asesoria','https://us04web.zoom.us/j/79372928750?pwd=R2svczlSaGR1T2pDenhqMGtYYUoyQT09','Lunes','7:00','9:00','',1,101),
 (2,'Asesoria','https://meet.google.com/eqe-jtxy-uhj','Lunes','14:00','17:00','',7,204),
 (3,'Asesoria','https://meet.google.com/eqe-jtxy-uhj','Martes','7:00','8:00','',7,706),
 (4,'Asesoria','https://meet.google.com/eqe-jtxy-uhj','Viernes','12:00','13:00','',7,706),
 (5,'Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','12:00','13:00','',9,106),
 (6,'Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','13:00','14:00','',9,106),
 (7,'Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','16:00','17:00','',9,202),
 (8,'Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','17:00','18:00','',9,202),
 -- (9,'Asesoria','https://meet.google.com/waj-empi-zjo','Lunes','15:00','16:00','',1,###),
 (10,'Asesoria','https://meet.google.com/waj-empi-zjo','Martes','13:00','14:00','',1,506),
 (11,'Asesoria','https://meet.google.com/gqk-crnm-tyq','Lunes','12:00','13:00','',4,606),
 (12,'Asesoria','https://meet.google.com/gqk-crnm-tyq','Martes','17:00','18:00','',4,606),
 (13,'Asesoria','https://meet.google.com/gqk-crnm-tyq','Viernes','7:00','8:00','',4,null),
 (14,'Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Martes','13:00','14:00','ID de reunión: 9195975 6386, Código de acceso: 340566',3,106),
 (15,'Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','8:00','9:00','ID de reunión: 9195975 6386, Código de acceso: 340566',3,304),
 (16,'Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','12:00','13:00','ID de reunión: 9195975 6386, Código de acceso: 340566',3,406),
 -- (17,'Asesoria','https://meet.google.com/lookup/el4fu65dax','Lunes','10:00','11:00','',3,202);
 (17,'Asesoria','https://meet.google.com/hcy-nggn-wdx','Miercoles','16:00','17:00','',15,null),
 (18,'Asesoria','https://meet.google.com/lookup/fu4xegew2b','Viernes','16:00','18:00','',14,101);

-- idCurso, tipo('O', 'V'), estado('E', 'D'), cupo, idAsignatura, idResponsable
INSERT INTO Cursos
 VALUES(1001, 'O', 'E',30, 201, 5),
       (1005, 'O', 'D',30, 401, 13),
       (1006, 'O', 'E',15, 101, 10),
       (1007, 'O', 'E',10, 301, 12),
       (1008, 'O', 'E',30, 501, 3),
       (1010, 'O', 'E',30, 601, 6),
       
       (1003, 'O', 'E',20, 502, 2),
       (1025, 'O', 'E',30, 602, 1),
       (1026, 'O', 'E',15, 102, 4),
       (1027, 'O', 'E',10, 302, 7),
       (1028, 'O', 'E',30, 202, 8),
       (1023, 'O', 'E',20, 402, 9),
       
       (1014, 'O', 'E',10, 303, 11),
       (1016, 'O', 'E',15, 503, 14),
       (1017, 'O', 'E',10, 603, 15),
       (1011, 'O', 'E',30, 103, 5),
       (1012, 'O', 'E',10, 203, 7),
       (1015, 'O', 'E',30,  403, 3),
       
       (1041, 'O', 'D',30, 104, 1),
       (1045, 'O', 'E',30, 404, 4),
       (1043, 'O', 'E',20, 204, 2),
       (1046, 'O', 'E',15, 504, 6),
       (1047, 'O', 'E',10, 304, 8),
       (1048, 'O', 'E',30, 604, 9),
       
       (1054, 'O', 'E',10, 305, 10),
       (1052, 'O', 'E',10, 605, 12),
       (1056, 'O', 'E',10, 205, 11),
       (1058, 'O', 'E',30, 105, 14),
       (1057, 'O', 'E',10, 405, 13),
       (1060, 'O', 'E',30, 505, 15),
       (1059, 'O', 'E',30, 705, 5),
       
       (1064, 'O', 'E',10, 206, 1),
       (1062, 'O', 'E',10, 406, 7),
       (1067, 'O', 'E',10, 306, 11),
       (1068, 'O', 'E',30, 706, 14),
       (1066, 'O', 'E',10, 606, 9),
       (1070, 'O', 'E',30, 506, 15),
       (1069, 'O', 'E',30, 106, 2),
       
       (1074, 'V', 'E',10, 206, 3),
       (1072, 'V', 'E',10, 406, 4),
       (1076, 'V', 'E',10, 306, 5),
       (1078, 'V', 'E',30, 706, 6),
       (1073, 'V', 'E',10, 606, 8),
       (1080, 'V', 'E',30, 506, 10),
       (1079, 'V', 'E',30, 106, 12);
       
-- idSeiones, idCurso, dia, horaInicio, horaFin,
INSERT INTO Sesiones
VALUES (999, 1001, 'Martes',    '9:00',   '11:00'),
       (998, 1005, 'Miercoles', '7:00',   '09:00'),
       (997, 1006, 'Lunes',     '14:00',  '16:00'),
       (996, 1007, 'Viernes',   '16:00',  '17:00'),
       (995, 1008, 'Jueves',    '9:00',   '11:00'),
       (994, 1010, 'Martes',    '11:00',  '13:00'),
       (954, 1001, 'Miercoles', '9:00',   '11:00'),
       (953, 1005, 'Martes',    '7:00',   '09:00'),
       (952, 1006, 'Jueves',    '14:00',  '16:00'),
       (951, 1007, 'Martes',   '16:00',  '17:00'),
       (950, 1008, 'Lunes',    '9:00',   '11:00'),
       (949, 1010, 'Viernes',  '11:00',  '13:00'),
       
       (993, 1003, 'Lunes',     '10:00',  '12:00'),
       (992, 1025, 'Viernes',   '7:00',   '9:00'),
       (991, 1026, 'Lunes',     '12:00',  '13:00'),
       (990, 1027, 'Viernes',   '16:00',  '17:00'),
       (989, 1028, 'Martes',    '14:00',  '16:00'),
       (988, 1023, 'Lunes',     '10:00',  '12:00'),
       (948, 1003, 'Martes',     '10:00',  '12:00'),
       (947, 1025, 'Lunes',   '7:00',   '9:00'),
       (946, 1026, 'Viernes',     '12:00',  '13:00'),
       (945, 1027, 'Lunes',   '16:00',  '17:00'),
       (944, 1028, 'Lunes',    '14:00',  '16:00'),
       (943, 1023, 'Viernes',     '10:00',  '12:00'),
       
       (987, 1014, 'Jueves',    '9:00',   '12:00'),
       (986, 1016, 'Lunes',     '12:00',  '13:00'),
       (985, 1017, 'Viernes',   '16:00',  '17:00'),
       (984, 1011, 'Martes',    '9:00',   '11:00'),
       (983, 1012, 'Viernes',   '11:00',  '12:00'),
       (982, 1015, 'Viernes',   '7:00',   '9:00'),
       
       (981, 1041, 'Martes',    '11:00',  '13:00'),
       (980, 1045, 'Viernes',   '7:00',   '9:00'),
       (979, 1043, 'Lunes',     '10:00',  '12:00'),
       (978, 1046, 'Lunes',     '12:00',  '13:00'),
       (977, 1047, 'Viernes',   '16:00',  '17:00'),
       (976, 1048, 'Martes',    '14:00',  '16:00'),
       
       (975, 1054, 'Jueves',    '8:00',   '9:00'),
       (974, 1052, 'Miercoles', '13:00',  '15:00'),
       (973, 1056, 'Viernes',   '16:00',  '17:00'),
       (972, 1058, 'Martes',    '9:00',   '11:00'),
       (971, 1057, 'Viernes',   '16:00',  '17:00'),
       (970, 1060, 'Lunes',     '14:00',  '16:00'),
       (969, 1059, 'Martes',    '9:00',   '11:00'),
       
       (968, 1064, 'Jueves',    '8:00',   '9:00'),
       (967, 1062, 'Miercoles', '13:00',  '15:00'),
       (966, 1067, 'Viernes',   '16:00',  '17:00'),
       (965, 1068, 'Martes',    '9:00',   '11:00'),
       (964, 1066, 'Viernes',   '16:00',  '17:00'),
       (963, 1070, 'Miercoles', '14:00',  '16:00'),
       (962, 1069, 'Lunes',     '9:00',   '11:00'),
	
       (961, 1074, 'Jueves',    '8:00',   '9:00'),
       (960, 1072, 'Miercoles', '13:00',  '15:00'),
       (959, 1076, 'Viernes',   '16:00',  '17:00'),
       (958, 1078, 'Martes',    '9:00',   '11:00'),
       (957, 1073, 'Viernes',   '16:00',  '17:00'),
       (956, 1080, 'Miercoles', '14:00',  '16:00'),
       (955, 1079, 'Lunes',     '9:00',   '11:00');

INSERT INTO Alumnos 
 VALUES('18011830','2018-08-06'),
       ('18011225','2019-08-06'),
       ('18011362','2018-08-06'),
       ('18011126','2015-08-06'),
       ('18011250','2018-08-06'),
       ('18011378','2016-08-06'),
       ('18011530','2020-08-06');

-- idCurso, estado('S', 'A', 'R'), matricula
# INSERT INTO Cursos_Alumnos VALUES(1001,'A','18011830'),
#       (1002,'A','18011225'),
#       (1003,'A','18011362'),
#       (1004,'A','18011126'),
#       (1005,'R','18011250'),
#       (1006,'R','18011378'),
#       (1001,'S','18011530');

-- PROCEDIMIENTOS ALMACENADOS

USE SIAE;
drop procedure if exists proce_iniciar_sesion;
DELIMITER $$
CREATE PROCEDURE proce_iniciar_sesion (
    in in_idUsuario VARCHAR(20),
    in in_contra VARCHAR(20)
)
    DETERMINISTIC   
BEGIN
    DECLARE ob_verif BOOLEAN DEFAULT FALSE;
    DECLARE act INT DEFAULT 0;
    DECLARE ob_contra VARCHAR(20);
    SELECT contra INTO ob_contra FROM Usuarios WHERE (idUsuario = in_idUsuario);
    IF ob_contra = in_contra THEN
		SET ob_verif = TRUE;
        SET act = 1;
	ELSE
        SELECT act FROM DUAL;
	END IF;
    IF ob_verif = TRUE THEN
		SELECT *, act FROM Usuarios WHERE idUsuario = in_idUsuario;
	END IF;
END $$
DELIMITER ;
-- CALL proce_iniciar_sesion('18011126', 'dhernandezr');

drop procedure if exists proce_reporte_cursos;
DELIMITER $$
CREATE PROCEDURE proce_reporte_cursos ()
    DETERMINISTIC
BEGIN
    SELECT idC, cupo, dia, horario, asignatura, credito, docente, semestre
    FROM
    (
        SELECT ca.idC, cupo, credito, semestre, asignatura, ca.idR, group_concat(dia SEPARATOR ',') AS dia, group_concat(horario SEPARATOR ',') AS horario
        FROM
        (
            SELECT c.idC, c.idR, cupo, semestre, asignatura, credito
            FROM
            (
                SELECT idCurso AS idC, cupo, idAsignatura AS idA, idResponsable AS idR 
                FROM Cursos WHERE estado = 'E' AND tipo = 'O'
            ) c
            JOIN 
            (
                SELECT idAsignatura AS idA, semestre, nombre AS asignatura, credito
                FROM Asignaturas
            ) a
            ON(c.idA=a.idA)
        ) ca
        JOIN
        (SELECT idSesiones AS idS, idCurso AS idC, dia, concat(horaInicio, ' - ', horaFin) AS horario FROM Sesiones
        ) s
        ON(s.idC = ca.idC)
        GROUP BY ca.idC
    ) cas
    JOIN
    (
        SELECT idUsuario AS idR, concat(nombre_1, ' ', apellido_pat) AS docente
        FROM Usuarios WHERE rol = 'R'
    ) u
    ON(cas.idR=u.idR)
    ORDER BY cas.semestre ASC;
END $$
DELIMITER ;
 CALL proce_reporte_cursos();

drop procedure if exists proce_reporte_asesorias;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asesorias()
    DETERMINISTIC
BEGIN
    SELECT docente, nombre AS asignatura, dia, horario, url, codigo
    FROM
    (
        SELECT idAA, url, dia, horario, concat(nombre_1, ' ', apellido_pat) AS docente, idA, codigo
        FROM
        (
        SELECT idAreasApoyo AS idAA, url, dia, concat(hora_inicio,' - ',hora_fin) AS horario, idResponsable AS idR, idAsignatura AS idA, codigo 
        FROM AreasApoyo
        ) a 
        LEFT JOIN Usuarios on(a.idR=idUsuario)
    ) b 
    LEFT JOIN Asignaturas ON(b.idA=idAsignatura);
END $$
DELIMITER ;
-- CALL proce_reporte_asesorias();

drop procedure if exists proce_reporte_asignatura;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asignatura()
    DETERMINISTIC
BEGIN
    SELECT idAsignatura AS idA, semestre, nombre, area, credito 
    FROM Asignaturas
    ORDER BY area;
END $$
DELIMITER ;
CALL proce_reporte_asignatura();

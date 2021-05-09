######################
# user = ISIC_IS     #
# pass = 1S_5%g4&21  #
######################
DROP SCHEMA SIAE;
CREATE SCHEMA IF NOT EXISTS SIAE DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE SIAE;

-- Table `SIAE`.`Usuarios`
CREATE TABLE IF NOT EXISTS Usuarios (
  idUsuario VARCHAR(20) NOT NULL,
  nombre_1 VARCHAR(45) NOT NULL, nombre_2 VARCHAR(45) NULL DEFAULT NULL, nombre_3 VARCHAR(45) NULL DEFAULT NULL,
  apellido_pat VARCHAR(45) NOT NULL, apellido_mat VARCHAR(45) NULL, correo_inst VARCHAR(45) NOT NULL,
  rol CHAR(1) NOT NULL CONSTRAINT `chk_Usuarios_rol`CHECK ( rol in('A', 'R', 'G')) ENFORCED COMMENT 'El rol puede ser: (A) alumno, (G) jefe, (R) representante',
  contra VARCHAR(128) NOT NULL, numTel VARCHAR(10) NULL DEFAULT NULL, foto MEDIUMBLOB NULL,
  PRIMARY KEY (idUsuario)
);

-- Table `SIAE`.`Responsable`
CREATE TABLE IF NOT EXISTS Responsables (
  tipo CHAR(1) NULL CONSTRAINT `chk_Responsables_tipo`CHECK ( tipo in('D', 'E')) ENFORCED COMMENT 'El tipo de responsable puede ser: (D) docente o (E) encargado',
  idUsuario VARCHAR(20) NOT NULL,
  PRIMARY KEY (idUsuario),
  CONSTRAINT `fk_Responsables_Usuarios` FOREIGN KEY (idUsuario) REFERENCES Usuarios (idUsuario)
);
-- Table `mydb`.`Asignaturas`
CREATE TABLE IF NOT EXISTS Asignaturas (
  idAsignatura INT NOT NULL,
  semestre INT NOT NULL, nombre VARCHAR(70) NOT NULL,
  area CHAR(2) NOT NULL CONSTRAINT `chk_Asignaturas_area`CHECK ( area IN('CB', 'CI', 'IA', 'DI', 'CS', 'CE','CC') ) ENFORCED COMMENT 'El area puede ser (CB), (CI), (IA), (DI), (CS), (CC)',
  credito INT NOT NULL CONSTRAINT `chk_Asignaturas_credito`CHECK ( credito BETWEEN 0 AND 10 ) ENFORCED COMMENT 'El credito puede ser entre 0 y 10',
  estado CHAR(1) NOT NULL CONSTRAINT `chk_Asignaturas_estado`CHECK ( estado in('E', 'D')) ENFORCED COMMENT 'El estado puede ser: (E) enable o (D) disable',
  solicitar INT DEFAULT 0 COMMENT 'La camtidad de alumnos que solicitan la materia para verano',
  PRIMARY KEY (idAsignatura)
);
-- Table `SIAE`.`AreasApoyo`
CREATE TABLE IF NOT EXISTS AreasApoyo (
  idAreasApoyo INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL, url VARCHAR(200) NOT NULL,
  dia VARCHAR(20) NOT NULL, hora_inicio TIME NOT NULL, hora_fin TIME NOT NULL, codigo VARCHAR(100) NULL,
  idResponsable VARCHAR(20) NOT NULL, idAsignatura INT NULL,
  estado CHAR(1) NOT NULL CONSTRAINT `chk_AreasApoyo_estado`CHECK ( estado IN('E', 'D') ) ENFORCED COMMENT 'El area puede ser (E) habilidato, (D) desabilitado',
  PRIMARY KEY (idAreasApoyo),
  CONSTRAINT `fk_AreasApoyo_Asignaturas` FOREIGN KEY (idAsignatura) REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_AreasApoyo_Responsables` FOREIGN KEY (idResponsable) REFERENCES Responsables (idUsuario),
  CONSTRAINT `chk_AreasApoyo_horario` CHECK( hora_inicio < hora_fin ) ENFORCED
);
-- Table `SIAE`.`Cursos`
CREATE TABLE IF NOT EXISTS Cursos (
  idCurso INT NOT NULL,
  tipo CHAR(1) NOT NULL CONSTRAINT `chk_Cursos_tipo`CHECK ( tipo in('O', 'V')) ENFORCED COMMENT 'El tipo de curso puede ser: (O) ordinario o (V) verano',
  estado CHAR(1) NOT NULL CONSTRAINT `chk_Cursos_estado`CHECK ( estado in('E', 'D')) ENFORCED COMMENT 'El estado puede ser: (E) enable o (D) disable',
  cupo INT NOT NULL CONSTRAINT `chk_Cursos_cupo`CHECK ( cupo > 0 ) ENFORCED COMMENT 'El cupo debe de ser mayor mayor de cero',
  idAsignatura INT NOT NULL, idResponsable VARCHAR(20) NOT NULL,
  PRIMARY KEY (idCurso),
  CONSTRAINT `fk_Cursos_Asignaturas` FOREIGN KEY (idAsignatura) REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_Cursos_Responsables` FOREIGN KEY (idResponsable) REFERENCES Responsables (idUsuario)
);
-- Table `SIAE`.`Alumnos`
CREATE TABLE IF NOT EXISTS Alumnos (
  matricula VARCHAR(20) NOT NULL, fecha_ingreso DATE NOT NULL,
  verano BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (matricula),
  CONSTRAINT `fk_Alumnos_Usuarios` FOREIGN KEY (matricula) REFERENCES Usuarios (idUsuario)
);
-- Table `SIAE`.`Cursos_Alumnos`
CREATE TABLE IF NOT EXISTS Cursos_Alumnos (
  idCurso INT NOT NULL,
  estado CHAR(2) NOT NULL CONSTRAINT `chk_Cursos_Alumnos_estado`CHECK ( estado in('SA','SB', 'A', 'R')) ENFORCED COMMENT 'El estado puede ser: (SA) solicitar alta, (SB) solicitar baja, (A) aceptado o (R) revocado',
  reporte CHAR(1) NOT NULL DEFAULT 'P' CONSTRAINT `chk_Cursos_Alumnos_reporte`CHECK ( reporte in('P','A', 'R')) ENFORCED COMMENT 'El estado puede ser: (P) sin registro, (A) aprovado o (R) reprovado',
  matricula VARCHAR(20) NOT NULL,
  PRIMARY KEY (idCurso, matricula),
  CONSTRAINT `fk_Cursos_Alumnos_Alumnos` FOREIGN KEY (matricula) REFERENCES Alumnos (matricula),
  CONSTRAINT `fk_Cursos_Alumnos_Cursos` FOREIGN KEY (idCurso) REFERENCES Cursos (idCurso)
);
-- Table `SIAE`.`Dependencias`
CREATE TABLE IF NOT EXISTS Dependencias (
  tipo CHAR(1) NOT NULL CONSTRAINT `chk_Dependencias_tipo`CHECK ( tipo in('S', 'C')) ENFORCED COMMENT 'El tipo de dependencia puede ser: (S) seriada o (C) Competencia',
  idAsignatura_p INT NOT NULL, idAsignatura_h INT NOT NULL,
  PRIMARY KEY (idAsignatura_p, idAsignatura_h),
  CONSTRAINT `fk_Dependencias_Asignaturas_p` FOREIGN KEY (idAsignatura_p) REFERENCES Asignaturas (idAsignatura),
  CONSTRAINT `fk_Dependencias_Asignaturas_h` FOREIGN KEY (idAsignatura_h) REFERENCES Asignaturas (idAsignatura)
);
-- Table `SIAE`.`Sesiones`
CREATE TABLE IF NOT EXISTS Sesiones (
  idSesion INT NOT NULL AUTO_INCREMENT, idCurso INT NOT NULL,
  dia VARCHAR(20) NOT NULL, hora_inicio TIME NOT NULL, hora_fin TIME NOT NULL,
  PRIMARY KEY (idSesion),
  CONSTRAINT `fk_Sesiones_Cursos` FOREIGN KEY (idCurso) REFERENCES Cursos (idCurso),
  CONSTRAINT `chk_Sesiones_horario` CHECK( hora_inicio < hora_fin ) ENFORCED
);


DROP PROCEDURE IF EXISTS proce_nuevo_user;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_user( in in_idUsuario VARCHAR(20), in in_nombre_1 VARCHAR(45), in in_nombre_2 VARCHAR(45), in in_nombre_3 VARCHAR(45), in in_apellido_pat VARCHAR(45), in in_apellido_mat VARCHAR(45), in in_correo_inst VARCHAR(45), in in_rol CHAR(1), in in_contra VARCHAR(20), in in_num_tel VARCHAR(10))
   COMMENT 'Este procedimiento creara un nuevo usuario, registrando sus datos generales' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg = '1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Usuarios VALUES(in_idUsuario, in_nombre_1, in_nombre_2, in_nombre_3, in_apellido_pat, in_apellido_mat, in_correo_inst, in_rol, SHA2(in_contra, 512), in_num_tel, null);
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' U ',in_idUsuario) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_nueva_asig;
DELIMITER $$
CREATE PROCEDURE proce_nueva_asig(in in_idAsignatura INT, in in_semestre INT, in in_nombre VARCHAR(70), in in_area CHAR(2), in in_credito INT, in in_estado CHAR(1))
    COMMENT 'Este procedimiento creara una nueva asignatura' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg = '1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Asignaturas VALUES(in_idAsignatura, in_semestre, in_nombre, in_area, in_credito, in_estado, 0);
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' A ',in_idAsignatura) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_nuevo_respo;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_respo(in in_tipo CHAR(1), in in_idUsuario VARCHAR(20)) COMMENT 'Este procedimiento creara un nuevo usuario, espesificamente del tipo responsable' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;                                                                                                                         
        INSERT INTO Responsables VALUES(in_tipo, in_idUsuario);
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' R ',in_idUsuario) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_nueva_area;
DELIMITER $$
CREATE PROCEDURE proce_nueva_area( in in_nombre VARCHAR(45), in in_url VARCHAR(200), in in_dia VARCHAR(20), in in_hora_inicio TIME,
    in in_hora_fin TIME, in in_codigo VARCHAR(100), in in_idResponsable VARCHAR(20), in in_idAsignatura INT, in in_estado CHAR(1) ) COMMENT 'Este procedimiento creara una nueva area de apoyo, validando el horario asignado al representante' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE count INT DEFAULT -1;
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    SELECT count(*) INTO count FROM AreasApoyo WHERE 
        ( (in_hora_inicio BETWEEN hora_inicio AND hora_fin) OR (in_hora_fin BETWEEN hora_inicio AND hora_fin) ) AND 
        ( (dia = in_dia) AND (idResponsable = in_idResponsable) AND estado = 'E');
    IF count > 0 THEN SET t_msg = 'Confictos en el horario'; SET t_error = TRUE; END IF;
    START TRANSACTION;
        INSERT INTO AreasApoyo(nombre, url, dia, hora_inicio, hora_fin, codigo, idResponsable, idAsignatura, estado) 
        VALUES(in_nombre, in_url, in_dia, in_hora_inicio, in_hora_fin, in_codigo, in_idResponsable, in_idAsignatura, in_estado);
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' AR ',in_idAsignatura) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_nuevo_curso;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_curso( in in_idCurso INT, in in_tipo CHAR(1), in in_estado CHAR(1), in in_cupo INT, in in_idAsignatura INT, in in_idResponsable VARCHAR(20) ) 
    COMMENT 'Este procedimiento creara un nuevo curso' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    START TRANSACTION;
        INSERT INTO Cursos(idCurso, tipo, estado, cupo, idAsignatura, idResponsable)
            VALUES(in_idCurso, in_tipo, in_estado, in_cupo, in_idAsignatura, in_idResponsable);
        IF in_tipo = 'V' THEN INSERT INTO Asignaturas(solicitar) VALUES(0);
        END IF;
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' C ',in_idCurso) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;


DROP PROCEDURE IF EXISTS proce_nueva_sesion;
DELIMITER $$
CREATE PROCEDURE proce_nueva_sesion( in in_idCurso INT, in in_dia VARCHAR(20), in in_hora_inicio TIME, in in_hora_fin TIME )
    COMMENT 'Este procedimiento creara una nueva sesión (clase) asosiada a un curso y validando su horario' DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = TRUE; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = TRUE; END;
    SELECT count(*) INTO count FROM Sesiones WHERE 
        ( (in_hora_inicio BETWEEN hora_inicio AND hora_fin) OR (in_hora_fin BETWEEN hora_inicio AND hora_fin) ) AND 
        ( (dia = in_dia) AND (idCurso = in_idCurso) );
    IF count > 0 THEN SET t_msg = 'Conflictos en el horario'; SET t_error = TRUE; END IF;
    START TRANSACTION;
        INSERT INTO Sesiones(idCurso, dia, hora_inicio, hora_fin) 
            VALUES(in_idCurso, in_dia, time(in_hora_inicio), time(in_hora_fin));
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' S ',in_idCurso) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;


DROP PROCEDURE IF EXISTS proce_nuevo_alumno;
DELIMITER $$
CREATE PROCEDURE proce_nuevo_alumno( in in_matricula VARCHAR(20), in in_fecha_ingreso DATE ) COMMENT 'Este procedimiento creara un nuevo alumno, validando sus datos' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    SELECT time(in_fecha_ingreso) < CURRENT_DATE INTO t_error FROM DUAL;
    IF t_error THEN SET t_msg = 'Fecha de ingreso no admitida'; END IF;
    START TRANSACTION;
        INSERT INTO Alumnos(matricula, fecha_ingreso) VALUES(in_matricula, in_fecha_ingreso);
    IF t_error THEN ROLLBACK; SELECT concat(t_msg,' A ',in_matricula) AS t_msg FROM dual; ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;


DROP FUNCTION IF EXISTS funci_nombre_user;
DELIMITER $$
CREATE FUNCTION funci_nombre_user ( in_idUsuario VARCHAR(20) ) RETURNS VARCHAR(225) COMMENT 'Esta fución obtendra el nombre completo del usuario' DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(225) DEFAULT '';
    SELECT concat(nombre_1 , ' ', COALESCE(nombre_2, ''), ' ', COALESCE(nombre_3, ''), apellido_pat, ' ', COALESCE(apellido_mat, '')) INTO nombre
    FROM Usuarios WHERE idUsuario = in_idUsuario;
    RETURN nombre;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_iniciar_sesion;
DELIMITER $$
CREATE PROCEDURE proce_iniciar_sesion ( in in_idUsuario VARCHAR(20), in in_contra VARCHAR(20) ) COMMENT 'Este procedimiento validara los datos de ingreso del usuario, y obteniendo los datos del usuario' NOT DETERMINISTIC
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
    IF ob_contra = ob_in_contra THEN SET ob_verif = TRUE; SET act = 1; ELSE SELECT act, sem FROM DUAL;
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

DROP PROCEDURE IF EXISTS proce_reporte_cursos;
DELIMITER $$
CREATE PROCEDURE proce_reporte_cursos() DETERMINISTIC
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

DROP PROCEDURE IF EXISTS proce_reporte_asesorias;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asesorias() COMMENT 'Este procedimiento, obtiene el reporte de las asesorias disponibles (habilitadas)' DETERMINISTIC
BEGIN
    SELECT docente, nombre AS asignatura, dia, horario, url, codigo
    FROM
    (SELECT idAA, url, dia, horario, funci_nombre_user(idUsuario) AS docente, idA, codigo FROM
        (SELECT idAreasApoyo AS idAA, url, dia, concat(hora_inicio,' - ',hora_fin) AS horario, idResponsable AS idR, idAsignatura AS idA, codigo FROM AreasApoyo WHERE estado = 'E') a 
        LEFT JOIN Usuarios ON(a.idR=idUsuario)
    ) b
    LEFT JOIN Asignaturas ON(b.idA=idAsignatura);
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_reporte_asignatura;
DELIMITER $$
CREATE PROCEDURE proce_reporte_asignatura(in in_option BOOLEAN) COMMENT 'Este procedimiento obtiene los datos de la asignatura (true) todos, (false) nombre y id que estan habilidatas' DETERMINISTIC
BEGIN
    IF in_option THEN SELECT idAsignatura AS idA, semestre, nombre, area, credito FROM Asignaturas ORDER BY area;
    ELSE SELECT idAsignatura, nombre FROM Asignaturas WHERE estado = 'E';
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_reporte_curso_docente;
DELIMITER $$
CREATE PROCEDURE proce_reporte_curso_docente( in in_idUsuario VARCHAR(20) ) COMMENT 'Este procedimiento obtiene la información de los alumnos de los cursos de un representante espesifico' DETERMINISTIC
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

DROP PROCEDURE IF EXISTS proce_cambio_status_alumno;
DELIMITER $$
CREATE PROCEDURE proce_cambio_status_alumno( in in_idCurso INT, in in_matricula VARCHAR(20), in in_reporte CHAR(1) ) COMMENT 'Este procedimiento realiza el reporte de su estado respecto a un curso, (P) pendiente, (R) reprovado, (A) aprovado' DETERMINISTIC
BEGIN
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
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

DROP PROCEDURE IF EXISTS proce_consulta_curso;
DELIMITER $$
CREATE PROCEDURE proce_consulta_curso() COMMENT 'Este procedimiento obtiene información del docente y la asignatura de cada curso existente' DETERMINISTIC
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

DROP PROCEDURE IF EXISTS proce_consulta_docente;
DELIMITER $$
CREATE PROCEDURE proce_consulta_docente() COMMENT 'Este procedimiento obtiene la información de los docentes registrados' DETERMINISTIC
BEGIN
    SELECT u.idUsuario, nombre FROM
    (SELECT idUsuario, funci_nombre_user(idUsuario) AS nombre FROM Usuarios WHERE rol = 'R') u
    JOIN
    (SELECT idUsuario FROM Responsables WHERE tipo = 'D') r
    ON(u.idUsuario=r.idUsuario);
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_consulta_asesoria;
DELIMITER $$
CREATE PROCEDURE proce_consulta_asesoria() COMMENT 'Este procedimiento obtiene la información de las asesorias impartidas y de los representantes' DETERMINISTIC
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

DROP PROCEDURE IF EXISTS proce_estado_curso;
DELIMITER $$
CREATE PROCEDURE proce_estado_curso( in in_id INT, in in_estado CHAR(1) ) COMMENT 'Este procedimiento cambia el estado de un curso para la visibilidad del alumno' DETERMINISTIC
BEGIN
    UPDATE Cursos SET estado = in_estado WHERE (idCurso = in_id);
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_estado_asignatura;
DELIMITER $$
CREATE PROCEDURE proce_estado_asignatura( in in_id INT, in in_estado CHAR(1) )
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT -1;
    DECLARE ob_inicio TIME DEFAULT NULL;
    DECLARE ob_fin TIME DEFAULT NULL;
    DECLARE ob_dia VARCHAR(20) DEFAULT NULL;
    DECLARE ob_respo VARCHAR(20) DEFAULT NULL;
    DECLARE ob_estado CHAR(1) DEFAULT NULL;
    SELECT hora_inicio INTO ob_inicio FROM AreasApoyo WHERE idAreasApoyo = in_id;
    SELECT hora_fin INTO ob_fin FROM AreasApoyo WHERE idAreasApoyo = in_id;
    SELECT dia INTO ob_dia FROM AreasApoyo WHERE idAreasApoyo = in_id;
    SELECT estado INTO ob_estado FROM AreasApoyo WHERE idAreasApoyo = in_id;
    SELECT idResponsable INTO ob_respo FROM AreasApoyo WHERE idAreasApoyo = in_id;
    SELECT count(*) INTO count FROM AreasApoyo WHERE 
        ( (ob_inicio BETWEEN hora_inicio AND hora_fin) OR (ob_fin BETWEEN hora_inicio AND hora_fin) ) AND 
        ( (dia = ob_dia) AND (idResponsable = ob_respo) AND estado = 'E');
    IF ob_estado = 'D' THEN
        IF count = 0 THEN UPDATE AreasApoyo SET estado = in_estado WHERE (idAreasApoyo = in_id); END IF;
    ELSE UPDATE AreasApoyo SET estado = in_estado WHERE (idAreasApoyo = in_id); 
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_consulta_sesion;
DELIMITER $$
CREATE PROCEDURE proce_consulta_sesion(in in_idCurso INT) COMMENT 'Este procedimiento obtiene la información de las sesiones de un curso' DETERMINISTIC
BEGIN
    SELECT idSesion, idCurso, dia, hora_inicio, hora_fin FROM Sesiones WHERE idCurso = in_idCurso;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_update_usuario;
DELIMITER $$
CREATE PROCEDURE proce_update_usuario( in in_id VARCHAR(20), in in_foto MEDIUMBLOB) COMMENT 'Este procedimiento actualiza la foto del usuario' DETERMINISTIC
BEGIN
    IF in_foto is not null THEN UPDATE Usuarios SET foto = in_foto WHERE (idUsuario = in_id);
    END IF;
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_cambiar_clave;
DELIMITER $$
CREATE PROCEDURE proce_cambiar_clave( in in_id VARCHAR(20), in in_p_pass VARCHAR(20), in in_n_pass VARCHAR(20)) COMMENT 'Este procedimiento actualiza la foto del usuario' DETERMINISTIC
BEGIN
    DECLARE ban BOOLEAN default false;
    SELECT true INTO ban FROM Usuarios WHERE (idUsuario = in_id) AND contra = SHA2(in_p_pass, 512);
    IF ban THEN UPDATE Usuarios SET contra = SHA2(in_n_pass, 512) WHERE (idUsuario = in_id); Select 'ok' from dual;
    ELSE Select 'Error' from dual;
    END IF;
END $$
DELIMITER ;
;
-- CALL proce_cambiar_clave('18011126', 'dhernandezr', 'dhernandezr');

DROP PROCEDURE IF EXISTS proce_eliminar_sesion;
DELIMITER $$
CREATE PROCEDURE proce_eliminar_sesion( in in_idSesion INT) COMMENT 'Este procedimiento elimina una sesión de un curso' DETERMINISTIC
BEGIN
    DELETE FROM Sesiones WHERE (idSesion = in_idSesion);
END $$
DELIMITER ;
;

DROP PROCEDURE IF EXISTS proce_reporte_cursos_ov;
DELIMITER $$
CREATE PROCEDURE proce_reporte_cursos_ov( in in_matricula VARCHAR(20)) COMMENT 'Este procedimiento obtiene todos los cursos de las materias disponibles, eliminando las materias aprobadas' DETERMINISTIC
BEGIN
    SELECT c.idC, c.tipo, a.idA, semestre, nombre, c.cupo, credito FROM
    (SELECT idAsignatura AS idA, semestre, nombre, credito FROM Asignaturas) a
    JOIN 
    (SELECT idCurso AS idC, idAsignatura AS idA, cupo, tipo FROM Cursos WHERE estado = 'E' AND cupo > 0) c
    ON(a.idA=c.idA) 
    WHERE a.idA 
    NOT IN(
        SELECT a.idA FROM
            (SELECT cu.idC,cu.idA, cupo FROM
            (SELECT idCurso AS idC, idAsignatura AS idA, cupo FROM Cursos) cu
            JOIN
            (SELECT idCurso AS idC FROM Cursos_Alumnos WHERE (estado in('A','SA','SB')) AND matricula = in_matricula) al
            ON(cu.idC=al.idC)
            ) c
        JOIN
            (SELECT idAsignatura AS idA, semestre, nombre, credito FROM Asignaturas) a
        ON(c.idA=a.idA)
    );
END $$
DELIMITER ;
;
-- CALL proce_reporte_cursos_ov('18011126');

DROP PROCEDURE IF EXISTS proce_solicitar_alta;
DELIMITER $$
CREATE PROCEDURE proce_solicitar_alta( in in_idCurso INT, in in_matricula VARCHAR(20)) COMMENT 'Este procedimiento realiza la solicitud de alta, de un curso ordinal por un alumno' DETERMINISTIC
BEGIN
    DECLARE obj_idA INT DEFAULT -1;
    DECLARE obj_rep BOOLEAN DEFAULT true;
    DECLARE obj_Apr INT DEFAULT 0;
    DECLARE t_error BOOLEAN; DECLARE t_msg VARCHAR(100) DEFAULT 'OK';
    DECLARE t_msg_error CONDITION FOR 1062; DECLARE t_msg_error_chk CONDITION FOR 3819; DECLARE t_msg_error_fk CONDITION FOR 1452; DECLARE t_msg_error_null CONDITION FOR 1048;
    DECLARE CONTINUE HANDLER FOR t_msg_error BEGIN SET t_msg ='1062 Clave duplicada'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_chk BEGIN SET t_msg = '3819 Check constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_fk BEGIN SET t_msg = '1452 foreign key constraint'; SET t_error = true; END;
    DECLARE CONTINUE HANDLER FOR t_msg_error_null BEGIN SET t_msg = '1048 Can not NULL'; SET t_error = true; END;
    SELECT idAh INTO obj_idA FROM 
        (SELECT idAsignatura AS idA FROM Cursos where idCurso = in_idCurso) c
    JOIN
        (SELECT idAsignatura_h AS idAh, idAsignatura_p AS idAp FROM Dependencias) d
    ON(c.idA=d.idAp);
    IF obj_idA != -1 THEN
        SELECT count(*) INTO obj_Apr FROM
            (SELECT idCurso AS idC FROM Cursos WHERE idAsignatura = obj_idA) c
        JOIN
            (SELECT idCurso AS idC FROM Cursos_Alumnos WHERE reporte = 'A' AND estado = 'A' AND matricula = in_matricula) ca
        ON(c.idC=ca.idC);
        IF obj_Apr = 0 THEN SET t_error = true; SET t_msg = 'Seriada'; END IF;
    END IF;
    SELECT false INTO obj_rep FROM Cursos_Alumnos WHERE idCurso = in_idCurso AND matricula = in_matricula;
    START TRANSACTION;
        UPDATE Cursos SET cupo = cupo - 1  WHERE (idCurso = in_idCurso);
        IF obj_rep THEN
            INSERT INTO Cursos_Alumnos VALUES(in_idCurso, 'SA', 'P', in_matricula);
        ELSE
            UPDATE Cursos_Alumnos SET estado = 'SA' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
        END IF;
    IF t_error THEN ROLLBACK; SELECT t_msg FROM dual;
    ELSE COMMIT;
    END IF;
END $$
DELIMITER ;
;
-- CALL proce_solicitar_alta(1006,'18011126');

DROP PROCEDURE IF EXISTS proce_consulta_alumnos;
DELIMITER $$
CREATE PROCEDURE proce_consulta_alumnos() COMMENT 'Este procedimiento obtiene los datos de los alumnos que han solicitado alta o baja' DETERMINISTIC
BEGIN
    SELECT ca.idC, ca.idA, matricula, nombre, alumno, estado, tipo, credito FROM
    (SELECT idCurso AS idC, matricula, funci_nombre_user(matricula) AS alumno, estado FROM Cursos_Alumnos WHERE estado in('SA','SB')) a
    JOIN
    (
        SELECT c.idC, a.idA, nombre, tipo, credito FROM
        (SELECT idCurso AS idC, tipo, idAsignatura AS idA FROM Cursos) c
        JOIN
        (SELECT idAsignatura AS idA, nombre, credito FROM Asignaturas) a
        ON(c.idA=a.idA)
    ) ca
    ON(a.idC=ca.idC) ORDER BY estado, matricula LIMIT 60;
END $$
DELIMITER ;
;
-- CALL proce_consulta_alumnos();

DROP PROCEDURE IF EXISTS proce_registrar_baja_alta;
DELIMITER $$
CREATE PROCEDURE proce_registrar_baja_alta( in in_idCurso INT, in in_matricula VARCHAR(20),in in_oper CHAR(1), in in_estado CHAR(1) ) COMMENT 'Este procedimiento registra la alta o baja, de un curso para un alumno' DETERMINISTIC
BEGIN
    IF in_oper = 'A' THEN
        IF in_estado = 'A' THEN
            UPDATE Cursos_Alumnos SET estado = 'A' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
            UPDATE Cursos SET cupo = cupo - 1  WHERE (idCurso = in_idCurso);
        END IF;
        IF in_estado = 'R' THEN
            UPDATE Cursos_Alumnos SET estado = 'R' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
        END IF;
    END IF;
    IF in_oper = 'B' THEN
        IF in_estado = 'A' THEN
        UPDATE Cursos_Alumnos SET estado = 'R' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
        UPDATE Cursos SET cupo = cupo + 1  WHERE (idCurso = in_idCurso);
        END IF;
        IF in_estado = 'R' THEN
        UPDATE Cursos_Alumnos SET estado = 'A' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
        END IF;
    END IF;
END $$
DELIMITER ;
;
-- CALL proce_registrar_baja_alta(idCurso,matricula,alta/baja,estado);

DROP PROCEDURE IF EXISTS proce_reporte_registro_cursos;
DELIMITER $$
CREATE PROCEDURE proce_reporte_registro_cursos( in in_matricula VARCHAR(20)) COMMENT 'Este procedimiento obtiene los cursos de las materias que son aceptadas' DETERMINISTIC
BEGIN
    SELECT c.idC, a.idA, semestre, nombre, c.cupo, credito, tipo FROM
        (SELECT cu.idC,cu.idA, cupo, cu.tipo FROM
        (SELECT idCurso AS idC, idAsignatura AS idA, cupo, tipo FROM Cursos WHERE estado = 'E') cu
        JOIN
        (SELECT idCurso AS idC FROM Cursos_Alumnos WHERE estado = 'A' AND matricula = in_matricula) al
        ON(cu.idC=al.idC)
        ) c
    JOIN
        (SELECT idAsignatura AS idA, semestre, nombre, credito FROM Asignaturas) a
    ON(c.idA=a.idA);
END $$
DELIMITER ;
;
-- CALL proce_reporte_registro_cursos('18011126');

DROP PROCEDURE IF EXISTS proce_solicitar_baja;
DELIMITER $$
CREATE PROCEDURE proce_solicitar_baja( in in_idCurso INT, in in_matricula VARCHAR(20)) COMMENT 'Este procedimiento realiza la solicitud de baja, de un curso ordinal por un alumno' DETERMINISTIC
BEGIN
    UPDATE Cursos_Alumnos SET estado = 'SB' WHERE (idCurso = in_idCurso) and (matricula = in_matricula);
END $$
DELIMITER ;
;
-- CALL proce_solicitar_baja();

DROP PROCEDURE IF EXISTS proce_solicitar_verano;
DELIMITER $$
CREATE PROCEDURE proce_solicitar_verano( in in_idAsignatura INT, in in_matricula VARCHAR(20), in in_final CHAR(1)) COMMENT 'Este procedimiento realiza el registro para las materias de verano' DETERMINISTIC
BEGIN
    DECLARE validar BOOLEAN DEFAULT FALSE;
    IF in_final = 'T' THEN
        UPDATE Alumnos SET verano = FALSE WHERE (matricula = in_matricula);
    ELSE
        SELECT verano INTO validar FROM Alumnos WHERE matricula = in_matricula;
        IF validar THEN
            UPDATE Asignaturas SET solicitar = solicitar + 1 WHERE (idAsignatura = in_idAsignatura);
        END IF;
    END IF;
END $$
DELIMITER ;
;
-- CALL proce_solicitar_verano( in in_idAsignatura INT, in in_matricula VARCHAR(20), in in_final BOOLEAN);

DROP PROCEDURE IF EXISTS proce_activo_verano;
DELIMITER $$
CREATE PROCEDURE proce_activo_verano( in_matricula VARCHAR(20)) COMMENT 'Este procedimiento identifica si esta activo la solicitud de verano las materias de verano' DETERMINISTIC
BEGIN
    SELECT verano FROM Alumnos WHERE matricula = in_matricula;
END $$
DELIMITER ;
;
-- CALL proce_activo_verano('18011126');


DROP PROCEDURE IF EXISTS proce_estado_solicitud_verano;
DELIMITER $$
CREATE PROCEDURE proce_estado_solicitud_verano( in in_verano BOOLEAN) COMMENT 'Este procedimiento habilita las solicitud para verano' DETERMINISTIC
BEGIN
    UPDATE Asignaturas SET solicitar = 0;
    UPDATE Alumnos SET verano = in_verano;
END $$
DELIMITER ;
;
-- CALL proce_activo_solicitud_verano(?);

DROP PROCEDURE IF EXISTS proce_estado_verano;
DELIMITER $$
CREATE PROCEDURE proce_estado_verano() COMMENT 'Este procedimiento obtiene el estado las solicitud para verano' DETERMINISTIC
BEGIN
    SELECT verano FROM Alumnos LIMIT 1;
END $$
DELIMITER ;
;
-- CALL proce_estado_verano();

DROP PROCEDURE IF EXISTS proce_reporte_verano;
DELIMITER $$
CREATE PROCEDURE proce_reporte_verano() COMMENT 'Este procedimiento obtiene el reporte de las solicitud de las asignaturas para verano' DETERMINISTIC
BEGIN
    SELECT idAsignatura AS idA, semestre, nombre, credito, solicitar FROM Asignaturas WHERE solicitar > 0;
END $$
DELIMITER ;
;
CALL proce_reporte_verano();


-- idUsuario, nombre_1, nombre_2, nombre_3, apellido_pat, apellido_mat, correo_inst, in_rol, in_contra, in_num_tel
CALL proce_nuevo_user('18011830','Emeling','Dayan',null,'Ramirez','Garcia','edramirez@itsoeh.edu.mx','A','edramirez','7732234176');
CALL proce_nuevo_user('18011225','Oswaldo','Jesus',null,'Hernandez','Gomez','ojhernandez@itsoeh.edu.mx','A','ojhernandez','7731314798');
CALL proce_nuevo_user('18011362','Nazareth','Zurisay',null,'Morales','Gino','nzmorales@itsoeh.edu.mx','A','nzmorales','7731103479');
CALL proce_nuevo_user('18011250','Sandra','Monserrat',null,'Bautista','Lopez','sbautista@itsoeh.edu.mx','A','sbautista','7721573570');
CALL proce_nuevo_user('18011530','Carlos','Gabriel',null,'Cruz','Chontal','cgcruz@itsoeh.edu.mx','A','cgcruz','7732010026');
CALL proce_nuevo_user('18011126','Daniel',null,null,'Hernandez','Reyes','dhernandezr@itsoeh.edu.mx','A','dhernandezr','7731171548');
CALL proce_nuevo_user('18011378','Joyce',null,null,'Gress','Hernandez','jgressh@itsoeh.edu.mx','A','jgressh','7712412085');
CALL proce_nuevo_user('G1234A','Administrador',null,null,'admin','admin','dever@itsoeh.edu.mx','G','root','');
CALL proce_nuevo_user('D00001','Cristy','Elizabeth',null,'Aguilar','Ojeda','caguilar@itsoeh.edu.mx','R','caguilar','7721619498');
CALL proce_nuevo_user('D00002','Hector','Daniel',null,'Hernandez','Garcia','hdhernandez@itsoeh.edu.mx','R','hdhernandez','7731379500');
CALL proce_nuevo_user('D00003','Dulce','Jazmin',null,'Navarrete','Arias','dnaverrete@itsoeh.edu.mx','R','dnavarrete','2224926179');
CALL proce_nuevo_user('D00004','Aline',null,null,'Perez','Martinez','aperezm@itsoeh.edu.mx','R','aperezm','7727364142');
CALL proce_nuevo_user('D00005','Guadalupe',null,null,'Calvo','Torres','gcalvo@itsoeh.edu.mx','R','gcalvo','7732250534');
CALL proce_nuevo_user('D00006','German',null,null,'Rebolledo','Avalos','grevolledo@itsoeh.edu.mx','R','grevolledo','7721599140');
CALL proce_nuevo_user('D00007','Elizabeth',null,null,'Garcia','Rios','egarcia@itsoeh.edu.mx','R','egarcia','');
CALL proce_nuevo_user('D00008','Eliut',null,null,'Paredes','Reyes','eparedes@itsoeh.edu.mx','R','eparedes','');
CALL proce_nuevo_user('D00009','Mario',null,null,'Perez','Bautista','mperez@itsoeh.edu.mx','R','mperez','7721315041');
CALL proce_nuevo_user('D00010','Jorge','Armando',null,'Garcia','Bautista','jgarciab@itsoeh.edu.mx','R','jgarciab','7731798374');
CALL proce_nuevo_user('D00011','Javier',null,null,'Perez','Escamilla','japereze@itsoeh.edu.mx','R','japerezm','7731375841');
CALL proce_nuevo_user('D00012','Lucino',null,null,'Lugo','Lopez','llugol@itsoeh.edu.mx','R','llugol','');
CALL proce_nuevo_user('D00013','Lorena',null,null,'Mendoza','Guzman','lmendozag@itsoeh.edu.mx','R','lmendozag','');
CALL proce_nuevo_user('D00014','Juan','Carlos',null,'Ceron','Almaraz','jcerona@itsoeh.edu.mx','R','jcerona','');
CALL proce_nuevo_user('D00015','Guillermo',null,null,'Castañeda','Ortiz','gcastanedao@itsoeh.edu.mx','R','gcastanedao','');
-- CALL proce_nuevo_user('D00016','Alberto',null,null,'Montoya','Buendia','amontoyab@itsoeh.edu.mx','R','amontoyab','');

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
-- CALL proce_nuevo_respo('R','D00016');

CALL proce_nuevo_alumno('18011830','2020-08-06');
CALL proce_nuevo_alumno('18011225','2020-08-06');
CALL proce_nuevo_alumno('18011362','2020-08-06');
CALL proce_nuevo_alumno('18011250','2020-08-06');
CALL proce_nuevo_alumno('18011530','2019-08-06');
CALL proce_nuevo_alumno('18011126','2020-08-06');
CALL proce_nuevo_alumno('18011378','2020-08-06');

CALL proce_nueva_asig(101,1,'Cálculo Diferencial','CB',5,'E');
CALL proce_nueva_asig(201,1,'Fundamentos de Programación','IA',5,'E');
CALL proce_nueva_asig(301,1,'Taller de Ética','CS',4,'E');
CALL proce_nueva_asig(401,1,'Matemáticas Discretas','CB',5,'E');
CALL proce_nueva_asig(501,1,'Taller de Administración','CE',4,'E');
CALL proce_nueva_asig(601,1,'Fundamentos de Investigación','CS',4,'E');
CALL proce_nueva_asig(102,2,'Cálculo Integral','CB',5,'E');
CALL proce_nueva_asig(202,2,'Programación Orientada a Objetos','CI',5,'E');
CALL proce_nueva_asig(302,2,'Contabilidad Financiera','CE',4,'E');
CALL proce_nueva_asig(402,2,'Química','CB',4,'E');
CALL proce_nueva_asig(502,2,'Álgebra Lineal','CB',5,'E');
CALL proce_nueva_asig(602,2,'Probabilidad y Estadística','CB',5,'E');
CALL proce_nueva_asig(103,3,'Cálculo Vectorial','CB',5,'E');
CALL proce_nueva_asig(203,3,'Estructura de Datos','CI',5,'E');
CALL proce_nueva_asig(303,3,'Cultura Empresarial','CE',4,'E');
CALL proce_nueva_asig(403,3,'Investigación de Operaciones','CB',4,'E');
CALL proce_nueva_asig(503,3,'Sistemas Operativos I','CI',4,'E');
CALL proce_nueva_asig(603,3,'Física General','CB',5,'E');
CALL proce_nueva_asig(104,4,'Ecuaciones Diferenciales','CB',5,'E');
CALL proce_nueva_asig(204,4,'Métodos Numéricos','CB',4,'E');
CALL proce_nueva_asig(304,4,'Tópicos Avanzados de Programación','CI',5,'E');
CALL proce_nueva_asig(404,4,'Fundamentos de Base de Datos','IA',5,'E');
CALL proce_nueva_asig(504,4,'Taller de Sistemas Operativos','DI',4,'E');
CALL proce_nueva_asig(604,4,'Principios Eléctricos y Aplicaciones Digitales','CI',5,'E');
CALL proce_nueva_asig(105,5,'Desarrollo Sustentable','CC',5,'E');
CALL proce_nueva_asig(205,5,'Fundamentos de Telecomunicaciones','CI',4,'E');
CALL proce_nueva_asig(305,5,'Taller de Base de Datos','DI',4,'E');
CALL proce_nueva_asig(405,5,'Simulación','IA',5,'E');
CALL proce_nueva_asig(505,5,'Fundamentos de Ingeniería de Software','IA',4,'E');
CALL proce_nueva_asig(605,5,'Arquitectura de Computadoras','IA',5,'E');
CALL proce_nueva_asig(705,5,'Programación Web','DI',5,'E');
CALL proce_nueva_asig(106,6,'Lenguajes y Autómatas I','IA',5,'E');
CALL proce_nueva_asig(206,6,'Redes de Computadoras','DI',5,'E');
CALL proce_nueva_asig(306,6,'Administración de Base de Datos','DI',5,'E');
CALL proce_nueva_asig(406,6,'Programación Lógica y Funcional','IA',4,'E');
CALL proce_nueva_asig(506,6,'Ingeniería de Software','DI',5,'E');
CALL proce_nueva_asig(606,6,'Lenguajes de Interfaz','IA',4,'E');
CALL proce_nueva_asig(706,6,'Taller de Investigación I','CS',4,'E');
CALL proce_nueva_asig(107,7,'Lenguajes y Autómatas II','DI',5,'E');
CALL proce_nueva_asig(207,7,'Conmutación y Enrutamiento en Redes de Datos','DI',5,'E');
CALL proce_nueva_asig(307,7,'Inteligencia Artificial','DI',4,'E');
CALL proce_nueva_asig(407,7,'Gestión de Proyectos de Software','IA',6,'E');
CALL proce_nueva_asig(507,7,'Sistemas Programables','DI',4,'E');
CALL proce_nueva_asig(108,8,'Graficación','DI',4,'E');
CALL proce_nueva_asig(208,8,'Administración de redes','DI',4,'E');
CALL proce_nueva_asig(308,8,'Taller de Investigación II','CS',4,'E');

CALL proce_nueva_area('Asesoria','https://us04web.zoom.us/j/79372928750?pwd=R2svczlSaGR1T2pDenhqMGtYYUoyQT09','Lunes','7:00','9:00','','D00001',101,'D');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Lunes','14:00','17:00','','D00007',204,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Martes','7:00','8:00','', 'D00007',706,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/eqe-jtxy-uhj','Viernes','12:00','13:00','', 'D00007',706,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','12:00','12:59','', 'D00009',106,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/uwj-ptcj-iqw','Lunes','13:00','14:00','', 'D00009',106,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','16:00','16:59','', 'D00009',202,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/ytn-decr-pbf','Miercoles','17:00','18:00','', 'D00009',202,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/waj-empi-zjo','Martes','13:00','14:00','', 'D00001',506,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Lunes','12:00','13:00','', 'D00004',606,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Martes','17:00','18:00','', 'D00004',606,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/gqk-crnm-tyq','Viernes','7:00','8:00','', 'D00004',null,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Martes','13:00','14:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',106,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','8:00','9:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',304,'E');
CALL proce_nueva_area('Asesoria','https://zoom.us/j/91959756386?pwd=T253UCtoaE84Mk9ZVFVZV2ZmZ3lYQT09','Viernes','12:00','13:00','ID de reunión: 9195975 6386, Código de acceso: 340566','D00003',406,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/hcy-nggn-wdx','Miercoles','16:00','17:00','', 'D00015',null,'E');
CALL proce_nueva_area('Asesoria','https://meet.google.com/lookup/fu4xegew2b','Viernes','16:00','18:00','', 'D00014',101,'E');

INSERT INTO Dependencias VALUES('S', '102', '101'),('S', '202', '201'),('S', '103', '102'),('S', '203', '202'),('S', '104', '103'),
('S', '304', '202'),('S', '504', '503'),('S', '305', '404'),('S', '405', '403'),('S', '605', '604'),('S', '206', '205'),('S', '506', '505'),
('S', '107', '106'),('S', '307', '406'),('S', '507', '606'),('S', '308', '706');

CALL proce_nuevo_curso(1000,'O','D',12,101,'D00001');
CALL proce_nuevo_curso(1001,'O','D',12,201,'D00002');
CALL proce_nuevo_curso(1002,'O','D',10,301,'D00003');
CALL proce_nuevo_curso(1003,'O','D',9,401,'D00004');
CALL proce_nuevo_curso(1004,'O','D',10,501,'D00005');
CALL proce_nuevo_curso(1005,'O','D',10,601,'D00006');
CALL proce_nuevo_curso(1006,'O','E',12,101,'D00007');
CALL proce_nuevo_curso(1007,'O','E',10,201,'D00008');
CALL proce_nuevo_curso(1008,'O','E',12,301,'D00009');
CALL proce_nuevo_curso(1009,'O','E',10,401,'D00010');
CALL proce_nuevo_curso(1010,'O','E',10,501,'D00011');
CALL proce_nuevo_curso(1011,'O','E',10,601,'D00012');
CALL proce_nuevo_curso(1012,'O','D',9,102,'D00013');
CALL proce_nuevo_curso(1013,'O','D',11,202,'D00014');
CALL proce_nuevo_curso(1014,'O','D',15,302,'D00015');
CALL proce_nuevo_curso(1015,'O','D',18,402,'D00001');
CALL proce_nuevo_curso(1016,'O','D',20,502,'D00002');
CALL proce_nuevo_curso(1017,'O','D',10,602,'D00003');
CALL proce_nuevo_curso(1018,'O','E',9,103,'D00002');
CALL proce_nuevo_curso(1019,'O','E',9,203,'D00003');
CALL proce_nuevo_curso(1020,'O','E',3,303,'D00004');
CALL proce_nuevo_curso(1021,'O','E',15,403,'D00005');
CALL proce_nuevo_curso(1022,'O','E',10,503,'D00006');
CALL proce_nuevo_curso(1023,'O','E',12,603,'D00007');

CALL proce_nueva_sesion(1000,'Lunes','8:00','9:59');
CALL proce_nueva_sesion(1000,'Viernes','15:00','17:59');
CALL proce_nueva_sesion(1001,'Martes','7:00','9:59');
CALL proce_nueva_sesion(1001,'Miercoles','10:00','12:59');
CALL proce_nueva_sesion(1002,'Jueves','12:00','13:59');
CALL proce_nueva_sesion(1002,'Lunes','10:00','12:59');
CALL proce_nueva_sesion(1003,'Viernes','18:00','19:59');
CALL proce_nueva_sesion(1003,'Martes','10:00','12:59');
CALL proce_nueva_sesion(1004,'Miercoles','13:00','14:59');
CALL proce_nueva_sesion(1004,'Jueves','14:00','16:59');
CALL proce_nueva_sesion(1012,'Martes','7:00','9:59');
CALL proce_nueva_sesion(1013,'Lunes','8:00','10:59');
CALL proce_nueva_sesion(1014,'Viernes','12:00','15:59');
CALL proce_nueva_sesion(1015,'Jueves','7:00','9:59');
CALL proce_nueva_sesion(1016,'Martes','10:00','11:59');
CALL proce_nueva_sesion(1017,'Lunes','11:00','12:59');
CALL proce_nueva_sesion(1012,'Jueves','10:00','12:59');
CALL proce_nueva_sesion(1013,'Jueves','13:00','14:59');
CALL proce_nueva_sesion(1014,'Miercoles','10:00','14:59');
CALL proce_nueva_sesion(1015,'Viernes','16:00','17:59');
CALL proce_nueva_sesion(1016,'Lunes','13:00','14:59');
CALL proce_nueva_sesion(1017,'Jueves','15:00','16:59');
CALL proce_nueva_sesion(1006,'Martes','8:00','9:59');
CALL proce_nueva_sesion(1007,'Martes','10:00','12:59');
CALL proce_nueva_sesion(1008,'Miercoles','8:00','11:59');
CALL proce_nueva_sesion(1009,'Jueves','7:00','9:59');
CALL proce_nueva_sesion(1010,'Viernes','12:00','14:59');
CALL proce_nueva_sesion(1011,'Lunes','12:00','13:59');
CALL proce_nueva_sesion(1006,'Viernes','15:00','16:59');
CALL proce_nueva_sesion(1007,'Jueves','10:00','13:59');
CALL proce_nueva_sesion(1008,'Lunes','14:00','15:59');
CALL proce_nueva_sesion(1009,'Martes','13:00','14:59');
CALL proce_nueva_sesion(1010,'Martes','15:00','16:59');
CALL proce_nueva_sesion(1011,'Miercoles','12:00','13:59');
CALL proce_nueva_sesion(1018,'Miercoles','7:00','9:59');
CALL proce_nueva_sesion(1019,'Miercoles','10:00','12:59');
CALL proce_nueva_sesion(1020,'Jueves','8:00','11:59');
CALL proce_nueva_sesion(1021,'Martes','7:00','9:59');
CALL proce_nueva_sesion(1022,'Lunes','7:00','9:59');
CALL proce_nueva_sesion(1023,'Viernes','7:00','9:59');
CALL proce_nueva_sesion(1018,'Lunes','10:00','11:59');
CALL proce_nueva_sesion(1019,'Viernes','10:00','13:59');
CALL proce_nueva_sesion(1020,'Lunes','12:00','14:50');
CALL proce_nueva_sesion(1021,'Jueves','12:00','14:59');
CALL proce_nueva_sesion(1022,'Viernes','14:00','16:59');
CALL proce_nueva_sesion(1023,'Martes','10:00','12:59');

INSERT INTO Cursos_Alumnos VALUES(1000,'A','R','18011126');
INSERT INTO Cursos_Alumnos VALUES(1001,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1002,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1003,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1004,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1005,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1000,'A','R','18011378');
INSERT INTO Cursos_Alumnos VALUES(1001,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1002,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1003,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1004,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1005,'A','R','18011378');
INSERT INTO Cursos_Alumnos VALUES(1000,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1001,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1002,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1003,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1004,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1005,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1000,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1001,'A','R','18011362');
INSERT INTO Cursos_Alumnos VALUES(1002,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1003,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1004,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1005,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1000,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1001,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1002,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1003,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1004,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1005,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1012,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1013,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1014,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1015,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1016,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1017,'A','A','18011250');
INSERT INTO Cursos_Alumnos VALUES(1012,'R','P','18011126');
INSERT INTO Cursos_Alumnos VALUES(1013,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1014,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1015,'A','R','18011126');
INSERT INTO Cursos_Alumnos VALUES(1016,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1017,'A','A','18011126');
INSERT INTO Cursos_Alumnos VALUES(1012,'R','P','18011378');
INSERT INTO Cursos_Alumnos VALUES(1013,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1014,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1015,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1016,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1017,'A','A','18011378');
INSERT INTO Cursos_Alumnos VALUES(1012,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1013,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1014,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1015,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1016,'A','A','18011225');
INSERT INTO Cursos_Alumnos VALUES(1017,'R','P','18011225');
INSERT INTO Cursos_Alumnos VALUES(1012,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1014,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1015,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1016,'A','A','18011362');
INSERT INTO Cursos_Alumnos VALUES(1017,'A','A','18011362');
#INSERT INTO Cursos_Alumnos VALUES(1018,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1019,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1020,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1021,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1022,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1023,'S','P','18011250');
#INSERT INTO Cursos_Alumnos VALUES(1019,'S','P','18011378');
#INSERT INTO Cursos_Alumnos VALUES(1020,'S','P','18011378');
#INSERT INTO Cursos_Alumnos VALUES(1021,'S','P','18011378');
#INSERT INTO Cursos_Alumnos VALUES(1022,'S','P','18011378');
#INSERT INTO Cursos_Alumnos VALUES(1023,'S','P','18011378');
#INSERT INTO Cursos_Alumnos VALUES(1019,'S','P','18011126');
#INSERT INTO Cursos_Alumnos VALUES(1020,'S','P','18011126');
#INSERT INTO Cursos_Alumnos VALUES(1021,'S','P','18011126');

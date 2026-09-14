-- Adminer 5.4.2 PostgreSQL 15.17 dump

DROP DATABASE IF EXISTS "gestion_escuela";
CREATE DATABASE "gestion_escuela";
\connect "gestion_escuela";

DROP TABLE IF EXISTS "alumnos";
DROP SEQUENCE IF EXISTS "public".alumnos_id_seq;
CREATE SEQUENCE "public".alumnos_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 91 CACHE 1;

CREATE TABLE "public"."alumnos" (
    "id" integer DEFAULT nextval('alumnos_id_seq') NOT NULL,
    "legajo" integer NOT NULL,
    "nombre" character varying(50) NOT NULL,
    "apellido" character varying(50) NOT NULL,
    "dni" character varying(20) NOT NULL,
    "email" character varying(100) NOT NULL,
    "id_carrera" integer,
    CONSTRAINT "alumnos_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX alumnos_legajo_key ON public.alumnos USING btree (legajo);

CREATE UNIQUE INDEX alumnos_dni_key ON public.alumnos USING btree (dni);

INSERT INTO "alumnos" ("id", "legajo", "nombre", "apellido", "dni", "email", "id_carrera") VALUES
(63,	4164,	'VERONICA',	'ZALACAIN',	'21508110',	'vzalacain@gmail.com',	6),
(66,	4503,	'LUCAS',	'PÉREZ',	'43556987',	'lucas.perez@alumno.edu.ar',	3),
(67,	4504,	'MARÍA',	'RODRÍGUEZ',	'40112365',	'maria.rod@alumno.edu.ar',	3),
(68,	4505,	'JUAN',	'LÓPEZ',	'39852147',	'jlopez@alumno.edu.ar',	4),
(69,	4506,	'SOFÍA',	'MARTÍNEZ',	'42336589',	'smartinez@alumno.edu.ar',	5),
(70,	4507,	'TOMÁS',	'GARCÍA',	'41589745',	'tgarcia@alumno.edu.ar',	7),
(71,	4508,	'VALENTINA',	'FERNÁNDEZ',	'44125896',	'vfernandez@alumno.edu.ar',	5),
(73,	4510,	'MARTINA',	'DÍAZ',	'39556874',	'mdiaz@alumno.edu.ar',	3),
(74,	4511,	'BAUTISTA',	'ALONSO',	'43225698',	'balonso@alumno.edu.ar',	4),
(76,	4513,	'NICOLÁS',	'ÁLVAREZ',	'41885698',	'nalvarez@alumno.edu.ar',	4),
(79,	4516,	'EMILIA',	'SOSA',	'44558965',	'esosa@alumno.edu.ar',	3),
(80,	4517,	'FEDERICO',	'CASTILLO',	'41225896',	'fcastillo@alumno.edu.ar',	7),
(81,	4518,	'VICTORIA',	'GIMÉNEZ',	'43112589',	'vgimenez@alumno.edu.ar',	4),
(62,	3263,	'SILVIO',	'SOLARI',	'22044187',	'solariunlu@gmail.com',	NULL),
(64,	4501,	'RODRIGO',	'MÉNDEZ',	'42105698',	'rodrigo.mendez@alumno.edu.ar',	NULL),
(65,	4502,	'ANA',	'GÓMEZ',	'41225364',	'ana.gomez@alumno.edu.ar',	NULL),
(72,	4509,	'MATEO',	'SILVA',	'40558712',	'msilva@alumno.edu.ar',	NULL),
(75,	4512,	'CAMILA',	'ROMERO',	'42558963',	'cromero@alumno.edu.ar',	NULL),
(78,	4515,	'JOAQUÍN',	'RUIZ',	'39114587',	'jruiz@alumno.edu.ar',	NULL),
(82,	4519,	'SANTIAGO',	'IGLESIAS',	'40889654',	'siglesias@alumno.edu.ar',	NULL),
(90,	11707,	'JUAN',	'LOPEZ',	'12345678',	'juanlopez01@gmail.com',	NULL),
(77,	4514,	'JULIETA',	'TORRES',	'40336589',	'solariunlu@gmail.com',	5);

DROP TABLE IF EXISTS "aulas";
DROP SEQUENCE IF EXISTS "public".aula_id_seq;
CREATE SEQUENCE "public".aula_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 4 CACHE 1;

CREATE TABLE "public"."aulas" (
    "id" integer DEFAULT nextval('aula_id_seq') NOT NULL,
    "descripcion" character varying(100) NOT NULL,
    CONSTRAINT "aulas_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "aulas" ("id", "descripcion") VALUES
(1,	'LAB REDES'),
(2,	'AULA 301'),
(3,	'AULA 102');

DROP TABLE IF EXISTS "carrera";
DROP SEQUENCE IF EXISTS "public".carrera_id_seq;
CREATE SEQUENCE "public".carrera_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 8 CACHE 1;

CREATE TABLE "public"."carrera" (
    "id" integer DEFAULT nextval('carrera_id_seq') NOT NULL,
    "descripcion" character varying(100) NOT NULL,
    CONSTRAINT "carrera_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX carrera_descripcion_key ON public.carrera USING btree (descripcion);

INSERT INTO "carrera" ("id", "descripcion") VALUES
(3,	'TECNICATURA SUPERIOR EN ANÁLISIS DE SISTEMAS'),
(4,	'TECNICATURA SUPERIOR EN DESARROLLO DE SOFTWARE'),
(5,	'TECNICATURA SUPERIOR EN REDES E INFRAESTRUCTURA'),
(6,	'PROFESORADO EN INFORMÁTICA'),
(7,	'CERTIFICACIÓN SUPERIOR EN PROGRAMACIÓN WEB');

DROP TABLE IF EXISTS "condicion_inscripcion";
DROP SEQUENCE IF EXISTS "public".condicion_inscripcion_id_seq;
CREATE SEQUENCE "public".condicion_inscripcion_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."condicion_inscripcion" (
    "id" integer DEFAULT nextval('condicion_inscripcion_id_seq') NOT NULL,
    "descripcion" character varying(20) NOT NULL,
    CONSTRAINT "condicion_inscripcion_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "condicion_inscripcion" ("id", "descripcion") VALUES
(1,	'REGULAR'),
(2,	'LIBRE');

DROP TABLE IF EXISTS "estados_inscripcion";
DROP SEQUENCE IF EXISTS "public".estados_inscripcion_id_seq;
CREATE SEQUENCE "public".estados_inscripcion_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 6 CACHE 1;

CREATE TABLE "public"."estados_inscripcion" (
    "id" integer DEFAULT nextval('estados_inscripcion_id_seq') NOT NULL,
    "descripcion" character varying(50) NOT NULL,
    CONSTRAINT "estados_inscripcion_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX estados_inscripcion_descripcion_key ON public.estados_inscripcion USING btree (descripcion);

INSERT INTO "estados_inscripcion" ("id", "descripcion") VALUES
(1,	'PENDIENTE'),
(2,	'APROBADA'),
(3,	'RECHAZADA');

DROP TABLE IF EXISTS "his_cabecera";
DROP SEQUENCE IF EXISTS "public".his_cabecera_id_seq;
CREATE SEQUENCE "public".his_cabecera_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 10 CACHE 1;

CREATE TABLE "public"."his_cabecera" (
    "id" integer DEFAULT nextval('his_cabecera_id_seq') NOT NULL,
    "fecha_baja" date,
    "periodo" date,
    "usuario" character varying(100),
    CONSTRAINT "his_cabecera_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "his_cabecera" ("id", "fecha_baja", "periodo", "usuario") VALUES
(9,	'2026-09-09',	'2026-06-03',	'admin');

DROP TABLE IF EXISTS "his_inscripciones";
DROP SEQUENCE IF EXISTS "public".his_inscripciones_id_seq;
CREATE SEQUENCE "public".his_inscripciones_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 24 CACHE 1;

CREATE TABLE "public"."his_inscripciones" (
    "id" integer DEFAULT nextval('his_inscripciones_id_seq') NOT NULL,
    "id_alumno" integer,
    "id_materia" integer,
    "fecha_inscripcion" date DEFAULT CURRENT_DATE,
    "id_estado" integer DEFAULT '1',
    "id_condicion" integer DEFAULT '1',
    "motivo" character varying(100),
    "fecha_notificado" date,
    "id_his_cabecera" integer NOT NULL,
    CONSTRAINT "his_inscripciones_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "his_inscripciones" ("id", "id_alumno", "id_materia", "fecha_inscripcion", "id_estado", "id_condicion", "motivo", "fecha_notificado", "id_his_cabecera") VALUES
(1,	71,	32,	'2026-06-30',	3,	1,	NULL,	NULL,	9),
(2,	73,	6,	'2026-06-03',	1,	1,	NULL,	NULL,	9),
(3,	71,	27,	'2026-06-09',	1,	1,	NULL,	NULL,	9),
(4,	71,	27,	'2026-06-30',	3,	1,	NULL,	NULL,	9),
(5,	71,	27,	'2026-07-05',	1,	1,	NULL,	NULL,	9),
(6,	71,	27,	'2026-07-05',	1,	1,	NULL,	NULL,	9),
(7,	71,	32,	'2026-06-27',	2,	2,	NULL,	NULL,	9),
(8,	73,	29,	'2026-08-11',	1,	2,	NULL,	NULL,	9),
(9,	80,	1,	'2026-06-26',	2,	2,	NULL,	NULL,	9),
(10,	67,	31,	'2026-08-19',	3,	1,	NULL,	NULL,	9),
(11,	66,	30,	'2026-08-13',	1,	1,	NULL,	NULL,	9),
(12,	76,	28,	'2026-08-04',	2,	2,	NULL,	NULL,	9),
(13,	74,	28,	'2026-08-04',	2,	1,	NULL,	NULL,	9),
(14,	68,	28,	'2026-08-04',	2,	1,	NULL,	NULL,	9),
(15,	69,	32,	'2026-06-27',	2,	2,	NULL,	NULL,	9),
(16,	63,	2,	'2026-07-03',	1,	1,	NULL,	NULL,	9),
(17,	70,	1,	'2026-06-26',	3,	2,	NULL,	NULL,	9),
(18,	81,	28,	'2026-08-04',	2,	1,	NULL,	NULL,	9),
(19,	69,	27,	'2026-07-05',	3,	1,	'No tiene Correlativas Aprobadas',	NULL,	9),
(20,	79,	6,	'2026-08-06',	3,	1,	'hola esta es una prueba 5  para poder cortarlo cuando pase 50',	NULL,	9),
(21,	77,	32,	'2026-06-27',	2,	1,	'hola prueba 3',	NULL,	9),
(22,	77,	27,	'2026-07-05',	3,	1,	'hola esta es una prueba 5',	NULL,	9),
(23,	77,	27,	'2026-07-08',	2,	2,	NULL,	NULL,	9);

DROP TABLE IF EXISTS "inscripciones";
DROP SEQUENCE IF EXISTS "public".inscripciones_id_inscripcion_seq;
CREATE SEQUENCE "public".inscripciones_id_inscripcion_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 31 CACHE 1;

CREATE TABLE "public"."inscripciones" (
    "id_inscripcion" integer DEFAULT nextval('inscripciones_id_inscripcion_seq') NOT NULL,
    "id_alumno" integer NOT NULL,
    "id_materia" integer NOT NULL,
    "fecha_inscripcion" date DEFAULT CURRENT_DATE NOT NULL,
    "id_estado" integer DEFAULT '1' NOT NULL,
    "id_condicion" integer DEFAULT '1' NOT NULL,
    "motivo" character varying(100),
    "fecha_notificado" date,
    CONSTRAINT "inscripciones_pkey" PRIMARY KEY ("id_inscripcion")
)
WITH (oids = false);

INSERT INTO "inscripciones" ("id_inscripcion", "id_alumno", "id_materia", "fecha_inscripcion", "id_estado", "id_condicion", "motivo", "fecha_notificado") VALUES
(2,	71,	32,	'2026-06-30',	3,	1,	NULL,	NULL),
(3,	73,	6,	'2026-06-03',	1,	1,	NULL,	NULL),
(4,	71,	27,	'2026-06-09',	1,	1,	NULL,	NULL),
(5,	71,	27,	'2026-06-30',	3,	1,	NULL,	NULL),
(6,	71,	27,	'2026-07-05',	1,	1,	NULL,	NULL),
(8,	71,	27,	'2026-07-05',	1,	1,	NULL,	NULL),
(9,	71,	32,	'2026-06-27',	2,	2,	NULL,	NULL),
(11,	73,	29,	'2026-08-11',	1,	2,	NULL,	NULL),
(12,	80,	1,	'2026-06-26',	2,	2,	NULL,	NULL),
(14,	67,	31,	'2026-08-19',	3,	1,	NULL,	NULL),
(15,	66,	30,	'2026-08-13',	1,	1,	NULL,	NULL),
(17,	76,	28,	'2026-08-04',	2,	2,	NULL,	NULL),
(18,	74,	28,	'2026-08-04',	2,	1,	NULL,	NULL),
(19,	68,	28,	'2026-08-04',	2,	1,	NULL,	NULL),
(20,	69,	32,	'2026-06-27',	2,	2,	NULL,	NULL),
(21,	63,	2,	'2026-07-03',	1,	1,	NULL,	NULL),
(22,	70,	1,	'2026-06-26',	3,	2,	NULL,	NULL),
(16,	81,	28,	'2026-08-04',	2,	1,	NULL,	NULL),
(25,	69,	27,	'2026-07-05',	3,	1,	'No tiene Correlativas Aprobadas',	NULL),
(13,	79,	6,	'2026-08-06',	3,	1,	'hola esta es una prueba 5  para poder cortarlo cuando pase 50',	NULL),
(7,	77,	32,	'2026-06-27',	2,	1,	'hola prueba 3',	'2026-07-07'),
(24,	77,	27,	'2026-07-05',	3,	1,	'hola esta es una prueba 5',	'2026-07-07'),
(26,	77,	27,	'2026-07-08',	2,	2,	NULL,	'2026-07-07');

DROP TABLE IF EXISTS "marcador_envio_de_mail";
DROP SEQUENCE IF EXISTS "public".marcador_envio_de_mail_id_marcador_envio_mail_seq;
CREATE SEQUENCE "public".marcador_envio_de_mail_id_marcador_envio_mail_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 8 CACHE 1;

CREATE TABLE "public"."marcador_envio_de_mail" (
    "id_alumno" integer NOT NULL,
    "email_destino" text,
    "asunto" text,
    "resultado" character varying(20),
    "id_marcador_envio_mail" integer DEFAULT nextval('marcador_envio_de_mail_id_marcador_envio_mail_seq') NOT NULL,
    CONSTRAINT "marcador_envio_de_mail_pkey" PRIMARY KEY ("id_marcador_envio_mail")
)
WITH (oids = false);

INSERT INTO "marcador_envio_de_mail" ("id_alumno", "email_destino", "asunto", "resultado", "id_marcador_envio_mail") VALUES
(77,	'solariunlu@gmail.com',	'Estado de tus Inscripciones a las Mesas de Examen',	'OK',	5),
(77,	'solariunlu@gmail.com',	'Estado de tus Inscripciones a las Mesas de Examen',	'OK',	6),
(77,	'solariunlu@gmail.com',	'Estado de tus Inscripciones a las Mesas de Examen',	'OK',	7);

DROP TABLE IF EXISTS "materias";
DROP SEQUENCE IF EXISTS "public".materias_id_seq;
CREATE SEQUENCE "public".materias_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."materias" (
    "id" integer DEFAULT nextval('materias_id_seq') NOT NULL,
    "codigo" character varying(10) NOT NULL,
    "nombre" character varying(100) NOT NULL,
    "anio" integer,
    "id_carrera" integer,
    "id_profesor" integer,
    "fecha_mesa" date,
    CONSTRAINT "materias_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX materias_codigo_key ON public.materias USING btree (codigo);

INSERT INTO "materias" ("id", "codigo", "nombre", "anio", "id_carrera", "id_profesor", "fecha_mesa") VALUES
(27,	'PROG1',	'PROGRAMACIÓN I',	1,	5,	6,	'2026-06-03'),
(32,	'ING001',	'INGLES TECNICO',	2,	5,	6,	'2026-06-30'),
(29,	'SO1',	'SISTEMAS OPERATIVOS',	2,	3,	3,	'2026-08-11'),
(30,	'ANASIS',	'ANÁLISIS DE SISTEMAS',	2,	3,	4,	'2026-08-13'),
(31,	'LAB2',	'LABORATORIO DE SOFTWARE II',	3,	3,	6,	'2026-08-19'),
(1,	'JS1',	'PROGRAMACION JAVASCRIPT',	1,	7,	5,	NULL),
(2,	'PF3',	'PRACTICAS PROFESIONALES',	3,	6,	5,	NULL),
(6,	'11034',	'PROGRAMACION 1',	1,	3,	NULL,	'2026-06-03'),
(28,	'BD1',	'BASES DE DATOS I',	1,	4,	NULL,	'2026-08-04');

DROP TABLE IF EXISTS "mesas_examen";
DROP SEQUENCE IF EXISTS "public".mesas_examen_id_seq;
CREATE SEQUENCE "public".mesas_examen_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."mesas_examen" (
    "id" integer DEFAULT nextval('mesas_examen_id_seq') NOT NULL,
    "id_materia" integer,
    "fecha" date NOT NULL,
    "id_aula" integer,
    CONSTRAINT "mesas_examen_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "mesas_examen" ("id", "id_materia", "fecha", "id_aula") VALUES
(7,	27,	'2026-07-05',	1),
(9,	27,	'2026-06-30',	1),
(10,	27,	'2026-07-08',	1),
(11,	32,	'2026-06-27',	3),
(12,	32,	'2026-09-06',	2),
(13,	28,	'2026-08-04',	1),
(14,	29,	'2026-08-11',	2),
(15,	30,	'2026-08-13',	3),
(16,	31,	'2026-08-19',	1),
(17,	6,	'2026-08-06',	2),
(1,	1,	'2026-06-26',	3),
(2,	2,	'2026-07-03',	2);

DROP TABLE IF EXISTS "profesores";
DROP SEQUENCE IF EXISTS "public".profesores_id_seq;
CREATE SEQUENCE "public".profesores_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 2 CACHE 1;

CREATE TABLE "public"."profesores" (
    "id" integer DEFAULT nextval('profesores_id_seq') NOT NULL,
    "nombre" character varying(50) NOT NULL,
    "apellido" character varying(50) NOT NULL,
    "email" character varying(100),
    CONSTRAINT "profesores_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "profesores" ("id", "nombre", "apellido", "email") VALUES
(4,	'JORGE',	'FERNÁNDEZ',	'jfernandez@escuela.edu.ar'),
(5,	'MARTA',	'GÓMEZ',	'mgomez@escuela.edu.ar'),
(6,	'SILVIA',	'MARTINI',	'smartini@escuela.edu.ar'),
(3,	'PATRICIA',	'ROSSI',	'practicasprofesionalizantes.26@gmail.com'),
(1,	'JUAN CARLOS',	'ROMERO',	'davidcoria004@gmail.com');

ALTER TABLE ONLY "public"."alumnos" ADD CONSTRAINT "alumnos_id_carrera_fkey" FOREIGN KEY (id_carrera) REFERENCES carrera(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."his_inscripciones" ADD CONSTRAINT "his_inscripciones_cabecera_fk" FOREIGN KEY (id_his_cabecera) REFERENCES his_cabecera(id);

ALTER TABLE ONLY "public"."inscripciones" ADD CONSTRAINT "inscripciones_id_alumno_fkey" FOREIGN KEY (id_alumno) REFERENCES alumnos(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY "public"."inscripciones" ADD CONSTRAINT "inscripciones_id_condicion_fkey" FOREIGN KEY (id_condicion) REFERENCES condicion_inscripcion(id);
ALTER TABLE ONLY "public"."inscripciones" ADD CONSTRAINT "inscripciones_id_estado_fkey" FOREIGN KEY (id_estado) REFERENCES estados_inscripcion(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE ONLY "public"."inscripciones" ADD CONSTRAINT "inscripciones_id_materia_fkey" FOREIGN KEY (id_materia) REFERENCES materias(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."marcador_envio_de_mail" ADD CONSTRAINT "marcador_envio_de_mail_id_alumno_fkey" FOREIGN KEY (id_alumno) REFERENCES alumnos(id);

ALTER TABLE ONLY "public"."materias" ADD CONSTRAINT "materias_id_carrera_fkey" FOREIGN KEY (id_carrera) REFERENCES carrera(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE ONLY "public"."materias" ADD CONSTRAINT "materias_id_profesor_fkey" FOREIGN KEY (id_profesor) REFERENCES profesores(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."mesas_examen" ADD CONSTRAINT "mesas_examen_id_aulas_fkey" FOREIGN KEY (id_aula) REFERENCES aulas(id) ON UPDATE CASCADE ON DELETE SET NULL;

-- 2026-09-09 23:15:48 UTC

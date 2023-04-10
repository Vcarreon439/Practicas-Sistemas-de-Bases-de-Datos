/*Practica 2.1*/
Create DATABASE bddnomina;

create table puesto(
    idpuesto serial primary key not null,
    nombre varchar(100)
);

create table nomina(
    idnomina serial primary key,
    numeronomina int not null,
    fechainicio date not null,
    fechafin date not null,
    aplicada bit not null
);

create table categoria(
    idcategoria serial primary key,
    nombre varchar(100) not null,
    sueldo numeric(10,2) null
);

create table departamento(
    iddepartemento serial primary key,
    nombre varchar(100) not null ,
    jefe int,
    iddepartementopadre int
);

alter table departamento
    add foreign key (iddepartementopadre) references departamento(iddepartemento);

create table empleado(
    idempleado serial primary key,
    nsss varchar(25) not null ,
    rfc char(13) not null ,
    curp char(18) not null ,
    nombre varchar(100) not null,
    apellidos varchar(100) not null ,
    telefono char(10) not null ,
    direccion varchar(150) not null ,
    nocuenta varchar(100) not null ,
    iddepartamento int null,
    id_cuenta_contable int null
);

alter table empleado
    add foreign key (iddepartamento) references departamento(iddepartemento);

create table nomina_detalle(
    idnominadetalle serial primary key,
    idnomina int not null ,
    idempleado int not null,
    sueldobase numeric(10,2) not null,
    totaldeducciones numeric(10,2) not null,
    totalcomplementos numeric(10,2) not null,
    totalsueldo numeric(10,2) not null
);

alter  table  nomina_detalle
    add foreign key (idnomina) references nomina(idnomina);

alter table nomina_detalle
    add foreign key (idempleado) references empleado(idempleado);

create table contrato(
  idcontrato serial primary key ,
  idempleado int not null ,
  numerocontrato varchar(25) not null,
  fechaalta date not null,
  fechabaja date null,
  idpuesto int not null,
  idcategoria int not null,
  iddepartamento int not null
);
alter table contrato
    add foreign key (idempleado) references empleado(idempleado);

alter table contrato
    add foreign key (idpuesto) references puesto(idpuesto);

alter table contrato
    add foreign key (idcategoria) references categoria(idcategoria);

alter  table contrato
    add foreign key (iddepartamento) references departamento(iddepartemento);
/*Inserts*/
insert into departamento (Nombre, iddepartementopadre)
values ('Dirección General', null),
		    ('Administrativo', 1),
				('Tecnico', 1),
				('Financiero', 2),
			    ('Academico',2),
				('Administrativo',1),
				('Financiero', 2),
				('Academico',2),
				('Recursos Humanos',3),
				('Servicios Escolares', 3),
				('Servicios Informaticos',3),
				('Carreras',4),
				('Psicologia',4),
				('Laboratorios',4),
				('Técnica',1),
				('Mantenimiento',11),
				('limpieza',11),
				('Cafetería',11),
				('Aulas',12),
       ('Laboratorio', 12),
       ('Baños', 12);

insert into puesto (Nombre) values ('Director'),
									('SubDirector'),
									('Jefe'),
									('Asistente'),
               ('Profesor'),
               ('Laboratorista'),
               ('Mantenimiento'),
               ('Intendente');

insert into categoria (Nombre, Sueldo) values
								('DG', 24000),
								('DA', 18000),
								('SA', 14000),
								('JD', 10000),
								('JA', 8000),
								('DA', 9000),
								('DB', 8000),
								('DC', 7000),
								('AD', 4000),
								('AJ', 3400);

INSERT into empleado (IdEmpleado, NSSS,RFC ,  CURP ,  Nombre ,  Apellidos ,  Telefono ,  Direccion ,  NoCuenta ,  IdDepartamento, id_cuenta_contable ) VALUES
(1, N'87442144', N'ROLK8106016D6', N'ROLK810601MCLDZR06', N'KARLA', N'RODRIGUEZ', N'8717448488', N'CONOCIDO TORREON', N'243689', 4,105),
(2, N'84698447', N'ROLC8406247JD', N'ROLK840624HCLDZR02', N'CARLOS', N'RODRIGUEZ', N'8714248963', N'AV. JOSE PAMANES', N'248996', 2,106),
(3, N'2488796', N'MOCK2436987D7', N'MOCK243698MCDLZR42', N'SANDRA', N'MORALES', N'8712486934', N'CERRADA SAN JONAS', N'2489636', 14,107),
(4, N'2444789', N'NOLC2436989F2', N'NOLC243698HCDLZR42', N'GUSTAVO', N'NOLASCO', N'8714786694', N'CERRADA SAN JONAS', N'2484696', 11,108),
(5, N'3466984', N'LOPL0801442F4', N'LOPL080144MCDLZR42', N'LUZ MARIA', N'LOZANO', N'8744124489', N'CERRADA SAN JONAS', N'26326489', 12,109);

INSERT into contrato  ( IdContrato ,  IdEmpleado ,  NumeroContrato ,  FechaAlta ,  FechaBaja ,  IdPuesto ,  IdCategoria ,  IdDepartamento ) VALUES
  (1, 1, N'12444ABC', CAST(N'2018-07-10' AS Date), NULL, 2, 4, 2),
  (2, 2, N'144239ABC', CAST(N'2010-04-12' AS Date), NULL, 6, 8, 14),
  (3, 3, N'32489664', CAST(N'2020-10-01' AS Date), CAST(N'2020-10-12' AS Date), 6, 8, 14),
  (4, 4, N'4484693KK', CAST(N'2014-08-12' AS Date), NULL, 6, 8, 11),
  (5, 5, N'4484693KK', CAST(N'2014-08-12' AS Date), NULL, 7, 8, 12);

/*-----------------------------------------------------------------------------------------*/

/*Practica 2.2*/
create extension dblink;

/*Insert a la tabla tb_con_poliza de la base de datos contabilidad*/
Select dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
    'INSERT INTO public."tb_con_poliza" (numero_poliza, fecha_poliza, saldo_deudor, saldo_acreedor, aplicada, tipo_poliza)
VALUES (1,''2023-12-12'',0,0,''0'',''B'')');

/*Insert a la tabla tb_con_poliza_detalle de la base de datos contabilidad*/
select dblink_connect('conexion','dbname=contabilidad user=postgres password=postgrespw');
select dblink_exec('conexion','INSERT INTO tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia) values (1,105,5000,0,''De nomina'')');
select dblink_disconnect('conexion');

/*-------------------------------------------------------------------------------------*/

/*Practica 2.3*/

--Inserta un registro en la tabla Nomina
insert into nomina (numeronomina, fechainicio, fechafin, aplicada) values (1,CAST(N'2022-08-01' as date),CAST(N'2022-08-15' as date),'0');
--Recupera el id de Nomina que acabas de insertar
select  max(idnomina) from nomina;

--Insert en Nomina Detalle
Insert into nomina_detalle(idnomina, idempleado, sueldobase, totaldeducciones, totalcomplementos,totalsueldo)
Values (1,1,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 1),2500,1900,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 1)-2500+1900),
(1,2,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 2),2500,1900,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 2)-2500+1900),
(1,3,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 3),2500,1900,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 3)-2500+1900),
(1,4,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 4),2500,1900,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 4)-2500+1900),
(1,5,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 5),2500,1900,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 5)-2500+1900);

--Inserta un registro en la tabla póliza que está en la base de datos de Contabilidad (usa Dblink).
SELECT dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
    'INSERT INTO public.tb_con_poliza (numero_poliza, fecha_poliza, saldo_deudor, saldo_acreedor, aplicada, tipo_poliza)
    values (1,''2023-03-15'',0,0,''0'',''B'')');

--Recupera el id de Poliza que acabas de insertar, utiliza Dblink.
Select temp.id from dblink('dbname=contabilidad user=postgres password=postgrespw',
    'SELECT max(id_poliza) from public.tb_con_poliza') as temp (id integer);

--Insertar en Poliza_Detalle dos registros (Utiliza DbLink)

--Registro Uno
select dblink_connect('conexion','dbname=contabilidad user=postgres password=postgrespw');
select dblink_exec('conexion','INSERT INTO public.tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia)
    values ( '''||(Select temp.id from dblink('dbname=contabilidad user=postgres password=postgrespw',
    'SELECT max(id_poliza) from public.tb_con_poliza') as temp (id integer))||''',''105'','''||(SELECT c2.sueldo from empleado inner join contrato c on empleado.idempleado = c.idempleado
inner join categoria c2 on c.idcategoria = c2.idcategoria where empleado.idempleado = 1)-2500+1900||''',''0'',''De nomina'')');
select dblink_disconnect('conexion');
--Registro Dos
select dblink_connect('conexion','dbname=contabilidad user=postgres password=postgrespw');
select dblink_exec('conexion','INSERT INTO public.tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia)
    values ( '''||(Select temp.id from dblink('dbname=contabilidad user=postgres password=postgrespw',
    'SELECT max(id_poliza) from public.tb_con_poliza') as temp (id integer))||''',''105'',''0'','''||(SELECT c2.sueldo from empleado inner join contrato c on empleado.idempleado = c.idempleado
inner join categoria c2 on c.idcategoria = c2.idcategoria where empleado.idempleado = 1)-2500+1900||''',''De nomina'')');
select dblink_disconnect('conexion');

/*Practica 2.4*/ -- Comprobación
Select * from contrato;

/*Practica 2.5*/
DROP procedure  Genera_Nomina(pFechaInicio date, pFechaFin date);
CREATE procedure Genera_Nomina(
    pFechaInicio date,
    pFechaFin date
)
    language plpgsql
as $$

    Declare vRNomina integer;
    Declare vDeducciones numeric(10,2):=(2500.00);
    Declare vComplementos numeric(10,2):=(1900.00);

    Declare insertarNomDetalle cursor for SELECT e.idempleado, c2.sueldo, e.id_cuenta_contable from empleado e inner join contrato c on e.idempleado = c.idempleado
    inner join categoria c2 on c2.idcategoria = c.idcategoria where fechabaja is null;

    Declare idEmp integer;
    Declare sueldoEmp numeric(18,2);
    Declare idCC integer;
    Declare totSueldo numeric(18,2);

    Declare tmpId integer;
    Declare fechaAct timestamp := cast(now() as timestamp);

    --Para la conexion
    Declare state text;

Begin

    --Insertar en nomina
    vRNomina:= (coalesce((Select max(idnomina) from nomina),0)+1);

    insert into nomina (numeronomina, fechainicio, fechafin, aplicada)
        values (vRNomina, pFechaInicio,pFechaFin,B'0');

    vRNomina:=(Select max(idnomina) from nomina);

    --Proceso de Insertar en Nomina_Detalle
    open insertarNomDetalle;
        loop
            fetch next from insertarNomDetalle into idEmp, sueldoEmp, idCC;
            exit when not FOUND;

            totSueldo:= (sueldoEmp+vComplementos-vDeducciones);

            insert into nomina_detalle (idnomina, idempleado, sueldobase, totaldeducciones, totalcomplementos, totalsueldo)
                values (vRNomina, idEmp,sueldoEmp,vDeducciones,vComplementos,totSueldo);

            --Proceso de Insertar en Poliza
            state:=dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
                'INSERT INTO public.tb_con_poliza (numero_poliza, fecha_poliza, saldo_deudor, saldo_acreedor, aplicada, tipo_poliza)
                values ('''||cast(vRNomina as varchar(25))||''','''||fechaAct||''','''||totSueldo||''','''||totSueldo||''',B''0'',''B'')');

            --Recupera el id de Poliza que acabas de insertar
            tmpId := (Select temp.id from dblink('dbname=contabilidad user=postgres password=postgrespw',
                'SELECT max(numero_poliza) from public.tb_con_poliza') as temp (id integer));

            --Insertar en Poliza_Detalle dos registros
            --Registro Uno
            state:=dblink_exec('dbname=contabilidad user=postgres password=postgrespw','
                insert into public.tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia)
                    values ('||tmpId||','||idCC||','''||totsueldo||''',''0'',''De nomina'')');

            --Registro Dos
            state:=dblink_exec('dbname=contabilidad user=postgres password=postgrespw','
                insert into public.tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia)
                    values ('||tmpId||', ''103'', ''0'','''||totsueldo||''', ''De nomina'')');

        end loop;
    close insertarNomDetalle;
end
$$;

--Ejecucion
do
$$
    begin
        call public.Genera_Nomina('2022-08-01','2022-08-15');
    end
$$;

--Comprobacion
SELECT * from nomina;
SELECT * from nomina_detalle;

Select temp.* from dblink('dbname=contabilidad user=postgres password=postgrespw',
                'SELECT * from public.tb_con_poliza') as temp(id integer, num varchar(25),fecha timestamp,saldod numeric(18,2),salcoa numeric(18,2),aplicada bit, tipo char);

Select temp.* from dblink('dbname=contabilidad user=postgres password=postgrespw',
                'SELECT * from public.tb_con_poliza_detalle') as temp(id integer, idcc integer, debe numeric(18,2), haber numeric(18,2), referencia varchar(50));
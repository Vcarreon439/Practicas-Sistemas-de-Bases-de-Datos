Create DATABASE bddnomina;

create extension dblink;

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

insert into nomina (numeronomina, fechainicio, fechafin, aplicada) values (1,CAST(N'2022-08-01' as date),CAST(N'2022-08-15' as date),'0');

/*Insert en Nomina Detalle*/

Insert into nomina_detalle(idnomina, idempleado, sueldobase, totaldeducciones, totalcomplementos,totalsueldo)
Values (1,1,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 1),500,200,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 1)-500+200),
(1,2,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 2),400,100,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 2)-400+100),
(1,3,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 3),600,600,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 3)-600+600),
(1,4,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 4),200,200,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 4)-200+200),
(1,5,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 5),600,700,(select sueldo from categoria as ca inner join contrato as co on ca.idcategoria = co.idcategoria where idempleado = 5)-600+700);

/*Insert a la tabla tb_con_poliza de la base de datos contabilidad*/
Select dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
    'INSERT INTO public."tb_con_poliza" (numero_poliza, fecha_poliza, saldo_deudor, saldo_acreedor, aplicada, tipo_poliza)
VALUES (1,''2023-12-12'',0,0,''0'',''B'')');

/*Insert a la tabla tb_con_poliza_detalle de la base de datos contabilidad*/
select dblink_connect('conexion','dbname=contabilidad user=postgres password=postgrespw');
select dblink_exec('conexion','INSERT INTO tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia) values (1,105,5000,0,''De nomina'')');
select dblink_disconnect('conexion');

/*Sentencia de max id_cc*/
Select externa.idcc
from dblink('dbname=contabilidad user=postgres password=postgrespw',
    'Select max(id_cuenta_contable) from cuenta_contable')
    as externa(idcc integer);

SELECT * from empleado;

/*Cursor*/
Drop procedure GeneraPoliza;
CREATE procedure GeneraPoliza(
    pFechaInicio date,
    pFechaFin date
)
    language plpgsql
as $$
    DECLARE cursor cursor for select n.*  from nomina_detalle nd
inner join nomina n on n.idnomina=nd.idnomina;



Declare vNumeroNomina integer;
Declare vIdNomina integer;
Declare vIdPoliza integer;
Declare vIdCuentacontable integer;
Begin

    vNumeroNomina := (Select Max(numeronomina) from nomina);

    if vNumeroNomina IS NULL THEN
        vNumeroNomina:=1;
    end if;

    Insert into public.nomina (numeronomina, fechainicio, fechafin, aplicada) values
          (vNumeroNomina,'2023-03-01','2023-03-15',b'0');
    vIdNomina := (Select max(idnomina) from nomina);

    Perform dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
        'INSERT INTO public.tb_con_poliza (numero_poliza, fecha_poliza, saldo_deudor, saldo_acreedor, aplicada, tipo_poliza)
        values (1,''2023-03-15'',0,0,''0'',''3'')');

    vIdPoliza:=(Select temp.id from dblink('dbname=contabilidad user=postgres password=postgrespw',
        'SELECT max(id_poliza) from public.tb_con_poliza') as temp (id integer));

    Insert into  public.nomina_detalle(idnomina, idempleado, sueldobase, totaldeducciones, totalcomplementos, totalsueldo)
    values (vIdNomina,1,8000,2000,3000,9000);

   vIdCuentacontable := 106;

        Perform dblink_exec('dbname=contabilidad user=postgres password=postgrespw',
       'INSERT into public.tb_con_poliza_detalle (id_poliza, id_cuenta_contable, debe, haber, referencia)
        values ('''||vIdpoliza||''','''||vIdCuentacontable||''',5000,0,''De nomina'')');

end
$$;

do
$$
    begin
        call public.generapoliza();
    end
$$;
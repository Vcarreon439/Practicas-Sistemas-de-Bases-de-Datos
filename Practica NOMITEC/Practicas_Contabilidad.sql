/*Practica 2.1*/
create database Contabilidad;

create table cuenta_contable(
    id_cuenta_contable serial primary key,
    numero_cuenta_contable varchar(20) not null ,
    nombre_cuenta_contable varchar(50) not null ,
    naturaleza_cuenta_contable char(1) not null ,
    tipo_cuenta_contable char(1) not null ,
    saldo_deudor numeric(18,2),
    saldo_acreedor numeric(18,2),
    id_cuenta_padre int,
    ultimo_nivel bit not null ,
    nivel int
);

alter table cuenta_contable
    add foreign key (id_cuenta_padre) references cuenta_contable(id_cuenta_contable);

create table tb_con_poliza(
    id_poliza serial primary key ,
    numero_poliza varchar(25) not null ,
    fecha_poliza timestamp,
    saldo_deudor numeric(18,2),
    saldo_acreedor numeric(18,2),
    aplicada bit,
    tipo_poliza char(1)

);

Create table tb_con_poliza_detalle(
    id_poliza int,
    id_cuenta_contable int,
    debe numeric(18,2),
    haber numeric(18,2),
    referencia varchar(50)
);

alter table tb_con_poliza_detalle
    add foreign key (id_cuenta_contable) references cuenta_contable(id_cuenta_contable);

alter  table tb_con_poliza_detalle
    add foreign key (id_poliza) references tb_con_poliza(id_poliza);

INSERT INTO cuenta_contable (Id_Cuenta_Contable, Numero_Cuenta_Contable, Nombre_Cuenta_Contable, Naturaleza_Cuenta_Contable, Tipo_Cuenta_Contable, Saldo_Deudor, Saldo_Acreedor, Id_Cuenta_Padre, Ultimo_Nivel, Nivel) VALUES
('1', '1000', 'ACTIVOS', 'N', 'N', '0.00', '5500.00', null,'0', '1'),
 ( '2',  '1100',  'Activo Circulante.',  'N',  'N',  '0.00',  '5500.00',  '1',  '0',  '2'),
 ( '3',  '1101',  'Caja',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '4',  '1102',  ' ancos',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '5',  '1103',  'Inversiones',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '6',  '1104',  'Clientes',  'D',  ' ',  '0.00',  '5500.00',  '2',  '0',  '3'),
 ( '7',  '1105',  'Documentos por co rar',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '8',  '1106',  'Deudores Diversos.',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '9',  '1107',  'Impuestos a favor',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '10',  '1108',  'Anticipo a Proveedores',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '11',  '1109',  'IVA Acredita le.',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '12',  '1110',  'Almacén',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '13',  '1111',  'Inventario',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '14',  '1112',  'Mercancías en tránsito',  'D',  ' ',  '0.00',  '0.00',  '2',  '0',  '3'),
 ( '15',  '1200',  'Activo no Circulante.',  'N',  'N',  '0.00',  '0.00',  '1',  '0',  '2'),
 ( '16',  '1201',  'Terrenos.',  'D',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '17',  '1202',  'Edificios',  'D',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '18',  '1203',  'Deprec. Acumulada de Edificio.',  'A',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '19',  '1204',  'Mo iliario y Equipo',  'D',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '20',  '1205',  'Deprec. Acum. De Mo iliario y Equipo',  'A',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '21',  '1206',  'Maquinaria y Equipo',  'D',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '22',  '1207',  'Deprec. Acum. De Maquinaria y Equipo',  'A',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '23',  '1208',  'Equipo de Transporte',  'D',  ' ',  '0.00',  '0.00',  '15',  '1',  '3'),
 ( '24',  '1209',  'Deprec. Acum. De Equipo de Transporte.',  'A',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '25',  '1210',  'Equipo de Cómputo.',  'D',  ' ',  '0.00',  '0.00',  '15',  '1',  '3'),
 ( '26',  '1211',  'Deprec. Acumulada de Equipo de cómputo',  'A',  ' ',  '0.00',  '0.00',  '15',  '0',  '3'),
 ( '27',  '1300',  'Otros Activos.',  'N',  'N',  '0.00',  '0.00',  '1',  '0',  '2'),
 ( '28',  '1301',  'Gastos de Instalación',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '29',  '1302',  'Amortizac. Acum. De Gastos de Instalación.',  'A',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '30',  '1303',  'Gastos de Organización',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '31',  '1304',  'Amortizac. Acum. De Gastos de Organización',  'A',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '32',  '1305',  'Marcas Registradas',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '33',  '1306',  'Amortizac. Acum. De Marcas Registradas.',  'A',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '34',  '1307',  'Patentes',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '35',  '1308',  'Amortizac. Acum. De Patentes.',  'A',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '36',  '1309',  'Derechos de Autor',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '37',  '1310',  'Amortizac. Acum. De Derechos de autor.',  'A',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '38',  '1311',  'Seguros pagados por anticipado',  'D',  ' ',  '0.00',  '0.00',  '27',  '1',  '3'),
 ( '39',  '1312',  'Rentas pagadas por anticipado',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '40',  '1313',  'Intereses Pagados por anticipado.',  'D',  ' ',  '0.00',  '0.00',  '27',  '0',  '3'),
 ( '41',  '1314',  'Papelería y útiles',  'D',  ' ',  '0.00',  '0.00',  '27',  '1',  '3'),
 ( '42',  '2000',  'PASIVOS',  'N',  'N',  '0.00',  '0.00',null,  '0',  '1'),
 ( '43',  '2100',  'Pasivo Circulante.',  'N',  'N',  '0.00',  '0.00',  '42',  '0',  '2'),
 ( '44',  '2101',  'Proveedores',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '45',  '2102',  'Acreedores Diversos.',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '46',  '2103',  'Documentos por Pagar',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '47',  '2104',  'Impuestos por Pagar',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '48',  '2105',  'Anticipos de Clientes',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '49',  '2106',  'IVA por Pagar',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '50',  '2107',  'Gastos pendientes de pago',  'A',  ' ',  '0.00',  '0.00',  '43',  '0',  '3'),
 ( '51',  '2200',  'Pasivo Fijo',  'N',  'N',  '0.00',  '0.00',  '42',  '0',  '2'),
 ( '52',  '2201',  'Hipotecas por Pagar',  'A',  ' ',  '0.00',  '0.00',  '51',  '0',  '3'),
 ( '53',  '2202',  'Documentos por Pagar a largo plazo',  'A',  ' ',  '0.00',  '0.00',  '51',  '0',  '3'),
 ( '54',  '2203',  'Préstamos  ancarios.',  'A',  ' ',  '0.00',  '0.00',  '51',  '0',  '3'),
 ( '55',  '2300',  'Otros Pasivos.',  'N',  'N',  '0.00',  '0.00',  '42',  '0',  '2'),
 ( '56',  '2301',  'Rentas co radas por anticipado',  'A',  ' ',  '0.00',  '0.00',  '55',  '0',  '3'),
 ( '57',  '2302',  'Intereses cobados',  'A',  'A',  '0.00',  '0.00',  '55',  '0',  '3'),
 ( '58',  '3000',  'CAPITAL Contable',  'N',  'N',  '0.00',  '0.00', null, '0',  '1'),
 ( '59',  '3100',  'Capital Social',  'N',  'N',  '0.00',  '0.00',  '58',  '0',  '2'),
 ( '60',  '3101',  'Capital Social',  'A',  ' ',  '0.00',  '0.00',  '59',  '1',  '3'),
 ( '61',  '3200',  'Superávit.',  'N',  'N',  '0.00',  '0.00',  '58',  '0',  '2'),
 ( '62',  '3201',  'Resultado del ejercicio actual.',  'A',  ' ',  '0.00',  '0.00',  '61',  '0',  '3'),
 ( '63',  '3202',  'Resultado de ejercicios anteriores.',  'A',  ' ',  '0.00',  '0.00',  '61',  '0',  '3'),
 ( '64',  '3203',  'Reserva Legal',  'A',  ' ',  '0.00',  '0.00',  '61',  '0',  '3'),
 ( '65',  '3204',  'Superávit donado.',  'A',  ' ',  '0.00',  '0.00',  '61',  '0',  '3'),
 ( '66',  '3205',  'Superávit por revaluación.',  'A',  ' ',  '0.00',  '0.00',  '61',  '0',  '3'),
 ( '67',  '4000',  'RESULTADOS ACREEDORAS',  'N',  'N',  '0.00',  '0.00', null,'0',  '1'),
 ( '68',  '4101',  'Ventas',  'A',  'R',  '0.00',  '0.00',  '67',  '0',  '3'),
 ( '69',  '4102',  'Devoluciones so re compra',  'A',  'R',  '0.00',  '0.00',  '67',  '0',  '3'),
 ( '70',  '4103',  'Re ajas so re compra.',  'A',  'R',  '0.00',  '0.00',  '67',  '0',  '3'),
 ( '71',  '4104',  'Otros Ingresos',  'A',  'R',  '0.00',  '0.00',  '67',  '0',  '3'),
 ( '72',  '4105',  'Productos Financieros.',  'A',  'R',  '0.00',  '0.00',  '67',  '0',  '3'),
( '73',  '5000',  'RESULTADOS DEUDORAS',  'N',  'N',  '5500.00',  '0.00', null, '0',  '1'),
 ( '74',  '5101',  'Costo de Ventas',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '75',  '5102',  'Compras',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '76',  '5103',  'Gastos de Compra',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '77',  '5104',  'Gastos de Operación',  'D',  'R',  '5500.00',  '0.00',  '73',  '0',  '3'),
 ( '78',  '5104.01',  'Gastos de Administración',  'D',  'R',  '3000.00',  '0.00',  '77',  '0',  '4'),
 ( '79',  '5104.02',  'Gastos de Venta',  'D',  'R',  '0.00',  '0.00',  '77',  '0',  '4'),
 ( '80',  '5105',  'Otros gastos',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '81',  '5106',  'Gastos Financieros.',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '82',  '5107',  'Devoluciones so re venta',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '83',  '5108',  'Re ajas so re venta.',  'D',  'R',  '0.00',  '0.00',  '73',  '0',  '3'),
 ( '84',  '1102.01',  'Scotia ank',  'D',  ' ',  '0.00',  '0.00',  '4',  '0',  '4'),
 ( '85',  '1102.01.01',  '151310',  'D',  ' ',  '0.00',  '0.00',  '84',  '1',  '5'),
 ( '86',  '1204.01',  'Office Depot',  'D',  ' ',  '0.00',  '0.00',  '19',  '1',  '4'),
 ( '87',  '2101.01',  'Rivers System',  'A',  ' ',  '0.00',  '0.00',  '44',  '1',  '4'),
 ( '88',  '2102.01',  'Toyota SA de CV',  'A',  ' ',  '0.00',  '0.00',  '45',  '1',  '4'),
 ( '89',  '1104.01',  'Fast Signs',  'D',  ' ',  '0.00',  '0.00',  '6',  '1',  '4'),
 ( '90',  '1104.02',  'Calidad Tecnologica',  'D',  ' ',  '0.00',  '0.00',  '6',  '1',  '4'),
 ( '91',  '5105.01',  'Imprenta Plus',  'D',  'R',  '0.00',  '0.00',  '80',  '1',  '4'),
 ( '92',  '1102.02',  ' anamex',  'D',  ' ',  '0.00',  '0.00',  '4',  '0',  '4'),
 ( '93',  '1102.02.01',  '251010',  'D',  ' ',  '0.00',  '0.00',  '92',  '1',  '5'),
 ( '94',  '5104.01.01',  'Telmex',  'D',  'R',  '0.00',  '0.00',  '78',  '1',  '5'),
 ( '95',  '5104.01.02',  'Telcel',  'D',  'R',  '0.00',  '0.00',  '78',  '1',  '5'),
 ( '96',  '5104.01.03',  'CFE',  'D',  'R',  '0.00',  '0.00',  '78',  '1',  '5'),
 ( '97',  '5104.01.04',  'Simas',  'D',  'R',  '3000.00',  '0.00',  '78',  '1',  '5'),
 ( '98',  '5104.03',  'Sueldos y Salarios',  'D',  'R',  '2500.00',  '0.00',  '77',  '1',  '4'),
 ( '99',  '1104.03',  'Delicatez',  'D',  ' ',  '0.00',  '5500.00',  '6',  '1',  '4'),
 ( '100',  '1104.04',  'Soriana',  'D',  ' ',  '0.00',  '0.00',  '6',  '0',  '4'),
 ( '101',  '1104.04.01',  'Sucursal Ham urgo',  'D',  ' ',  '0.00',  '0.00',  '100',  '1',  '5'),
 ( '103',  '1102.01',  ' ancomer',  'D',  ' ',  '0.00',  '0.00',  '4',  '1',  '4'),
 ( '104',  '1102.02',  ' anamex',  'D',  ' ',  '0.00',  '0.00',  '4',  '1',  '4'),
( '105',  '5104.01.01',  'ROLK810601MCLDZR06',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5'),
( '106',  '5104.01.02',  'ROLK840624HCLDZR02',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5'),
( '107',  '5104.01.03',  'MOCK243698MCDLZR42',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5'),
( '108',  '5104.01.04',  'NOLC243698HCDLZR42',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5'),
( '109',  '5104.01.05',  'LOPL080144MCDLZR42',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5');

/*-----------------------------------------------------------------------------------*/

/*Practica 2.2*/
create extension dblink;

SELECT * from tb_con_poliza_detalle;

/*Select a la base de Datos bddnomina*/
Select externa.idEmpleado, externa.idCuenta, externa.Curp, concat_ws(' ',externa.Nombre, externa.Apellido) as Nombre
from dblink('dbname=bddnomina user=postgres password=postgrespw',
    'Select idempleado, id_cuenta_contable, curp, nombre, apellidos from empleado')
    as externa(idEmpleado integer, idCuenta integer, Curp char(18), Nombre varchar(100), Apellido varchar(100))
ORDER BY externa.Nombre;

/*-----------------------------------------------------------------------------------------*/

/*Practica 2.3*/ --Solo para comprobar
Select * from tb_con_poliza_detalle;
SELECT * from tb_con_poliza;
SELECT * from cuenta_contable;

/*Practica 2.4*/


/*Inserta una cuenta contable que posteriormente tendrás que asociar con un empleado. En el
número de cuenta contable utiliza esta nomenclatura 5104.01.05 y cambia el consecutivo de
los últimos dos dígitos. El CURP será el nombre de la cuenta contable (ejem:
'LOPL080144MCDLZR42'), La naturaleza es D, el tipo es B, saldo deudor y acreedor es 0, cuenta
padres es 78, es de último nivel y pertenece al nivel 5.*/

WITH variables (nomencletua, curp, naturaleza, tipo, saldoAD, padre, un, nivel) as (
    values (
            concat('5104.01.', (SELECT lpad(cast(cast(substring(numero_cuenta_contable from '\d+\.\d+\.(\d+)$')
            as integer)+1 as varchar),2,'0') FROM cuenta_contable ORDER BY
            id_cuenta_contable DESC LIMIT 1)),
            'LOPL080144MCDLZR42',
            'D',
            'B',
            0,
            78,
            B'1',
            5)
)
Insert Into cuenta_contable (numero_cuenta_contable, nombre_cuenta_contable, naturaleza_cuenta_contable, tipo_cuenta_contable, saldo_deudor, saldo_acreedor, id_cuenta_padre, ultimo_nivel, nivel) SELECT nomencletua, curp, naturaleza, tipo, saldoAD, saldoAD, padre, un, nivel from variables;

SELECT * from cuenta_contable;

/*Recupera el id de Cuenta contable del punto 1.*/
SELECT max(id_cuenta_contable) from cuenta_contable;

/*Inserta en la tabla Empleado dentro de la base de datos de Nomina los siguientes datos. Utiliza
DbLink.*/
WITH variables2 (NSSS, RFC, CURP, Nombre, Apellidos, Tel, Direccion, NoCuenta, idDepartamento, idCC) AS (
   SELECT '340657225524079', 'LOPL080144MCD', 'LOPL080144MCDLZR42', 'Pau', 'Oliva', '9437456497',
          'Placa López, 4, 7º B, Villa Gallego PC:62565', '5171930070800412', 1,
          (SELECT max(id_cuenta_contable) FROM cuenta_contable)
)
SELECT dblink_exec('dbname=bddnomina user=postgres password=postgrespw',
   'INSERT INTO public.empleado (nsss, rfc, curp, nombre, apellidos, telefono, direccion, nocuenta, iddepartamento, id_cuenta_contable) ' ||
   'VALUES (' || NSSS || ', ''' || RFC || ''', ''' || CURP || ''', ''' || Nombre || ''', ''' || Apellidos || ''', ''' || Tel || ''', ''' || Direccion || ''', ''' || NoCuenta || ''', ' || idDepartamento || ', ' || idCC || ')')
FROM variables2;

/*Recupera el Id del empleado del punto 3.*/
Select idEmpleado from dblink('dbname=bddnomina user=postgres password=postgrespw',
            'Select max(idempleado) from empleado') as tempEmp (idEmpleado integer);

/*Inserta en la tabla Contrato dentro de la base de datos de Nomina los siguientes datos. Utiliza DbLink.*/
WITH variables3 (idEmpleado, NumeroContrato, FechaAlta, FechaBaja, idPuesto, idCategoria, idDepartamento) AS (
   SELECT (SELECT idEmpleado FROM dblink('dbname=bddnomina user=postgres password=postgrespw', 'SELECT max(idempleado) FROM empleado') AS tempEmp (idEmpleado integer)),
          'CONTRATO-P001', now()::text, null, 4, 7, 15
)
SELECT dblink_exec('dbname=bddnomina user=postgres password=postgrespw','
   INSERT INTO public.contrato (idempleado, numerocontrato, fechaalta, fechabaja, idpuesto, idcategoria, iddepartamento)
   VALUES (' || idEmpleado || ','''|| NumeroContrato ||''','''|| FechaAlta ||''',NULL,'|| idPuesto ||','|| idCategoria ||','|| idDepartamento ||')')
FROM variables3;

Select tempEmp.* from dblink('dbname=bddnomina user=postgres password=postgrespw',
            'Select * from contrato') as tempEmp (icC integer, idEmp integer, numCnt varchar(25), alta date, baja date, idP integer, idC integer, idD integer);

/*Practica 2.5*/
drop procedure Crea_Empleado(varchar, char, char, varchar, varchar, char, varchar, varchar, varchar, date, date, integer, integer, integer);
CREATE procedure Crea_Empleado(
    --Empleado
    NSSS varchar(25),
    RFC char(13),
    CURP char(18),
    Nombre varchar(100),
    Apellidos varchar(100),
    Telefono char(10),
    Direccion varchar(150),
    NoCuenta varchar(100),
    --Contrato
    NumeroContrato varchar(25),
    FechaAlta date,
    FechaBaja date,
    IdPuesto integer,
    IdCategoria integer,
    IdDepartamento integer
)
    language plpgsql
as $$
    DECLARE vState text;
    Declare vCCFormat varchar:='5104.01.';
-- En el número de cuenta contable utiliza esta nomenclatura 5104.01.05 y cambia el consecutivo de los últimos dos dígitos.
    Declare vLstCc varchar:= (SELECT lpad(cast(cast(substring(numero_cuenta_contable from '\d+\.\d+\.(\d+)$')
                                as integer)+1 as varchar),2,'0') FROM cuenta_contable ORDER BY
                                id_cuenta_contable DESC LIMIT 1);
    Declare vIdCC integer;
    Declare idEmp integer;

Begin
    vCCFormat:=cast(concat(vCCFormat,vLstCc) as varchar);

    vIdCC:=(cast((Select max(id_cuenta_contable)+1 from cuenta_contable) as integer));

    --Inserta una cuenta contable
    Insert Into cuenta_contable (id_cuenta_contable,numero_cuenta_contable, nombre_cuenta_contable, naturaleza_cuenta_contable,
         tipo_cuenta_contable, saldo_deudor, saldo_acreedor, id_cuenta_padre, ultimo_nivel, nivel)
    values (vIdCC,vCCFormat,CURP,'D','B',0,0,78,B'1',5);

    -- Recupera el id de Cuenta contable.
    vIdCC:=(cast((Select max(id_cuenta_contable) from cuenta_contable) as integer));

    -- Inserta en la tabla Empleado
    vState:=dblink_exec('dbname=bddnomina user=postgres password=postgrespw','
                insert into public.empleado (nsss,rfc,curp,nombre,apellidos,telefono, direccion, nocuenta, iddepartamento, id_cuenta_contable)
                    values ('''||NSSS||''','''||RFC||''','''||CURP||''','''||Nombre||''','''||Apellidos||''','''||Telefono||''','''||Direccion||''','''||NoCuenta||''','''||IdDepartamento||''','''||vIdCC||''')');

    -- Recupera el Id del empleado que acabas de insertar.
    idEmp:=(Cast((Select idEmpleado from dblink('dbname=bddnomina user=postgres password=postgrespw',
            'Select max(idempleado) from empleado') as tempEmp (idEmpleado integer))as integer));


    --Inserta en la tabla Contrato
    vState:=dblink_exec('dbname=bddnomina user=postgres password=postgrespw','
                insert into public.contrato (idempleado, numerocontrato, fechaalta, fechabaja, idpuesto, idcategoria, iddepartamento)
                    values ('''||idEmp||''','''||NumeroContrato||''','''||FechaAlta||''','''||FechaBaja||''','''||IdPuesto||''','''||IdCategoria||''','''||IdDepartamento||''')');

end
$$;

-- Ejecucion de prueba
do
$$
begin
    call public.crea_empleado(
            nsss := cast('1234567890123456789012345' as varchar),
            rfc := cast('PERJ850101123' as char(13)),
            curp := cast('PERJ850101HDFRNR09' as char(18)),
            nombre := cast('Juan' as varchar),
            apellidos := cast('Perez' as varchar),
            telefono := cast('5551234567' as char(10)),
            direccion := cast('Calle 123, Colonia Centro' as varchar),
            nocuenta := cast('01234567890123456789' as varchar),
            numerocontrato := cast('CONTRATO-001' as varchar),
            fechaalta := cast(now() as date),
            fechabaja := cast(now() as date),
            idpuesto := 6,
            idcategoria := 8,
            iddepartamento := 14
        );
end
$$;

-- Selects de comrpobacion
SELECT * from cuenta_contable order by id_cuenta_contable desc limit 1;
Select temp.* from dblink('dbname=bddnomina user=postgres password=postgrespw',
                'SELECT * from public.empleado') as temp (idempleado int, nsss varchar(25), rfc char(13),
                    curp char(18), nombre varchar(100), apellidos varchar(100), telefono char(10),
                    direccion varchar(150), nocuenta varchar(100), iddepartamento int, id_cuenta_contable int)
              order by temp.idempleado desc limit 1;

Select temp.* from dblink('dbname=bddnomina user=postgres password=postgrespw',
                'SELECT * from public.contrato') as temp (idcontrato int, idempleado int, numerocontrato varchar(25),
                        fechaalta date, fechabaja date, idpuesto int, idcategoria int, iddepartamento int)
              order by temp.idcontrato desc limit 1;

/*-------------------------------Ejercicios vistos en clase y extras---------------------------------------------------------*/

/*Select del esquema de bddnomina*/
Select concat_ws(' ', tempEmp.Nombre, tempEmp.Apellidos) as Nombre, cast(tempEmp.Sueldo as money) as Sueldo,
       tempEmp.id_cuenta_contable,
       tempEmp.nsss,
       tempEmp.rfc,
       tempEmp.curp,
       tempEmp.Puesto,
       tempEmp.Categoria,
       tempEmp.Departamento
       from dblink(
    'dbname=bddnomina user=postgres password=postgrespw',
    'Select E.id_cuenta_contable, e.nsss, e.rfc, e.curp, e.nombre ,e.apellidos,p.nombre, c2.nombre, c2.sueldo, d.nombre from empleado as E
    inner join contrato c on E.idempleado = c.idempleado
    inner join puesto p on c.idpuesto = p.idpuesto
    inner join categoria c2 on c.idcategoria = c2.idcategoria
    inner join departamento d on c.iddepartamento = d.iddepartemento'
    )
as tempEmp (id_cuenta_contable integer, NSSS varchar(25), RFC char(13),
    CURP char(18),Nombre varchar(100), Apellidos varchar(100),Puesto varchar(50),
    Categoria varchar(50), Sueldo numeric(10,2), Departamento varchar(50))
order by sueldo, nombre;

/*Insert a Cuenta contable*/
INSERT INTO cuenta_contable (Id_Cuenta_Contable, Numero_Cuenta_Contable, Nombre_Cuenta_Contable, Naturaleza_Cuenta_Contable, Tipo_Cuenta_Contable, Saldo_Deudor, Saldo_Acreedor, Id_Cuenta_Padre, Ultimo_Nivel, Nivel) VALUES
('110','5104.01.06',  'LOPL080144MCDLZR42',  'D',  ' ',  '0.00',  '0.00',  '78',  '1',  '5');

/*Sentencia para agarrar el max de id_cuenta_contable*/
SELECT max(id_cuenta_contable) from cuenta_contable;

SELECT * from tb_con_poliza_detalle;

/*Para insertar valores desde dblink es con*/
/*'''||(valor o select)||'''*/

select dblink_connect('conexion','dbname=bddnomina user=postgres password=postgrespw');
select dblink_exec(
    'conexion',
    'insert into empleado (idempleado, nsss, rfc, curp, nombre, apellidos, telefono, direccion, nocuenta, iddepartamento, id_cuenta_contable)
        values (''6'', ''46541254'', ''AUVE08020116D'', ''AUVE080201HDGRZDA8'', ''Edgar'', ''Arguijo'', ''8714166171'', ''Fracc. Santa Teresa'', ''28326599'', ''1'', '''||(Select max(id_cuenta_contable) from cuenta_contable)||''')');
select dblink_disconnect('conexion');
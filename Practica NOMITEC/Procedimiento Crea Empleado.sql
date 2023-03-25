drop procedure public.crea_empleado(varchar, char, char, varchar, varchar, char, varchar, varchar, varchar, date, date, integer, integer, integer);
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
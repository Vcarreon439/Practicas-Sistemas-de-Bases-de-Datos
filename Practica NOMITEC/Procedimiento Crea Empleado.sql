DROP procedure  GeneraPoliza(pFechaInicio date, pFechaFin date);
CREATE procedure GeneraPoliza(
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
    FechaAlta date,
    FechaBaja date,
    IdPuesto integer,
    IdCategoria integer,
    IdDepartamento integer
)
    language plpgsql
as $$
    DECLARE state text;
Begin
    state:=dblink_exec('dbname=bddnomina user=postgres password=postgrespw','
                insert into public.empleado (nsss,rfc,curp,nombre,apellidos,telefono, direccion, nocuenta, iddepartamento)
                    values ('||NSSS||','||RFC||','''||totsueldo||''',''0'',''De nomina'')');


end
$$;
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
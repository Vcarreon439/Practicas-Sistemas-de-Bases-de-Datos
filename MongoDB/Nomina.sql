use Nomitec;
db.createCollection('Nomina_Detalle');
db.getCollection('Nomina_Detalle').insertMany([
    {
        idEmpleado:1,
        DatoNomina:[
            {"idNomina": 1, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500},
            {"idNomina": 2, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500}
        ],
    },
    {
        idEmpleado:2,
        DatoNomina:[
            {"idNomina": 3, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500},
            {"idNomina": 4, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500}
        ],
    },
    {
        idEmpleado:3,
        DatoNomina:[
            {"idNomina": 5, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500},
            {"idNomina": 6, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500}
        ],
    },
    {
        idEmpleado:4,
        DatoNomina:[
            {"idNomina": 7, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500},
            {"idNomina": 8, "Sueldo": 5000, "Comp": 1000, "Deduc": 500, "Total": 3500}
        ],
    },
]);

db.Nomina_Detalle.find();
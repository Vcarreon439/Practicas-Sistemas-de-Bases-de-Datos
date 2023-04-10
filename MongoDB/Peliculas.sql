db.createCollection("movies")
db.movies.insertMany([
    {
        "title" : "Fight Club",
        "writer" : "Chuck Palahniuk",
        "year" : "1999",
        "actors" : [
            "Brad Pitt",
            "Edward Norton"
        ]
    },
    {
        "title" : "Pulp Fiction",
        "writer" : "Quentin Tarantino",
        "year" : 1994,
        "actors" : [
            "John Travolta",
            "Uma Thurman"
        ]
    },
    {
        "title" : "Inglorious Basterds",
        "writer" : "Quentin Tarantino",
        "year" : 2009,
        "actors" : [
            "Brad Pitt",
            "Diane Kruger",
            "Eli Roth"
        ]
    ,},
    {
        "title" : "The Hobbit: An Unexpected Journey",
        "writer" : "J.R.R. Tolkein",
        "year" : 2012,
        "franchise" : "The Hobbit"
    },
    {
        "title" : "The Hobbit: The Desolation of Smaug",
        "writer" : "J.R.R. Tolkein",
        "year" : 2013,
        "franchise" : "The Hobbit"
    },
    {
        "title" : "The Hobbit: The Battle of the Five Armies",
        "writer" : "J.R.R. Tolkein",
        "year" : 2012,
        "franchise" : "The Hobbit",
        "synopsis" : "Bilbo and Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness."
    }
])

db.movies.find()
/*Realizar las siguientes consultas en la colección movies:*/

/*1.- Obtener documentos con writer igual a "Quentin Tarantino"*/
db.movies.find({writer:{$eq:"Quentin Tarantino"}})

/*2. Obtener documentos con actors que incluyan a "Brad Pitt"*/
db.movies.find({actors:{$eq:"Brad Pitt"}})

/*3. Obtener documentos con franchise igual a "The Hobbit"*/
db.movies.find({franchise:{$eq:"The Hobbit"}})

/*4. Obtener todas las películas de los 90s.*/
db.movies.find({ "year": { $gte: 1990, $lte: 1999 } })
/*Preguntar si es necesario que salga "Fight Club", ya que su propiedad year es de tipo cadena*/

/*5. Obtener las películas estrenadas entre el año 2000 y 2010.*/
db.movies.find({ "year": { $gte: 2000, $lte: 2010 } })

/*Realiza la actualización de documentos*/
/*Agregar sinopsis a "The Hobbit: An Unexpected Journey" : "A reluctant hobbit,
Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves
to reclaim their mountain home - and the gold within it - from the dragon
Smaug."*/

db.movies.updateOne(
    { title:"The Hobbit: An Unexpected Journey"},
    { $set: { synopsis: "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug."  }}
)

db.movies.find(
    {title: "The Hobbit: An Unexpected Journey" }
)

/*Agregar sinopsis a "The Hobbit: The Desolation of Smaug" : "The dwarves, along
with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor,
their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and
magical ring."*/
db.movies.updateOne(
    { title:"The Hobbit: The Desolation of Smaug"},
    { $set: { synopsis: "The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring."  }}
)

db.movies.find(
    {title: "The Hobbit: The Desolation of Smaug" }
)

/*3. Agregar un actor llamado "Samuel L. Jackson" a la película "Pulp Fiction".*/
db.movies.updateOne(
   { "title": "Pulp Fiction" },
   { $push: { "actors": "Samuel L. Jackson" } }
)

db.movies.find({ "title": "Pulp Fiction" })

/*4. Eliminar la película "Pee Wee Herman's Big Adventure"*/
db.movies.deleteOne({ "title": "Pee Wee Herman's Big Adventure" })
db.movies.find()

/*5. Eliminar la película "Avatar"*/
db.movies.deleteOne({ "title": "Avatar" })
db.movies.find()

/*Realizar las siguientes consultas en la colección*/

/*1. Encontrar las películas que en la sinopsis contengan la palabra "Bilbo"*/
db.movies.find({ "synopsis": { $regex: /Bilbo/ } })

/*2. Encontrar las películas que en la sinopsis contengan la palabra "Gandalf"*/
db.movies.find({ "synopsis": { $regex: /Gandalf/ } })

/*3. Encontrar las películas que en la sinopsis contengan la palabra "Bilbo" y no la palabra "Gandalf"*/
db.movies.find({ "synopsis": { $regex: /Bilbo/ , $not: /Gandalf/ } })

/*4. Encontrar las películas que en la sinopsis contengan la palabra "dwarves" ó "hobbit"*/
db.movies.find({ "synopsis": { $regex: /dwarves|hobbit/ } })

/*5. Encontrar las películas que en la sinopsis contengan la palabra "gold" y "dragon"*/
db.movies.find({ "synopsis": { $regex: /gold.*dragon|dragon.*gold/ } })

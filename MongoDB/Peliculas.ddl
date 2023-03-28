db.createCollection("Peliculas")

db.Peliculas.insertOne(
{anio:2019,"titulo":"Avengers: Endgame","info":{
"directors":[
    "Anthony Russo",
    "Joe Russo"
],
"release_date":"2019-04-25T00:00:00Z",
"rating":8.8,
"genero":[
    "Action",
    "Adventure",
    "Sci-Fi"
],
"image_url":"",
"plot":""
}})

db.Peliculas.insertOne(
{anio:2019,"titulo":"Avengers: Endgame","info":{
"directors":[
    "Anthony Russo",
    "Joe Russo"
],
"release_date":"2019-04-25T00:00:00Z",
"rating":8.8,
"genero":[
    "Action",
    "Adventure",
    "Sci-Fi"
],
"image_url":"",
"plot":""
}})

db.Peliculas.find(
{_id: ObjectId("642367cea0fa8b6e11b106dc")}
)

db.Peliculas.find()

db.Peliculas.find(
{titulo:{$eq:"Avengers: Endgame"}}
)


db.Peliculas.find(
{"info.actors" : { $eq : "actor1"}}
)

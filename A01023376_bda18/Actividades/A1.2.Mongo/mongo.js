db.Escuela.insert({titulo:"POO", Profesor:[{Nombre:"Emilio",Matricula:"A012345678", Direccion:"NO C",Genero:"Hombre",Cursos:[{titulo:"Fundamentos",ano:"2018"},{titulo:"POO",ano:2018}]}],Ano:2018})
db.Escuela.update({titulo:"POO"}, {$set:{Evaluacion:[{Teoricas: 8, Practicas: 9}]}})
db.Escuela.update({titulo:"POO"}, {$set:{Alumnos:[{Nombre:"Emiliano", Matricula:"A01023234", Direccion:"Por ahi", Genero:"Hombre", Cursos:[{Nombre:"POO", Ano:2018, CalidficacionesEval:[{Curso:1, Calf: 23},{Curso:1, Calf:80},{Curso:3, Calf:57},{Curso:4, Calf:23}]}],CalfFin:83, CalfProf:100}]}})

{ "_id" : ObjectId("5aa98fdc888ccce7f6885e70"), "Cursos Impartidos" : "POO" }
{
	"_id" : ObjectId("5aac0cb2abfd5751a5c50b01"),
	"titulo" : "POO",
	"Profesor" : [
		{
			"Nombre" : "Emilio",
			"Matricula" : "A012345678",
			"Direccion" : "NO C",
			"Genero" : "Hombre",
			"Cursos" : [
				{
					"titulo" : "Fundamentos",
					"ano" : "2018"
				},
				{
					"titulo" : "POO",
					"ano" : 2018
				}
			]
		}
	],
	"Ano" : 2018,
	"Alumnos" : [
		{
			"Nombre" : "Emiliano",
			"Matricula" : "A01023234",
			"Direccion" : "Por ahi",
			"Genero" : "Hombre",
			"Cursos" : [
				{
					"Nombre" : "POO",
					"Ano" : 2018,
					"CalidficacionesEval" : [
						{
							"Curso" : 1,
							"Calf" : 23
						},
						{
							"Curso" : 1,
							"Calf" : 80
						},
						{
							"Curso" : 3,
							"Calf" : 57
						},
						{
							"Curso" : 4,
							"Calf" : 23
						}
					]
				}
			],
			"CalfFin" : 83,
			"CalfProf" : 100
		}
	],
	"Evaluacion" : [
		{
			"Teoricas" : 8,
			"Practicas" : 9
		}
	]
}
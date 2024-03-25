extends Node3D
var tamaño=0
var db
var db_name = "res://prueba"
var numero=0
var animacion
var conta
@export var texture: Texture2D
"""@onready var ropa=[$grande/Honoka_ARM/Skeleton3D/cop_aviators,$grande/Honoka_ARM/Skeleton3D/cop_hat]"""
@onready var main=$"todo/Hip Hop Dancing/AnimationPlayer"
@onready var shar=$"todo/Jazz Dancing/AnimationPlayer"
@onready var lik=$"todo/Dancing Twerk/AnimationPlayer"
@onready var ross=$"todo/Snake Hip Hop Dance/AnimationPlayer"
@onready var jenny=$Jenny/animacionesJenny
func _ready():
	$main.current=true
	db = SQLite.new()
	db.path = db_name
	jenny.play("idle")
	#main.play("mixamo_com")
	readFromDB()
	
	#saveTextureToDB(texture)
	#var itemResult = getItemsByUserID(1)
	#LoadImageFromDB()
	#saveImageTo("C:/temp/test.png", texture)
	#loadImagePathFromDB()
	pass # Replace with function body.

func commitDataToDB():
	db.open_db()
	var tableName = "prueba"
	var dict : Dictionary = Dictionary()
	dict["Name"] = "this is a test user"
	dict["Score"] = 5000
	
	db.insert_row(tableName,dict)

func readFromDB():
	db.open_db()
	#print("read")
	var tableName = "prueba"
	db.query("select * from " + tableName + ";")
	tamaño=db.query_result.size()
	#print(tamaño,numero)
	if tamaño>numero:
		numero=tamaño
		print("iguala tamaño y numero")
		#print(tamaño,numero)
		#for i in range(0, db.query_result.size()):
		#print("Qurey results ", db.query_result[i]["prueba"])#, db.query_result[i])
		"""
			if db.query_result[i]["Rosas"]=="P":
				$AnimationPlayer.play("mini_2")
				$mini.start()
				animacion=true
		"""
		conta=db.query_result.size()-1
		if db.query_result[conta]["Rosas"]=="R":
			$main.current=false
			$main2.current=false
			$shar.current=false
			$lik.current=false
			$ros.current=true
			ross.play("mixamo_com")
			$ro.start()
			print("rosa")
			
		elif db.query_result[conta]["Rosas"]=="F":
			$main.current=false
			$main2.current=false
			$shar.current=false
			$ros.current=false
			$lik.current=true
			lik.play("mixamo_com")
			$li.start()
			print("like")
		elif db.query_result[conta]["Rosas"]=="L":
			print("Ejecuta")
			jenny.play("jump")
			$likejenny.start()
		elif db.query_result[conta]["Rosas"]=="S":
			$main.current=false
			$main2.current=false
			$lik.current=false
			$ros.current=false
			$shar.current=true
			shar.play("mixamo_com")
			$ar.start()
			print("Share")
		"""
		if db.query_result[i]["Rosas"]=="l":
			$AnimationPlayer.play("cola")
			$salto.start()
			animacion=true
		"""
		"""
		if db.query_result[i]["Rosas"]=="C":
			$AnimationPlayer.play("corazon")
			$corazon.start()
			animacion=true
		"""
	if numero==tamaño:
		nada()
func nada():
	pass

func _on_ar_timeout():
	
	shar.stop()
	#main.play("mixamo_com")
	$main.current=true

func _on_li_timeout():
	
	lik.stop()
	#main.play("mixamo_com")
	$main.current=true

func _on_ro_timeout():
	
	ross.stop()
	#main.play("mixamo_com")
	$main.current=true
func _on_actualiza_timeout():
	tamaño=db.query_result.size()
	readFromDB()


func _on_likejenny_timeout():
	jenny.stop()
	jenny.play("idle")

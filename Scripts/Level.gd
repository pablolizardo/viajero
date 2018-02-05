tool
extends Spatial
var block = preload("res://Scenes/Brick.tscn")
var player = preload("res://Scenes/Player.tscn")

onready var Goal = get_node("Goal")
onready var cam = get_node("cam")
onready var Tiempo = get_node("Tiempo")
onready var UI_tiempo = get_node("UI/tiempo_value")
onready var Char = get_node("Char")
onready var Indicador = get_node("Indicador")

export var grid=Vector3(20,3,20)
var charPos = Vector3()
var GROW_ANIM = 5

var row = ""
var height = 0
var initialRotation = Vector3(-30,45,0)
var rotationNew = Vector3(0,5,0)
var index = 0
var goal = 0
var h = 0
var maximun = 0
var minimun = 99
var maximun_pos = Vector2()
var minimun_pos = Vector2()
var mat

var rows = []
var cols = []

func _process(delta):
	#UI_tiempo.text = String(floor(Tiempo.time_left ))
	pass
	
func _ready():
	randomize()
	set_process(true)
	goal = floor(rand_range(0,grid.x * grid.z))
	
	#generacion de array [rows][cols]
	for i in range(grid.x):
		rows=[]
		cols.append(rows)
		for k in range(grid.z):
			index +=1
			h = floor(rand_range(0,grid.y)) +1
			if(index == goal ):
				h = grid.y +2
			rows.append(h)

	#generacion de bricks
	for j in range(grid.x):
		for k in range(grid.z):
			var blockNew = block.instance()
			var heightNew = cols[j][k]
			if heightNew > maximun :
				maximun_pos= Vector2(j,k)
				maximun = heightNew
			if heightNew < minimun:
				minimun = heightNew
				minimun_pos= Vector2(j,k)
				
			#print(maximun)
			blockNew.translate(Vector3(j - grid.x/2 ,0 , k - grid.z/2))

			var tween = blockNew.get_node("Tween")
			tween.interpolate_property(blockNew,"scale",scale,Vector3(1,heightNew,1), GROW_ANIM, Tween.TRANS_CUBIC,Tween.EASE_OUT)
			tween.start()

			#blockNew.scale.y = heightNew
			mat = blockNew.get_node("cubo_mesh").get_surface_material(0).duplicate()
			mat.albedo_color = Color(heightNew*8,0.5,0,1)
			blockNew.get_node("cubo_mesh").set_surface_material(0,mat)
			blockNew.get_node("cubo_mesh").get_surface_material(0).albedo_color = Color(heightNew/10,1,0.5,0.1)
			blockNew.color = Color(heightNew/10,rand_range(0,1),1)
			add_child(blockNew)


			#print(Color(heightNew/10,heightNew/10,heightNew/10,1))

			#blockNew.get_node("cubo_mesh").get_surface_material().set("alpha", 0.3)
			#blockNew.get_node("RayCast").get_collision_point()
	
	for i in range(grid.x):
		var indi = Indicador.instance()
		indi.x = 
	# setear posicion del halo de luz en la posicion mas alta
	Goal.translation.x = maximun_pos.x- grid.x/2
	Goal.translation.z = maximun_pos.y- grid.z/2
	Goal.translation.y= maximun
	
	# setear posicion del personaje en la posicion mas baja
	Char.translation.x = minimun_pos.x- grid.x/2
	Char.translation.z = minimun_pos.y- grid.z/2
	Char.translation.y= minimun
	
	charPos = Vector3(minimun_pos.x, minimun, minimun_pos.y)
	print(charPos)

func _on_Timer_timeout():
	Goal.anim()


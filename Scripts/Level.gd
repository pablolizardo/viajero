extends Spatial

var block = preload("res://Scenes/Brick.tscn")
var player = preload("res://Scenes/Player.tscn")
onready var Char = get_node("Char")
export var sizeX = 10
export var sizeY = 10
export var sizeZ = 3

var row = ""
var height = 0
var initialRotation = Vector3(-30,45,0)
var rotationNew = Vector3(0,5,0)
var index = 0
var goal = 0
var h = 0
var r = 0
var g = 0
var b = 0
var maximun = 0
var minimun = 99
var maximun_pos = Vector2()
var mat

onready var cam = get_node("cam")

var rows = []
var cols = []

func _ready():
	randomize()

	set_process(true)
	goal = floor(rand_range(0,sizeX * sizeY))
	#print (goal)
	
	#generacion de array [rows][cols]
	for i in range(sizeX):
		rows=[]
		cols.append(rows)
		for k in range(sizeY):
			index +=1
			h = floor(rand_range(0,sizeZ)) +1
			if(index == goal ):
				h = sizeZ +2
			rows.append(h)
	

	#generacion de bricks
	for j in range(sizeX):
		for k in range(sizeY):
			var blockNew = block.instance()
			var heightNew = cols[j][k]
			if heightNew > maximun :
				maximun_pos.x = j
				maximun_pos.y = k
				maximun = heightNew
			print(maximun)
			blockNew.translate(Vector3(j - sizeX/2 ,0 , k - sizeY/2))

			var tween = blockNew.get_node("Tween")
			tween.interpolate_property(blockNew,"scale",scale,Vector3(1,heightNew,1), 12, Tween.TRANS_CUBIC,Tween.EASE_OUT)
			tween.start()

			#blockNew.scale.y = heightNew
			mat = blockNew.get_node("cubo_mesh").get_surface_material(0).duplicate()
			mat.albedo_color = Color(heightNew*sizeZ,0.5,0,1)
			blockNew.get_node("cubo_mesh").set_surface_material(0,mat)
			#blockNew.get_node("cubo_mesh").get_surface_material(0).albedo_color = Color(heightNew/10,1,0.5,0.1)
			#blockNew.color = Color(heightNew/10,rand_range(0,1),1)
			add_child(blockNew)


			#print(Color(heightNew/10,heightNew/10,heightNew/10,1))

			#blockNew.get_node("cubo_mesh").get_surface_material().set("alpha", 0.3)
			#blockNew.get_node("RayCast").get_collision_point()
	Char.translation.x = maximun_pos.x- sizeX/2
	Char.translation.z = maximun_pos.y- sizeY/2
	Char.translation.y= maximun
	
	
	

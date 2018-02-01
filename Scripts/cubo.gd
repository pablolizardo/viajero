tool
extends Spatial

export var height  = 1
export var color = Color(1,1,1)
#onready var cast = get_node("Sprite3D/RayCast")
onready var mesh = get_node("cubo_mesh")

func _ready():
	#print(cast.is_colliding())
	#.get_surface_material(0).albedo_color = Color(heightNew/10,1,0.5,0.1)
	#mesh.get_surface_material(0).albedo_color = color
	pass
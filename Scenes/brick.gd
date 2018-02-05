extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mat
func _ready():
	# Called every time the node is added to the scene.
	pass
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_mouse_entered():
	print("over" , self)
	mat = self.get_node("MeshInstance").get_surface_material(0).duplicate()
	mat.albedo_color=Color(1,0,.6)
	self.get_node("MeshInstance").set_surface_material(0,mat)
	pass # replace with function body


func _on_Area_mouse_exited():
	mat = self.get_node("MeshInstance").get_surface_material(0).duplicate()
	mat.albedo_color=Color(1,1,1)
	self.get_node("MeshInstance").set_surface_material(0,mat)
	pass # replace with function body

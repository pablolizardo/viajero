extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tween = get_node("Tween")
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	print(self.translation)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees+Vector3(0,90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
	if Input.is_action_just_pressed("ui_right"):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees-Vector3(0,90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
	if Input.is_action_just_pressed("ui_up"):
		tween.interpolate_property(self,"translation",translation, translate_object_local(Vector3(0,0,1)),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
	if Input.is_action_just_pressed("ui_down"):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees-Vector3(0,180,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

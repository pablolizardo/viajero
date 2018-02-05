extends Spatial

onready var world = get_parent()
onready var tw = get_node("Tween")
var direction = Vector2(1,0)

func _ready():
	# setear posicion del personaje en la posicion mas baja
#	translation.x = world.minimun_pos.x- world.sizeX/2
#	translation.z = world.minimun_pos.y- world.sizeY/2
#	translation.y= world.minimun
	print(world.charPos)
	set_process(true)
	

func CharRotate() :
	print(direction)
	

func _process(delta):
	
	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2(direction.y, -direction.x)
		CharRotate()
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees+Vector3(0,90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2(-direction.y, direction.x)
		CharRotate()
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees+Vector3(0,-90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	elif Input.is_action_just_pressed("ui_up"):
		tw.interpolate_property(self,"translation",translation, translate_object_local(Vector3(0,0,1)),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	elif Input.is_action_just_pressed("ui_down"):
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees-Vector3(0,180,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

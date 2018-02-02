extends Spatial

onready var tw = get_node("Tween")
var direction = Vector2()

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees+Vector3(0,90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	if Input.is_action_just_pressed("ui_right"):
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees+Vector3(0,-90,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	if Input.is_action_just_pressed("ui_up"):
		tw.interpolate_property(self,"translation",translation, translate_object_local(Vector3(0,0,1)),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
	if Input.is_action_just_pressed("ui_down"):
		tw.interpolate_property(self,"rotation_degrees",rotation_degrees,rotation_degrees-Vector3(0,180,0),.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tw.start()
		
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

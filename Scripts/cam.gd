extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const INITIALROT = 45
var lastPos = Vector3(0,0,0)
var lastRot = Vector3(0,0,0)
export var speed = .2
var zoom_bool = 0
var rotSteps = 90
var cam_far = 30
var cam_near = 22

onready var tw = get_node("Tween")
onready var cam = get_node("Camera")
onready var world = get_parent()

func _ready():
	cam_far =( ( ( world.sizeX+world.sizeY ) / 2 )* 2.2 )+ 5
	cam_near = cam_far / 0.7
	cam.size = cam_far
	
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)


func _process(delta):
	if Input.is_action_just_pressed("rotate_left"):
		INITIALROT-=rotSteps
		tw.interpolate_property(self,"rotation_degrees",Vector3(0,rotation_degrees.y,0), Vector3(0,INITIALROT,0), speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
		tw.start()
	if Input.is_action_just_pressed("rotate_right"):
		INITIALROT+=rotSteps
		tw.interpolate_property(self,"rotation_degrees",Vector3(0,rotation_degrees.y,0), Vector3(0,INITIALROT,0), speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
		tw.start()
	if Input.is_action_just_pressed("view_map"):
		if (zoom_bool == 0 ):
			lastPos = cam.translation
			lastRot = cam.rotation_degrees
			print (lastRot)
			tw.interpolate_property(cam,"translation",Vector3(lastPos), Vector3(0,20,0), speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.interpolate_property(cam,"rotation_degrees",Vector3(lastRot), Vector3(-90,0,0), speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.interpolate_property(cam,"size",cam_far, cam_near, speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.start()
			zoom_bool = 1
		else :
			print (lastRot)
			tw.interpolate_property(cam,"translation",Vector3(0,20,0) , Vector3(lastPos) , speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.interpolate_property(cam,"rotation_degrees",Vector3(-90,0,0) ,Vector3(lastRot) , speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.interpolate_property(cam,"size",cam_near, cam_far, speed, Tween.TRANS_QUAD,Tween.EASE_OUT)
			tw.start()
			zoom_bool = 0
		


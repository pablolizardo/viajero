extends Spatial

onready var tw = get_node("Tween")
onready var timer = get_node("Timer")
onready var root = get_parent()

func _ready():
	timer.wait_time = root.GROW_ANIM
	timer.start()

		
func anim() :
	tw.interpolate_property(self, "scale",Vector3(0,1,0), Vector3(1,1,1),.5,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start()
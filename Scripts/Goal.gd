extends Spatial

onready var tw = get_node("Tween")
onready var timer = get_node("Timer")

func _ready():
	timer.start()

		
func anim() :
	tw.interpolate_property(self, "scale",Vector3(0,1,0), Vector3(1,1,1),.5,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start()
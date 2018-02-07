tool 

extends Spatial

onready var brick = get_node("brick")
onready var player = get_node("player")
onready var tw = get_node("player/Tween")

onready var player_srt = get_node("player/srt")
onready var tw_2 = get_node("player/srt/Tween")

onready var gate = get_node("gate")
onready var debPos = get_node("debug/pos")
onready var debRot = get_node("debug/rot")
onready var debMat = get_node("debug/matrix")

export var gameSize = Vector3(10,6,10)
var matrix = []
var newPos = Vector3()
var dir = Vector2(0,-1)
var angle = 0


func rotPlayer(side):
	if (side<0):
		dir = Vector2(dir.y, -dir.x)
	else :
		dir = Vector2(-dir.y, dir.x)
	#player_srt.rotate_y( dir.angle_to( Vector2(player.translation.x, player.translation.z) ) )
	angle = rad2deg (dir.angle()) 
	print(angle)
	tw_2.interpolate_property(player_srt, "rotation_degrees", player_srt.rotation_degrees, Vector3(0,-angle,0 ), .2, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tw_2.start()
		
		
	debRot.text = "RotPlayer  x:" + str(dir.x)  + " y:" + str(dir.y)  + "  angle-> " + str( angle )
	
func _ready():
	randomize()
	
	#inicializar array
	for i in gameSize.x:
		matrix.append([])
		matrix[i] = []
		for j in gameSize.z:
			matrix[i].append([])
			matrix[i][j] = floor(rand_range(0, gameSize.y))
	print(matrix)
	print("minimo valor ",minPos())
	print("maximo valor ",maxPos())
	
	genWorld()
	setPlayerPos()
	setGatePos()
	set_process(true)
	
func _process(delta):
	
	#debMat.text = "matrix  x:" + str(newPos.x)  + " y:" + str(newPos.y) +  " z:" +  str(newPos.z)
	if Input.is_action_just_pressed("ui_up"):
		debPos.text = "PosPlayer  x:" + str(newPos.x)  + " y:" + str(newPos.y) +  " z:" +  str(newPos.z)
		newPos.x += dir.x
		newPos.z += dir.y
		print(player.translation)
		tw.interpolate_property(player, "translation", player.translation, Vector3( newPos.x, matrix[newPos.x][newPos.z]+1 ,newPos.z ), .2, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		tw.start()
		#player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z]+1 ,newPos.z ) )
		pass
		
	if Input.is_action_just_pressed("ui_down"):
		pass
		#newPos.x -=1
		#player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z] +1,newPos.z ) )
	if Input.is_action_just_pressed("ui_right"):
		rotPlayer(1)
		#newPos.z +=1
		#player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z]+1 ,newPos.z ) )
	if Input.is_action_just_pressed("ui_left"):
		rotPlayer(-1)
		#newPos.z -=1
		#player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z] +1,newPos.z ) )
		
	pass
	
func setPlayerPos():
	player.set_translation(Vector3(minPos()) )

func setGatePos():
	gate.translate(Vector3(maxPos()) + Vector3(0,1,0))

func maxPos():
	var maxVal = 0
	var maxPos = Vector3()
	for i in range(gameSize.x):
		for j in range(gameSize.z):
			if matrix[i][j] > maxVal :
				maxVal = matrix[i][j]
				maxPos =Vector3(i,maxVal,j)
	return maxPos
	
func minPos():
	var minVal = 999
	var minPos = Vector3()
	for i in range(gameSize.x):
		for j in range(gameSize.z):
			if matrix[i][j] < minVal :
				minVal = matrix[i][j]
				minPos =Vector3(i,minVal,j)
	return minPos

func genWorld():
	for i in gameSize.x:
		for j in gameSize.z:
			var brickNew = brick.duplicate()
			add_child(brickNew)
			#brickNew.translate(Vector3(i, matrix[i][j], j))
			brickNew.translate(Vector3(i, 0, j))
			brickNew.scale.y = matrix[i][j]+1
			brickNew.add_to_group("bricks")
			

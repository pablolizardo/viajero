tool 

extends Spatial

onready var brick = get_node("brick")
onready var player = get_node("player")
onready var gate = get_node("gate")

export var gameSize = Vector3(10,6,10)
var matrix = []
var newPos = Vector3()

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
	if Input.is_action_just_pressed("ui_up"):
#		player.translate(Vector3(1,0,0))
		newPos.x +=1
		player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z]+1 ,newPos.z ) )
	if Input.is_action_just_pressed("ui_down"):
#		player.translate(Vector3(1,0,0))
		newPos.x -=1
		player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z] +1,newPos.z ) )
	if Input.is_action_just_pressed("ui_right"):
#		player.translate(Vector3(1,0,0))
		newPos.z +=1
		player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z]+1 ,newPos.z ) )
	if Input.is_action_just_pressed("ui_left"):
#		player.translate(Vector3(1,0,0))
		newPos.z -=1
		player.set_translation( Vector3( newPos.x, matrix[newPos.x][newPos.z] +1,newPos.z ) )
		
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
			

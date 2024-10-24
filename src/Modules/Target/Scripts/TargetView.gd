class_name TargetView extends Area2D

var current_duck

var screen_width: float
var screen_height: float
var value_of_screen = Vector2()

var remote_client: TargetRemotePosition = null

enum INPUT_OPTION { REMOTE, MOUSE, JOYSTICK }

var input_controller

func _ready():
	update_screen_size()
	input_controller = INPUT_OPTION.MOUSE

func _process(delta):
	update_screen_size()
	
	# Definir a nov posição de acordo com a entrada definida
	if input_controller == INPUT_OPTION.MOUSE:
		position = get_global_mouse_position()
	elif input_controller == INPUT_OPTION.REMOTE:
		if (remote_client != null):
			position = remote_client.remote_position(screen_width, screen_height)
			
			if remote_client.has_shoot():
				remote_client.set_shoot_value(false)
				on_fire()
	
	if ClientManager.get_client_list_size() >= 0 and remote_client == null:
		remote_client = ClientManager.get_client_by_index(0)
		input_controller = INPUT_OPTION.REMOTE
	
	

func _on_Target_body_entered(body):
	current_duck = body
	

func _input(event):
	if (Input.is_action_just_pressed("on_fire")):
		on_fire()
	
	## SWITCH INPUT CONTROLLER
	if input_controller != INPUT_OPTION.MOUSE and event is InputEventMouseButton:
		input_controller = INPUT_OPTION.MOUSE
		remote_client = null
	

func on_fire():
	$AudioStream.play()
	if (current_duck != null):
		current_duck._mata()
		

func update_screen_size():
	if value_of_screen.x != get_viewport().size.x or value_of_screen.y != get_viewport().size.y:
		screen_width = get_viewport().size.x
		screen_height = get_viewport().size.y
		value_of_screen = Vector2(screen_width, screen_height)
		print("Screen size updated: %d x %d" % [screen_width, screen_height])

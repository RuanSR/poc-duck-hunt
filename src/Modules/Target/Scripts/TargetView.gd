class_name TargetView extends Area2D

var current_duck

# Configuracao de tela
var screen_width: float
var screen_height: float
var value_of_screen = Vector2()

var remote_client: TargetRemotePosition = null 

onready var default_target_position = Vector2(screen_width / 2, screen_height / 2)

func _ready():
	update_screen_size()
	pass

func _process(delta):
	update_screen_size()
	
	remote_client = ClientManager.get_client_by_index(0)
	if (remote_client != null):
		position = remote_client.remote_position(screen_width, screen_height)
	else:
		position = get_global_mouse_position()
	
	if remote_client != null:
		if remote_client.has_shoot():
			remote_client.set_shoot_value(false)
			on_fire()
	

func _on_Target_body_entered(body):
	current_duck = body
	

func _input(event):
	if (Input.is_action_just_pressed("on_fire")):
		on_fire()
	

func on_fire():
	$AudioStream.play()
	if (current_duck == null):
		print("sem patos para atirar")
		return
	else:
		current_duck._mata()

func update_screen_size():
	if value_of_screen.x != get_viewport().size.x or value_of_screen.y != get_viewport().size.y:
		screen_width = get_viewport().size.x
		screen_height = get_viewport().size.y
		value_of_screen = Vector2(screen_width, screen_height)
		print("Screen size updated: %d x %d" % [screen_width, screen_height])

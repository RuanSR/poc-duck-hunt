extends Node2D

func _ready():
	pass

func _process(delta):
	$Target.position = get_local_mouse_position()

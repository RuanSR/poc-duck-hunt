class_name TargetView extends Area2D

var current_duck

func _ready():
	pass


func _on_Target_body_entered(body):
	current_duck = body
	

func _input(event):
	if (Input.is_action_just_pressed("on_fire")):
		$AudioStream.play()
		if (current_duck == null):
			print("sem patos para atirar")
			return
		else:
			current_duck._mata()
	

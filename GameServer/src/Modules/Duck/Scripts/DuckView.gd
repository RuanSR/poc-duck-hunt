class_name DuckView extends KinematicBody2D

var lado: int = 1
var vel: Vector2 = Vector2()
var speed: int = 100
var queda: int = 1

func _ready():
	randomize()
	$OnMoveChangeTimer.wait_time = rand_range(0.4, 2)
	$OnAnimChangeTimer.wait_time = rand_range(0.6, 1)
	$OnQuackTimer.wait_time = rand_range(0.8, 2)
	

func _process(delta):
	position.x += speed * lado * delta
	position.y -= 140 * queda * delta
	
	if (lado < 0):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	

func _on_OnMoveChangeTimer_timeout():
	lado = lado * (-1)
	

func _on_OnAnimChangeTimer_timeout():
	if ($AnimatedSprite.animation == "up"):
		$AnimatedSprite.animation = "side"
	elif $AnimatedSprite.animation == "lado":
		$AnimatedSprite.animation = "up"
	

func _on_OnDeadTimer_timeout():
	$AnimatedSprite.animation = "death"
	queda = -1
	lado = 0
	

func _mata():
	$AnimatedSprite.animation = "scare"
	$OnDeadTimer.start()
	$AudioStreamPlayer.stop()
	

func _on_OnQuackTimer_timeout():
	$AudioStreamPlayer.play()
	

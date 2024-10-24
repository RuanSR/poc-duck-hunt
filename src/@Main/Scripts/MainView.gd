extends Node2D

var ducks_on_screen
var _duck_prefab = preload("res://src/Modules/Duck/Duck.tscn")
var fly_away_count: int = 0
var duck_catch_count: int  = 0

var instance_target_player: Node2D = preload("res://src/Modules/Target/Target.tscn").instance()

var _game_server: GameServer = GameServer.new()

func _ready():
	_game_server.start(self)
	$OnGenerateDuckTimer.start()
	add_child(instance_target_player)

func _process(delta):
	_game_server.poll()
	

func create_duck():
	var new_duck = _duck_prefab.instance()
	new_duck.position = Vector2(rand_range(50, 700), 700)
	add_child(new_duck)

func _on_OnGenerateDuckTimer_timeout():
	ducks_on_screen = int(rand_range(1 , 6))
	for i in ducks_on_screen:
		create_duck()
	

func _on_OnWaitTimer_timeout():
	$OnGenerateDuckTimer.start()
	

func _on_GoalTop_body_entered(body):
	fly_away_count = 1
	ducks_on_screen -= 1
	update_turn()
	

func _on_GoalBotton_body_entered(body):
	duck_catch_count += 1
	ducks_on_screen -= 1
	update_turn()
	

func update_turn():
	if (ducks_on_screen == 0):
		$OnWaitTimer.start()
		if fly_away_count == 1:
			$Dog/AnimatedSprite.play("fail")
			fly_away_count = 0
		else:
			$Dog/AnimatedSprite.play("success")
	

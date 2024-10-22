class_name TargetRemotePosition

var id: int setget , get_id
var data: JSONParseResult = null setget , get_data
var remote_position: Vector2 = Vector2.ZERO
var _shoot: bool = false

var smooth_x = 0.0
var smooth_y = 0.0
var alpha = 0.9  # Fator de suavização

func set_data(data: JSONParseResult) -> void:
	self.data = data
	

func get_data() -> JSONParseResult:
	return data

func get_id() -> int:
	return id

func _init(id: int):
	self.id = id
	

func set_shoot_value(shoot: bool):
	_shoot = shoot

func has_shoot() -> bool:
	return _shoot

func remote_position(screen_width: int, screen_height: int) -> Vector2:
	_process_target_pos(screen_width, screen_height)
	return remote_position
	

func _process_target_pos(screen_width: int = 0, screen_height: int = 0):
	if data == null:
		return
	
	if data.error == OK:

		if !data.result.has("gyroscope"):
			return
		
		var coords = data.result["gyroscope"]
		
		var y = float(coords.y)
		var z = float(coords.z)
		
		
		smooth_x = alpha * smooth_x + (1.0 - alpha) * (z * screen_width /2)
		smooth_y = alpha * smooth_y + (1.0 - alpha) * (y * screen_height /2)
		
		var screen_x = clamp(- smooth_x, 0, screen_width)
		var screen_y = clamp(smooth_y, 0, screen_height)
		
		remote_position = Vector2(screen_x, screen_y)
#		print("Mira movida para: %s" % str(target.position))
		
	else:
		print("Erro ao processar JSON: %s" % str(data.error))

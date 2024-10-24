class_name ClientServer

const _PORT = 9080

var _localhost_url: String
var _client = WebSocketClient.new()
var _context: Node

var _connection_successful: bool = false

func _to_server_url(ip_adress: String) -> String:
	return str("ws://", ip_adress, ":", _PORT)

func start(node_context: Node, url) -> void:
	_context = node_context
	
	_localhost_url = _to_server_url(url)
	_connect_signals()
	_create_connection()
	

func stop() -> void:
	if _connection_successful:
		_client.disconnect_from_host()
		_connection_successful = false
	

func poll() -> void:
	_client.poll()
	

func has_connection() -> bool:
	return _connection_successful
	

func disconnect_from_host() -> void:
	if _connection_successful:
		_client.disconnect_from_host()
		_connection_successful = false
	

func dispatch_shoot() -> void:
	var shoot_data = { "on_shoot": true }
	var json_data = JSON.print(shoot_data)
	_client.get_peer(1).put_packet(json_data.to_utf8())
	

func dispatch_position(new_position: Vector3) -> void:
	var data = {
		"gyroscope": { "x": new_position.x, "y": new_position.y, "z": new_position.z }
	}
	
	var json_data = JSON.print(data)
	_client.get_peer(1).put_packet(json_data.to_utf8())
	

func _connect_signals() -> void:
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")
	

func _create_connection():
	if _connection_successful:
		print("Already connected, disconnecting before reconnecting...")
		_client.disconnect_from_host()
	
	var err = _client.connect_to_url(_localhost_url)
	
	if err != OK:
		print("Unable to connect")
		_context.set_process(false)
		_connection_successful = false
	else:
		print("Attempting to connect...")
		_context.set_process(true)
	

func _closed(was_clean = false):
	_context.set_process(false)
	_connection_successful = false
	print("Closed, clean: ", was_clean)
	

func _connected(proto = ""):
	_client.get_peer(1).put_packet("Olá, sou o client Godot".to_utf8())
	_connection_successful = true
	print("Connected with protocol: ", proto)
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())
	

func _on_data():
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())
	

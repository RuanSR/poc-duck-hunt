class_name GameServer

const PORT = 9080

var _server = WebSocketServer.new()

func _connected(id, proto):
	ClientManager.add_new_client(id)
	
	print("Client %d connected with protocol: %s" % [id, proto])

func _close_request(id, code, reason):
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])

func _disconnected(id, was_clean = false):
	ClientManager.remove_client(id)
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])

func _on_data(id: int):
	var pkt = _server.get_peer(id).get_packet()
	var result: JSONParseResult = JSON.parse(pkt.get_string_from_utf8())
	
	send_message(id, "Olá, sou o server!")
	
	if result.error == OK:
		if result.result.has("on_shoot"):
			ClientManager.set_shoot_value(id)
			pass
		ClientManager.add_new_data(id, result)

func _connect_signals(nodeContext: Node) -> void:
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")

	_server.connect("data_received", self, "_on_data")
	
	var err = _server.listen(PORT)
	
	if err == OK:
		print("server started!")
	
	if err != OK:
		print("Unable to start server")
		nodeContext.set_process(false)

func start(nodeContext: Node) -> void:
	_connect_signals(nodeContext)

func poll() -> void:
	_server.poll()

func stop() -> void:
	_server.stop()

func send_message(client_id: int, message: String) -> void:
	_server.get_peer(client_id).put_packet(message.to_utf8())

extends Node

var _client_list: Array = []

func add_new_client(id: int) -> void:
	var client:  = TargetRemotePosition.new(id)
	_client_list.append(client)
	

func add_new_data(id: int, data: JSONParseResult) -> void:
	for client in _client_list:
		if client.id == id:
			client.set_data(data)
			break
	pass

func set_shoot_value(id: int) -> void:
	get_by_id(id).set_shoot_value(true)

func get_client_by_index(index: int) -> TargetRemotePosition:
	if index <= _client_list.size() -1:
		return _client_list[index]
	
	return null

func get_by_id(id: int) -> TargetRemotePosition:
	var client = null
	for i in _client_list:
		if i.id == id:
			client = i
			break
	return client

func get_client_list_size() -> int:
	return _client_list.size() - 1

func um_a_um() -> TargetRemotePosition:
	for client in _client_list:
		if client == null:
			return null
		return client
	return null

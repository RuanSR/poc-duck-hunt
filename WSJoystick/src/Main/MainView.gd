extends Node

onready var status_label_label_text: Label = $Control/StatusLabel/LabelText
onready var connect_control_input_text: TextEdit = $Control/ConnectControl/InputText
onready var connect_control_connect_button: Button = $Control/ConnectControl/ConnectButton
onready var control_shoot_button: Button = $Control/ShootButton

var _client_server: ClientServer = ClientServer.new()

func _ready():
	control_shoot_button.disabled = true
	
	on_connect_server()
	

func _process(_delta):
	_client_server.poll()
	_on_capture()
	

func on_connect_server() -> void:
	var localhost_url: String = connect_control_input_text.text

	if (localhost_url.empty()):
		status_label_label_text.text = "invalid url"
	
	_client_server.start(self, localhost_url)

func _on_ShootButton_pressed():
	_client_server.dispatch_shoot()
	

func _on_ConnectButton_pressed():
	on_connect_server()
	print("Reconnecting...")
	

func _exit_tree():
	_client_server.disconnect_from_host()
	

func _on_capture():
	if (_client_server.has_connection()):
		control_shoot_button.disabled = false
		connect_control_connect_button.disabled = true
		status_label_label_text.text = "connected!"
		
		_client_server.dispatch_position(Input.get_gravity())
		
	else:
		status_label_label_text.text = "wating..."
		control_shoot_button.disabled = true
		connect_control_connect_button.disabled = false
		print("wating...")
	


class_name AudioManager extends Node

const AUDIO_DOG_CATCH = preload("res://src/Modules/AudioManager/@Assets/cao_captura.wav")
const AUDIO_DOG_FAIL = preload("res://src/Modules/AudioManager/@Assets/cao_rindo.wav")
const AUDIO_FLY_AWAY = preload("res://src/Modules/AudioManager/@Assets/flyaway.wav")
const AUDIO_COLIDER = preload("res://src/Modules/AudioManager/@Assets/colidiu.wav")
const AUDIO_ROUND = preload("res://src/Modules/AudioManager/@Assets/round.wav")

onready var stream_player: AudioStreamPlayer2D = $StreamPlayer

func play_audio_dog_catch() -> void:
	_play_audio(AUDIO_DOG_CATCH)
	

func play_audio_dog_fail() -> void:
	_play_audio(AUDIO_DOG_FAIL)
	

func play_audio_fly_away() -> void:
	_play_audio(AUDIO_FLY_AWAY)
	

func play_audio_colider() -> void:
	_play_audio(AUDIO_COLIDER)
	

func play_audio_round() -> void:
	_play_audio(AUDIO_ROUND)
	

func _play_audio(audio) -> void:
	stream_player.stream = audio
	stream_player.play()
	


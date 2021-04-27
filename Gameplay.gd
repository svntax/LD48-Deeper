extends Node2D

onready var bg_music = $BgMusic
onready var waves_animation_player = $WavesAnimationPlayer

func _ready():
	bg_music.play()
	waves_animation_player.play("waves", -1, 0.5)

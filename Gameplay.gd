extends Node2D

onready var bg_music = $BgMusic
onready var waves_animation_player = $WavesAnimationPlayer
onready var ocean_bg_deep = $OceanBgDeep
onready var player = $Player

func _ready():
	bg_music.play()
	waves_animation_player.play("waves", -1, 0.5)

func _process(delta):
	var ratio = (player.global_position.y - 648) / 2000
	ratio = clamp(ratio, 0, 1)
	
	ocean_bg_deep.color.a = ratio

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "transition_in":
		pass

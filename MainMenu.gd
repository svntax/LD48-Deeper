extends Node2D

onready var waves_animation_player = $WavesAnimationPlayer
onready var animation_player = $AnimationPlayer

onready var transition_playing = false

func _ready():
	waves_animation_player.play("waves", -1, 0.5)
	$TransitionRect.color.a = 0

func _on_StartButton_pressed():
	if not transition_playing:
		transition_playing = true
		animation_player.play("transition")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "transition":
		get_tree().change_scene("res://Gameplay.tscn")

extends KinematicBody2D

onready var animation_player = $AnimationPlayer

enum States {NORMAL}
onready var state

onready var lives = 3

onready var speed = 12
onready var velocity = Vector2()
onready var acceleration = 12

func _ready():
	set_state(States.NORMAL)

func _physics_process(delta):
	if state == States.NORMAL:
		normal_state_logic(delta)

func normal_state_logic(delta):
	if Input.is_action_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		var dir = global_position.direction_to(get_global_mouse_position())
		velocity += dir * acceleration
		if animation_player.current_animation == "idle":
			# Started moving
			velocity += dir * acceleration * 4
		velocity = velocity.clamped(128)
		animation_player.play("move")
		rotation = mouse_pos.angle_to_point(global_position)
	else:
		animation_player.play("idle")
		# Friction
		velocity = velocity.linear_interpolate(Vector2.ZERO, 0.05)
	
	move_and_slide(velocity)

func enter_state(new_state):
	match new_state:
		States.NORMAL:
			pass

func exit_state(previous_state):
	pass

func set_state(new_state):
	var previous_state = state
	exit_state(previous_state)
	state = new_state
	enter_state(new_state)

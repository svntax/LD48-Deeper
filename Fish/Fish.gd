extends KinematicBody2D

onready var sprite = $Polygons/Polygon2D
onready var sprite_large = $PolygonsLarge/Polygon2D
onready var animation_player = $AnimationPlayer
onready var move_timer = $MoveTimer
onready var idle_timer = $IdleTimer
onready var sprites_list = $Sprites

enum States {IDLE, MOVE}
onready var state

onready var velocity = Vector2()
onready var acceleration = 12
onready var dir = Vector2()

func _ready():
	randomize()
	var choice = randi() % sprites_list.get_child_count()
	var tex = sprites_list.get_child(choice).get_texture()
	if choice < 2:
		sprite.texture = tex
		sprite_large.get_parent().hide()
	else:
		sprite_large.texture = tex
		sprite.get_parent().hide()
	
	sprites_list.queue_free()
	
	set_state(States.IDLE)

func _physics_process(delta):
	if state == States.IDLE:
		idle_logic(delta)
	elif state == States.MOVE:
		move_logic(delta)
	
	move_and_slide(velocity)

func idle_logic(delta):
	# Friction
	velocity = velocity.linear_interpolate(Vector2.ZERO, 0.05)

func move_logic(move):
	velocity += dir * acceleration
	velocity = velocity.clamped(128)

func enter_state(new_state):
	match new_state:
		States.IDLE:
			animation_player.play("idle")
			idle_timer.start(rand_range(1, 6))
		States.MOVE:
			animation_player.play("move")
			move_timer.start(rand_range(0.2, 3))
			var rand_pos = global_position + Vector2(rand_range(-32, 32), rand_range(-32, 32))
			dir = global_position.direction_to(rand_pos)
			rotation = dir.angle()

func exit_state(previous_state):
	pass

func set_state(new_state):
	var previous_state = state
	exit_state(previous_state)
	state = new_state
	enter_state(new_state)

func _on_MoveTimer_timeout():
	set_state(States.IDLE)

func _on_IdleTimer_timeout():
	set_state(States.MOVE)

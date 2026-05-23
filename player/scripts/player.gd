extends Node2D
class_name Player

enum dash_states {
	DASH_AVAILABLE,
	DASHING,
	DASH_COOLDOWN,
}

@export_group("Movement Settings")
@export var move_speed: float = 700.0
@export var dash_distance: float = 300.0
@export var dash_time: float = 0.15
@export var dash_cooldown: float = 0.4
var dash_speed: float
var dash_timer: Timer
var last_direction: Vector2
var dash_state: dash_states = dash_states.DASH_AVAILABLE

@export_group("Components")
@export var hit_box_shape: CollisionShape2D

func _ready() -> void:
	dash_speed = dash_distance/dash_time

	dash_timer = Timer.new()
	dash_timer.one_shot = true
	add_child(dash_timer)

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float) -> void:
	if dash_state == dash_states.DASHING:
		position.x += last_direction.x * dash_speed * delta
		position.y += last_direction.y * dash_speed * delta
		return
	
	if Input.is_action_just_pressed("dash") and dash_state == dash_states.DASH_AVAILABLE:
		dash_state = dash_states.DASHING
		stop_dash()
		return

	# get movement directions
	var direction: Vector2
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	last_direction = direction

	# move character
	position.x += direction.x * move_speed * delta
	position.y += direction.y * move_speed * delta

func stop_dash() -> void:
	dash_timer.wait_time = dash_time
	dash_timer.start()
	await dash_timer.timeout
	dash_state = dash_states.DASH_COOLDOWN
	enable_dash()

func enable_dash() -> void:
	dash_timer.wait_time = dash_cooldown
	dash_timer.start()
	await dash_timer.timeout
	dash_state = dash_states.DASH_AVAILABLE

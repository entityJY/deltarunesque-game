extends CharacterBody2D
class_name Player


enum dash_states {
	DASH_AVAILABLE,
	DASHING,
	DASH_COOLDOWN,
}

# 16 25 34 43 52
# 
# 32 44 56 68 80
# 
# 48 63 78 93 108
# 

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
@export var hit_box: CollisionShape2D
@export var outer_shield: CollisionShape2D
@export var collision_shape: CollisionShape2D
@export var shield_sprite_array: Array[Sprite2D]

var shield_level: int = 4: set = set_shield_level


func _ready() -> void:
	dash_speed = dash_distance/dash_time

	dash_timer = Timer.new()
	dash_timer.one_shot = true
	add_child(dash_timer)
	set_shield_level(shield_level)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		shield_level -= 1
	movement(delta)
	move_and_slide()


func movement(_delta: float) -> void:
	if dash_state == dash_states.DASHING:
		velocity = last_direction * dash_speed
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

	velocity = direction * move_speed

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


func set_shield_level(level: int) -> void:
	if level < 0 or level > 4:
		return
	
	shield_level = level
	for i in range(5):
		if i == level:
			shield_sprite_array[i].visible = true
		else:
			shield_sprite_array[i].visible = false
	
	var scale_hit_box = func (i):
		hit_box.shape.radius = 16 + 9 * i
		collision_shape.shape.radius = 32 + 12 * i
		outer_shield.shape.radius = 48 + 15 * i
	scale_hit_box.call_deferred(level)

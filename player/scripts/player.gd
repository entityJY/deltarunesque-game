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
# 64 88 112 136 160

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
@export var death_sprite: Sprite2D

var shield_level: int = 4: set = set_shield_level

var points: int = 0

var grazing_bullets: Dictionary[Area2D, float] = {}

signal player_killed(score: int)


func _ready() -> void:
	dash_speed = dash_distance/dash_time

	dash_timer = Timer.new()
	dash_timer.one_shot = true
	add_child(dash_timer)
	set_shield_level(shield_level)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		shield_level -= 1

	for area in grazing_bullets.keys():
		if !is_instance_valid(area):			# May need to remake dictionary every time, but hopefully not
			(func(a: Area2D): grazing_bullets.erase(a)).call_deferred(area)
			continue
		grazing_bullets[area] += delta
		# calculate difference in velocity here
	
	movement(delta)
	move_and_slide()

func hurt(damage: int) -> void:
	if damage > 0:
		damage *= -1
	shield_level += damage


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
	if level < 0:
		player_killed.emit(points)
		death_sprite.visible = true
		for i in range(5):
			shield_sprite_array[i].visible = false
		return
	if level > 4:
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


func _on_outer_hitbox_area_entered(area: Area2D) -> void:
	if (area is Projectile or area is Laser):
		grazing_bullets[area] = 0.0

func _on_outer_hitbox_area_exited(area: Area2D) -> void:
	if (area is Projectile or area is Laser):
		points += int(grazing_bullets[area] * 100)			# 100 points per second spent grazing
		grazing_bullets.erase(area)

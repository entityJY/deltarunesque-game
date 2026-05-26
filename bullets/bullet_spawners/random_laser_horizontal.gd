extends BasicSpawner
class_name RandomHorizontalLaserSpawner


## whether bullets fire on ready for debugging
@export var debug_spawning: bool = false

## laser type to use
@export var laser: PackedScene
@export var warning_beats : float
@export var flash_time : float
## time between damages to player
@export var cooldown_timeout = 0.2
@export var laser_duration : float = 10
@export var laser_width: float = 80
var laser_size : Vector2 = Vector2(200, 1200)


func _ready() -> void:
	if debug_spawning:
		position = Vector2(1920.0/2, 1080.0/2)
		start_spawning()

func spawn_projectile():
	var new_laser: Laser = laser.instantiate()

	new_laser.laserSize = laser_size
	new_laser.warningTime = warning_beats / bpm * 60
	new_laser.flashTime = flash_time
	new_laser.cooldown_timeout = cooldown_timeout
	new_laser.laser_duration = laser_duration
	new_laser.scale.x *= laser_width/571
	new_laser.scale.y = 1920*3
	new_laser.global_rotation = 1
	new_laser.position = Vector2(randf_range(-480, 480), randf_range(-270, 270))

	new_laser.rotation = PI/2

	get_parent().add_child(new_laser)

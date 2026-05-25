extends BasicSpawner
class_name SpiralSpawner


## whether bullets fire on ready for debugging
@export var debug_spawning: bool = false

## bullet type to use
@export var bullet: PackedScene
## radius of circle bullets spawn from
@export var spawn_radius: float
## radians between each bullet spawn
@export var rad_between_bullet: float
## whether bullets are spawned in clockwise direction or not
@export var rotates_clockwise: bool
## initial radians to start spawning bullets from
@export var initial_rad: float
## beats between each bullet firing
@export var beats_per_bullet: float
## how many beats the spawner runs for
@export var firing_time: float
## speed of each bullet
@export var bullet_speed: float
## radius of each bullet
@export var bullet_radius: float

var spawning_enabled: bool = false
var next_bullet_spawn: float
var spawn_position: Vector2

func _ready() -> void:
	if !rotates_clockwise:
		rad_between_bullet *= -1
	if debug_spawning:
		position = Vector2(1920.0/2, 1080.0/2)
		start_spawning()

func start_spawning():
	spawning_enabled = true
	spawn_position = Vector2(spawn_radius, 0)
	spawn_position = spawn_position.rotated(initial_rad)

func _process(_delta: float) -> void:
	if !spawning_enabled: return

	var song_beat = (audio_stream.get_playback_position() + AudioServer.get_time_since_last_mix()) * bpm / 60.0 - time
	if song_beat > firing_time:
		queue_free()
	
	if song_beat > next_bullet_spawn:
		var new_bullet: Projectile = bullet.instantiate()
		new_bullet.speed = bullet_speed
		new_bullet.direction = (Vector2.ZERO - spawn_position).normalized()
		new_bullet.scale = Vector2(bullet_radius/325, bullet_radius/325)
		new_bullet.position = spawn_position

		get_parent().add_child(new_bullet)

		spawn_position = spawn_position.rotated(rad_between_bullet)
		next_bullet_spawn += beats_per_bullet

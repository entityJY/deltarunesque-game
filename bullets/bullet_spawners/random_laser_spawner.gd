extends Marker2D


## whether bullets fire on ready for debugging
@export var debug_spawning: bool = false

## laser type to use
@export var laser: PackedScene

## beats between each bullet firing
@export var beats_per_laser: float
## how many beats the spawner runs for
@export var firing_time: float
@export var warning_beats : float
@export var flash_time : float
## time between damages to player
@export var cooldown_timeout = 0.2
@export var laser_duration : float = 10
@export var laser_width: float = 80
@export var player: Player
var laser_size : Vector2 = Vector2(200, 1200)

## how long a beat of the song lasts for
@export var bpm: float
## the audio stream being played
@export var audio_stream: AudioStreamPlayer
## what beat the spawner starts firing
@export var time: float

var spawning_enabled: bool = false
var next_laser_spawn: float

func _ready() -> void:
	if debug_spawning:
		position = Vector2(1920.0/2, 1080.0/2)
		start_spawning()

func start_spawning():
	process_mode = Node.PROCESS_MODE_INHERIT
	spawning_enabled = true

func _process(_delta: float) -> void:
	if !spawning_enabled: return

	var song_beat = (audio_stream.get_playback_position() + AudioServer.get_time_since_last_mix()) * bpm / 60.0 - time
	if song_beat > firing_time:
		queue_free()

	if song_beat > next_laser_spawn:
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

		var direction_to_player: Vector2 = (new_laser.position - player.position)
		new_laser.rotation = Vector2(1, 0).angle_to(direction_to_player) + PI/4

		get_parent().add_child(new_laser)

		next_laser_spawn += beats_per_laser
